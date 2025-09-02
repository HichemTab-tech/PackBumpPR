#!/bin/bash

# Test script to understand package manager detection
echo "Testing package manager detection logic..."

# Function to detect package manager
detect_package_manager() {
    if [ -f "pnpm-lock.yaml" ]; then
        echo "pnpm"
    elif [ -f "yarn.lock" ]; then
        echo "yarn"
    elif [ -f "package-lock.json" ]; then
        echo "npm"
    else
        echo "unknown"
    fi
}

# Test the detection
echo "Current package manager: $(detect_package_manager)"

# Test different lock files
echo ""
echo "Testing with different lock files:"

# Create test lock files
touch pnpm-lock.yaml
echo "With pnpm-lock.yaml: $(detect_package_manager)"
rm pnpm-lock.yaml

touch yarn.lock  
echo "With yarn.lock: $(detect_package_manager)"
rm yarn.lock

touch package-lock.json
echo "With package-lock.json: $(detect_package_manager)"
rm package-lock.json

echo "With no lock file: $(detect_package_manager)"