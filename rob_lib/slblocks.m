function blkStruct = slblocks
%SLBLOCKS Defines the Simulink library block representation
%   for the Xilinx Blockset.

% Copyright (c) 1998 Xilinx Inc. All Rights Reserved.

blkStruct.Name    = ['Libreria de prueba de roberto'];
blkStruct.OpenFcn = 'rob_lib.m';
blkStruct.MaskInitialization = '';

blkStruct.MaskDisplay = ['disp(''Libreria de prueba de roberto'')'];

% Define the library list for the Simulink Library browser.
% Return the name of the library model and the name for it
%
Browser(1).Library = 'rob_lib';
Browser(1).Name    = 'Roberto lib';

blkStruct.Browser = Browser;

% End of slblocks.m
