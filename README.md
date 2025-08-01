My first github pages static website using github action for ci/dc pipeline

testing


name: Merge to gh_pages and trigger deployment

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
# adding write permission for the github bot
permissions:
  contents: write

jobs:
  merge:
    runs-on: ubuntu-latest
    steps:
      # Checkout the main branch of the repository
      - name: Checkout code
        uses: actions/checkout@v3

      # Clone the gh_pages repository using the GitHub token for authentication
      - name: Clone gh_pages repo
        run: |
          git clone https://github.com/tim18fak-sys/gh_pages.git
          cd gh_pages

      # Set Git configuration for user
      - name: Set git user config
        run: |
          git config --global user.email "${{ secrets.EMAIL }}"
          git config --global user.name "${{ secrets.NAME }}"

      # Fetch all remote branches and checkout gh_pages branch
      - name: Checkout gh_pages branch
        run: |
          git fetch origin
          git checkout gh_pages || git checkout -b gh_pages

      # Merge main into gh_pages
      - name: Merge main into gh_pages
        run: |
          git fetch origin main
          git merge origin/main --no-ff --no-commit

      # If merge has changes, commit them
      - name: Commit changes
        run: |
          git add .
          git status
          git diff --cached --quiet || git commit -m "Merge completed from main to gh_pages"

      # Push the changes to the gh_pages branch
      - name: Push changes to gh_pages
        run: |
          git branch
          git push https://${{ secrets.GITHUB_TOKEN }}@github.com/tim18fak-sys/gh_pages.git 
