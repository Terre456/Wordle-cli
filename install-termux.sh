#! /data/data/com.termux/files/usr/bin/bash
cd $(basename $0)
if [[ ! -f "$HOME/.profile" ]]; then touch $HOME/.profile; chmod +x $HOME/.profile; fi
echo "alias wordle=\"bash $HOME/Wordle/main.sh\"" >> $HOME/.profile

if [[ ! d $HOME/Wordle ]]; then mkdir $HOME/Wordle ; fi
cp -r bin Assets lib exec-java main.sh $HOME/Wordle
