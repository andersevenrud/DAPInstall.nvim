local M = {}

local dbg_path = require("dap-install.debuggers_list").debuggers["markdown_dbg"][2]

M.dap_info = {
    name_adapter = "markdown",
    name_configuration = "markdown",
}

M.config = {
    adapters = {
        type = "executable",
        name = "mockdebug",
        command = "node",
        args = {"./out/debugAdapter.js"},
        cwd = dbg_path .. "vscode-mock-debug/"
    },
    configurations = {
        {
            type = "mock",
            request = "launch",
            name = "mock test",
            program = "${file}", -- This configuration will launch the current file if used.
            stopOnEntry = true,
            debugServer = 4711
        }
    }
}

M.installer = {
    before = "",
    install = [[
		git clone https://github.com/Microsoft/vscode-mock-debug.git
		cd vscode-mock-debug
		sudo npm install
	]],
    uninstall = [[
		cd vscode-mock-debug && sudo npm uninstall .
		cd ../..
		sudo rm -rf markdown_dbg
	]]
}

return M
