-- ASIAA 5 GSps ADC DMUX 1:1 board interface
-- This should run at the full rate on ROACH-2
--
--
-----------------------------------------------------------
-- Block Name: adc5g_dmux1_mux_x2
--
----------------------------------------------------------
-- Designers: Roberto Fuentes
-- 
-- Revisions: initial 25-09-2015
--            for sx475t-1  (Roach2 board)
--
--
--
----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library adc5g_dmux_x2_interface_v1_00_a;
use adc5g_dmux_x2_interface_v1_00_a.all;

--------------------------------------------
--    ENTITY section
--------------------------------------------

entity adc5g_dmux_x2_interface is
  generic (  
    adc_bit_width   : integer :=8;
    clkin_period    : real    :=2.0;  -- clock in period (ns)
    mode            : integer :=0;    -- 1-channel mode
    mmcm_m          : real    :=2.0;  -- MMCM multiplier value
    mmcm_d          : integer :=1;    -- MMCM divide value
    mmcm_o0         : real    :=2.0;  -- MMCM first clock divide
    mmcm_o1         : integer :=2;    -- MMCM second clock divide
    bufr_div        : integer :=4;
    bufr_div_str    : string  :="4"
    );
  port (      
    ctrl_clk_in     : in std_logic;-- this is the only entry that is common

    --ADC0
    --Miselaneus inputs  are not comming from the adc
    adc0_dcm_reset       : in std_logic;
    adc0_dcm_psclk       : in std_logic;
    adc0_dcm_psen        : in std_logic;
    adc0_dcm_psincdec    : in std_logic;
    adc0_ctrl_reset      : in std_logic;

    --Miselaneus out, this don't apear in the yellow block
    adc0_dcm_psdone      : out std_logic;
    adc0_ctrl_clk_out    : out std_logic;
    adc0_ctrl_clk90_out  : out std_logic;
    adc0_ctrl_clk180_out : out std_logic;
    adc0_ctrl_clk270_out : out std_logic;
    adc0_ctrl_dcm_locked : out std_logic;
    adc0_fifo_full_cnt   : out std_logic_vector(15 downto 0);
    adc0_fifo_empty_cnt  : out std_logic_vector(15 downto 0);
    
    adc0_datain_pin      : in std_logic_vector(4 downto 0);
    adc0_datain_tap      : in std_logic_vector(4 downto 0);
    adc0_tap_rst         : in std_logic


    -- Ports 
    adc0_adc_clk_p_i     : in std_logic;
    adc0_adc_clk_n_i     : in std_logic;
    adc0_adc_sync_p      : in std_logic;
    adc0_adc_sync_n      : in std_logic;
    adc0_adc_data0_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i0:i1
    adc0_adc_data0_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i0:i1
    adc0_adc_data1_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q0:q1
    adc0_adc_data1_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q0:q1
    adc0_adc_data2_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i2:i3
    adc0_adc_data2_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i2:i3
    adc0_adc_data3_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q2:q3
    adc0_adc_data3_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q2:q3

    adc0_sync            : out std_logic;
    adc0_user_data_i0    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_i1    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_i2    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_i3    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_i4    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_i5    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_i6    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_i7    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_q0    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_q1    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_q2    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_q3    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_q4    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_q5    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_q6    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_user_data_q7    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc0_adc_reset_o     : out std_logic;

    --ADC1
    --Miselaneus inputs  are not comming from the adc
    adc1_dcm_reset       : in std_logic;
    adc1_dcm_psclk       : in std_logic;
    adc1_dcm_psen        : in std_logic;
    adc1_dcm_psincdec    : in std_logic;
    adc1_ctrl_reset      : in std_logic;

    --Miselaneus out, this don't apear in the yellow block
    adc1_dcm_psdone      : out std_logic;
    adc1_ctrl_clk_out    : out std_logic;
    adc1_ctrl_clk90_out  : out std_logic;
    adc1_ctrl_clk180_out : out std_logic;
    adc1_ctrl_clk270_out : out std_logic;
    adc1_ctrl_dcm_locked : out std_logic;
    adc1_fifo_full_cnt   : out std_logic_vector(15 downto 0);
    adc1_fifo_empty_cnt  : out std_logic_vector(15 downto 0);
    
    adc1_datain_pin      : in std_logic_vector(4 downto 0);
    adc1_datain_tap      : in std_logic_vector(4 downto 0);
    adc1_tap_rst         : in std_logic


    -- external Ports 

    adc1_adc_clk_p_i     : in std_logic;
    adc1_adc_clk_n_i     : in std_logic;

    adc1_adc_sync_p      : in std_logic;
    adc1_adc_sync_n      : in std_logic;
    adc1_adc_data0_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i0:i1
    adc1_adc_data0_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i0:i1
    adc1_adc_data1_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q0:q1
    adc1_adc_data1_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q0:q1
    adc1_adc_data2_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i2:i3
    adc1_adc_data2_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i2:i3
    adc1_adc_data3_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q2:q3
    adc1_adc_data3_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q2:q3

    adc1_sync            : out std_logic;
    adc1_user_data_i0    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_i1    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_i2    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_i3    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_i4    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_i5    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_i6    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_i7    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_q0    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_q1    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_q2    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_q3    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_q4    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_q5    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_q6    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_user_data_q7    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc1_adc_reset_o     : out std_logic;
    );
