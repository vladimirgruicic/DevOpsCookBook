#!/bin/bash
# set_project_permissions.sh
# Script to set permissions for the project structure based on user roles.

DEV_GROUP="dev_team"
STAGING_GROUP="staging_team"
PROD_GROUP="prod_team"
ADMIN_GROUP="admins"

PROJECT_DIR="/project"
ENVIRONMENTS=("dev" "staging" "prod")

# Set permissions for each environment
set_permissions() {
    for env in "${ENVIRONMENTS[@]}"; do
        ENV_DIR="$PROJECT_DIR/$env"
        echo "Setting permissions for $ENV_DIR"

        case $env in
            dev)
                chgrp "$DEV_GROUP" "$ENV_DIR"
                chmod 770 "$ENV_DIR"  # Full access for dev_team
                ;;
            staging)
                chgrp "$STAGING_GROUP" "$ENV_DIR"
                chmod 750 "$ENV_DIR"  # Full access for staging_team, read-only for others
                ;;
            prod)
                chgrp "$PROD_GROUP" "$ENV_DIR"
                chmod 750 "$ENV_DIR"  # Full access for prod_team
                setfacl -m g:"$ADMIN_GROUP":rwx "$ENV_DIR"  # Full access for admins
                ;;
        esac
        echo "Permissions set for $ENV_DIR"
    done
}

# Execute the function
set_permissions

# Show final permissions setup
echo "Permissions set for the project directory:"
ls -ld "$PROJECT_DIR"/*
