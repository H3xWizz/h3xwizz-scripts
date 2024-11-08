#!/bin/bash

# Function to display the header
function showHeader() {
    cat << "EOF"
 _   _ _____    __        ___             ____            _       _       
| | | |___ /_  _\ \      / (_)________   / ___|  ___ _ __(_)_ __ | |_ ___ 
| |_| | |_ \ \/ /\ \ /\ / /| |_  /_  /   \___ \ / __| '__| | '_ \| __/ __|
|  _  |___) >  <  \ V  V / | |/ / / /     ___) | (__| |  | | |_) | |_\__ \
|_| |_|____/_/\_\  \_/\_/  |_/___/___|   |____/ \___|_|  |_| .__/ \__|___/
                                                         |_|            

Swap Cleaner Installation Script...
EOF
}

# Function to display the Linux scripts menu
function linuxScriptsMenu() {
    while true; do
        clear
        showHeader
        echo "1. Dev Setup"
        echo "2. Install Swap Cleaner"
        echo "3. Exit"
        echo -n "Choose an option: "
        read choice

        case $choice in
            1)
                echo "Running Dev Setup..."
                dev_command='bash <(curl -sL https://raw.githubusercontent.com/H3xWizz/h3xwizz-scripts/refs/heads/main/linux/dev_setup.sh)'
                eval $dev_command
                echo "Bye..."
                break
                ;;
            2)
                echo "Running Install Swap Cleaner..."
                swap_command='curl -sL -o /tmp/install_swap_cleaner.sh https://raw.githubusercontent.com/H3xWizz/h3xwizz-scripts/refs/heads/main/linux/install_swap_cleaner.sh && sudo bash /tmp/install_swap_cleaner.sh'

                # Prompt the user for --limit-percent value
                echo -n "--limit-percent (DEFAULT: 50): "
                read limit_percent
                if [ -n "$limit_percent" ]; then
                    swap_command+=" --limit-percent $limit_percent"
                fi

                # Prompt the user for --sleep-time value
                echo -n "--sleep-time (DEFAULT: 30): "
                read sleep_time
                if [ -n "$sleep_time" ]; then
                    swap_command+=" --sleep-time $sleep_time"
                fi

                # Execute the swap cleaner command
                eval $swap_command
                echo "Bye..."
                break
                ;;
            3)
                echo "Bye..."
                break
                ;;
            *)
                echo "Invalid option! Please try again."
                ;;
        esac
    done
}

# Check the operating system and call the appropriate menu
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "MacOS detected. This script is for Linux only."
else
    echo "Linux detected."
    linuxScriptsMenu
fi
