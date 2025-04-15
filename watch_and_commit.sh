#!/bin/bash

# Define the file to watch
file_to_watch="abril.txt"
# Function to handle changes
handle_change() {
  echo "Changes detected in $file_to_watch"
  git add "$file_to_watch"
  git commit -m "actualizacion de archivo"
  git push origin HEAD
  echo "Changes committed and pushed."
}

# Get initial state
initial_state=$(stat "$file_to_watch")

# Loop indefinitely
while true; do
  current_state=$(stat "$file_to_watch")

  # Compare current state with initial state
  if [ "$current_state" != "$initial_state" ]; then
    handle_change
    initial_state=$current_state
  fi

  # Wait for a short interval before checking again
  sleep 5
done