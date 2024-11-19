#!/bin/bash
set -ex

echo "Starting run-liquibase.sh script"

echo "Environment variables:"
env

echo "Checking PostgreSQL connection..."
for i in {1..30}; do
  if pg_isready -h matrimony_postgres -U "$POSTGRES_USER" -d "$POSTGRES_DB"; then
    echo "PostgreSQL is ready"
    break
  fi
  echo "Waiting for PostgreSQL to start... (Attempt $i/30)"
  sleep 5
done

if [ $i -eq 30 ]; then
  echo "Timeout waiting for PostgreSQL to start"
  exit 1
fi

echo "PostgreSQL is ready. Running Liquibase..."

# Run Liquibase
set -x
$LIQUIBASE_HOME/liquibase \
  --changelog-file=/liquibase/changelog.xml \
  --url="jdbc:postgresql://matrimony_postgres:5432/$POSTGRES_DB" \
  --username="$POSTGRES_USER" \
  --password="$POSTGRES_PASSWORD" \
  --logLevel=DEBUG \
  update
set +x

echo "Liquibase execution completed"
