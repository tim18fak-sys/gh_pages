#!/bin/bash
# This script connects a new GitHub repo to VS Code and initializes Git.

link() {
    # Ask if the user has an existing README.md
    read -p "Do you have an existing README.md file in your repo? (y/N): " IS_README_EXIST

    if [[ "$IS_README_EXIST" != "y" && "$IS_README_EXIST" != "Y" ]]; then
        read -p "Enter content for the README.md file: " CONTENT
        echo "$CONTENT" > ./README.md
        echo "README.md file created"
    fi

    # Initialize Git repository
    git init

    # Check if .gitignore exists (optional feature)
    if [[ ! -f ".gitignore" ]]; then
        echo ".gitignore file does not exist. Consider adding one."
    fi

    # Add all files to Git
    git add .

    # Commit changes
    read -p "Enter your commit message: " COMMIT_MESSAGE
    git commit -m "$COMMIT_MESSAGE"


    # Set main branch
    git branch -M main
    echo "Main branch has been created"

    # Get GitHub repo URL
    read -p "Enter the GitHub repo URL: " GITHUB_URL
    git remote add origin "$GITHUB_URL"
    echo "Remote repository added"

    # Push to GitHub
    git push -u origin main
    echo "The changes have been pushed to the remote repository"
}

link
