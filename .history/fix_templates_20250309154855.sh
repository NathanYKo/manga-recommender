#!/bin/bash
# Script to fix template escaping issues in Jinja2 templates

echo "Fixing template files..."

# Function to fix a single file
fix_file() {
    local file=$1
    echo "Fixing file: $file"
    
    # For macOS compatibility, use a different sed approach
    sed -i '' "s/onerror=\"this.src='{{ url_for(\\\\'static\\\\', filename=\\\\'img\/no-cover.jpg\\\\') }}'/onerror=\"this.src='{{ url_for(\"static\", filename=\"img/no-cover.jpg\") }}'/g" "$file"
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