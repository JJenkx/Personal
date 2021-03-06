#!/bin/sh
# Last Change: 2022/04/08
# Apt-fast with Aria2 Pro Core https://github.com/P3TERX/Aria2-Pro-Core
# Modified from https://gist.github.com/voyeg3r/409041


# Install local user: 
# mkdir -p $HOME/.local/scripts ; curl https://raw.githubusercontent.com/JJenkx/Personal/main/apt_fast.sh >$HOME/.local/scripts/apt_fast.sh ; userhome="$HOME" ; sudo chmod +x "$userhome"/.local/scripts/apt_fast.sh


# Auto add $HOME/.local/scripts to $PATH ?
# Uncomment and add to .bashrc file

# if [ -d "$HOME/.local/scripts" ]
# then
#   case :$PATH: # notice colons around the value
#     in *:$HOME/.local/scripts:*) ;; # do nothing, it's there
#        *) export PATH=$PATH:$HOME/.local/scripts ;;
#   esac
# fi


# apt-fast with proxy:
# aria2c -s 20 -j 10 --http-proxy=http://username:password@proxy_ip:proxy_port -i apt-fast.list

[ "`whoami`" = root ] || exec sudo "$0" "$@"

# If the user entered arguments contain upgrade, install, or dist-upgrade
if echo "$@" | grep -q "upgrade\|install\|dist-upgrade"; then
  
  printf "\n"
  printf "\033[1;33mapt_fast\033[1;0m with \033[1;29mAria2 Pro Core\033[1;0m started."
  printf "\n"
  
  # Have apt-get print the information, including the URI's to the packages
  # Strip out the URI's, and download the packages with Aria2 Pro Core for speediness
  apt -y --print-uris $@ 2>/dev/null | egrep -o -e "(https?|ftp)://(www\.)?[^\']+" > /tmp/apt-fast.list;
  
  
  # Put filecount in variable
  lines="$(wc -l < /tmp/apt-fast.list)"
  
  if [ "$lines" -ne "0" ]
  then
    # Set here Aria2 Max Connections and Concurrent Downloads
    max_connection_per_server="36"
    max_concurrent_downloads="4"
    
    
    # Predefine Split to use all connections.
    split="$max_connection_per_server"
    
    
    #Calculate value Aria2 --max-concurrent-downloads=<value>
    #Calculate value Aria2 --split=<value>
    
    if [ "$lines" -ge "$max_concurrent_downloads" ]
    
    then
      split="$((max_connection_per_server/max_concurrent_downloads))"
    else
      
      if [ "$lines" -ne "1" ]
      then
        if [ "$lines" -eq "2" ]
        then
          split="$((max_connection_per_server/2))"
        fi
        
        if [ "$lines" -eq "3" ]
        then
          split="$((max_connection_per_server/3))"
        fi
        
        if [ "$lines" -eq "4" ]
        then
          split="$((max_connection_per_server/4))"
        fi
        
        if [ "$lines" -gt "4" ]
        then
          split="$((max_connection_per_server/max_concurrent_downloads))"
        fi
      
      fi
    
    fi
  
## Adjust $max_concurrent_downloads if there could be a single file remaining that downloads by #itself
#remainder="$((lines%$max_concurrent_downloads))"
#
#if [ "$lines" -ge "$max_concurrent_downloads" ]
#then   
#  if [ "$remainder" -le "1" ]
#  then 
#    max_concurrent_downloads="$((max_concurrent_downloads-1))"
#    split="$((max_connection_per_server/max_concurrent_downloads))"
#  fi
#fi
  
    echo "Set Aria2 --max-concurrent-downloads=$max_concurrent_downloads"
    echo "Set Aria2 --split=$split\n"
    aria2c --download-result=full --continue=true --split="$split" --max-connection-per-server="$max_connection_per_server" --max-concurrent-downloads="$max_concurrent_downloads" --min-split-size=8K --piece-length=8K --lowest-speed-limit=1K --dir="/var/cache/apt/archives" --input-file="/tmp/apt-fast.list" --connect-timeout=600 --timeout=600 -m0;
    
    
    # Show list of files downloaded sorted by size
    printf "\n\033[1;37mFiles downloaded: Sorted by size\n\033[;0m"
    exa -lF --group-directories-first --ignore-glob="lock|partial" --no-permissions --no-user --no-time -s size /var/cache/apt/archives
    printf "\n\n"

    
    
    # Perform the user's requested action via apt-get
    
    apt $@ -y;
    
    printf "\n\033[1;33mapt_fast\033[1;0m with \033[1;29mAria2 Pro Core\033[1;0m finished.\n\n\033[1;29m$lines\033[1;0m files downloaded with \033[1;29mAria2\033[1;0m and installed with \033[1;29mapt\n\n"
    
    sudo apt clean
  
  else
  
    printf "\n\033[1;31mNo updates found.\n\033[;0m\n"
  
  fi

else

  apt $@;

fi



# Usage

# Update and Upgrade
# sudo apt update && sudo apt_fast.sh upgrade

# Install
# sudo apt_fast.sh install <PackageNames>



# My Aliases

# Install
# alias apti='sudo $HOME/.local/scripts/apt_fast.sh install'

#Update and Upgrade
# alias aptuu='sudo apt update && sudo $HOME/.local/scripts/apt_fast.sh upgrade'
