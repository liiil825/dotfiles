# zsh-config

我的终端配置，快速配置终端环境，使用了 `ohmyzsh` 进行对所有终端配置进行管理

### 包含的插件

这些放在 `plugins` 和 `theme` 目录下

- 状态栏 [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [z.lua](https://github.com/skywind3000/z.lua)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting.git)

### 安装需求

成功完成配置需要用到一下软件依赖:

- [oh my zsh](https://github.com/ohmyzsh/ohmyzsh)
- 字体 [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
- lua
- [zplug](https://github.com/zplug/zplug)

### 安装

安装默认地址为 `~/.config/zsh`
如果修改需要修改一下文件 `.zshrc` 的设置 `ZSH_CUSTOM`

```
git clone --depth 1 https://github.com/liiil825/zsh-config.git ~/.config/zsh
cd ~/.config/zsh
git submodule update --init --depth=1 --recursive
mv ~/.zshrc ~/.zshrc.backup # (可选)备份原来配置
ln -sf ~/.config/zsh/.zshrc ~/.zshrc
```

### 建议安装

适合服务器和开发环境:

- 终端管理工具[tmux](https://github.com/tmux/tmux#installation)
- 进程查看器管理工具 [htop](https://github.com/htop-dev/htop#build-instructions)
- 终端电脑信息展示工具 [neofetch]()

适合开发环境:

- 快速查找文件的工具 [fzf](https://github.com/junegunn/fzf#installation)
- 控制台文件管理预览工具 [ranger](https://github.com/ranger/ranger#installing)
