return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		-- Automatically open/close UI
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- Keybindings: Invisible until used
		vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Start/Continue Debugging" })
		vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Step Over" })
		vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step Into" })
		vim.keymap.set("n", "<Leader>dx", function()
			dapui.close()
		end, { desc = "Close Debug UI" })

		-- C++ / Vortex Setup
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg", -- This refers to the adapter inside cpptools
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
		}

		-- Unity / C# Setup
		dap.configurations.cs = {
			{
				type = "nlua", -- netcoredbg
				request = "attach",
				name = "Attach to Unity",
				processId = require("dap.utils").pick_process,
			},
		}
	end,
}
