#!/bin/bash
# Script to fix template escaping issues in Jinja2 templates

echo "Fixing template files..."

# Function to fix a single file
fix_file() {
    local file=$1
    echo "Fixing file: $file"
    
    # For macOS compatibility, use a different sed approach with simpler pattern
    # This replaces any onerror attribute containing url_for and no-cover.jpg with a simple static path
    sed -i '' 's/onerror="this\.src='\''{{[^}]*no-cover\.jpg[^}]*}}'\''"/onerror="this.onerror=null; this.src='\''\/static\/img\/no-cover.jpg'\''"/g' "$file" 2>/dev/null || true
}

# Process all template files
find templates -name "*.html" -type f | while read file; do
    fix_file "$file"
done

# Fix any history template files if needed
if [ -d ".history" ]; then
    echo "Fixing history template files..."
    find .history -name "*.html" -type f | while read -r file; do
        fix_file "$file"
    done
fi

echo "Fixing completed!" 