# Keymaps reference

`<leader>` is **Space**. Three ways to discover keymaps live:

- Press **`<leader>`** and wait → the which-key menu shows the categories below.
- **`<leader>?`** → show *every* mapping (which-key full list).
- **`<leader>sk`** → fuzzy-search keymaps (Telescope).

The leader menu is organized into these categories (defined once in
`lua/custom/plugins/which-key.lua`):

| Prefix | Category | Plugin |
|---|---|---|
| `<leader>s` | [S]earch | Telescope |
| `<leader>F` | [F]ind | fzf-lua |
| `<leader>g` | [G]it | gitsigns |
| `<leader>h` | [H]arpoon | harpoon |
| `<leader>b` | [B]uffer | bufferline |
| `<leader>d` | [D]ebug | nvim-dap |
| `<leader>x` | Diagnostics | trouble |
| `<leader>t` | [T]oggle | (mixed) |
| `gr` | [G]oto / LSP | nvim-lspconfig |

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

## Find — fzf-lua (`<leader>F`)
| Key | Action |
|---|---|
| `<leader>Ff` | Files |
| `<leader>Fg` | Live grep |
| `<leader>Fb` | Buffers |
| `<leader>Fw` | Word under cursor |
| `<leader>Fh` | Help tags |
| `<leader>Fr` | Resume |

## Git — gitsigns (`<leader>g`, `]c` / `[c`)
*Active in git-tracked files.*
| Key | Action |
|---|---|
| `]c` / `[c` | Next / previous change |
| `<leader>gs` | Stage hunk (or selection in Visual) |
| `<leader>gr` | Reset hunk (or selection in Visual) |
| `<leader>gS` | Stage buffer |
| `<leader>gR` | Reset buffer |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame line |
| `<leader>gd` | Diff against index |
| `<leader>gD` | Diff against last commit |

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
| `<leader>dB` | Conditional breakpoint |
| `<leader>du` | Toggle debugger UI |
| `<leader>dr` | Toggle REPL |

## Diagnostics — Trouble (`<leader>x`)
| Key | Action |
|---|---|
| `<leader>xx` | Workspace diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>xs` | Symbols |
| `<leader>xl` | LSP defs / refs |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |

## Toggle (`<leader>t`)
| Key | Action |
|---|---|
| `<leader>tb` | Git blame line |
| `<leader>tD` | Git show deleted |
| `<leader>th` | LSP inlay hints |
| `<leader>tL` | LSP on/off (this buffer) |
| `<leader>tc` | Treesitter context (sticky header) |

## Code & LSP
| Key | Action | Source |
|---|---|---|
| `<leader>f` | Format buffer | conform |
| `<leader>q` | Diagnostics → quickfix list | core |
| `grn` | Rename symbol | LSP |
| `gra` | Code action (normal/visual) | LSP |
| `grr` | References | LSP |
| `grd` / `grD` | Definition / Declaration | LSP |
| `gri` | Implementation | LSP |
| `grt` | Type definition | LSP |
| `gO` / `gW` | Document / Workspace symbols | LSP |
| `K` | Hover docs | LSP (built-in) |

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
