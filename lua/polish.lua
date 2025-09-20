-- -- This will run last in the setup process.
-- -- This is just pure lua so anything that doesn't
-- -- fit in the normal config locations above can go here

if vim.uv.os_uname().sysname == "Windows_NT" then vim.o.shell = "powershell" end
