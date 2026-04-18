#!/bin/bash

####################################################################
#this script was created for an audit stule need to run an 
#audit script on a remote server and copy the files it 
#generated back onto your local machine

#listed below are variables used in the script
# var 1 (${1}) is the user 
# var 2 (${2})is the ip address or hostname of the remote server

######################################################################
remote_host="${1}@${2}"
aix_script="aix_audit.sh"
linux_script="linux_audit.sh"
afile1="file1.txt"
afile2="file2.txt"
afile3="file3.txt"

lfile1="file4.txt"
lfile2="file5.txt"
lfile3="file6.txt"

#functions to execute the scripts on remote servers

execute_aix () {
        cat "$aix_script"| ssh "$remote_host" bash -s & wait
}

execute_linux () {
        cat "$linux_script"| ssh "$remote_host" bash -s & wait
}

#ssh to remote host and check for if server is AIX or LINUX and execute file on approptiate server
if [[ "$(ssh "$remote_host" 'uname')" == "AIX" ]]; then
        cat "$aix_script"| ssh "$remote_host" bash -s & wait
        #check to see if the files exist
        if [ -e "$afile1" ];then
                #this will copy over the files from remote server back onto your computer
                scp "$remote_host":/home/pi/${afile1} .
                scp "$remote_host":/home/pi/${afile2} .
                scp "$remote_host":/home/pi/${afile3} .
                echo "Files copied successfully"
        
        else
                echo "File not found on remote server"
                #rerun the script (find a way to make running the script a function)
        fi
else
        cat "$linux_script"| ssh "$remote_host" bash -s & wait
        #check to see if the files exist
        if [ -e "$lfile1" ]; then
                #this will copy over the files from remote server back onto your computer
                scp "$remote_host":/home/pi/${lfile1} .
                scp "$remote_host":/home/pi/${lfile2} .
                scp "$remote_host":/home/pi/${lfile3} .
                echo "Files copied successfully"

        else
                echo "File not found on remote server"
                #rerun the script
        fi
fi
exit

