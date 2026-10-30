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
  slurm/{bin,shell.sh}        sq sqls sqr sqdir showjob showuserjobs ... ; sqcd/ficd functions
  pbs/{bin,shell.sh}          sq sqls sqr sqdir pbsjobs ;                 sqcd/ficd functions
sites/<name>/                 per-machine overrides
  shell.sh                    modules, conda, env vars
  bin/  templates/            extra tools, submit-script templates
local/                        gitignored: machine-only binaries (local/bin) and secrets (local/shell.sh)
```

PATH priority (highest first) is `local/bin` > `sites/$ENV_SITE/bin` > `scheduler/$ENV_SCHED/bin` > `common/bin`.

### Job commands (same names on Slurm and PBS)

| command | does |
|---|---|
| `sq` | list my jobs |
| `sqr` | list my running jobs |
| `sqls` | list my jobs with their working directories |
| `sqdir <id\|name>` | print a job's working directory |
| `sqcd <id\|name>` / `ficd` | cd into a job's working directory |
| `ifsubmited` / `ifdirrunning` | is a job running from this directory (or below it)? |
| `reset` | CONTCAR→POSCAR, then resubmit with `$ENV_SUBMIT_CMD` (copies `$ENV_SUBMIT_TEMPLATE` if there's no submit script here) |
| `rma` / `rma -a` | delete VASP outputs (`-a` deletes the inputs too) |

## Adding a new machine

1. `mkdir sites/<name>` and write `sites/<name>/shell.sh` (add `bin/` and `templates/` if needed).
2. Add a detection line to `env_detect_site` in `lib/detect.sh`. Or just run `./install.sh --site <name>`.
3. If it uses a new scheduler, add `scheduler/<sched>/{bin,shell.sh}` with the same command names.

## Binaries

Prebuilt binaries are no longer kept in the repo. Build or download them and put them in `local/bin/`:

- `bader`: <https://theory.cm.utexas.edu/henkelman/code/bader/>
- `nnp-*` (n2p2): <https://github.com/CompPhysVienna/n2p2>
- `lmp_mpi`: LAMMPS, <https://www.lammps.org> (or use the site module)
