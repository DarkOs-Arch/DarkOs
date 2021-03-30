green="\e[1;32m"
blue="\e[1;34m"
cyan="\e[1;36m"
purple="\e[1;35m"
reset="\e[1;49;39m"
yellow="\e[1;33m"
red="\e[1;31m"
col1="\e[38;5;208m"
col2="\e[38;5;203m"
echo -e "
     ┌──────────────────────────────────────────────────────────────┐
     │                Welcome to DarkOs $green'Schmedding'$reset                │ 
     │──────────────────────────────────────────────────────────────│
     │                                                              │
     │  $blue Standard install$reset:                                          │
     │                                                              │
     │      installer                                               │
     │                                                              │
     │  $purple Run a live session$reset:                                        │
     │                                                              │
     │      installer -l [session]                                  │
     │                                                              │
     │  $red Change the installation name$reset:                              │
     │                                                              │
     │      installer -d 'MyDistro'                                 │
     │                                                              │
     │  $col1 Set root and/or boot partitions$reset:                           │
     │                                                              │
     │      installer -r ROOT -b BOOT                               │
     │                                                              │
     │  $col2 Manual install$reset:                                            │
     │                                                              │
     │    Instructions in install.txt                               │
     │                                                              │
     └──────────────────────────────────────────────────────────────┘
 "
 ./.starts && rm .starts
