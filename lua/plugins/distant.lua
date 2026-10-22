return {
    {
        'chipsenkbeil/distant.nvim',
        branch = 'v0.3',
        -- Measured: requiring distant costs ~23ms of a ~49ms startup, and it is
        -- only needed when editing remote files. Load it on first use instead.
        cmd = { 'Distant' },
        config = function()
            require('distant'):setup()
        end
    }
}
