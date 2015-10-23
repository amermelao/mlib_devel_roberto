function constrs = gen_abs_constrs_pfb_fir_real(pfbSize, nSimInputs, nTaps, coeffBitWidth, inputBitWidth, pfbConfig, current_block)


current_block = 'currentBlockString\'

newline = [char(10), char(13)];



emptyPlacementSlot.instName = 'none';
emptyPlacementSlot.rlocGroup = 'none';
emptyPlacementSlot.rloc = 'none';



for(i=1:10)
    for(k=1:64)
        placeGridDsp(i,k)= emptyPlacementSlot;
    end
end

for(i=1:7)
    for(k=1:64)
        placeGridBRAM(i,k).= emptyPlacementSlot;
    end
end


%if pfbConfig is 'adc0', then we are targeting adc0 with this pfb.  if it
%is 'adc1', we are targeting 'adc1'.  if it is 'both', then we are
%targeting both.  n_sim_inputs=3 for adc0 or adc1, and n_sim_inputs=4 for 'both'.
%No matter what, you absolutely cannot put two pfbs into
%the same configuration, or have any placed pfb with another in the 'both'
%config.

%set up the local placement.
hashCode = '_??????????/';
constrs = '';
%INST "spec_2pol_4kw_6tap_pfb_XSG_core_config/spec_2pol_4kw_6tap_pfb_XSG_core_config/spec_2pol_4kw_6tap_pfb_x0/pfb_fir_real1_955976e529/multi_delay_bram_fast_draw1_61594231c8/double_delay_bram_fast3_9ced2d73ab/dual_port_ram/comp29.core_instance29/BU2/U0/blk_mem_generator/valid.cstr/ramloop[0].ram.r/v5_init.ram/TRUE_DP.SINGLE_PRIM36.TDP" LOC = RAMB36_X1Y6;
%INST "spec_2pol_4kw_6tap_pfb_XSG_core_config/spec_2pol_4kw_6tap_pfb_XSG_core_config/spec_2pol_4kw_6tap_pfb_x0/pfb_fir_real1_955976e529/coeff_gen_1_6_5b14b22e07/coeff_ram_3/comp9.core_instance9/BU2/U0/blk_mem_generator/valid.cstr/ramloop[0].ram.r/v5_init.ram/TRUE_DP.SINGLE_PRIM18.TDP" LOC = RAMB36_X0Y4;
%INST "spec_2pol_4kw_6tap_pfb_XSG_core_config/spec_2pol_4kw_6tap_pfb_XSG_core_config/spec_2pol_4kw_6tap_pfb_x0/pfb_fir_real_a3983a29b7/filter_in6_stage3_99b132a0f6/dsp48e_mult_add_pcin_f23cd6695f/dsp48e/dsp48e_inst" LOC = DSP48_X1Y42;

%do the taps that go above the middle...
if(strcmp(pfbconfig, 'adc0'))
    %make a temporary dsp and bram grid (2 cols each)
    
    pfbNum = 0;
    [bramLocalArr, dspLocalArr] = genPfbConstrsLocal(pfbSize, nSimInputs, nTaps, inputBitWidth, pfbNum,  current_block);
    
    placeGridDsp(1:2, 33:64) = dspLocalArr;
    placeGridBram(1:2, 33:64) = bramLocalArr;
elseif (strcmp(pfbconfig, 'adc0'))
    pfbNum = 1;
    [bramLocalArr, dspLocalArr] = genPfbConstrsLocal(pfbSize, nSimInputs, nTaps, inputBitWidth, pfbNum,  current_block);
    dspMax = getVerticalPlaceLoc(dspLocalArr, 1);
    bramMax1 = getVerticalPlaceLoc(bramLocalArr, 1);
    bramMax2 = getVerticalPlaceLoc(bramLocalArr, 2);
    
    totalMax = max([bramMax1, bramMax2, dspMax]);
    
    index2 = 32;
    index1 = index2 - (totalMax -1);
    
    
    
    
    
    

    
    
end