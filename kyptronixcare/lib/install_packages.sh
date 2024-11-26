#!/bin/bash

# List of packages to add
packages=(
    "connectivity_plus"
    "google_fonts"
    "logger"
    "gap"
    "bloc"
    "flutter_bloc"
    "equatable"
    "get_it"
)

# Loop through the list and run flutter pub add command for each package
for package in "${packages[@]}"
do
  echo "Adding package: $package"
  flutter pub add $package
done

echo "All packages have been added."
