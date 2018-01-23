#!/bin/bash

# Locale and Path varialbes required for miniconda
PRE_BASH_VARS=$(cat <<EOF
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH="$HOME/miniconda/bin:$PATH"
EOF
)

POST_BASH_VARS=$(cat <<EOF
source activate datacubenv
cd $HOME
EOF
)

SHELL_CONFIGS=("$HOME/.profile" "$HOME/.bashrc")
MINICONDA_URL="https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh"
DATACUBE_REPO="https://github.com/opendatacube/datacube-core"
DATACUBE_TAG="$1"
PYTHON_VERSION="3.6"

cd $HOME

# SET SHELL VARIABLES
for ele in ${SHELL_CONFIGS[@]}
do
    echo "$PRE_BASH_VARS" >> "$ele"
done

# Install conda
wget -q $MINICONDA_URL -O $HOME/miniconda.sh
bash $HOME/miniconda.sh -b -f -p $HOME/miniconda
rm $HOME/miniconda.sh

# reload bash_profile
source $HOME/.profile

# Download copy of the repo // Could be linked instead for local dev
git clone --depth 1 -b $DATACUBE_TAG $DATACUBE_REPO datacube-core
cd datacube-core

conda config --set always_yes yes --set changeps1 yes

conda config --prepend channels conda-forge
conda update --all

conda create -n datacubenv python=$PYTHON_VERSION

conda clean --all --yes

source activate datacubenv

conda env update -n datacubenv --file $HOME/datacube-install/environment.yaml
pip install . --no-deps --upgrade

conda clean --all --yes

# SET SHELL VARIABLES
for ele in ${SHELL_CONFIGS[@]}
do
    echo "$POST_BASH_VARS" >> "$ele"
done
