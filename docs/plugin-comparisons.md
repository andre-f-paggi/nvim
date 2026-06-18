# Plugin comparisons

Short answers to "how do these differ?" for the plugins in this config.

---

## 1. lualine vs mini.statusline (what you had before)

Both draw the **statusline** — the bar at the very bottom showing mode, file, position, etc. You can only sensibly run **one**, which is why adding lualine meant disabling `mini.statusline` (your `mini.ai` and `mini.surround` from the same suite are untouched).

| | **mini.statusline** (old) | **lualine** (new) |
|---|---|---|
| Comes from | `mini.nvim` suite (already installed) | dedicated plugin |
| Philosophy | minimal, fast, few knobs | feature-rich, declarative |
| Components | a handful (mode, git, diagnostics, file, location) | many built-ins (branch, diff, diagnostics, filetype, encoding, progress, LSP, …) |
| Theming | limited; tweak via Lua functions | many themes + `theme = 'auto'` matches your colorscheme |
| Layout config | override section functions | named sections `lualine_a … lualine_z` |
| Integrations | — | bufferline, trouble, nvim-tree, etc. |
| Extra dependency | none (you had it already) | one more plugin (small) |

**Net:** lualine is the richer, easier-to-customize bar that most configs use (it's the LazyVim/NvChad default); mini.statusline was simpler and one fewer plugin. With your old setup you'd hand-write a Lua function to change a section (you did this for the `LINE:COLUMN` location); with lualine you just list components in `lualine_a..z`.

> `mini.nvim` is **not** removed — only its statusline module is off. `mini.ai` (text objects) and `mini.surround` still run.

---

## 2. Did fzf-lua replace harpoon? **No — they do different jobs.**

This is the key mental model:

- **harpoon = speed-dial for a few pinned files.** You *deliberately* add the 3–4 files you're actively working on to a small, **persistent, ordered** list, then jump to them by position (`<leader>1`…`<leader>4`) from muscle memory. The list stays put until you change it, and it's remembered per project.

- **fzf-lua = a search engine over your project.** It's an **ephemeral** fuzzy finder: you open it, type to filter across *everything* (all files, every line via grep, buffers, help, LSP symbols), pick one, and it closes. No saved list.

**Analogy:** harpoon is your browser bookmarks bar; fzf-lua is Google. You use fzf-lua/Telescope to **find** a file the first time, and harpoon to **pin** the handful you keep coming back to so you stop re-searching for them.

| | **harpoon** | **fzf-lua / Telescope** |
|---|---|---|
| Purpose | jump to a few pinned files | search across everything |
| The list | persistent, manual, ordered | generated fresh by your query |
| How you pick | by position (1/2/3/4) | type-to-filter |
| Scope | your current working set | whole project, all sources |
| Lifetime | sticks around | gone after you pick |

So nothing replaced harpoon. The thing fzf-lua actually overlaps with is **Telescope** ↓.

---

## 3. fzf-lua vs Telescope (the real overlap)

You now have **both** fuzzy finders. They do the *same kind* of thing (files, live grep, buffers, LSP, help — with a preview), and differ mainly in engine and ecosystem:

| | **Telescope** (`<leader>s…`) | **fzf-lua** (`<leader>F…`) |
|---|---|---|
| Engine | pure Lua sorter | shells out to the native `fzf` binary |
| Speed on huge repos | good, can lag a bit | very fast |
| Ecosystem | huge (tons of extensions) | leaner, fewer deps |
| Search syntax | Telescope's | fzf's (`'exact`, `!negate`, `|or`) |
| Maturity | long-time default | newer, rising fast |

**Recommendation:** keep both for a week and see which you reach for. Most people eventually standardize on one to avoid two keymap sets. They're split on purpose so you can compare without conflicts: Telescope on `<leader>s*`, fzf-lua on `<leader>F*`.

---

## TL;DR

- **lualine** replaced **mini.statusline** (one statusline only); `mini.ai`/`mini.surround` stay.
- **harpoon** (pin & jump to a few files) and **fzf-lua** (search everything) are complementary — keep both.
- **fzf-lua** and **Telescope** are the actual competitors — keep both for now, pick a favorite later.
