## Force pull
git fetch --all
git reset --hard origin/main

## git untrack files
git rm --cached *.txt
git check-ignore -v debug.test

## git undo the previous commit
git reset --soft HEAD~1

# When adding your personal repository, need to configure email:
git config --global user.email {ID}+{username}@users.noreply.github.com
This github email address can be found in Settings> Access > Emails > Primary Email Address texts

# configure ssh key
First make sure the repo is cloned using ssh. Otherwise, do: 
git remote set-url origin git@github.com:username/repo.git
Then, generate ssh key:

```
$ ssh-keygen -t ed25519 -C "your_email@example.com"
$ eval "$(ssh-agent -s)"
$ ssh-add ~/.ssh/id_ed25519
```

Last, add the key to the git website:

```
$ cat ~/.ssh/id_ed25519.pub
```

copy the output above and go to your git repo online:
> Settings > SSH and GPG keys > New SSH key > paste the output from 'cat' above to the field


