#!/usr/bin/env bash
#
# Usage: ./update.sh [pattern]
#
# Specify [pattern] to update only repos that match the pattern.
#
# When deleting plugins, uncomment here and delete in bundles directory

repos=(
   tpope/vim-pathogen

   airblade/vim-gitgutter #Plugin to show changed lines in file being modified
#  alampros/vim-styled-jsx
#   altercation/vim-colors-solarized
#  ap/vim-css-color
#  docunext/closetag.vim
#  ervandew/supertab
#  haya14busa/incsearch.vim
   itchyny/lightline.vim #Bottom status line in vim
   itchyny/vim-gitbranch #Used to show git branch in lightline
#  junegunn/fzf.vim
#  junegunn/goyo.vim
#  mileszs/ack.vim
   nathanaelkane/vim-indent-guides #show guide line where indent tabs occur
#  qpkorr/vim-bufkill
#  scrooloose/nerdtree
   sheerun/vim-polyglot #Indentation and syntax support for various langs
#  statico/vim-inform7
#  tomasr/molokai
   tpope/vim-commentary #Commenting blocks of code or lines - Select in visual mode and 'gc'
#  tpope/vim-endwise
#  tpope/vim-eunuch
   tpope/vim-fugitive #Git handling in vim
   tpope/vim-repeat #Repeat last command using '.'
#  tpope/vim-rhubarb
   tpope/vim-sleuth #Change shiftwidth and expandtab based on opened file
#   tpope/vim-surround
#  tpope/vim-sensible
#  tpope/vim-unimpaired
   w0rp/ale #linter
#  wellle/targets.vim
   vim-scripts/desert256.vim #colour scheme
   majutsushi/tagbar #Show tags in sidebar
   ludovicchabant/vim-gutentags #Generate tags for a file
   ntpeters/vim-better-whitespace #Show trailing whitespace
   neoclide/coc.nvim #Intellisense
)

set -e
dir=~/dotfiles/vim/bundle

if [ ! -d $dir ]
then
  mkdir $dir
fi

wd=`pwd`
for repo in ${repos[@]}; do
  if [ -n "$1" ]; then
    if ! (echo "$repo" | grep -i "$1" &>/dev/null) ; then
      continue
    fi
  fi
  plugin="$(basename $repo | sed -e 's/\.git$//')"
  [ "$plugin" = "vim-styled-jsx" ] && plugin="000-vim-styled-jsx" # https://goo.gl/tJVPja
  dest="$dir/$plugin"
  (
    if [ -d $dest ]
    then
      cd $dest
      git pull
      cd $wd
      echo ". Updated $repo"
    else
      rm -rf $dest
      git clone --depth=1 -q https://github.com/$repo $dest
      echo "· Cloned $repo"
    fi
   ) &
done
wait
