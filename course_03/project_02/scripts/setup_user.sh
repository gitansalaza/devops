#!/bin/bash
# Name:        setup_user.sh
# Description: create a new user to run ansible playbooks
# Usage:       ./setup_user.sh # as root
#              or
#              sudo ./setup_user.sh
# Calls:       logger.sh
# Author:      Antonio Salazar (antonio.salazar@ymail.com)
# Date:        2022-04-17
# --------------------------------------------------------

#
# Create or set up new user to run ansible playbooks
#
new_user(){
    #
    # Get OS family
    #
    is_id_like=`grep -E '^ID_LIKE=' /etc/os-release | wc -l` ;

    if [ $is_id_like -eq 0 ]; then
        os_family=`grep -E '^ID=' /etc/os-release | cut -f 2 -d \=`;
    else
        os_family=`grep -E '^ID_LIKE=' /etc/os-release | cut -f 2 -d \=`;
    fi ;
    log_msg "OS family $os_family" ;

    #
    # Ask for username
    #
    read -p 'Please enter the username: ' user ;
    read -p "Please enter the $user password: " -s password ; 
    echo "$password" | sed 's/./*/g';

    #
    # Verify whether the user exists
    #
    log_msg "Verify whether the $user exists" ;
    user_exist=`grep $user /etc/passwd | wc -l`;

    #
    # If user does not exist, then create it
    #
    if [ $user_exist -eq 1 ]; then
        echo "The username: $user already exists." | tee -a ${log_file} ; 
        echo "`grep $user /etc/passwd`" | tee -a ${log_file} ;
    else

        #
        # Add user
        #
        log_msg "Add user $user" ;
        useradd -p $(openssl passwd -crypt $password) $user -m -s /bin/bash | tee -a ${log_file} ; 
        
        #
        # Grant sudoers privilege
        #
        log_msg "Grant sudoers privilege" ;
        # debian like family
        if [[ $os_family =~ "debian" || $os_family =~ "ubuntu" ]]; then
            usermod -aG sudo $user | tee -a ${log_file} ; 
        fi ;

        # rhel/fedora like family
        if [[ $os_family =~ "rhel" || $os_family =~ "fedora" ]]; then
            usermod -aG wheel $user | tee -a ${log_file} ;
        fi ;

        #
        # Create a backup of /etc/sudoers
        #
        log_msg "Backup sudoers file" ;
        cp /etc/sudoers /etc/sudoers.$(date +%Y%m%d-%H%M) ;

        #
        # Is root user set up in ./sudoers file? (1=yes,0=no)
        #
        is_root_sudoer=`grep -E '^root' /etc/sudoers | wc -l`;

        #
        # Append $user to /etc/sudoers.new file
        #
        if [ $is_root_sudoer -eq 1 ]; then

            #
            # If $user exist in ./sudoers file, then replace it. Otherwise append that below root.
            #
            is_user_sudoer=`grep -E "^$user" /etc/sudoers | wc -l` ;

            if [ $is_user_sudoer -eq 1 ]; then
                sed "s/^${user}.*/$user\tALL=(ALL:ALL)\tNOPASSWD\:ALL/g" /etc/sudoers > /etc/sudoers.new ;
            else 
                sed "/^root.*/a $user\tALL=(ALL:ALL)\tNOPASSWD\:ALL" /etc/sudoers > /etc/sudoers.new ;
            fi ;

        else
            cp /etc/sudoers /etc/sudoers.new ;
            echo "${user} ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers.new ;
        fi ;
        #
        # Set the changes to ./sudoers file
        #
        mv /etc/sudoers.new /etc/sudoers;


        #
        # Allow user to connect by ssh
        #
        find_allow_users=`grep -E '^AllowUsers' /etc/ssh/sshd_config | wc -l` ;

        if [ $find_allow_users -eq 0 ]; then
            echo "AllowUsers $user" >> /etc/ssh/sshd_config ;
        else 
            sed "/^AllowUsers.*/ s/$/\ $user/" /etc/ssh/sshd_config > /etc/ssh/sshd_config.new ;
            mv /etc/ssh/sshd_config.new /etc/ssh/sshd_config ;
        fi ;

        #
        # restart sshd service
        #
        systemctl restart sshd ; 

    fi ;
}


#
# Main
#
source ./logger.sh ;

set_log "./logs" ;

log_msg "Starting process..." ;

new_user;

log_msg "Process completed successfully." ;
