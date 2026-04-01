#!/bin/bash
#cd ~/Documents/Applications/Wordle1.1
#PATH=$PATH+"/home/$USER/Documents/projets/Wordle/exec-java:"
if [[ ! -d "./tmp" ]]; then
    mkdir tmp
fi
line=$((1 + $RANDOM % 12825))
word=$(grep -n -E ".*" Assets/mots4-6.txt | grep -E "^$line:" | cut -d ":" -f 2)
grep -ow -E ".{${#word}}" Assets/mots4-6.txt > tmp/currentwords.txt
echo "==============================================================================================="
echo "                       BIENVENUE DANS LE WORDLE DU TERMINAL"
echo "            /!\ les accent (é,è,à,â,î,ï,ê,ë,ù,ô) ne sont pas pris en compte /!\ "
echo -e "\033[32mUn caractère en vert est bien placé\033[0m." "\033[33mUn caractère en jaune est mal placé\033[0m." "\033[31mUn caractère en rouge n'est pas dans le mot\033[0m." 
echo -e "===============================================================================================\n"

win=0
field=$(./exec-java Field $word)

echo $field | tr " " "\n"

for i in $(seq 0 5); do
    echo -e "\n======================================================================\n"
    echo -e "Taille du mot a trouver: ${#word} \n"
    echo "Entrez un mot :"
    read userInputuserInput
    userInput=$(echo $userInput | tr a-z A-Z |tr -dc A-Z)

    while [ $(grep -cwE $userInput tmp/currentwords.txt) == 0 ]; do
        echo "Votre mot n'est pas de la bonne logueur ou n'existe pas dans le dictionnaire"
        echo "Entrez un mot :"
        read userInput
        userInput=$(echo $userInput | tr a-z A-Z |tr -dc A-Z)
    done
    field=$(exec-java Print $field $userInput $i $word)
    echo $field | tr " " "\n"
    # cas de victoire
    if [ "$userInput" = "$word" ] 
    then
        win=1
        echo "egalité"
        break
    fi
done

if [ $win = 1 ] 
then
    echo "Bien joué vous avez trouvé !!"
else 
    echo "Dommage, c'est raté! le mot était '${word}'."
fi
echo -e "Pour rejouer, relancez le programme. \nPour quitter, appuyer sur [ENTREE]"
read 
rm -r ./tmp
exit