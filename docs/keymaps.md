# Keymaps reference

`<leader>` is **Space**. All leader shortcuts are **lowercase** (no Shift). Three
ways to discover keymaps live:

- Press **`<leader>`** and wait → the which-key menu shows the categories below.
- **`<leader>?`** → show *every* mapping (which-key full list).
- **`<leader>sk`** → fuzzy-search keymaps (Telescope).

The leader menu is organized into these categories (defined once in
`lua/custom/plugins/which-key.lua`):

| Prefix | Category | Plugin |
|---|---|---|
| `<leader>s` | Search | Telescope |
| `<leader>z` | Find (fuzzy) | fzf-lua |
| `<leader>g` | Git | gitsigns |
| `<leader>h` | Harpoon | harpoon |
| `<leader>b` | Buffer | bufferline |
| `<leader>d` | Debug | nvim-dap |
| `<leader>x` | Diagnostics | trouble |
| `<leader>t` | Toggle | (mixed) |
| `gr` | Goto / LSP | nvim-lspconfig |

---

## Search — Telescope (`<leader>s`)
| Key | Action |
|---|---|
| `<leader>sf` | Files |
| `<leader>sg` | Grep (live) |
| `<leader>sw` | Current word |
| `<leader>sd` | Diagnostics |
| `<leader>sh` | Help tags |
| `<leader>sk` | Keymaps |
| `<leader>ss` | Telescope builtins (pick a picker) |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Recent files |
| `<leader>sn` | Neovim config files |
| `<leader>s/` | Grep in open files |
| `<leader>/` | Fuzzy-find in current buffer |
| `<leader><leader>` | Open buffers |

## Find — fzf-lua (`<leader>z` = fuzzy)
| Key | Action |
|---|---|
| `<leader>zf` | Files |
| `<leader>zg` | Live grep |
| `<leader>zb` | Buffers |
| `<leader>zw` | Word under cursor |
| `<leader>zh` | Help tags |
| `<leader>zr` | Resume |

## Git — gitsigns (`<leader>g`, `]c` / `[c`)
*Active in git-tracked files.*
| Key | Action |
|---|---|
| `]c` / `[c` | Next / previous change |
| `<leader>gs` | Stage hunk (or selection in Visual) |
| `<leader>gr` | Reset hunk (or selection in Visual) |
| `<leader>ga` | Stage buffer (all) |
| `<leader>gx` | Reset buffer (discard all) |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame line |
| `<leader>gd` | Diff against index |
| `<leader>gl` | Diff against last commit |

## Harpoon (`<leader>h`, `<leader>1`–`<leader>4`)
| Key | Action |
|---|---|
| `<leader>ha` | Add current file |
| `<leader>hm` | Toggle the quick menu |
| `<leader>hn` / `<leader>hp` | Next / previous |
| `<leader>1`–`<leader>4` | Jump to pinned file 1–4 |

## Buffer — bufferline (`<leader>b`, `[b` / `]b`)
| Key | Action |
|---|---|
| `]b` / `[b` | Next / previous buffer |
| `<leader>bp` | Pin / unpin |
| `<leader>bo` | Close other buffers |
| `<leader>bd` | Delete buffer |

## Debug — nvim-dap (`<leader>d`, F-keys)
| Key | Action |
|---|---|
| `<F5>` | Start / continue |
| `<F1>` / `<F2>` / `<F3>` | Step into / over / out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Conditional breakpoint |
| `<leader>du` | Toggle debugger UI |
| `<leader>dr` | Toggle REPL |

## Diagnostics — Trouble (`<leader>x`)
| Key | Action |
|---|---|
| `<leader>xx` | Workspace diagnostics |
| `<leader>xb` | Buffer diagnostics |
| `<leader>xs` | Symbols |
| `<leader>xr` | LSP defs / refs |
| `<leader>xl` | Location list |
| `<leader>xq` | Quickfix list |

## Toggle (`<leader>t`)
| Key | Action |
|---|---|
| `<leader>tb` | Git blame line |
| `<leader>td` | Git show deleted |
| `<leader>th` | LSP inlay hints |
| `<leader>tl` | LSP on/off (this buffer) |
| `<leader>tc` | Treesitter context (sticky header) |

## Code & LSP
| Key | Action | Source |
|---|---|---|
| `<leader>f` | Format buffer | conform |
| `<leader>q` | Diagnostics → quickfix list | core |
| `grn` | Rename symbol | LSP |
| `gra` | Code action (normal/visual) | LSP |
| `grr` | References | LSP |
| `grd` / `grc` | Definition / Declaration | LSP |
| `gri` | Implementation | LSP |
| `grt` | Type definition | LSP |
| `grs` / `grw` | Document / Workspace symbols | LSP |
| `K` | Hover docs | LSP (built-in; Shift is unavoidable here) |

## Editing — Comment, mini, completion
| Key | Action | Source |
|---|---|---|
| `gcc` | Toggle line comment | Comment.nvim |
| `gc{motion}` / visual `gc` | Toggle comment over motion/selection | Comment.nvim |
| `gbc` | Toggle block comment | Comment.nvim |
| `sa{motion}{char}` | Add surround | mini.surround |
| `sd{char}` | Delete surround | mini.surround |
| `sr{old}{new}` | Replace surround | mini.surround |
| `va)`, `vi"`, `ci'`, `yinq` … | Around/Inside text objects | mini.ai |
| `<C-y>` | Accept completion (insert) | blink.cmp |
| `<C-space>` | Open completion menu / docs | blink.cmp |
| `<C-n>` / `<C-p>` | Next / previous item | blink.cmp |

## Windows & core
| Key | Action |
|---|---|
| `<C-h/j/k/l>` | Move focus between splits |
| `<Esc>` | Clear search highlight |
| `<Esc><Esc>` | Exit terminal mode (in `:terminal`) |

> Note: `K` (hover) and `<C-…>` completion keys use Shift/Ctrl by Vim convention
> and are left as-is. Everything under `<leader>` is lowercase.
