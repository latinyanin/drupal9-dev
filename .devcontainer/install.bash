#!/bin/bash

RED='\033[0;31m';
GREEN='\033[0;32m';
NC='\033[0m';
bold=$(tput bold)
normal=$(tput sgr0)

# get confirmation
read -t 15 -N 1 -p "This will drop database and rebuild site. Continue (y/N)? " answer
echo

# if answer is yes within 15 seconds start site install ...
if [ "${answer,,}" != "y" ]
then
    printf "\n${SUCCESS_COLOR}${bold}Stop rebuild site...\n${NORMAL_COLOR}${normal}"
    exit 0;
fi

# Copy settings.php to site
sudo chmod 0755 web/sites/default
sudo rm -f web/sites/default/settings.php || { printf "\n${RED}${bold}File setings.php not faund \n\n${NC}"; exit 1; };
sudo cp .devcontainer/develop.settings.php web/sites/default/settings.php;
mkdir -p .vscode && cp -f .devcontainer/launch.json .vscode/launch.json

printf "\n${GREEN}${bold}Run drush site:install...\n\n${NC}";
# drush si minimal --site-name=DEV --account-name=admin --account-pass=admin --account-mail=hello@admin.jet.dev --db-url=mysql://$MYSQL_USER:$MYSQL_PASSWORD@db:3306/$MYSQL_DATABASE -y || { printf "\n${RED}${bold}ERROR Site install ...\n\n${NC}"; exit 1; };
drush si --existing-config --site-name=DEV --account-name=admin --account-pass=admin --account-mail=hello@admin.jet.dev --db-url=mysql://$MYSQL_USER:$MYSQL_PASSWORD@db:3306/$MYSQL_DATABASE -y || { printf "\n${RED}${bold}ERROR Site install ...\n\n${NC}"; exit 1; };

# get confirmation
read -t 15 -N 1 -p "This will generate content. Continue (Y/n)? " answer
echo
# if answer is yes within 15 seconds start devel generate ...
if [ "${answer,,}" != "n" ]
then
    printf "\n${SUCCESS_COLOR}${bold}Generate content...\n${NORMAL_COLOR}${normal}"
    drush genc 20
    drush genu 5
fi
