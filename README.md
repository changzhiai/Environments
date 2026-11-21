# Environments

My shell tools, job-scheduler helpers and vim config, installable on any HPC system or laptop.

## Install

```bash
git clone git@github.com:changzhiai/Environments.git ~/bin/Environments
cd ~/bin/Environments
./install.sh            # auto-detects everything
source ~/.bashrc
```

Options:

| flag | meaning |
|---|---|
| `--dry-run` | print what would change, change nothing |
| `--site NAME` | force a site (`aurora`, `perlmutter`, `s3df`, `niflheim`, `macos`, `generic`) |
| `--scheduler X` | force a scheduler (`slurm`, `pbs`, `none`) |
| `--no-vim` | skip the vim setup |

Re-running is safe. `./uninstall.sh` reverses it and restores the backups.

To update later: `git pull`. New scripts and `shell.sh` changes take effect in the next shell. Re-run `./install.sh` only if the detected site or scheduler should change.

### On every new machine: set your git identity

Without this, git invents an author email from the hostname (e.g. `changzhiai@aurora-uan-0009...`), and GitHub won't count those commits as yours:

```bash
git config --global user.name  "Changzhi Ai"
git config --global user.email <email on your GitHub account>
```

### What it does

1. Adds this block to `~/.bashrc` (also `~/.zshrc` on macOS). It replaces any older copy of the block:
   ```bash
   # >>> Environments >>>
   export ENV_ROOT=... ENV_OS=linux ENV_SITE=aurora ENV_SCHED=pbs
   [ -f "$ENV_ROOT/shell/init.sh" ] && . "$ENV_ROOT/shell/init.sh"
   # <<< Environments <<<
   ```
   `shell/init.sh` adds the right `bin/` dirs to `PATH` and sources the matching `shell.sh` files. Nothing gets copied into `~/bin`.
