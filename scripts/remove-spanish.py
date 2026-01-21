#!/usr/bin/env python3
"""
Remove Spanish translation attributes and language toggle from all HTML files
"""

import os
import re
from pathlib import Path

def remove_spanish_from_html(content):
    """Remove Spanish translation attributes and language toggle button"""
    
    # Remove language toggle button
    content = re.sub(
        r'<button class="lang-toggle"[^>]*>.*?</button>',
        '',
        content,
        flags=re.DOTALL
    )
    
    # Remove data-es attributes
    content = re.sub(r'\s+data-es="[^"]*"', '', content)
    
    # Remove data-en attributes and keep only the English text
    def replace_data_en(match):
        return ''
    
    content = re.sub(r'\s+data-en="[^"]*"', replace_data_en, content)
    
    return content

def process_html_files(root_dir):
    """Process all HTML files in the directory"""
    root_path = Path(root_dir)
    html_files = list(root_path.rglob('*.html'))
    
    print(f"Found {len(html_files)} HTML files to process")
    
    for html_file in html_files:
        print(f"Processing: {html_file}")
        
        # Read file
        with open(html_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Remove Spanish
        new_content = remove_spanish_from_html(content)
        
        # Write back
        with open(html_file, 'w', encoding='utf-8') as f:
            f.write(new_content)
        
        print(f"  ✓ Updated")
    
    print(f"\n✅ Processed {len(html_files)} files")

if __name__ == '__main__':
    # Get the repository root (parent of scripts directory)
    script_dir = Path(__file__).parent
    repo_root = script_dir.parent
    
    print("Removing Spanish translation from LER Landscaping website...")
    print(f"Repository: {repo_root}\n")
    
    process_html_files(repo_root)
    
    print("\n✅ All Spanish translations removed!")
    print("Next steps:")
    print("  1. Review the changes")
    print("  2. git add .")
    print("  3. git commit -m 'Remove Spanish translation, make site English-only'")
    print("  4. git push origin main")
