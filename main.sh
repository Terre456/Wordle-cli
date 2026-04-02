#!/bin/bash
printf "\033[8;25;90t"
echo -ne "\033]0;Wordle\007"
cd $(dirname $0)
exec-java() { 
    java -cp .:lib/JColor-5.5.1.jar:bin $@ 
}

if [[ ! -d "./tmp" ]]; then
    mkdir tmp
    touch tmp/currentwords.txt
fi
line=$((1 + $RANDOM % 12825))
word=$(grep -n -E ".*" "Assets/mots4-6.txt" | grep -E "^$line:" | cut -d ":" -f 2)
grep -ow -E ".{${#word}}" "Assets/mots4-6.txt" > "tmp/currentwords.txt"
echo    "=========================================================================================="
echo    "                       BIENVENUE DANS LE WORDLE DU TERMINAL"
echo    "            /!\ les accent (é,è,à,â,î,ï,ê,ë,ù,ô) ne sont pas pris en compte /!\ "
echo -e "\033[32mUn caractère en vert est bien placé\033[0m."
echo -e "\033[33mUn caractère en jaune est mal placé\033[0m."
echo -e "\033[31mUn caractère en rouge n'est pas dans le mot\033[0m."
echo    "=========================================================================================="

win=0
field=$(exec-java Field $word)

echo $field | tr " " "\n"

for i in $(seq 0 5); do
    echo -e "\n==========================================================================================\n"
    echo -e "Taille du mot a trouver: ${#word} \n"
    echo "Entrez un mot :"
    read userInput
    userInput=$(echo $userInput | tr a-z A-Z |tr -dc A-Z)

    while test $(grep -cwE $userInput tmp/currentwords.txt) -eq 0 ; do
        echo "Votre mot n'est pas de la bonne longueur ou n'existe pas dans le dictionnaire"
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

if [[ $win -eq 1 ]] 
then
    echo -e "\033[32mBien joué vous avez trouvé !!\033[32m"
else 
    echo -e "\033[31mDommage, c'est raté! le mot était '${word}'.\033[31m"
fi
echo -e "Pour rejouer, relancez le programme. \nPour quitter, appuyer sur [ENTREE]"
read 
rm -r ./tmp
exit