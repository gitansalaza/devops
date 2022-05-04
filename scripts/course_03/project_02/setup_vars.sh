#!/bin/bash
# Name:        setup_vars.sh
# Description: assist to create setup_vars.yaml vault encrypted file
# Author:      Antonio Salazar (antonio.salazar@ymail.com)
# Date:        2022-04-24
# --------------------------------------------------------
# 
# Pause and wait to press any key
# 
set_pause() {
    read -s -n 1 -p "$1";
    echo "" ;
}

#
# Abort
#
quit() {
    echo "Something went wrong." ;
    exit 1;
}

# set up the new user in the local host
echo "-------------------------------------------------------" ;
echo "Create and encrypt the setup_vars.yaml vault file." ;
echo "-------------------------------------------------------" ;

# Read the inputs from user
echo "Please enter the information below." ;
echo "..................................." ;
read -p "1) Enter the 'Vault Password': " -s vault_password ; 
echo "$vault_password" | sed 's/./*/g';

echo  "2) The admin user is: $USER" ; 

read -p "3) Enter the $USER user password: " -s admin_password ; 
echo "$admin_password" | sed 's/./*/g';

read -p '4) Enter the build username: ' build_username ;

read -p "5) Enter the $build_username user password: " -s build_password ;
echo "$build_password" | sed 's/./*/g';

read -p '6) Enter the destination host: [name | IP | group ]: ' dest_host ;
echo "..................................." ;
echo "Thanks for your input." ;

#
# Create vault key and encrypts it
#
[ -f .stvltkey ] && rm -f .stvltkey ;
echo "$vault_password" > .stvltkey ;
chmod 400 .stvltkey ;
unset vault_password ;

# 
# Create setup_vars.yaml file
#
echo "---" > setup_vars.yaml ;
echo "admin_username: ${USER}" >> setup_vars.yaml ;
echo "admin_password: ${admin_password}" >> setup_vars.yaml ;
echo "build_username: ${build_username}" >> setup_vars.yaml ;
echo "build_password: ${build_password}" >> setup_vars.yaml ;
echo "..." >> setup_vars.yaml ;

[ $? -ne 0 ] && quit ;

#
# Encrypt the setup_vars.yaml file
#
echo "The file 'setup_vars.yaml' has been created successfully."
echo "Encrypt the 'setup_vars.yaml' file . . ."
ansible-vault encrypt setup_vars.yaml --vault-password-file=.stvltkey;
