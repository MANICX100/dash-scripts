#!/bin/bash

# Define the input fish config file
fish_config_file="$1"

# Check if file exists
if [ ! -f "$fish_config_file" ]; then
    echo "Fish configuration file does not exist."
    exit 1
fi

# Ensure the $HOME/bin directory exists
mkdir -p "$HOME/bin"

# Read the fish config file
while IFS= read -r line
do
    # Check if line starts a function
    if [[ $line == function* ]]; then
        # Get the function name
        func_name=$(echo "$line" | awk '{print $2}')
        # Start capturing function body until end keyword
        echo "$line" > "$HOME/bin/$func_name.sh"
        while IFS= read -r line && [[ ! $line == end* ]]; do
            echo "$line" >> "$HOME/bin/$func_name.sh"
        done
        echo "end" >> "$HOME/bin/$func_name.sh"
        chmod +x "$HOME/bin/$func_name.sh"
    elif [[ $line == alias* ]]; then
        # Append the line to the aliases file
        echo "$line" >> "$HOME/bin/aliases.sh"
    fi
done < "$fish_config_file"

# Make the aliases file executable
chmod +x "$HOME/bin/aliases.sh"

