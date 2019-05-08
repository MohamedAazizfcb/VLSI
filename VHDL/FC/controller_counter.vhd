
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
    generic (
        n              : integer := 256;
        ram_size       : integer := 64;
        address_size   : integer := 8;
        label_size     : integer := 8
    );
    port (
        clk            : in    std_logic; 
        rst            : in    std_logic;
        initiate       : inout std_logic;

        -- IO integration
        enable_read     : out std_logic;
        address_out     : inout std_logic_vector(7 downto 0);
        data_in         : in std_logic_vector(255 downto 0);

        answer    : out std_logic_vector(15 downto 0);
        done_comp : inout std_logic
        
        -- memory
        --clk_inv        : in    std_logic; 
        --enable_mar_in  : inout std_logic;
        --enable_mdr_in  : inout std_logic;
        --enable_mdr_out : inout std_logic;
        --enable_write   : inout std_logic;
        --mdr_data_out   : inout std_logic_vector(255 downto 0);
    );
end entity controller;

architecture a_controller of controller is

    -- decoder signals
    signal sel_dst : std_logic_vector(3 downto 0);
    signal enable_decoder_dst : std_logic;

    signal sel_dst_booth : std_logic_vector(3 downto 0);
    signal enable_decoder_dst_booth : std_logic;

    signal label_reg_file_sel_dst : std_logic_vector(3 downto 0);
    signal label_reg_file_enable_decoder_dst : std_logic;
    
    -- num
    signal enable_num : std_logic;
    signal num_in : std_logic_vector(7 downto 0);
    signal num_out : std_logic_vector(7 downto 0);

    -- signal enable_null_vec : std_logic;
    signal null_vec_in : std_logic_vector(7 downto 0);
    signal null_vec_out : std_logic_vector(7 downto 0);
    
    -- address
    signal enable_address : std_logic;
    signal address_in  : std_logic_vector(7 downto 0);

    signal alu_inp1  : std_logic_vector(label_size - 1 downto 0);
    signal alu_inp2  : std_logic_vector(label_size - 1 downto 0);
    signal alu_out   : std_logic_vector(label_size - 1 downto 0);
    signal alu_sel   : std_logic;
    signal alu_cin   : std_logic;
    signal alu_cout  : std_logic;
    

    signal label_1_input  : std_logic_vector(15 downto 0);
    signal label_2_input  : std_logic_vector(15 downto 0);
    signal label_3_input  : std_logic_vector(15 downto 0);
    signal label_4_input  : std_logic_vector(15 downto 0);
    signal label_5_input  : std_logic_vector(15 downto 0);
    signal label_6_input  : std_logic_vector(15 downto 0);
    signal label_7_input  : std_logic_vector(15 downto 0);
    signal label_8_input  : std_logic_vector(15 downto 0);
    signal label_9_input  : std_logic_vector(15 downto 0);
    signal label_10_input : std_logic_vector(15 downto 0);

    ------------- label output ------------
    signal label_1_output   : std_logic_vector(15 downto 0);
    signal label_2_output   : std_logic_vector(15 downto 0);
    signal label_3_output   : std_logic_vector(15 downto 0);
    signal label_4_output   : std_logic_vector(15 downto 0);
    signal label_5_output   : std_logic_vector(15 downto 0);
    signal label_6_output   : std_logic_vector(15 downto 0);
    signal label_7_output   : std_logic_vector(15 downto 0);
    signal label_8_output   : std_logic_vector(15 downto 0);
    signal label_9_output   : std_logic_vector(15 downto 0);
    signal label_10_output  : std_logic_vector(15 downto 0);


    signal label_1_input_state_machine  : std_logic_vector(15 downto 0);
    signal label_2_input_state_machine  : std_logic_vector(15 downto 0);
    signal label_3_input_state_machine  : std_logic_vector(15 downto 0);
    signal label_4_input_state_machine  : std_logic_vector(15 downto 0);
    signal label_5_input_state_machine  : std_logic_vector(15 downto 0);
    signal label_6_input_state_machine  : std_logic_vector(15 downto 0);
    signal label_7_input_state_machine  : std_logic_vector(15 downto 0);
    signal label_8_input_state_machine  : std_logic_vector(15 downto 0);
    signal label_9_input_state_machine  : std_logic_vector(15 downto 0);
    signal label_10_input_state_machine : std_logic_vector(15 downto 0);

    signal state     : std_logic_vector(2 downto 0); 
    signal sub_state : std_logic_vector(2 downto 0);
    signal ready_signal   : std_logic;    -- from state machine to booth
    signal done           : std_logic;    -- from booth to state machine

    signal label_1_input_booth  : std_logic_vector(15 downto 0); 
    signal label_2_input_booth  : std_logic_vector(15 downto 0);
    signal label_3_input_booth  : std_logic_vector(15 downto 0);
    signal label_4_input_booth  : std_logic_vector(15 downto 0);
    signal label_5_input_booth  : std_logic_vector(15 downto 0);
    signal label_6_input_booth  : std_logic_vector(15 downto 0);
    signal label_7_input_booth  : std_logic_vector(15 downto 0);
    signal label_8_input_booth  : std_logic_vector(15 downto 0);
    signal label_9_input_booth  : std_logic_vector(15 downto 0);
    signal label_10_input_booth : std_logic_vector(15 downto 0);
    
    signal start_comp : std_logic;

