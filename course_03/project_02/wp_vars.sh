#!/bin/bash
# Name:        wp_vars.sh
# Description: assist to create wp_vars.yaml vault encrypted file
# Author:      Antonio Salazar (antonio.salazar@ymail.com)
# Date:        2022-04-26
# --------------------------------------------------------

#
# Abort
#
quit() {
    echo "Something went wrong." ;
    exit 1;
}

# set up the new user in the local host
clear;
echo "-------------------------------------------------------" ;
echo "Setup and encrypt the wp_vars.yaml vault file." ;
echo "-------------------------------------------------------" ;

# Read the inputs from user
read -p "Please input the 'Vault Password': " -s vault_password ; 
echo "$vault_password" | sed 's/./*/g';

echo "The build username is $USER" ;
read -p "Enter the $USER user password: " -s build_password ;
echo "$build_password" | sed 's/./*/g';

echo "............................."
echo "- WordPress variables setup -"
echo "............................."
echo "The Admin DB user is named 'root'";
read -p "Please enter the DB admin user root password': " -s db_rootpasswd ; 
echo "$db_rootpasswd" | sed 's/./*/g';

echo "- WordPress DB variables -"
read -p 'Please enter the DB name: ' db_name ;
read -p 'Please enter the DB user: ' db_username ;
read -p "Please enter the DB $db_username user password: " -s db_password ;
echo "$db_password" | sed 's/./*/g';

echo "- WordPress App variables -"
echo "The WordPress installation path is /var/www/html" ; 
read -p 'Please enter the application name: ' app_name ;

#
# Create vault key and encrypts it
#
[ -f .bldkey ] && rm -f .bldkey ;
echo "$vault_password" > .bldkey ;
chmod 400 .bldkey ;
unset vault_password ;

# 
# Create wp_vars.yaml file
#
echo "---" > wp_vars.yaml ;
echo "build_username: ${USER}" >> wp_vars.yaml;
echo "build_password: ${build_password}" >> wp_vars.yaml ;
echo "root_passwd: ${db_rootpasswd}" >> wp_vars.yaml ;
echo "db_user: ${db_username}" >> wp_vars.yaml ;
echo "db_passwd: ${db_password}" >> wp_vars.yaml ;
echo "db_name: ${db_name}" >> wp_vars.yaml ;
echo "install_path: /var/www/html" >> wp_vars.yaml ;
echo "app_name: ${app_name}" >> wp_vars.yaml ;
echo "table_prefix: 'wp_'" >> wp_vars.yaml ;
echo "debug_mode: 'FALSE'" >> wp_vars.yaml ;
echo "..." >> wp_vars.yaml ;

[ $? -ne 0 ] && quit ;

#
# Encrypt the wp_vars.yaml file
#
echo "The file 'wp_vars.yaml' has been created successfully."
echo "Encrypt the 'wp_vars.yaml' file . . ."
ansible-vault encrypt wp_vars.yaml --vault-password-file=.bldkey;
