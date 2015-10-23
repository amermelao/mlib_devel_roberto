function fir_init(blk, varargin)
%este bloque sirve para ...
if same_state(blk, varargin{:}), return, end
munge_block(blk, varargin{:});
num1=get_var('num1', varargin{:});
num2=get_var('num2', varargin{:});
if num2<0, error('inside summer: num2 cannot be less than 0'), end
delete_lines(blk);

reuse_block(blk, 'const1', 'xbsIndex_r4/Constant', 'const', num2str(num1), ...
    'n_bits', '8', 'bin_pt','7','arith_type', 'Unsigned','Position', [25    29    95    61]);
reuse_block(blk, 'const2', 'xbsIndex_r4/Constant', 'const', num2str(num2), ...
    'Position', [25    79    95    111]);
reuse_block(blk, 'adder', 'xbsIndex_r4/AddSub', 'latency','3', ...
    'Position', [140    51    210    84]);
reuse_block(blk, 'out', 'built-in/outport', 'Port', '1', ...
    'Position', [265    60    285    80]);

add_line(blk, 'const1/1', 'adder/1');
add_line(blk, 'const2/1', 'adder/2');
add_line(blk, 'adder/1', 'out/1');
