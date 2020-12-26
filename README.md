# Sample config to use vim as TypeScript IDE

The config works both for vim 8.0 and neovim 0.4.x+.

I use neovim 0.4.4.

## Install NeoVim

`sudo ./install_nvim.sh`

## Make required config changes

`python3 setup_vim.py <home-dir-path>`

## Install plugins

```
vim
:PackUpdate
```

Some plugins require restart.
Therefore, exit and start vim again.