2. Links `~/.vimrc` → `common/vim/vimrc`, installs [vim-plug](https://github.com/junegunn/vim-plug) and runs `:PlugInstall`. The plugins are NERDTree, nerdcommenter, supertab, ALE (flake8/black) and auto-pairs.
3. Links `~/.config/flake8` and `~/.config/.flake8` → `common/config/flake8`.

If a file is in the way, it is moved to `<file>.bak.<timestamp>` first.

## Detection (`lib/detect.sh`)

| | rule |
|---|---|
| OS | `uname -s` = Darwin → `macos`, otherwise `linux` |
| site | macOS → `macos`; `$NERSC_HOST=perlmutter` → `perlmutter`; hostname `*aurora*` or `/lus/flare` → `aurora`; `/sdf` → `s3df`; hostname `*niflheim*` or `/home/energy` → `niflheim`; otherwise `generic` |
| scheduler | `sbatch` on PATH → `slurm`; `qsub` → `pbs`; otherwise `none` |

Run `lib/detect.sh` to see the result for the current machine.

## Layout

```
common/                       loaded everywhere
  bin/                        VASP/analysis tools: grepe grepr rma reset relax fix lens.py run_vasp.py ...
  shell.sh                    aliases, EDITOR, cpot, VASP_EXE
  vim/vimrc  config/flake8  data/vdw_kernel.bindat
scheduler/
  slurm/{bin,shell.sh}        sq sqls sqr sqdir hpc-summary showjob showuserjobs ... ; sqcd/ficd functions
  pbs/{bin,shell.sh}          sq sqls sqr sqdir hpc-summary pbsjobs ;     sqcd/ficd functions
sites/<name>/                 per-machine overrides
  shell.sh                    modules, conda, env vars
  bin/  templates/            extra tools, submit-script templates
local/                        gitignored: machine-only binaries (local/bin) and secrets (local/shell.sh)
```

PATH priority (highest first) is `local/bin` > `sites/$ENV_SITE/bin` > `scheduler/$ENV_SCHED/bin` > `common/bin`. The `shell.sh` files are sourced in the opposite order (common, scheduler, site, local), so later ones override earlier ones.

### Sites

| site | scheduler | what its `shell.sh` sets up |
|---|---|---|
| `aurora` | PBS | `submit.pbs` template, `hpc-summary` queue list |
| `perlmutter` | Slurm | `VASP_EXE=vasp`, conda, `submit.sh` template, partition list; `check_logins`, `mq_cancel_iter` |
| `s3df` | Slurm | `~/.profile.d`, python 3.8 aliases, EasyBuild modules, myqueue completion, libxc paths, partition list; `mq_cancel_all` |
| `niflheim` | Slurm | modules (VESTA, vaspkit), ASE/VASP env, catmap, conda, many submit templates; `bsub.py`, `clease_*` |
| `macos` | none | Homebrew, GNU coreutils/sed/grep/findutils ahead of the BSD ones |
| `generic` | auto | nothing |

### Environment variables

| variable | set by | used by |
|---|---|---|
| `ENV_ROOT`, `ENV_OS`, `ENV_SITE`, `ENV_SCHED` | `~/.bashrc` block | everything |
| `ENV_SUBMIT_CMD` | scheduler (`sbatch` / `qsub`) | `reset` |
| `ENV_SUBMIT_TEMPLATE` | site | `reset` |
| `VASP_EXE` (default `vasp_std`) | common, site | `run_vasp.py` |
| `VASP_PP_PATH` | site | `cpot Pd H O` (concatenates POTCARs) |
| `ENV_DATA` | common | points at `common/data` (`vdw_kernel.bindat`) |
| `HPC_SUMMARY_PARTITIONS` / `HPC_SUMMARY_QUEUES` | site | `hpc-summary` |

Anything only one machine needs (secrets, extra paths) goes in `local/shell.sh`, which is gitignored.

### Job commands (same names on Slurm and PBS)

| command | does |
|---|---|
| `sq` | list my jobs |
| `sqr` | list my running jobs |
| `sqls` | list my jobs with their working directories |
| `sqdir <id\|name>` | print a job's working directory |
| `sqcd <id\|name>` / `ficd` | cd into a job's working directory |
| `hpc-summary` / `node-summary` | how busy the machine is (below) |
| `ifsubmited` / `ifdirrunning` | is a job running from this directory (or below it)? |
| `reset` | CONTCAR→POSCAR, then resubmit with `$ENV_SUBMIT_CMD` (copies `$ENV_SUBMIT_TEMPLATE` if there's no submit script here) |
| `rma` / `rma -a` | delete VASP outputs (`-a` deletes the inputs too) |

PBS only: `pbsjobs [-x] [ids]` prints my jobs as tab-separated `id name state queue nodes walltime workdir` (`-x` includes finished jobs). The other PBS commands build on it.

### `hpc-summary`

```
hpc-summary [-n] [partition|queue ...]
```

- **Slurm:** one row per partition with total, allocated, idle and other nodes, plus running and pending jobs and the nodes they use. The TOTAL row adds up jobs only, because partitions share nodes.
- **PBS:** a node count (busy, free, down), then running, queued and held jobs per queue. `-n` skips the node count, which takes about 15 s on Aurora.
- With no names it uses the site's `$HPC_SUMMARY_PARTITIONS` / `$HPC_SUMMARY_QUEUES`. If neither is set, it shows everything.

```
Nodes: 10624 total, 10408 busy, 128 free, 88 down/offline, 0 other

QUEUE              RUN_JOBS RUN_NODES   Q_JOBS   Q_NODES     HELD
debug                    18        22        5         7        2
prod                      0         0       95    169504        0
small                     5      2368       71     30017       11
```

### Notes

- **Aurora:** `sq` can take 1–7 s. The time is spent waiting on the shared PBS server, not on the script, so avoid polling it in a loop (`watch sq`).
- `dire2cart.py` and `entropy.py` are still Python 2. `sum_dos_*` need `ksh`.

## Adding a new machine

1. `mkdir sites/<name>` and write `sites/<name>/shell.sh` (add `bin/` and `templates/` if needed).
2. Add a detection line to `env_detect_site` in `lib/detect.sh`. Or just run `./install.sh --site <name>`.
3. If it uses a new scheduler, add `scheduler/<sched>/{bin,shell.sh}` with the same command names.

## Binaries

Prebuilt binaries are no longer kept in the repo. Build or download them and put them in `local/bin/`:

- `bader`: <https://theory.cm.utexas.edu/henkelman/code/bader/>
- `nnp-*` (n2p2): <https://github.com/CompPhysVienna/n2p2>
- `lmp_mpi`: LAMMPS, <https://www.lammps.org> (or use the site module)
