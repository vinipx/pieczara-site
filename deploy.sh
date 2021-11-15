#!/usr/bin/env sh

# Abort on errors
set -eu

# Logger
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>deploy.log 2>&1

echo '=== > Step 1/6 - Git - Initializing repository to be published'
npm run build
cd dist/
git init
echo '=== > Step 2/6 - Git - Commiting changes'
git add -A
git commit -m "Automatic deployment via shell script"
echo '=== > Step 3/6 - Git - Pushing to Patrycja Pieczara repository'
git push -f git@github.com:vinipx/pieczara-site.git master:site
echo '=== > Step 4/6 - Hooray! Website published successfully.'

echo '===> Step 5/6 - Git - fetching and rebasing repo...'
cd ../
git fetch upstream && git rebase upstream/source && git push
git checkout main && git fetch upstream && git rebase upstream/source && git push

echo '===> Step 6/6 - SUCCESS! Repository is up-to-date and ready for more!'

cd -