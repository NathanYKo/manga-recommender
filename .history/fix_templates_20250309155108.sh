#!/bin/bash
# Script to fix template escaping issues in Jinja2 templates

echo "Fixing template files..."

# Function to fix a single file
fix_file() {
    local file=$1
    echo "Fixing file: $file"
    
    # Fix escaped quotes in onerror attributes - replace with simpler static path
    perl -i -pe 's/onerror="this\.src='\''{{[^}]*}}'\''"/onerror="this.onerror=null; this.src='\''\/static\/img\/no-cover.jpg'\''"/g' "$file" 2>/dev/null || true
    
    # Fix escaped quotes in onclick attributes
    perl -i -pe 's/onclick="([^"]*)\\\\'([^"]*)\\\\'([^"]*)"/onclick="$1'\''$2'\''$3"/g' "$file" 2>/dev/null || true
    
    # Remove any trailing semicolons in HTML attributes that may be causing linter errors
    perl -i -pe 's/(onerror="[^"]*);"/\1"/g' "$file" 2>/dev/null || true
}

# Process main template files
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