for i =1:length(as)
    gw = as{i};
    gw_name = get_param(gw, 'Name');
    if regexp(gw_name, 'dout_o$')
        set_param(gw, 'Name', clear_name([cursys, '_dout_o']));
    else 
        parent_name = get_param(gw, 'Parent');
        errordlg(['Unknown gateway: ', parent_name, '/', gw_name]);
    end
end