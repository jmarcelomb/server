#!/usr/bin/env bash

# Check if docker is installed
if ! command -v docker &>/dev/null || ! docker compose version &>/dev/null; then
  echo "Error: docker is not installed or not supported." >&2
  exit 1
fi

# Define compose files
COMPOSE_FILES=(
  "./docker-compose.yml"
  "./paperless/docker-compose.yml"
)

# Loop through files and bring up services
for COMPOSE_FILE in "${COMPOSE_FILES[@]}"; do
  if [ -f "$COMPOSE_FILE" ]; then
    docker compose -f "$COMPOSE_FILE" up --no-recreate -d
  else
    echo "Warning: $COMPOSE_FILE not found, skipping."
  fi
done
