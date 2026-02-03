return {
	{
		"folke/lazydev.nvim", -- configure Lua LSP, for Nvim api
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	{ "Bilal2453/luvit-meta", lazy = true },

	{
		"neovim/nvim-lspconfig", -- Main LSP Configuration

		dependencies = { -- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} }, -- Status animations
		},

		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local langmap = require("langmapper").map
					local map = function(keys, func)
						langmap("n", keys, func, { buffer = event.buf })
					end
					local fzf = require("fzf-lua")

					map("gd", fzf.lsp_definitions) -- To jump back, press <C-t>.
					map("gr", fzf.lsp_references)
					map("gI", fzf.lsp_implementations) -- When your language has ways of declaring types without an actual implementation.
					map("<leader>D", fzf.lsp_typedefs) -- When unsure about type of a variable

					--  Symbols: variables, functions, types, etc.
					map("<leader>ds", fzf.lsp_document_symbols) -- Document-wide
					map("<leader>ws", fzf.lsp_workspace_symbols) -- Entire project-wide

					map("<leader>rn", vim.lsp.buf.rename) --  Most LSPs can rename across files, etc.
					map("<leader>ca", vim.lsp.buf.code_action) -- Execute error correction suggestion
					map("gD", vim.lsp.buf.declaration) --  Ex: in C this would take you to the header.

					local function client_supports_method(client, method, bufnr)
						if vim.fn.has 'nvim-0.11' == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
						local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
						-- Highlight references of the word cursor is on
						vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						-- Clear highlights after cursor movement
						vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd('LspDetach', {
							group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
							end,
						})
					end

					-- Inlay hints (if the LSP supports them)
					if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
						map('<leader>th', function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
						end)
					end
				end,
			})

			--  NOTE: ### Language Servers ### -- See: `:h lspconfig-setup`

			local servers = {
				-- See `:help lspconfig-all` - list of LSPs
				clangd = {
					--setup = {
					--	init_options = {
					--		fallbackFlags = { "-I/usr/include/gtk-4.0" },
					--	}
					--}
				},
				ts_ls = {},
				-- vtsls = {}, -- when tsserver doesn"t work
				cssls = {},
				html = {},
				texlab = {},
				pyright = {},

				lua_ls = {
					settings = {
						Lua = {
							runtime = { -- telling to LSP Lua"s version
								version = "LuaJIT",
							},
							diagnostics = {
								-- globals = { "awesome", "client" }, -- To avoid "Undefined Global" warning
								disable = { "missing-fields", "undefined-global", "lowercase-global" } ,
							},
							workspace = {
								checkThirdParty = false,
								library = { -- Makes server aware of Neovim runtime files, awesome libraries
									vim.env.VIMRUNTIME,
									{ "/usr/share/awesome/lib/" },
								},
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			}

			--  NOTE: ### LSP Manager ### -- Place to add tools that you want Mason to install
			require("mason").setup()

			-- Telling LSP about Neovim"s capabilities (they are expanded with certain plugins, like cmp-nvim-lsp)
			local capabilities = require('blink.cmp').get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, { "stylua" }) -- Formats Lua code
			require("mason-tool-installer").setup { ensure_installed = ensure_installed }

			require("mason-lspconfig").setup {
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

						lspconfig[server_name].setup(server)
					end,
				},
			}
		end,
	},

	{
		'saghen/blink.cmp',
		version = '1.*',
		build = 'cargo build --release',
		dependencies = { 'rafamadriz/friendly-snippets' },

		config = function()
			require("custom.blink_config")
		end,

		opts_extend = { "sources.default" },
	}
}
