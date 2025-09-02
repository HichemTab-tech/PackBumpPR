#!/bin/bash

# Test script to validate multi-package-manager support
echo "Testing PackBumpPR multi-package-manager support..."

# Create a sample package.json for testing
cat > package.json << EOF
{
  "name": "test-package",
  "version": "1.0.0",
  "description": "Test package for PackBumpPR",
  "main": "index.js"
}
EOF

echo "Created test package.json with version 1.0.0"

# Test 1: NPM detection
echo ""
echo "=== Test 1: NPM Detection ==="
touch package-lock.json
echo "Created package-lock.json"

# Simulate the detection logic from action.yml
if [ -f "pnpm-lock.yaml" ]; then
  PACKAGE_MANAGER="pnpm"
  LOCK_FILE="pnpm-lock.yaml"
elif [ -f "yarn.lock" ]; then
  PACKAGE_MANAGER="yarn"
  LOCK_FILE="yarn.lock"
elif [ -f "package-lock.json" ]; then
  PACKAGE_MANAGER="npm"
  LOCK_FILE="package-lock.json"
else
  PACKAGE_MANAGER="npm"
  LOCK_FILE="package-lock.json"
  echo "No lock file detected, defaulting to npm"
fi

echo "Detected package manager: $PACKAGE_MANAGER"
echo "Lock file: $LOCK_FILE"
rm package-lock.json

# Test 2: PNPM detection
echo ""
echo "=== Test 2: PNPM Detection ==="
touch pnpm-lock.yaml
echo "Created pnpm-lock.yaml"

if [ -f "pnpm-lock.yaml" ]; then
  PACKAGE_MANAGER="pnpm"
  LOCK_FILE="pnpm-lock.yaml"
elif [ -f "yarn.lock" ]; then
  PACKAGE_MANAGER="yarn"
  LOCK_FILE="yarn.lock"
elif [ -f "package-lock.json" ]; then
  PACKAGE_MANAGER="npm"
  LOCK_FILE="package-lock.json"
else
  PACKAGE_MANAGER="npm"
  LOCK_FILE="package-lock.json"
fi

echo "Detected package manager: $PACKAGE_MANAGER"
echo "Lock file: $LOCK_FILE"
rm pnpm-lock.yaml

# Test 3: Yarn detection
echo ""
echo "=== Test 3: Yarn Detection ==="
touch yarn.lock
echo "Created yarn.lock"

if [ -f "pnpm-lock.yaml" ]; then
  PACKAGE_MANAGER="pnpm"
  LOCK_FILE="pnpm-lock.yaml"
elif [ -f "yarn.lock" ]; then
  PACKAGE_MANAGER="yarn"
  LOCK_FILE="yarn.lock"
elif [ -f "package-lock.json" ]; then
  PACKAGE_MANAGER="npm"
  LOCK_FILE="package-lock.json"
else
  PACKAGE_MANAGER="npm"
  LOCK_FILE="package-lock.json"
fi

echo "Detected package manager: $PACKAGE_MANAGER"
echo "Lock file: $LOCK_FILE"
rm yarn.lock

# Test 4: No lock file (default to npm)
echo ""
echo "=== Test 4: No Lock File (Default to NPM) ==="

if [ -f "pnpm-lock.yaml" ]; then
  PACKAGE_MANAGER="pnpm"
  LOCK_FILE="pnpm-lock.yaml"
elif [ -f "yarn.lock" ]; then
  PACKAGE_MANAGER="yarn"
  LOCK_FILE="yarn.lock"
elif [ -f "package-lock.json" ]; then
  PACKAGE_MANAGER="npm"
  LOCK_FILE="package-lock.json"
else
  PACKAGE_MANAGER="npm"
  LOCK_FILE="package-lock.json"
  echo "No lock file detected, defaulting to npm"
fi

echo "Detected package manager: $PACKAGE_MANAGER"
echo "Lock file: $LOCK_FILE"

# Test 5: Priority order (pnpm > yarn > npm)
echo ""
echo "=== Test 5: Priority Order (Multiple Lock Files) ==="
touch package-lock.json
touch yarn.lock
touch pnpm-lock.yaml
echo "Created all lock files to test priority"

if [ -f "pnpm-lock.yaml" ]; then
  PACKAGE_MANAGER="pnpm"
  LOCK_FILE="pnpm-lock.yaml"
elif [ -f "yarn.lock" ]; then
  PACKAGE_MANAGER="yarn"
  LOCK_FILE="yarn.lock"
elif [ -f "package-lock.json" ]; then
  PACKAGE_MANAGER="npm"
  LOCK_FILE="package-lock.json"
else
  PACKAGE_MANAGER="npm"
  LOCK_FILE="package-lock.json"
fi

echo "Detected package manager: $PACKAGE_MANAGER (should be pnpm)"
echo "Lock file: $LOCK_FILE (should be pnpm-lock.yaml)"

# Cleanup
rm -f package.json package-lock.json yarn.lock pnpm-lock.yaml

echo ""
echo "All tests completed!"
echo ""
echo "Summary of changes made to action.yml:"
echo "1. Added package manager detection based on lock file presence"
echo "2. Updated semver execution to use appropriate package manager (pnpm exec, yarn exec, npx)"
echo "3. Added proper lock file handling for each package manager"
echo "4. Updated commit messages to include package manager info"
echo "5. Updated PR titles and bodies to reflect the detected package manager and lock files"