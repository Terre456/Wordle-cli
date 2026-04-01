#! /data/data/com.termux/files/usr/bin/bash

if [[ ! -f "$HOME/.profile" ]]; then touch $HOME/.profile; chmod +x $HOME/.profile; fi
echo "alias wordle=\"bash $HOME/Wordle/main.sh\"" >> $HOME/.profile

mkdir $HOME/Wordle
cp -r $PWD/* $HOME/Wordle
