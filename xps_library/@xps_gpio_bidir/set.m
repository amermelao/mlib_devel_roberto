function b = set(b,field,value)
try
eval(['b.',field,'=value;']);
catch
b.xps_block = set(b.xps_block,field,value);
end
