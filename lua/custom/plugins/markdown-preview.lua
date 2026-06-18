-- Live Markdown preview in the browser (:MarkdownPreview), themed with flexoki.
return {
  'iamcco/markdown-preview.nvim',
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
