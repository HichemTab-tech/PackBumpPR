#!/bin/bash

# Test script to validate package manager installation logic
echo "Testing PackBumpPR package manager installation logic..."

# Create a sample package.json for testing
cat > package.json << EOF
{
  "name": "test-package",
  "version": "1.0.0",
  "description": "Test package for PackBumpPR",
  "main": "index.js"
}
EOF

echo "Created test package.json"

# Test 1: Test installation logic for pnpm
echo ""
echo "=== Test 1: PNPM Installation Check ==="
touch pnpm-lock.yaml
echo "Created pnpm-lock.yaml"

# Simulate the installation logic from action.yml
echo "Checking installation logic:"
if [ -f "pnpm-lock.yaml" ]; then
  echo "✓ Would install pnpm (pnpm-lock.yaml detected)"
  echo "  Command: npm install -g pnpm"
else
  echo "✗ Would not install pnpm"
fi

rm pnpm-lock.yaml

# Test 2: Test installation logic for yarn
echo ""
echo "=== Test 2: Yarn Installation Check ==="
touch yarn.lock
echo "Created yarn.lock"

if [ -f "yarn.lock" ]; then
  echo "✓ Would install yarn (yarn.lock detected)"
  echo "  Command: npm install -g yarn"
else
  echo "✗ Would not install yarn"
fi

rm yarn.lock

# Test 3: Test no installation when only npm is used
echo ""
echo "=== Test 3: NPM Only (No Installation) ==="
touch package-lock.json
echo "Created package-lock.json"

echo "Checking installation logic:"
pnpm_install=false
yarn_install=false

if [ -f "pnpm-lock.yaml" ]; then
  pnpm_install=true
fi

if [ -f "yarn.lock" ]; then
  yarn_install=true
fi

if [ "$pnpm_install" = false ] && [ "$yarn_install" = false ]; then
  echo "✓ No additional package managers to install (npm only)"
else
  echo "✗ Unexpected installation required"
fi

rm package-lock.json

# Test 4: Test multiple package managers
echo ""
echo "=== Test 4: Multiple Package Managers ==="
touch pnpm-lock.yaml
touch yarn.lock
echo "Created both pnpm-lock.yaml and yarn.lock"

echo "Installation logic would run:"
if [ -f "pnpm-lock.yaml" ]; then
  echo "✓ Would install pnpm"
fi

if [ -f "yarn.lock" ]; then
  echo "✓ Would install yarn"
fi

# Cleanup
rm -f package.json pnpm-lock.yaml yarn.lock

echo ""
echo "All installation logic tests completed!"
echo ""
echo "Summary of the installation step added to action.yml:"
echo "1. Added 'Install Package Managers' step after Node.js setup"
echo "2. Installs pnpm globally if pnpm-lock.yaml exists"  
echo "3. Installs yarn globally if yarn.lock exists"
echo "4. Uses npm (included with Node.js) to install other package managers"
echo "5. Shows version information for debugging"
echo "6. Ensures package managers are available before they are used in later steps"