begin
	
    process( clk , rst , ready_signal)
    begin

        if(rst='1') then 
            state <= "000";
  	        sub_state <= "000";
            sel_dst <= "0000"; 
            enable_decoder_dst <= '0';
            alu_cin <= '0';
            enable_num <= '0';
            enable_address <= '0';
            ready_signal <= '0';
            enable_read <= '0';
            address_in <= ( 7 downto 0 => '0');

            start_comp <= '0';

            label_1_input_state_machine  <= (15 downto 0 => '0');
            label_2_input_state_machine  <= (15 downto 0 => '0');
            label_3_input_state_machine  <= (15 downto 0 => '0');
            label_4_input_state_machine  <= (15 downto 0 => '0');
            label_5_input_state_machine  <= (15 downto 0 => '0');
            label_6_input_state_machine  <= (15 downto 0 => '0');
            label_7_input_state_machine  <= (15 downto 0 => '0');
            label_8_input_state_machine  <= (15 downto 0 => '0');
            label_9_input_state_machine  <= (15 downto 0 => '0');
            label_10_input_state_machine <= (15 downto 0 => '0');

        elsif (clk'event and clk = '1') then
            if(initiate = '1') then
                ready_signal <= '0'; 
		        initiate <= '0';
                state <= "000";       
            elsif (state = "000" ) then
                if (sub_state = "000") then
                    sel_dst <= "0000"; 
                    enable_read <= '0';
                    enable_decoder_dst <= '0';
                    address_in <= "00000000";
                    enable_num <= '1';
                    null_vec_in <= (7 downto 0 =>'0');
                    sub_state <= "001";
                elsif (sub_state = "001") then
                    sub_state <= "010";
                    enable_address <= '1';
                    enable_read <= '1';
                elsif (sub_state = "010") then 
                    sub_state <= "011";
                    alu_inp1 <= address_out;
                    alu_inp2 <= "00000001";
                    alu_sel <= '0';
                    enable_read <= '0';
                elsif (sub_state = "011") then
                    sub_state <= "100";
                    address_in <= alu_out;
                else
                    sub_state <= "000";
                    num_in <= data_in(7 downto 0);
                    state <= "001";
                end if;

            elsif (state = "001") then
                if(sub_state = "000") then
                    sel_dst <= "0000"; 
                    enable_read <= '0';
                    enable_decoder_dst <= '0';
                    sub_state <= "001";
                elsif (sub_state = "001") then 
                    sub_state <= "010";
                    enable_read <= '1';
                elsif (sub_state = "010") then
                    sub_state <= "011";
                    enable_read <= '0';
                    alu_inp1 <= address_out;
                    alu_inp2 <= "00000001";
                    alu_sel <= '0';
                elsif (sub_state = "011") then
                    sub_state <= "100";
                    address_in <= alu_out; 
                else
                    sub_state <= "000";
                    state <= "010";
                    enable_decoder_dst <= '1';
                    sel_dst <= "1111";

                    label_1_input_state_machine  <= data_in(15 downto 0);
                    label_2_input_state_machine  <= data_in(31 downto 16);
                    label_3_input_state_machine  <= data_in(47 downto 32);
                    label_4_input_state_machine  <= data_in(63 downto 48);
                    label_5_input_state_machine  <= data_in(79 downto 64);
                    label_6_input_state_machine  <= data_in(95 downto 80);
                    label_7_input_state_machine  <= data_in(111 downto 96);
                    label_8_input_state_machine  <= data_in(127 downto 112);
                    label_9_input_state_machine  <= data_in(143 downto 128);
                    label_10_input_state_machine <= data_in(159 downto 144);

                end if;
            
            elsif (state = "010") then
                -- here all neurons are done and I'm waiting for another initiate signal.
                if(num_out = null_vec_out and done = '1') then
                    start_comp <= '1';
                    state <= "100"; --idle
                -- if ready_signal is equal to zero this means booths needs more.
                elsif (ready_signal = '0' or done = '1') then
                    if(sub_state = "000") then
                        sel_dst <= "0000";
                        enable_read <= '0';
                        enable_decoder_dst <= '0';
                        ready_signal <= '0';
                        sub_state <= "001";
                    elsif (sub_state = "001") then
                        sub_state <= "010";
                        enable_read <= '1';
                        alu_inp1 <= address_out;
                        alu_inp2 <= "00000001";
                        alu_sel <= '0';
                    elsif ( sub_state = "010" ) then
                        sub_state <= "011";
                        address_in <= alu_out;
                    else 
	    	        	sub_state <= "000";
		    	        state <= "011";
                        enable_read <= '0';
                    end if;    
                end if ;
            elsif(state = "011") then
                if (sub_state = "000") then
                    sel_dst <= "0000"; 
                    enable_read <= '0';
                    enable_decoder_dst <= '0';
                    alu_inp1 <= num_out;
                    alu_inp2 <= "00000001";
                    alu_cin <= '0';
                    alu_sel <= '1';
                    sub_state <= "001";
                else
                    num_in <= alu_out;
                    ready_signal <= '1';
                    state <= "010";
                    sub_state <= "000";
                end if;
                         
            elsif(state = "100") then  
                state <= "100";
            end if;
        end if;
    end process; 
    
    -- specialregfile : entity work.special_register_file port map ( clk , clk_inv , rst ,  enable_mar_in , enable_mdr_in , enable_mdr_out , enable_write , address_out, mdr_data_out );
    -- address_out <= address_out_7 & address_out_6 & address_out_5 & address_out_4 & address_out_3 & address_out_2 & address_out_1 & address_out_0;
    -- signal address_out : std_logic_vector(7 downto 0);

    max_calc : entity work.maximum_ic port map(
        clk         ,
        rst         ,
        start_comp  ,
        done_comp   ,
        label_1_output, 
        label_2_output, 
        label_3_output,
        label_4_output,
        label_5_output, 
        label_6_output,
        label_7_output, 
        label_8_output, 
        label_9_output,
        label_10_output,
        answer  
    );


    labelsregfile  : entity work.label_register_file 
    port map ( 
        
        clk,
        rst,
        
        label_reg_file_enable_decoder_dst,
        label_reg_file_sel_dst,
        
        label_1_input,
        label_2_input,
        label_3_input,
        label_4_input,
        label_5_input,
        label_6_input,
        label_7_input,
        label_8_input,
        label_9_input,
        label_10_input,
        
        label_1_output, 
        label_2_output, 
        label_3_output,
        label_4_output,
        label_5_output, 
        label_6_output,
        label_7_output, 
        label_8_output, 
        label_9_output,
        label_10_output 
    );

    alu_subtractor_adder : entity work.alu generic map ( label_size ) port map ( alu_inp1 , alu_inp2 , alu_sel , alu_cin , alu_out , alu_cout );

    addr: entity work.N_Dff generic map (address_size) port map ( clk , rst , enable_address , address_in , address_out );
    num : entity work.N_Dff generic map ( 8 ) port map ( clk , rst , enable_num , num_in , num_out );
    null_vec : entity work.N_Dff generic map ( 8 ) port map ( clk , rst , '0' , null_vec_in , null_vec_out );
     
    booth : entity work.booth_adder_components port map (
        
        clk,
        rst,
        ready_signal,
        done,

        -- Neuron and its weights
        data_in(15 downto 0),
        data_in(31 downto 16),
        data_in(47 downto 32),
        data_in(63 downto 48),
        data_in(79 downto 64),
        data_in(95 downto 80),
        data_in(111 downto 96),
        data_in(127 downto 112),
        data_in(143 downto 128),
        data_in(159 downto 144),
        data_in(175 downto 160),
        
        label_1_input_booth,
        label_2_input_booth,
        label_3_input_booth,
        label_4_input_booth,
        label_5_input_booth,
        label_6_input_booth,
        label_7_input_booth,
        label_8_input_booth,
        label_9_input_booth,
        label_10_input_booth,
        
        label_1_output,
        label_2_output,
        label_3_output,
        label_4_output,
        label_5_output,
        label_6_output, 
        label_7_output,
        label_8_output,
        label_9_output,
        label_10_output,
        
        enable_decoder_dst_booth,
	    sel_dst_booth
        
    );

    label_reg_file_enable_decoder_dst <= '1' when (enable_decoder_dst = '1' or enable_decoder_dst_booth = '1') else
                                         '0';
    
    label_reg_file_sel_dst <=  sel_dst when enable_decoder_dst = '1' else
                               sel_dst_booth when enable_decoder_dst_booth = '1' else
                                "0000";



    label_1_input <= label_1_input_booth when  enable_decoder_dst_booth = '1' else 
                        label_1_input_state_machine when enable_decoder_dst = '1';
    
    label_2_input <= label_2_input_booth when  enable_decoder_dst_booth = '1' else
    label_2_input_state_machine when enable_decoder_dst = '1';
        
    label_3_input <= label_3_input_booth when  enable_decoder_dst_booth = '1' else
    label_3_input_state_machine when enable_decoder_dst = '1';
        
    label_4_input <= label_4_input_booth when  enable_decoder_dst_booth = '1' else
    label_4_input_state_machine when enable_decoder_dst = '1';
        
    label_5_input <= label_5_input_booth when  enable_decoder_dst_booth = '1' else
    label_5_input_state_machine when enable_decoder_dst = '1';
        
    label_6_input <= label_6_input_booth when  enable_decoder_dst_booth = '1' else
    label_6_input_state_machine when enable_decoder_dst = '1';
        
    label_7_input <= label_7_input_booth when  enable_decoder_dst_booth = '1' else
    label_7_input_state_machine when enable_decoder_dst = '1';
        
    label_8_input <= label_8_input_booth when  enable_decoder_dst_booth = '1' else
    label_8_input_state_machine when enable_decoder_dst = '1';
        
    label_9_input <= label_9_input_booth when  enable_decoder_dst_booth = '1' else
    label_9_input_state_machine when enable_decoder_dst = '1';
        
    label_10_input <= label_10_input_booth when  enable_decoder_dst_booth = '1' else
    label_10_input_state_machine when enable_decoder_dst = '1';
             
end a_controller;
