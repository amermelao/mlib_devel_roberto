function result = get(b,field)
try
eval(['result = b.',field,';']);
catch
try
result = get(b.xps_block,field);
catch
error(['Field name unknow to block object: ', field]);
end
end
