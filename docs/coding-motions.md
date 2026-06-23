# Coding motions cheatsheet

The same content is available **inside Neovim** as a floating menu: press
**`<leader>m`** (or run **`:Cheatsheet`**), and `q` / `<Esc>` to close.

The pattern is **operator + text object**. Pick an operator, then a target:

| Operator | Does |
|---|---|
| `v` | select (visual) |
| `d` | delete |
| `c` | change (delete + insert) |
| `y` | yank (copy) |

Targets use **`i`** (inside) or **`a`** (around — includes the delimiters).

## Text objects

| Object | Inside / Around | Selects |
|---|---|---|
| Parentheses `( )` | `i(` / `a(` | inside / incl. the parens — also a call's args |
| Braces `{ }` | `i{` / `a{` | a code block body |
| Brackets `[ ]` | `i[` / `a[` | arrays / indexers |
| Quotes | `i"` `i'` `` i` `` | inside the quotes |
| HTML/XML tag | `it` / `at` | tag contents / whole element |
| Word | `iw` / `aw` | word (`iW`/`aW` = WORD incl. punctuation) |
| Paragraph | `ip` / `ap` | paragraph |
| **Function** | `if` / `af` | whole function *(treesitter)* |
| **Class** | `ic` / `ac` | whole class *(treesitter)* |
| **Block** | `io` / `ao` | `if` / loop block *(treesitter)* |

## Common coding examples

| Goal | Keys |
|---|---|
| Select the whole function | `vaf` |
| Delete the whole function | `daf` |
| Change everything inside `( )` | `ci(` |
| Change inside quotes | `ci"` |
| Change inside an HTML tag | `cit` |
| Change a word | `ciw` |
| Yank inside `{ }` | `yi{` |
| Select inside brackets | `vi[` |
| Jump to the matching bracket | `%` |
| Next / previous method | `]m` / `[m` |

## Surround (mini.surround)

| Goal | Keys | Example |
|---|---|---|
| Add | `sa{motion}{char}` | `saiw)` → wrap word in `( )` |
| Delete | `sd{char}` | `sd"` → remove quotes |
| Replace | `sr{old}{new}` | `sr({` → change `( )` to `{ }` |

## Comments (Comment.nvim)

| Goal | Keys |
|---|---|
| Toggle current line | `gcc` |
| Toggle over a motion | `gc{motion}` (e.g. `gcap`) |
| Toggle a selection | select, then `gc` |

> The **function / class / block** objects need treesitter parsers + the
> `nvim-treesitter-textobjects` queries. Run `:Lazy sync` once after pulling this,
> then they work in any language treesitter supports. The bracket/quote/tag/word
> objects are built into Vim and work everywhere with no setup.
