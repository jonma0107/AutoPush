#!/bin/bash

# Define the file to watch
file_to_watch_1="abril.txt"
file_to_watch_2="pendientes.txt"
# Function to handle changes
handle_change() {
  echo "Changes detected in $file_to_watch_1 and $file_to_watch_2. Committing and pushing changes..."
  git add "$file_to_watch_1" "$file_to_watch_2"
  git commit -m "actualización de archivos"
  git push origin HEAD
  echo "Changes committed and pushed."
}

# Get initial state
initial_state=$(stat "$file_to_watch_1" "$file_to_watch_2")

# Loop indefinitely
while true; do
  current_state=$(stat "$file_to_watch_1" "$file_to_watch_2")

  # Compare current state with initial state
  if [ "$current_state" != "$initial_state" ]; then
    handle_change
    initial_state=$current_state
  fi

  # Wait for a short interval before checking again
  sleep 5
done