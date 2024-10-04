# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$HOME/Script:$HOME/bin/vtstscripts-967:$PATH"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export PS1='[\u@\h \w]\$ '
#export PS1='\[\e[35m\u\] \[\e[35m\w\] \[\e[35m\]\[\e[1m\]$ \[\e[0m\]'

LS_COLORS='no=00:fi=00:di=01;33:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=0
1;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32
:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;3
1:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm
=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'

alias emacs="emacs -nw"

#alias sq='squeue -u changai'
alias sq='~/bin/sq.sh'
alias sqls='source ~/bin/sqls.sh'
alias sqcd='source ~/bin/sqcd.sh'
alias sqr='source ~/bin/sqr.sh'
alias ficd='source ~/bin/ficd.sh'
alias grepr='grep "reached required" OUTCAR; grep "energy without" OUTCAR|tail -1; less OSZICAR|tail -1'
#alias grepr='~/bin/grepr.sh'
alias grepe='~/bin/grepe.sh'
alias rma='~/bin/rma.sh'
alias ifreachedreq='source ~/bin/ifreachedreq.sh'

function cpot {
for i in $*
do
cat /home/energy/modules/software/VASP/vasp-potpaw-5.4/potpaw_PBE/$i/POTCAR >> POTCAR
done	
}

################# queue format #####################
export SQUEUE_FORMAT="%.18i %.9P %.8j %.8u %.10T %.9Q %.10M %.9l %.6D %.6C %R"

################# add module ###################
module use /home/energy/changai/software/modules
module use /home/energy/modules/modules/all
module use /home/energy/jchang/modules/modules/all

##################### load #########################
module load lrzsz/lrzsz   #lrzsz
module load vesta/vesta-gtk3  #vesta
module load vaspkit/vaspkit  #vaspkit
#module load miniconda3  #miniconda3


###################### ase-vasp ####################
#ASE_VASP_VDW=/home/energy/modules/software/VASP/vasp-potpaw-5.4
#VASP_SCRIPT=$HOME/bin/run_vasp.py #for Vasp
#ASE_VASP_COMMAND="mpiexec vasp_std"  #for Vasp2

################## ase-vasp & ase-gpaw ###############
#module load VASP/5.4.4-intel-2019b
#module load ASE/3.20.1-intel-2019b-Python-3.7.4
#module load ASE
export ASE_VASP_VDW=/home/energy/modules/software/VASP/vasp-potpaw-5.4
export VASP_PP_PATH=/home/energy/modules/software/VASP/vasp-potpaw-5.4/
#export ASE_VASP_COMMAND="mpiexec vasp_std"  #for Vasp
export ASE_VASP_COMMAND="mpiexec -n 24 vasp_std"  #for Vasp
#module load GPAW/20.10.0-intel-2019b-ASE-3.20.1-Python-3.7.4
#module load module load ASAP3/3.11.10-intel-2018b-ASE-3.18.0-Python-3.6.6
#################################################

# set p4vasp environment variables
#export PATH=$PATH:/home/energy/changai/p4vasp/bin

################### catmap #####################
export PYTHONPATH=/home/energy/changai/software/catmap/catmap:$PYTHONPATH

#source /home/energy/stly/batman-summerschool/activate.sh

export PYTHONPATH=$PYTHONPATH:/home/energy/changai/software/asc-scripts/
export PATH=$PATH:/home/energy/changai/software/asc-scripts/bin

##################kitchin###############
export PYTHONPATH=/home/energy/changai/software/vasp-python3:$PYTHONPATH
export PATH=/home/energy/changai/software/vasp-python3/bin:$PATH

export MESA_GL_VERSION_OVERRIDE=3.3 # for mayavi

export PATH=/home/energy/changai/software/miniconda3/bin:$PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/energy/changai/software/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/energy/changai/software/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/energy/changai/software/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/energy/changai/software/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda deactivate
