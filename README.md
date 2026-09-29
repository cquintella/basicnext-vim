# basicnext-vim

Official Basic Next (0.6) language support for Vim and Neovim in canonical Vimscript.

## Quick Install (Terminal One-Liner)

### Vim

```sh
mkdir -p ~/.vim/pack/plugins/start && git clone https://github.com/cquintella/basicnext-vim.git ~/.vim/pack/plugins/start/basicnext-vim
```

### Neovim

```sh
mkdir -p ~/.local/share/nvim/site/pack/plugins/start && git clone https://github.com/cquintella/basicnext-vim.git ~/.local/share/nvim/site/pack/plugins/start/basicnext-vim
```

### Both Editors

```sh
mkdir -p ~/.vim/pack/plugins/start ~/.local/share/nvim/site/pack/plugins/start && git clone https://github.com/cquintella/basicnext-vim.git ~/.vim/pack/plugins/start/basicnext-vim && cp -R ~/.vim/pack/plugins/start/basicnext-vim ~/.local/share/nvim/site/pack/plugins/start/
```

---

## Installation via Plugin Managers

### vim-plug

```vim
Plug 'cquintella/basicnext-vim'
```

### Pathogen

```sh
git clone https://github.com/cquintella/basicnext-vim.git ~/.vim/bundle/basicnext-vim
```

### Local Checkout

```vim
set runtimepath+=/path/to/basicnext-vim
```

---

## What It Provides

* **Automatic Filetype**: Associates `*.bn` files with `filetype=basicnext`.
* **Syntax Highlighting**: Conforms to Basic Next 0.6 grammar (keywords, types, numbers, string escapes, `ASYNC`/`AWAIT`, and marks removed keywords like `DELETE` as errors).
* **Smart Indentation**: Automatically indents and aligns blocks (`FUNCTION`, `IF`/`ELSE`, `WHILE`, `FOR`, `CLASS`, `STRUCT`, `INTERFACE`, `REPEAT`/`UNTIL`).
* **Block Navigation**: `%` navigates between block openings and closers using Vim's built-in `matchit`.
* **Commands**:
  * `:BasicNextRun [args]`: Executes the current file with `bni run`.
  * `:BasicNextCheck [args]`: Checks the current file with `bni check`.

---

## Compiler and Quickfix (`:make`)

The plugin registers `bni` as the default compiler. Run `:make` to validate the active file against the frontend parser and type checker:

```vim
:make
```

Diagnostics populate the Quickfix list automatically. Use `:copen` to view errors and `:cnext` / `:cprev` to jump through diagnostics.

To compile with the native backend (`bnc`):

```vim
:compiler bnc
:make
```

---

## Language Server Protocol (`bni lsp`)

Basic Next includes a built-in LSP server invoked with `bni lsp`.

### vim-lsp

```vim
if executable('bni')
  au User lsp_setup call lsp#register_server({
      \ 'name': 'bni-lsp',
      \ 'cmd': {server_info->['bni', 'lsp']},
      \ 'whitelist': ['basicnext'],
      \ })
endif
```

### coc.nvim

Add to `coc-settings.json` (`:CocConfig`):

```json
{
  "languageserver": {
    "basicnext": {
      "command": "bni",
      "args": ["lsp"],
      "filetypes": ["basicnext"]
    }
  }
}
```

---

## Verification

Open any `.bn` file and verify:

```vim
:set filetype?
```

Expected output: `filetype=basicnext`.

---

## License

Mozilla Public License Version 2.0 (MPL-2.0). See [LICENSE](LICENSE) for details.
