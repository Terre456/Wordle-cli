#! /data/data/com.termux/files/usr/bin/bash
cd $(dirname $0)
if [[ ! -f "$HOME/.profile" ]]; then touch $HOME/.profile; chmod +x $HOME/.profile; fi
if test -z $(grep -Pz "(?s)# Wordle commands.*\n.*# Fin Wordle commands" $HOME/.profile) 
then echo -e "# Wordle commands\nalias wordle=\"bash $HOME/Wordle/main.sh\"\n# Fin Wordle commands" >> $HOME/.profile
fi

if [[ ! -d $HOME/Wordle ]]; then mkdir $HOME/Wordle ; fi
cp -r bin Assets lib exec-java main.sh $HOME/Wordle
. $HOME/.profile
