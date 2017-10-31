#!/usr/bin/env bash
#
# Usage: ./update.sh [pattern]
#
# Specify [pattern] to update only repos that match the pattern.
#
# When deleting plugins, uncomment here and delete in bundles directory

repos=(

   airblade/vim-gitgutter
#  alampros/vim-styled-jsx
#   altercation/vim-colors-solarized
#  ap/vim-css-color
#  docunext/closetag.vim
#  ervandew/supertab
#  haya14busa/incsearch.vim
   itchyny/lightline.vim
#  junegunn/fzf.vim
   junegunn/goyo.vim
#  mileszs/ack.vim
   nathanaelkane/vim-indent-guides
#  qpkorr/vim-bufkill
#  scrooloose/nerdtree
   sheerun/vim-polyglot
#  statico/vim-inform7
   tomasr/molokai
   tpope/vim-commentary
#  tpope/vim-endwise
#  tpope/vim-eunuch
   tpope/vim-fugitive
   tpope/vim-pathogen
   tpope/vim-repeat
#  tpope/vim-rhubarb
   tpope/vim-sleuth
#   tpope/vim-surround
#  tpope/vim-sensible
#  tpope/vim-unimpaired
   w0rp/ale
#  wellle/targets.vim
   vim-scripts/desert256.vim

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
