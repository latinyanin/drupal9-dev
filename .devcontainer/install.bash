#!/bin/bash

RED='\033[0;31m';
GREEN='\033[0;32m';
NC='\033[0m';
bold=$(tput bold)
normal=$(tput sgr0)

echo `pwd`
sudo cp .devcontainer/develop.settings.php sites/default/settings.php;
cp .devcontainer/launch.json .vscode/launch.json
# get confirmation
read -t 15 -N 1 -p "This will drop database and rebuild site. Continue (y/n)? " answer
echo

# if answer is yes within 15 seconds start updating cluster nodes ...
if [ "${answer,,}" != "y" ]
then
    printf "\n${SUCCESS_COLOR}${bold}Stop rebuild site...\n${NORMAL_COLOR}${normal}"
    exit 0;
fi

printf "\n${GREEN}${bold}Run drush site:install...\n\n${NC}";
drush si --site-name=DEV --account-name=admin --account-pass=admin --account-mail=hello@admin.jet.dev --db-url=mysql://$MYSQL_USER:$MYSQL_PASSWORD@db:3306/$MYSQL_DATABASE -y || { printf "\n${RED}${bold}ERROR Site install ...\n\n${NC}"; exit 1; };
