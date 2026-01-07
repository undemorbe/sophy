#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Running Static Analysis..."
flutter analyze

echo "Running Tests with Coverage..."
flutter test --coverage

echo "Generating Coverage Report..."
# Ensure lcov is installed or skip
if command -v lcov &> /dev/null; then
    genhtml coverage/lcov.info -o coverage/html
    echo "Coverage report generated at coverage/html/index.html"
else
    echo "lcov not found, skipping HTML report generation."
fi

echo "CI Check Completed Successfully!"
