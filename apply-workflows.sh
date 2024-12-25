#!/bin/bash

# Define directories
TEMPLATES_DIR="atomics"
WORKFLOWS_DIR="workflows"
NAMESPACE="argo"

# Function to apply files in a directory
apply_files() {
    local dir=$1
    echo "Applying YAML files in $dir..."
    find "$dir" -type f -name "*.yaml" | while read -r file; do
        echo "Applying $file..."
        kubectl apply -f "$file" -n "$NAMESPACE"
    done
}

# Apply all files in templates and workflows directories
if [ -d "$TEMPLATES_DIR" ]; then
    apply_files "$TEMPLATES_DIR"
else
    echo "Templates directory $TEMPLATES_DIR does not exist."
fi

if [ -d "$WORKFLOWS_DIR" ]; then
    apply_files "$WORKFLOWS_DIR"
else
    echo "Workflows directory $WORKFLOWS_DIR does not exist."
fi

echo "All YAML files applied successfully!"
