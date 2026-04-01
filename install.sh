#!/bin/bash
app=~/.local/share/applications/Wordle.desktop
dest=~/Documents/Applications/Wordle1.1
mkdir -p $dest/tmp
echo "[Desktop Entry]
Type=Application
Name=Wordle
Comment= Ouvre un wordle dans un terminal
Icon=/home/$USER/Documents/Applications/Wordle/Assets/image_wordle.jpg
Exec=/home/$USER/Documents/Applications/Wordle/main.sh
Terminal=true
StartupNotify=false
Categories=Application;" > $app
chmod +x $app

cp -r Assets $dest
cp -r bin $dest
cp -r lib $dest
#a verifier
#cp -r .vscode $dest
#
cp compile $dest
cp exec-java $dest
cp main.sh $dest
cp README.md $dest

echo Installation Terminée. Lancez le jeu depuis le menu demarrer

