# nvim

[![verify](https://github.com/andre-f-paggi/nvim/actions/workflows/verify.yml/badge.svg)](https://github.com/andre-f-paggi/nvim/actions/workflows/verify.yml)

My personal Neovim configuration. It started as a fork of
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and has since been
split into focused modules, retargeted at a **Windows-first, C#/.NET** workflow,
switched to [fzf-lua](https://github.com/ibhagwan/fzf-lua) as the single fuzzy
finder, and migrated to Neovim 0.12's native stack: **vim.pack** for plugins and
**vim.lsp.config/enable** for servers — no plugin manager. Completion is
**mini.completion** (LSP + fallback, from mini.nvim).

> It lives standalone in this repo and is also vendored as the `nvim` submodule
> of my [dotfiles](https://github.com/andre-f-paggi/dotfiles).

## Highlights

- **Modular** — `init.lua` only sets the leader keys, then loads small files
  under `lua/config/` (settings) and `lua/plugins/` (one file per plugin).
- **Native `vim.pack`** plugin management (Neovim 0.12+) — one manifest in
  `lua/config/pack.lua`, no plugin-manager plugin.
- **Native LSP + mini.completion** — `vim.lsp.enable()` with nvim-lspconfig's
  server configs, `mini.completion` autocompletion, Mason as a pure binary
  installer, `conform.nvim` formatting, with first-class **C#/.NET** support
  (`roslyn.nvim` + `netcoredbg` debugging). 12 languages preconfigured: Lua,
  TS/JS, C#, PowerShell, Bash, JSON, YAML, Markdown, Rust, Python, Ruby, Go.
- **Auto-everything** — Treesitter parsers auto-install on first open of a new
  filetype (and highlight immediately); Mason auto-installs every server/tool
  from one list; LSP + completion attach on their own.
- **Self-testing** — `tests/verify.lua` checks clean startup, health, and
  per-language LSP attach; runs in CI on every push (badge above).
- **fzf-lua** for files / live-grep / LSP pickers (no Telescope).
- **Discoverable keymaps** — which-key popups plus two built-in floating
  cheatsheets (`<leader>k` and `<leader>m`).
- **Windows-friendly** — PowerShell 7 as the shell, `zig` as the Treesitter
  compiler, and Windows-specific build workarounds baked in.
- [flexoki](https://github.com/kepano/flexoki-neovim) (`flexoki-dark`) theme +
  `lualine` statusline + `bufferline` tabs.

---

## Requirements

| Need | Why | Install (Windows) |
|---|---|---|
| **Neovim 0.12+** | the editor (`vim.pack` needs 0.12) | `winget install Neovim.Neovim` |
| **git** | vim.pack plugin clones | `winget install Git.Git` |
| **PowerShell 7** (`pwsh`) | `:terminal` and `:!` are wired to `pwsh.exe` | `winget install Microsoft.PowerShell` |
| **zig** | C compiler used to build Treesitter parsers | `winget install zig.zig` |
| **tree-sitter CLI** | builds parsers on the TS `main` branch (auto-installed via Mason) | `npm i -g tree-sitter-cli` |
| **ripgrep** | fzf-lua live grep | `winget install BurntSushi.ripgrep.MSVC` |
| **fzf** binary | the fzf-lua picker engine | `winget install junegunn.fzf` |
| **A Nerd Font** | icons (`vim.g.have_nerd_font = true`) | [nerdfonts.com](https://www.nerdfonts.com/) |
| **fd** *(optional)* | faster file listing | `winget install sharkdp.fd` |

Per-language toolchains are pulled in as needed — e.g. the **.NET SDK** for C#
(`roslyn` + `netcoredbg`), `node`/`npm` for TypeScript, `go` for Go, etc.

On Linux/macOS the equivalents are `neovim`, `git`, `ripgrep`, `fzf`, `fd`, a C
compiler (`gcc`/`clang` — `zig` is optional there), and a clipboard tool
(`xclip`/`xsel`/`wl-clipboard`). Clipboard sync uses `unnamedplus`; on Windows
`win32yank` (shipped with Neovim) handles it.

---

## Install

Neovim loads its config from a single directory. Back up anything already there
first.

| OS | Config path |
|---|---|
| Windows | `%LOCALAPPDATA%\nvim` |
| Linux / macOS | `${XDG_CONFIG_HOME:-~/.config}/nvim` |

<details><summary><b>Windows (PowerShell)</b></summary>

```powershell
# back up an existing config if you have one
Move-Item "$env:LOCALAPPDATA\nvim" "$env:LOCALAPPDATA\nvim.bak" -ErrorAction SilentlyContinue

git clone https://github.com/andre-f-paggi/nvim "$env:LOCALAPPDATA\nvim"
nvim
```
</details>

<details><summary><b>Linux / macOS</b></summary>

```sh
# back up an existing config if you have one
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true

git clone https://github.com/andre-f-paggi/nvim "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
nvim
```
</details>

> Want to try it without touching your existing setup? Clone it elsewhere and run
> `NVIM_APPNAME=nvim-test nvim`, or on Windows
> `$env:NVIM_APPNAME='nvim-test'; nvim` after cloning into `%LOCALAPPDATA%\nvim-test`.

---

## Running it

The first `nvim` launch clones every plugin via `vim.pack` and Mason installs
the LSP servers/formatters/debug adapters — let it finish, then restart.
Day-to-day commands:

| Command | What it does |
|---|---|
| `:lua vim.pack.update()` | update plugins (review the diff, then apply) |
| `:Mason` | install/manage LSP servers, formatters, debug adapters |
| `:MasonToolsInstallSync` | install everything from the ensure-installed list |
| `:checkhealth` | diagnose missing dependencies (compiler, fzf, clipboard, …) |
| `:TSUpdate` | update/install Treesitter parsers (needs a C compiler / `zig`) |
| `:Tutor` | the built-in Vim tutor, if you're new |

**C#/.NET debugging:** `netcoredbg` is on the Mason ensure-installed list —
build your project, press `<F5>`, and point it at your `.dll`.

If something looks off after pulling changes, `:lua vim.pack.update()` then
`:checkhealth` clears up most issues. To verify the whole config end-to-end
(same checks CI runs):

```sh
nvim --headless "+luafile tests/verify.lua"     # VERIFY_LEVEL=1|2|3 (default 3)
```

---

## Code structure

`init.lua` sets the leader keys and the Nerd-Font flag (these must be set before
plugins load), then `require`s each module in order. Everything else is split by
concern:

```
nvim/
├─ init.lua                  Entry point — leader keys + load order
│
├─ lua/config/               Your editor settings (no plugins here)
│  ├─ options.lua            vim.o options: numbers, clipboard, pwsh shell, listchars, …
│  ├─ keymaps.lua            Global, plugin-independent keymaps
│  ├─ autocmds.lua           Autocommands (yank highlight, cursor shape on exit)
│  ├─ pack.lua               Plugin manifest (vim.pack.add) + loads lua/plugins/*
│  ├─ lsp.lua                vim.lsp.config/enable; capabilities; gr* keymaps; diagnostics
│  ├─ cheatsheet.lua         Coding-motions floating cheatsheet  (<leader>m / :Cheatsheet)
│  └─ keymap-cheatsheet.lua  Keybinds/plugins floating cheatsheet (<leader>k / :Keys)
│
├─ lua/plugins/              One file per plugin: setup() + its own keymaps
│  ├─ fzf-lua.lua            Fuzzy finder — files, grep, LSP pickers, ui-select (the finder)
│  ├─ mason.lua              Binary installer ONLY (servers/formatters/adapters list)
│  ├─ roslyn.lua             C#/.NET language server (Microsoft Roslyn)
│  ├─ conform.lua            Formatting (format-on-save + <leader>cf; stylua, …)
│  ├─ treesitter.lua         Syntax / indent ('main' branch API; parser list)
│  ├─ treesitter-context.lua Sticky header showing the enclosing function/class
│  ├─ mini.lua               mini.ai + mini.surround + mini.bufremove + mini.completion
│  ├─ comment.lua            gc / gcc commenting (Comment.nvim)
│  ├─ gitsigns.lua           Git gutter signs + hunk stage/reset/preview/blame
│  ├─ harpoon.lua            Pin a few files and jump to them (<leader>1–4)
│  ├─ neo-tree.lua           File-explorer sidebar (<leader>e)
│  ├─ bufferline.lua         VS Code-style buffer tabs along the top
│  ├─ lualine.lua            Statusline (theme follows the colorscheme)
│  ├─ trouble.lua            Pretty diagnostics / quickfix / references panel
│  ├─ todo-comments.lua      Highlight + navigate TODO/FIXME/HACK/NOTE
│  ├─ dap.lua                nvim-dap + dap-ui, wired for .NET (netcoredbg)
│  ├─ fidget.lua             LSP progress messages (bottom-right)
│  ├─ indent-blankline.lua   Indent guide lines
│  ├─ guess-indent.lua       Auto-detect tabstop/shiftwidth from the file
│  ├─ lazydev.lua            Lua LSP types for editing this config
│  ├─ colorscheme.lua        flexoki-dark theme
│  └─ which-key.lua          Leader-menu popup + the group/category definitions
│
├─ tests/                    Headless verification (verify.lua + per-language fixtures)
├─ .github/workflows/        CI: stylua + the verify script on every push
├─ docs/                     Long-form notes (coding motions, plugin comparisons)
├─ doc/                      Kickstart's bundled :help docs
└─ *.css                     flexoki themes for external markdown/highlight tools
```

**Mental model:** `lua/config/*` is *how the editor behaves*; `lua/plugins/*`
is *what's installed*. To add a plugin, add its URL to `lua/config/pack.lua`,
drop a `lua/plugins/<name>.lua` with its `setup()` + keymaps, and add the module
name to the list at the bottom of `pack.lua`.

---

## Keybindings

`<leader>` is **Space**. Everything under `<leader>` is **lowercase** — no Shift.
The fastest way to learn the maps is to discover them live:

| Key | Shows |
|---|---|
| `<leader>` (then wait) | which-key menu of the categories below |
| `<leader>?` | *every* mapping (which-key full list) |
| `<leader>k` / `:Keys` | keybinds + plugin-usage cheatsheet (floating) |
| `<leader>m` / `:Cheatsheet` | coding-motions cheatsheet (text objects, surround, …) |
| `<leader>sk` | fuzzy-search all keymaps |

### Leader categories

| Prefix | Category | Driven by |
|---|---|---|
| `<leader>e` | Explorer (toggle file tree) | neo-tree |
| `<leader>f` | Find **files** | fzf-lua |
| `<leader>s` | **Search** content | fzf-lua |
| `<leader>c` | Code (format, diagnostics) | conform / core |
| `<leader>g` | Git | gitsigns |
| `<leader>h` | Harpoon | harpoon |
| `<leader>b` | Buffer | mini.bufremove |
| `<leader>t` | Tabline (the tab bar) | bufferline |
| `<leader>d` | Debug | nvim-dap |
| `<leader>x` | Trouble / Diagnostics | trouble |
| `<leader>u` | UI / Toggle | mixed |
| `gr` | Goto / LSP | native LSP (fzf-lua pickers) |

### Find & Search (fzf-lua)

| Key | Action | | Key | Action |
|---|---|---|---|---|
| `<leader>ff` | Files | | `<leader>sg` | Grep (live) |
| `<leader>fr` | Recent files | | `<leader>sw` | Word under cursor |
| `<leader>fb` | Buffers | | `<leader>sd` | Diagnostics (buffer) |
| `<leader>fn` | Neovim config files | | `<leader>sh` | Help tags |
| `<leader>/` | Search in current buffer | | `<leader>sk` | Keymaps |
| | | | `<leader>sr` | Resume last picker |
| | | | `<leader>ss` | Document symbols |
| | | | `<leader>s/` | Lines in open buffers |

*In a picker:* type to filter, `<Tab>` multi-select, `<C-q>` send results to the
quickfix list.

### Code & LSP

LSP maps are buffer-local — active once a language server attaches.

| Key | Action | | Key | Action |
|---|---|---|---|---|
| `grd` | Go to definition | | `grn` | Rename symbol |
| `grr` | References | | `gra` | Code action (n/x) |
| `gri` | Implementation | | `grs` | Document symbols |
| `grt` | Type definition | | `grw` | Workspace symbols |
| `grc` | Declaration | | `K` | Hover docs (built-in) |
| `<leader>cf` | Format buffer (conform) | | `<leader>cd` | Line diagnostics (float) |
| `<leader>q` | Diagnostics → loclist | | | |

### Git (gitsigns) — in a tracked file

| Key | Action | | Key | Action |
|---|---|---|---|---|
| `]c` / `[c` | Next / prev change | | `<leader>gp` | Preview hunk |
| `<leader>gs` | Stage hunk (or selection) | | `<leader>gb` | Blame line |
| `<leader>gr` | Reset hunk (or selection) | | `<leader>gd` | Diff against index |
| `<leader>ga` | Stage whole buffer | | `<leader>gl` | Diff against last commit |
| `<leader>gx` | Reset buffer (discard) | | | |

### Harpoon

| Key | Action |
|---|---|
| `<leader>ha` | Add current file |
| `<leader>hm` | Toggle quick menu |
| `<leader>hn` / `<leader>hp` | Next / previous |
| `<leader>1`–`<leader>4` | Jump to pinned file 1–4 |

### Buffers & Tabline (bufferline)

| Key | Action | | Key | Action |
|---|---|---|---|---|
| `]b` / `[b` | Next / prev buffer | | `<leader>tj` | Pick a buffer (jump) |
| `<A-l>` / `<A-h>` | Next / prev buffer | | `<leader>tp` | Toggle pin |
| `<A-1>`…`<A-9>` | Jump to buffer N | | `<leader>tx` | Pick a buffer to close |
| `<leader>t1`…`t9` | Jump to buffer N | | `<leader>to` | Close other buffers |
| `<leader>t0` | Last buffer | | `<leader>th` / `<leader>tl` | Close left / right |
| `<leader>bw` | Close buffer (keep layout) | | `<leader>ts` / `<leader>te` | Sort by dir / ext |
| `<leader>t[` / `<leader>t]` | Move buffer left / right | | | |

### Debug (nvim-dap)

| Key | Action | | Key | Action |
|---|---|---|---|---|
| `<F5>` | Start / continue | | `<leader>db` | Toggle breakpoint |
| `<F1>` / `<F2>` / `<F3>` | Step into / over / out | | `<leader>dc` | Conditional breakpoint |
| `<leader>du` | Toggle debugger UI | | `<leader>dr` | Toggle REPL |

### Trouble / Diagnostics

| Key | Action | | Key | Action |
|---|---|---|---|---|
| `<leader>xx` | Workspace diagnostics | | `<leader>xl` | Location list |
| `<leader>xb` | Buffer diagnostics | | `<leader>xq` | Quickfix list |
| `<leader>xs` | Symbols | | `<leader>xt` | Todo comments |
| `<leader>xr` | LSP defs / refs | | | |

### UI toggles (`<leader>u`)

| Key | Toggles | | Key | Toggles |
|---|---|---|---|---|
| `<leader>ub` | Git blame line | | `<leader>ui` | Indent guides |
| `<leader>uc` | Treesitter context | | `<leader>ul` | LSP (this buffer) |
| `<leader>ud` | Git show deleted | | `<leader>uw` | Word wrap |
| `<leader>uh` | LSP inlay hints | | `<leader>us` | Spell check |
| `<leader>u`<kbd>Space</kbd> | Show whitespace | | | |

### Editing & motions

| Key | Action |
|---|---|
| `<C-s>` | Save (normal **and** insert) |
| `<A-j>` / `<A-k>` | Move line / selection down / up (re-indents) |
| `<C-d>` / `<C-u>` | Half-page down / up, kept centred |
| `n` / `N` | Next / prev search match, centred |
| `<` / `>` (visual) | Indent and keep the selection |
| `<leader>p` (visual) | Paste over without clobbering the register |
| `d` / `D` / `x` | Delete WITHOUT yanking (black-hole register) |
| `<leader>dd` | Cut — the old delete-into-register behaviour |
| `<leader>sx` | Replace word under cursor across the file |
| `J` | Join line below, keep cursor put |
| `gcc` / `gc{motion}` / `gbc` | Toggle line / motion / block comment |
| `sa{motion}{c}` / `sd{c}` / `sr{old}{new}` | Add / delete / replace surround |
| `vif`/`vaf`, `vic`/`vac`, `vio`/`vao` | Select inside/around function / class / block |

*Completion (mini.completion, insert mode):* auto-triggers as you type ·
`<C-Space>` force-trigger · `<C-n>`/`<C-p>` next/prev · `<C-y>` accept ·
`<C-e>` cancel. Docs + signature-help windows pop up automatically.

### Windows, splits & navigation pairs

| Key | Action |
|---|---|
| `<C-h/j/k/l>` | Move focus between splits |
| `<Esc>` | Clear search highlight |
| `<Esc><Esc>` | Exit terminal mode (in `:terminal`) |
| `]c` / `[c` | Next / prev git change |
| `]t` / `[t` | Next / prev todo comment |
| `]d` / `[d` | Next / prev diagnostic |
| `]m` / `[m` | Next / prev method (start) |

*neo-tree* (inside the tree): `a` add · `d` delete · `r` rename · `c` copy ·
`x` cut · `p` paste · `<leader>e` close.

---

## Customizing

- **Add a plugin** — add its URL to `lua/config/pack.lua`, create
  `lua/plugins/<name>.lua` with its `setup()` + keymaps, and add the module name
  to the list at the bottom of `pack.lua`.
- **Add an LSP server** — add its name to `vim.lsp.enable` in
  `lua/config/lsp.lua` (overrides via `vim.lsp.config()` above it) and its Mason
  package to `lua/plugins/mason.lua`; it installs on next start.
- **Add a formatter** — extend `formatters_by_ft` in
  `lua/plugins/conform.lua` (+ Mason package in `lua/plugins/mason.lua`).
- **Change a global setting / keymap** — edit `lua/config/options.lua` or
  `lua/config/keymaps.lua`.
- **Leader-menu categories** live once in `lua/plugins/which-key.lua`.
