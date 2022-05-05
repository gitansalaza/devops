#!/bin/bash
# Name:        logger.sh
# Description: script used as library for logging messages
# Usage:       source ./logger.sh   # To include it as linrary in the script header
#              log_msg "Proces executed successfully." 
#              or 
#              log_msg "Error" "Somethig went wrong..."
# Author:      Antonio Salazar (antonio.salazar@ymail.com)
# Date:        2022-04-24
# --------------------------------------------------------

#
# Get the script name
#
export script_base=$(basename $0) ;

#
# Create the log_file
#
set_log() {
    export script_name=$(echo $script_base | cut -f 1 -d ".");
    export date_stamp=$(date +%Y%m%d_%H%M%S) ;
    # if log_home argument is empty then define the current directory as log_home
    if [ "$#" -lt 1 ]; then
        export log_home=$(pwd) ;
    else
        export log_home="$1" ;
        # create the log directory if does not exist
        [ ! -d $log_home ] && mkdir -p $log_home ;
    fi ;
    export log_filename="${script_name}_${date_stamp}.log" ;
    export log_file="${log_home}/${log_filename}" ;
    [ ! -f $log_file ] && touch $log_file ;
   
    echo "===========================================================" | tee -a ${log_file} ;
    echo "Script:   ${script_name}"                                    | tee -a ${log_file} ;
    echo "Hostname: $(hostname -f)"                                    | tee -a ${log_file} ;
    echo "Date:     $(date)"                                           | tee -a ${log_file} ;
    echo "Log:      ${log_file}"                                       | tee -a ${log_file} ;
    echo "===========================================================" | tee -a ${log_file} ;
}

#
# get the log file name
#
get_log() {
    return $log_file ;
}
#
# Log a message. Usage: log_msg "Proces executed successfully." or log_msg "Error" "Somethig went wrong..."
#
log_msg() {
    local msg=("$@");
    local msg_type=$(echo ${2:-info} | tr '[:lower:]' '[:upper:]') ; 
    [ ! -z "$2" ] && unset msg[${#msg[@]}-1] ;
    echo -e "$(date '+%Y-%m-%dT%H:%M:%S'):${msg_type}: ${msg[@]}" | tee -a ${log_file} ;
    unset msg;
}