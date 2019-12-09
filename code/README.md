# Visual Studio Code

## Saving extensions

```
code list-extensions > $DOTFILES/code extensions.txt
```

### Installing extensions from the list

```
cat $DOTFILES/code/extensions.txt | xargs -L1 code --install-extension
```