end  adc5g_dmux_x2_interface ;

----------------------------------------------
--    ARCHITECTURE section
----------------------------------------------

architecture behavioral of adc5g_dmux_x2_interface is

    component adc5g_dmux1_interface
        generic (  
            adc_bit_width   : integer :=8;
            clkin_period    : real    :=2.0;  -- clock in period (ns)
            mode            : integer :=0;    -- 1-channel mode
            mmcm_m          : real    :=2.0;  -- MMCM multiplier value
            mmcm_d          : integer :=1;    -- MMCM divide value
            mmcm_o0         : real    :=2.0;  -- MMCM first clock divide
            mmcm_o1         : integer :=2;    -- MMCM second clock divide
            bufr_div        : integer :=4;
            bufr_div_str    : string  :="4"
            );
        port (
            adc_clk_p_i     : in std_logic;
            adc_clk_n_i     : in std_logic;
            adc_sync_p      : in std_logic;
            adc_sync_n      : in std_logic;
            dcm_reset       : in std_logic;
            dcm_psclk       : in std_logic;
            dcm_psen        : in std_logic;
            dcm_psincdec    : in std_logic;
            ctrl_reset      : in std_logic;
            ctrl_clk_in     : in std_logic;
            adc_data0_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i0:i1
            adc_data0_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i0:i1
            adc_data1_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q0:q1
            adc_data1_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q0:q1
            adc_data2_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i2:i3
            adc_data2_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i2:i3
            adc_data3_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q2:q3
            adc_data3_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q2:q3

            sync            : out std_logic;
            dcm_psdone      : out std_logic;
            ctrl_clk_out    : out std_logic;
            ctrl_clk90_out  : out std_logic;
            ctrl_clk180_out : out std_logic;
            ctrl_clk270_out : out std_logic;
            ctrl_dcm_locked : out std_logic;
            fifo_full_cnt   : out std_logic_vector(15 downto 0);
            fifo_empty_cnt  : out std_logic_vector(15 downto 0);
            user_data_i0    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_i1    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_i2    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_i3    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_i4    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_i5    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_i6    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_i7    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_q0    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_q1    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_q2    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_q3    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_q4    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_q5    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_q6    : out std_logic_vector(adc_bit_width-1 downto 0);
            user_data_q7    : out std_logic_vector(adc_bit_width-1 downto 0);
            adc_reset_o     : out std_logic;

            datain_pin      : in std_logic_vector(4 downto 0);
            datain_tap      : in std_logic_vector(4 downto 0);
            tap_rst         : in std_logic
            );
    end component;

    begin

        ADC0:adc5g_dmux1_interface
            port mat (
                adc_clk_p_i     => adc0_adc_clk_p_i  , 
                adc_clk_n_i     => adc0_adc_clk_n_i  , 
                adc_sync_p      => adc0_adc_sync_p   , 
                adc_sync_n      => adc0_adc_sync_n   , 
                dcm_reset       => adc0_dcm_reset    , 
                dcm_psclk       => adc0_dcm_psclk    , 
                dcm_psen        => adc0_dcm_psen     , 
                dcm_psincdec    => adc0_dcm_psincdec , 
                ctrl_reset      => adc0_ctrl_reset   , 
                ctrl_clk_in     => ctrl_clk_in  , 
                adc_data0_p_i   => adc0_adc_data0_p_i, 
                adc_data0_n_i   => adc0_adc_data0_n_i, 
                adc_data1_p_i   => adc0_adc_data1_p_i, 
                adc_data1_n_i   => adc0_adc_data1_n_i, 
                adc_data2_p_i   => adc0_adc_data2_p_i, 
                adc_data2_n_i   => adc0_adc_data2_n_i, 
                adc_data3_p_i   => adc0_adc_data3_p_i, 
                adc_data3_n_i   => adc0_adc_data3_n_i, 

                sync            => adc0_sync           ,
                dcm_psdone      => adc0_dcm_psdone     ,
                ctrl_clk_out    => adc0_ctrl_clk_out   ,
                ctrl_clk90_out  => adc0_ctrl_clk90_out ,
                ctrl_clk180_out => adc0_ctrl_clk180_out,
                ctrl_clk270_out => adc0_ctrl_clk270_out,
                ctrl_dcm_locked => adc0_ctrl_dcm_locked,
                fifo_full_cnt   => adc0_fifo_full_cnt  ,
                fifo_empty_cnt  => adc0_fifo_empty_cnt ,
                user_data_i0    => adc0_user_data_i0   ,
                user_data_i1    => adc0_user_data_i1   ,
                user_data_i2    => adc0_user_data_i2   ,
                user_data_i3    => adc0_user_data_i3   ,
                user_data_i4    => adc0_user_data_i4   ,
                user_data_i5    => adc0_user_data_i5   ,
                user_data_i6    => adc0_user_data_i6   ,
                user_data_i7    => adc0_user_data_i7   ,
                user_data_q0    => adc0_user_data_q0   ,
                user_data_q1    => adc0_user_data_q1   ,
                user_data_q2    => adc0_user_data_q2   ,
                user_data_q3    => adc0_user_data_q3   ,
                user_data_q4    => adc0_user_data_q4   ,
                user_data_q5    => adc0_user_data_q5   ,
                user_data_q6    => adc0_user_data_q6   ,
                user_data_q7    => adc0_user_data_q7   ,
                adc_reset_o     => adc0_adc_reset_o    ,

                datain_pin      => adc0_datain_pin ,
                datain_tap      => adc0_datain_tap ,
                tap_rst         => adc0_tap_rst    ,
            );

        ADC1:adc5g_dmux1_interface
            port mat (
                adc_clk_p_i     => adc1_adc_clk_p_i  , 
                adc_clk_n_i     => adc1_adc_clk_n_i  , 
                adc_sync_p      => adc1_adc_sync_p   , 
                adc_sync_n      => adc1_adc_sync_n   , 
                dcm_reset       => adc1_dcm_reset    , 
                dcm_psclk       => adc1_dcm_psclk    , 
                dcm_psen        => adc1_dcm_psen     , 
                dcm_psincdec    => adc1_dcm_psincdec , 
                ctrl_reset      => adc1_ctrl_reset   , 
                ctrl_clk_in     => ctrl_clk_in  , 
                adc_data0_p_i   => adc1_adc_data0_p_i, 
                adc_data0_n_i   => adc1_adc_data0_n_i, 
                adc_data1_p_i   => adc1_adc_data1_p_i, 
                adc_data1_n_i   => adc1_adc_data1_n_i, 
                adc_data2_p_i   => adc1_adc_data2_p_i, 
                adc_data2_n_i   => adc1_adc_data2_n_i, 
                adc_data3_p_i   => adc1_adc_data3_p_i, 
                adc_data3_n_i   => adc1_adc_data3_n_i, 

                sync            => adc1_sync           ,
                dcm_psdone      => adc1_dcm_psdone     ,
                ctrl_clk_out    => adc1_ctrl_clk_out   ,
                ctrl_clk90_out  => adc1_ctrl_clk90_out ,
                ctrl_clk180_out => adc1_ctrl_clk180_out,
                ctrl_clk270_out => adc1_ctrl_clk270_out,
                ctrl_dcm_locked => adc1_ctrl_dcm_locked,
                fifo_full_cnt   => adc1_fifo_full_cnt  ,
                fifo_empty_cnt  => adc1_fifo_empty_cnt ,
                user_data_i0    => adc1_user_data_i0   ,
                user_data_i1    => adc1_user_data_i1   ,
                user_data_i2    => adc1_user_data_i2   ,
                user_data_i3    => adc1_user_data_i3   ,
                user_data_i4    => adc1_user_data_i4   ,
                user_data_i5    => adc1_user_data_i5   ,
                user_data_i6    => adc1_user_data_i6   ,
                user_data_i7    => adc1_user_data_i7   ,
                user_data_q0    => adc1_user_data_q0   ,
                user_data_q1    => adc1_user_data_q1   ,
                user_data_q2    => adc1_user_data_q2   ,
                user_data_q3    => adc1_user_data_q3   ,
                user_data_q4    => adc1_user_data_q4   ,
                user_data_q5    => adc1_user_data_q5   ,
                user_data_q6    => adc1_user_data_q6   ,
                user_data_q7    => adc1_user_data_q7   ,
                adc_reset_o     => adc1_adc_reset_o    ,

                datain_pin      => adc1_datain_pin ,
                datain_tap      => adc1_datain_tap ,
                tap_rst         => adc1_tap_rst    ,
            );

    end  adc5g_dmux1_interface ;


end behavioral; 