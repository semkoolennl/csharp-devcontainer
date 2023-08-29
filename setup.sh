#!/bin/bash

echo "Creating .env file from .env.example"
cp .devcontainer/.env.example .devcontainer/.env

echo "Retrieving user details..."
current_user=$(whoami)
user_uid=$(id -u $current_user)
user_gid=$(id -g $current_user)

echo "Replacing .env values with values of current user..."
sed -i "/^USERNAME=/ s/=.*/=$current_user/" .devcontainer/.env
sed -i "/^USER_UID=/ s/=.*/=$user_uid/" .devcontainer/.env
sed -i "/^USER_GID=/ s/=.*/=$user_gid/" .devcontainer/.env

echo "Creating 'Projects' directory";

echo "Finished seting up the project..."
exit 0
