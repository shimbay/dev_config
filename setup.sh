#! /bin/bash

mode=$1

case $mode in
  "base" | "dev") echo "Setup Mode: $mode" ;;
  *)
    echo "illegal mode, base or dev"
    exit
    ;;
esac

remove_and_link() {
  dst=$1
  lnk=$2
  rm -rf $dst
  ln -s $lnk $dst
  echo "remove $dst and link $lnk to $dst"
}

git_clone() {
  url=$1
  dst=$2
  if ! test -d "$dst"; then
    git clone $1 $2
  else
    echo "$1 already exists, skip clone"
  fi
}

WS=$(realpath $(dirname "${BASH_SOURCE[0]}"))
TARGET=$HOME

is_root=0
prefix="sudo"
uid=$(id -u)
if test "$uid" == "0"; then
  is_root=1
  prefix=""
fi

OS=$(uname -s)
if test "$OS" == "Darwin"; then
  echo "Darwin"
elif test "$OS" == "Linux"; then
  $prefix add-apt-repository -y ppa:git-core/ppa
  $prefix apt update
  $prefix apt install -y libncurses-dev autoconf pkg-config software-properties-common libtool libtool-bin git tmux zsh wget curl make vim iproute2
fi

# git
remove_and_link ${TARGET}/.gitconfig ${WS}/.gitconfig

# gdb
remove_and_link ${TARGET}/.gdbinit ${WS}/.gdbinit

# tmux
remove_and_link ${TARGET}/.tmux.conf ${WS}/.tmux.conf

# pip
mkdir -p $TARGET/.pip
remove_and_link ${TARGET}/.pip/pip.conf ${WS}/.pip/pip.conf

# npm
remove_and_link ${TARGET}/.npmrc ${WS}/.npmrc

# zsh & oh-my-zsh
git_clone https://github.com/ohmyzsh/ohmyzsh.git ${TARGET}/.oh-my-zsh
git_clone https://github.com/popstas/zsh-command-time.git ${TARGET}/.oh-my-zsh/custom/plugins/command-time
git_clone https://github.com/zsh-users/zsh-autosuggestions.git ${TARGET}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git_clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${TARGET}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

remove_and_link ${TARGET}/.oh-my-zsh/themes/amuse.zsh-theme ${WS}/.oh-my-zsh/themes/amuse.zsh-theme
remove_and_link ${TARGET}/.oh-my-zsh/custom/plugins/command-time/command-time.plugin.zsh ${WS}/.oh-my-zsh/custom/plugins/command-time/command-time.plugin.zsh

remove_and_link ${TARGET}/.zshrc ${WS}/.zshrc
remove_and_link ${TARGET}/.dedup.sh ${WS}/.dedup.sh

chsh -s /bin/zsh

# .config
mkdir -p ${TARGET}/.config
pushd ${WS}/.config
find * -maxdepth 1 -type d | while read line; do
  rm -rf ${TARGET}/.config/$line
  ln -s ${WS}/.config/$line ${TARGET}/.config/$line
done
popd

# vim & nvim
mkdir -p ${TARGET}/.vim/backup ${TARGET}/.vim/swap ${TARGET}/.vim/undo ${TARGET}/.vim/bundle

remove_and_link ${TARGET}/.vimrc ${WS}/.vimrc
remove_and_link ${TARGET}/.vimrc.base ${WS}/.vimrc.base
remove_and_link ${TARGET}/.vimrc.dev ${WS}/.vimrc.dev.e

# rust
mkdir -p ${TARGET}/.cargo

remove_and_link ${TARGET}/.cargo/config ${WS}/.cargo/config

if test "$mode" == "dev"; then
  git_clone https://github.com/VundleVim/Vundle.vim.git ${TARGET}/.vim/bundle/Vundle.vim
  remove_and_link ${TARGET}/.vimrc.dev ${WS}/.vimrc.dev.r
fi

# miniconda
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
