-- Live Markdown preview in the browser (:MarkdownPreview), themed with flexoki.
return {
  'iamcco/markdown-preview.nvim',
  -- The build below patches tracked files (index.jsx + the prebuilt app/out),
  -- which leaves this plugin's git tree dirty. Pin it so `:Lazy sync` won't try
  -- to pull updates and fail with "local changes ... Please remove them". It is
  -- built once on install and then stays put (update manually with `x` then `I`).
  pin = true,
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = function()
    local plugin_dir = vim.fn.stdpath('data') .. '/lazy/markdown-preview.nvim'
    local jsx = plugin_dir .. '/app/pages/index.jsx'

    -- Patch: always show the dark-mode toggle (not just on hover)
    local content = table.concat(vim.fn.readfile(jsx), '\n')
    content = content:gsub('themeModeIsVisible: false', 'themeModeIsVisible: true')
    vim.fn.writefile(vim.split(content, '\n'), jsx)

    -- Install deps then rebuild the Next.js frontend
    vim.fn.system('cd ' .. plugin_dir .. '/app && yarn install')
    vim.fn.system(
      'cd ' .. plugin_dir ..
      ' && yarn install' ..
      ' && NODE_OPTIONS=--openssl-legacy-provider yarn build-app'
    )
  end,
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
    vim.g.mkdp_markdown_css = vim.fn.stdpath('config') .. '/flexoki-markdown.css'
    vim.g.mkdp_highlight_css = vim.fn.stdpath('config') .. '/flexoki-highlight.css'
  end,
  ft = { 'markdown' },
}
