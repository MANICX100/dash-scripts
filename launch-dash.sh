#!/bin/bash
for file in ~/bin/*; do
    if [ -f "$file" ]; then
        . "$file"
    fi
done
exec /bin/dash

