
_addon.author   = 'Eleven Pies';
_addon.name     = 'MyMacro';
_addon.version  = '3.1.0';

require 'common'
require 'myexec.myexec'

local function myexec_macro(name)
    -- Add a nonce to the key to allow running multiple instances
    local tmp_name = name .. '#' .. tostring(os.time());
    if (myexec.exists(tmp_name) == false) then
        local steps = ashita.settings.load(_addon.path .. 'settings/' .. name .. '.json');
        myexec.set_steps(tmp_name, steps);
        myexec.start_steps(tmp_name);
    else
        print ('Already running macro: ' .. name);
    end
end

ashita.register_event('command', function(cmd, nType)
    local args = cmd:args();
    if (args[1] ~= nil and (string.lower(args[1]) == '/exe')) then
        if (args[2] ~= nil) then
            myexec_macro(args[2]);
        else
            print('/exe macroname');
        end

        return true;
    elseif (args[1] ~= nil and (string.lower(args[1]) == '/exedebug')) then
        myexec.print_debug();
        return true;
    end

    return false;
end );

ashita.register_event('load', function()
end );

ashita.register_event('unload', function()
end );
