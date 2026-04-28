#!/bin/bash

echo "Fetching latest from base..."
git fetch base

echo "Merging all base changes..."
git merge base/main --no-edit

echo "Pulling all base files..."
git checkout base/main -- sections/
git checkout base/main -- snippets/
git checkout base/main -- assets/
git checkout base/main -- layout/
git checkout base/main -- config/settings_schema.json
git checkout base/main -- templates/

# Check if merge had conflicts
if [ $? -ne 0 ]; then
  echo ""
  echo "⚠️  Merge conflict detected."
  echo "Fix the conflicts shown above, then run:"
  echo "  git add <conflicted-file>"
  echo "  ./pull-base.sh --continue"
  exit 1
fi

echo "Restoring store-specific files..."
git checkout HEAD -- assets/custom.css
git checkout HEAD -- assets/custom.js
git checkout HEAD -- sections/custom.liquid
git checkout HEAD -- config/settings_data.json
git checkout HEAD -- templates/index.json
git checkout HEAD -- templates/product.json
git checkout HEAD -- templates/collection.json
git checkout HEAD -- templates/page.json
git checkout HEAD -- templates/cart.json
git checkout HEAD -- templates/blog.json
git checkout HEAD -- templates/article.json
git checkout HEAD -- templates/404.json
git checkout HEAD -- templates/password.json
git checkout HEAD -- templates/customers/account.json
git checkout HEAD -- templates/customers/login.json


echo ""
echo "✅ Done. Review with: git status"
echo "Commit with: git add . && git commit -m 'chore: pull latest from base'"