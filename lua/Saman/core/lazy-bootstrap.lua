local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local function locked_lazy_commit()
	local lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json"
	local ok, contents = pcall(vim.fn.readfile, lockfile)
	if not ok then
		return nil
	end

	local decoded_ok, lock = pcall(vim.json.decode, table.concat(contents, "\n"))
	if not decoded_ok or type(lock) ~= "table" then
		return nil
	end

	return lock["lazy.nvim"] and lock["lazy.nvim"].commit or nil
end

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local commit = locked_lazy_commit()
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--no-checkout", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end

	if commit then
		out = vim.fn.system({ "git", "-C", lazypath, "checkout", "--detach", commit })
	else
		out = vim.fn.system({ "git", "-C", lazypath, "checkout", "stable" })
	end

	if vim.v.shell_error ~= 0 then
		vim.fn.delete(lazypath, "rf")
		error("Error checking out lazy.nvim:\n" .. out)
	end
end

vim.opt.rtp:prepend(lazypath)
