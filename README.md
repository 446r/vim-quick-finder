# vim-quick-finder

finder with quickfix for vim

## Installation インストール

Clone

```
cd ~/.config/vim/pack/xxx/start/
git clone https://github.com/446r/vim-quick-finder.git
```

vimrc

```
autocmd VimEnter * call vim_quick_finder#Setup()
```

Customize.

```
autocmd VimEnter * call vim_quick_finder#Setup({'command': 'Find', 'ignore': ['.git/']})
```

## Usage 使い方

```
:Qf keyword target_dir
```

-> vim opens QuickFix with list of files.


## Ex command

覚えやすいの、使いやすいのをsetupで指定してください。

- Qf キーワード 場所 ... QuickFix + finder (default)
- Ff キーワード 場所 ... Fuzzy finder
- Ex キーワード 場所 ... netrw乗っ取り
- Glob キーワード 場所 ... globっぽいもの

