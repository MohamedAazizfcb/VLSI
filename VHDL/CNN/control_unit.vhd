library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

entity control_unit is
 port ( 
    clk : in  std_logic;
	x_MFC : inout  std_logic;
	data_out: in std_logic_vector(511 downto 0);
	data_in: out std_logic_vector(511 downto 0);
	ram_address: out std_logic_vector(15 downto 0);
	ram_wr, ram_rd: out std_logic;
	Weights_ptr: out std_logic_vector(15 downto 0);
	Start_signal: in std_logic;
	Go_FC_Go: out std_logic
  );
end control_unit;

architecture controlUnit of control_unit is
-- Process signal received from the IO module
signal Pro_signal: std_logic := '0';
--signal Go_FC_Go: std_logic;
signal row0_en, row1_en, row2_en, row3_en, row4_en,row_counter_en: std_logic;

-- Conditions of states
signal Cond1: std_logic;
signal Cond2: std_logic;
signal Cond2_sub: std_logic;
signal Cond3: std_logic;
signal Cond3_sub:std_logic;
--signal set_no_rows: std_logic := '0';
signal Cond4: std_logic;
signal Cond5: std_logic;
signal Cond6,Cond6_sub: std_logic;
signal Cond7: std_logic := '0';
signal Cond8: std_logic := '0';

-- RAM variables intialization
--signal data_out: std_logic_vector(511 downto 0);
--signal data_in: std_logic_vector(511 downto 0);
--signal ram_address: std_logic_vector(15 downto 0);
--signal ram_wr: std_logic;
--signal ram_rd: std_logic;


-- Beginging flag egister
signal begin_out: std_logic_vector(0 downto 0) := "1";
signal begin_in: std_logic_vector(0 downto 0) := "1";
signal begin_rst: std_logic := '0';
signal begin_en: std_logic := '0';

-- state counter intialization variables 
signal enable_state_counter: std_logic := '0';
signal reset_state_counter: std_logic := '0';
signal state_counter_out: std_logic_vector(7 downto 0);

-- first time signal variables
signal rst_first_time: std_logic;
signal first_time_out: std_logic_vector(0 downto 0) := "0";
signal first_time_en : std_logic_vector(0 downto 0);
signal first_time_temp: std_logic;


-- Layers number register variables -- 3 bits(8 max as mentioned)
signal layers_number_out: std_logic_vector(2 downto 0);
signal layers_number_rst: std_logic := '0';
signal layers_number_en: std_logic;

-- Layers_number_tristate variables
--signal LN_tri_out: std_logic_vector(2 downto 0);
--signal LN_tri_en: std_logic;
 
-- IMG PTRs
signal img_ptr: std_logic_vector(15 downto 0) := "0000000000010000";
signal alt_img_ptr: std_logic_vector(15 downto 0) := "0000000000001000";
signal current_img_ptr:std_logic_vector(15 downto 0) := "0000000000010000";
signal new_current_img_ptr:std_logic_vector(15 downto 0) := "0000000000010000";
signal swap_en:std_logic;
signal rst_current_img_ptr: std_logic;

-- Condition 2 signals
signal state1_en: std_logic;
signal filters_size: std_logic_vector(2 downto 0);
signal in_depth : std_logic_vector(6 downto 0);
signal out_depth : std_logic_vector(6 downto 0);
signal in_size : std_logic_vector(4 downto 0);
signal out_size : std_logic_vector(4 downto 0);
signal conv_pool : std_logic;
signal filters_number : std_logic_vector(3 downto 0);

-- filter ptr signals
signal enable_filter_ptr_inc: std_logic := '0'; 
signal filter_ptr_rst: std_logic := '0';
signal filter_ptr_out: std_logic_vector(15 downto 0) := "0000000000000001";
signal filter_ptr_en: std_logic := '0';


-- window loader signals
signal row_ptr: std_logic_vector(2 downto 0);
signal get_new_rows: std_logic := '1';
signal row0: std_logic_vector(511 downto 0);
signal row1: std_logic_vector(511 downto 0);
signal row2: std_logic_vector(511 downto 0);
signal row3: std_logic_vector(511 downto 0);
signal row4: std_logic_vector(511 downto 0);

  
-- sorted rows 
signal row0_sorted: std_logic_vector(511 downto 0);
signal row1_sorted: std_logic_vector(511 downto 0);
signal row2_sorted: std_logic_vector(511 downto 0);
signal row3_sorted: std_logic_vector(511 downto 0);
signal row4_sorted: std_logic_vector(511 downto 0);

signal no_row_pass_out: std_logic_vector(2 downto 0);
signal send_row_ptr_en:std_logic;
signal flag : std_logic_vector(7 downto 0);

-- window loader signals 
signal window_en_3_4: std_logic;
signal window_reset: std_logic := '0';
signal window_en: std_logic;
signal window_0:std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
signal window_1:std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
signal window_2:std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
signal window_3:std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
signal window_4:std_logic_vector(79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";

--bias signals
--signal biases_en: std_logic;
signal bias_done: std_logic_vector(0 downto 0) := "0";
signal biases: std_logic_vector(399 downto 0);
signal bias_rst: std_logic := '0';
signal bias: std_logic_vector(15 downto 0);
signal bias_done_rst: std_logic := '0';

-- image ptr counter signals
signal enable_img_ptr_inc:std_logic;
signal img_ptr_rst:std_logic := '0';
signal img_ptr_out:std_logic_vector(15 downto 0);
signal force_img_ptr: std_logic;
signal img_ptr_value_force: std_logic_vector(15 downto 0);

-- no rows passed signals
signal no_row_to_get_counter_en: std_logic;
signal zero_flag_rows: std_logic := '1';

-- filter
signal filter: std_logic_vector(511 downto 0);
signal filter_en: std_logic := '0';
signal filter_loaded: std_logic:='0';
signal reset_filters_covered_counter: std_logic :='1';
signal filters_counter_out: std_logic_vector(15 downto 0);
signal filters_number_xor_B: std_logic_vector(15 downto 0);
signal filters_covered_xor_out: std_logic;

-- number of rows covered signals
signal rows_covered_en:std_logic := '0';
signal rows_covered_xor_out : std_logic; 
signal rows_covered_counter_out:std_logic_vector(15 downto 0);
signal rows_covered_xor_B:std_logic_vector(15 downto 0);
signal rows_value_force:std_logic_vector(7 downto 0);

-- number of images covered signals
signal images_covered_rst:std_logic := '0';
signal images_covered_counter_out:std_logic_vector(15 downto 0);
signal images_covered_xor_out:std_logic;
signal images_covered_counter_en: std_logic := '0';
signal images_covered_xor_B: std_logic_vector(15 downto 0);

-- number of columns covered signals
signal columns_covered_xor_B : std_logic_vector(7 downto 0);
--signal columns_covered_en:std_logic; 
signal columns_covered_counter_out: std_logic_vector(7 downto 0);
signal columns_covered_xor_out: std_logic;


-- number of layers covered signals
signal layers_covered_counter_en: std_logic;
signal layers_covered_counter_out: std_logic_vector(7 downto 0);
signal layers_covered_xor_B: std_logic_vector(7 downto 0);
signal layers_covered_xor_out: std_logic;

-- result calculation logic
signal wait_op_en: std_logic := '0';
signal wait_op_rst: std_logic := '0';
signal wait_op_out: std_logic_vector(7 downto 0);
signal op_done: std_logic;
signal five: std_logic;

-- new row write signals
signal new_row : std_logic_vector(511 downto 0);
signal result : std_logic_vector(15 downto 0);
signal new_row_en : std_logic := '0';
signal new_row_rst : std_logic := '0';
signal row_is_done : std_logic := '0';
signal write_row_tri_en: std_logic;


-- fixing signals
signal layers_number_address_tri_en,rows_covered_counter_rst,columns_covered_counter_rst,images_covered_counter_rst,last_cycle_flag,state_counter_rst_1, state_counter_rst_2: std_logic;
signal layers_number_out_sub: std_logic_vector(7 downto 0);
begin

     -- state counter conditions
     Cond1 <= Pro_signal and not state_counter_out(0) AND not state_counter_out(1) AND not state_counter_out(2) AND not state_counter_out(3)  AND not state_counter_out(4);
     
     -- Intialize the RAM --
     ram_rd <= (Cond1 or Cond2 or Cond3 or Cond4) and not x_MFC;
     ram_wr <= write_row_tri_en;
     --X_ram:entity work.ram port map(clk, ram_wr, ram_rd, ram_address, data_in, data_out, x_MFC);
     -- Begining flag register
     begin_rst <= Cond1;
     begin_reg: entity work.n_dff generic map(1) port map( clk , layers_number_en , begin_en, begin_in, begin_out);	
     -- Intialize state counter --
     enable_state_counter <= Cond1 or (Cond2 and x_MFC) or Cond3_sub or (Cond5 and op_done) or (Cond3 and zero_flag_rows) or window_en or Cond4 or Cond7 or Cond6 or Cond6_sub or Cond2_sub;
	 state_counter_rst_1 <= Cond8 or Start_signal;
	 state_counter_rst_2 <= layers_covered_counter_en or Start_signal;
     state_counter:entity work.state_counter port map(clk ,enable_state_counter,state_counter_rst_1, state_counter_rst_2,state_counter_out);
     -- 1 bit first time counter
     first_time_en(0) <= first_time_temp or rows_covered_xor_out;
	 rst_first_time <= not rows_covered_xor_out and Cond8;
     first_time: entity work.n_dff generic map(1) port map( clk , rst_first_time , first_time_en(0), first_time_en, first_time_out);	
     -- Address of number of layers register
	 layers_number_address_tri_en <= Cond1 and not x_MFC;
     layers_number_address_tri: entity work.tri_state generic map(16) port map(layers_number_address_tri_en,"0000000000000000",ram_address);
     -- Numbers of layers register
     layers_number_en <= Cond1 and first_time_temp; -- ?? removed begin_in(0);
     layers_number: entity work.n_dff generic map(3) port map( clk , layers_number_rst , layers_number_en, data_out(2 downto 0), layers_number_out);	

--------------------------------------------------------------------------------------------------------------------------------------------   
   swap_en <= Cond1;
   force_img_ptr <= Cond1 or rst_current_img_ptr;
   img_ptr_swap: entity work.swap port map(swap_en, img_ptr,alt_img_ptr,current_img_ptr,img_ptr_value_force);
 
----------------------------------------------------------------------------------------------------------------------------------
-- Cond2
 Cond2 <= Pro_signal and state_counter_out(0) AND not state_counter_out(1) AND not state_counter_out(2) AND not state_counter_out(3)  AND not state_counter_out(4);   
 
 enable_filter_ptr_inc <= (Cond2 and x_MFC) or filter_en;
 filter_ptr:entity work.up_counter_top_filter generic map(16)port map(clk ,enable_filter_ptr_inc,Start_signal,'0',filter_ptr_out);
 filter_ptr_en <= Cond2 or (Cond2 and not x_MFC) or (Cond4 and conv_pool and not filter_loaded); --edited
 filter_ptr_tri: entity work.tri_state generic map(16) port map(filter_ptr_en,filter_ptr_out,ram_address);
          
 state1_en <= Cond2 and x_MFC;
		
layer_data_logic: entity work.load_layer_data port map(state1_en,data_out,filters_size,in_depth,out_depth,in_size,out_size,conv_pool,filters_number,biases);
	
rows_value_force <= "00000"&no_row_pass_out;
-----------------------------------------------------------------------------------------------------------------------------
-- Cond3
Cond2_sub <= Pro_signal and not state_counter_out(0) AND state_counter_out(1) AND not state_counter_out(2) AND not state_counter_out(3)  AND not state_counter_out(4); 

Cond3 <= Pro_signal and state_counter_out(0) AND state_counter_out(1) AND not state_counter_out(2) AND not state_counter_out(3)  AND not state_counter_out(4);   
Cond3_sub <= Pro_signal and not state_counter_out(0) AND not state_counter_out(1) AND state_counter_out(2) AND not state_counter_out(3)  AND not state_counter_out(4);

bias_select_logic: entity work.bias_logic port map(clk,filter_en,bias_rst,biases,bias);
-----------------------------------------------------------------------------------------------------------------

no_row_pass: entity work.mux_3to1 generic map(3) port map(first_time_out(0),get_new_rows, "000", filters_size,"001",no_row_pass_out);
send_row_ptr_en <= Cond3 and get_new_rows; --removed not x_MFC and not bias_done
get_new_row_tri: entity work.tri_state generic map(16) port map(send_row_ptr_en,img_ptr_out,ram_address);

img_ptr_counter:entity work.img_ptr_counter generic map(16)port map(clk ,enable_img_ptr_inc,img_ptr_rst,img_ptr_out,force_img_ptr, img_ptr_value_force);

enable_img_ptr_inc <= Cond3 and get_new_rows;
no_row_to_get_counter_en <= Cond3 and x_MFC and zero_flag_rows;

xor_salvation: entity work.xor_1bit_out_8bit port map(flag,rows_value_force,zero_flag_rows);


-- rows registers
Row0_reg : entity work.n_dff generic map(512) port map( clk , Cond1 , row0_en, data_out, row0);	
Row1_reg : entity work.n_dff generic map(512) port map( clk , Cond1 , row1_en, data_out, row1);
Row2_reg : entity work.n_dff generic map(512) port map( clk , Cond1 , row2_en, data_out, row2);
Row3_reg : entity work.n_dff generic map(512) port map( clk , Cond1 , row3_en, data_out, row3);
Row4_reg : entity work.n_dff generic map(512) port map( clk , Cond1 , row4_en, data_out, row4);


rows_loading_process: entity work.row_loading_process port map(Cond3,Cond8,x_MFC,zero_flag_rows,row0_en,row1_en,row2_en,row3_en,row4_en,row_counter_en,row_ptr,flag,first_time_temp, images_covered_xor_out, row_is_done,Cond2_sub);
--------------------------------------------------------------------------------------------------------------------------
-- sorted rows
row0_mux : entity work.mux5x1 generic map(512) port map(filters_size(1),row_ptr,row0,row1,row2,row3,row4,row0_sorted); 
row1_mux : entity work.mux5x1 generic map(512) port map(filters_size(1),row_ptr,row1,row2,row3,row4,row0,row1_sorted); 
row2_mux : entity work.mux5x1 generic map(512) port map(filters_size(1),row_ptr,row2,row3,row4,row0,row1,row2_sorted); 
row3_mux : entity work.mux5x1 generic map(512) port map(filters_size(1),row_ptr,row3,row4,row0,row1,row2,row3_sorted); 
row4_mux : entity work.mux5x1 generic map(512) port map(filters_size(1),row_ptr,row4,row0,row1,row2,row3,row4_sorted);

-- window selection

window_en <= Pro_signal and state_counter_out(0) AND not state_counter_out(1) AND state_counter_out(2) AND not state_counter_out(3)  AND not state_counter_out(4);
window0 : entity work.window_logic port map(clk, window_en, get_new_rows, row0_sorted,window_0, filters_size);
window1 : entity work.window_logic port map(clk, window_en, get_new_rows, row1_sorted,window_1, filters_size);
window2 : entity work.window_logic port map(clk, window_en, get_new_rows, row2_sorted,window_2, filters_size);
window_en_3_4 <= window_en and not filters_size(1);
window3 : entity work.window_logic port map(clk, window_en_3_4, get_new_rows, row3_sorted,window_3, filters_size);
window4 : entity work.window_logic port map(clk, window_en_3_4, get_new_rows, row4_sorted,window_4, filters_size);

----------------------------------------------------------------------------------------------------------------------------

get_new_rows <= columns_covered_xor_out or first_time_temp;

-- number of rows covered logic
rows_covered_xor_B <= "00000000000"&in_size;
rows_covered_counter_rst <= rows_covered_xor_out and Cond3 and row_is_done;
rows_covered_xor : entity work.xor_1bit_out generic map(16)port map(rows_covered_counter_out,rows_covered_xor_B,rows_covered_xor_out);
rows_covered_counter:entity work.up_counter_top_filter port map(clk ,row_counter_en ,rows_covered_counter_rst,Start_signal,rows_covered_counter_out);

-- number of columns covered
columns_covered_counter_rst <= columns_covered_xor_out and Cond3_sub;
columns_covered_counter:entity work.up_counter_top port map(clk ,window_en,columns_covered_counter_rst,Start_signal,columns_covered_counter_out);
columns_covered_xor : entity work.xor_1bit_out_8bit port map(columns_covered_counter_out,columns_covered_xor_B,columns_covered_xor_out);
columns_covered_xor_B <= "000"&out_size;

-- number of images covered logic
images_covered_counter_en <= rows_covered_xor_out and Cond8 and row_is_done;
images_covered_counter_rst <= images_covered_xor_out and Cond8 and row_is_done;
images_covered_counter:entity work.up_counter_top_filter port map(clk ,images_covered_counter_en,images_covered_counter_rst,Start_signal,images_covered_counter_out);
images_covered_xor_B <= "000000000"&in_depth;
images_covered_xor : entity work.xor_1bit_out port map(images_covered_counter_out,images_covered_xor_B,images_covered_xor_out);

-- number of layers covered logic
layers_covered_counter_en <= Cond2_sub and row_is_done and filters_covered_xor_out and images_covered_xor_out and rows_covered_xor_out;
layers_covered_counter:entity work.up_counter_top port map(clk ,layers_covered_counter_en,Start_signal,'0',layers_covered_counter_out);
layers_covered_xor : entity work.xor_1bit_out_8bit port map(layers_covered_counter_out,layers_covered_xor_B,layers_covered_xor_out);
layers_covered_xor_B <= "00000"&layers_number_out;
 
----------------------------------------------------------------------------------------------------------------------------
Cond4 <= Pro_signal and state_counter_out(0) AND not state_counter_out(1) AND state_counter_out(2) AND not state_counter_out(3)  AND not state_counter_out(4);   
filter_en<= Cond4 and conv_pool  and not filter_loaded and x_MFC;
   
-- filters done counter
filters_number_xor_B <= "000000000000"&filters_number;
reset_filters_covered_counter <= Cond8 and filters_covered_xor_out and row_is_done and images_covered_xor_out and rows_covered_xor_out;

filters_covered_counter:entity work.up_counter_top_filter_2 port map(clk ,filter_en,reset_filters_covered_counter,Start_signal,filters_counter_out,filters_number_xor_B);
filters_covered_xor : entity work.xor_1bit_out port map(filters_counter_out,filters_number_xor_B,filters_covered_xor_out);

--------------------------------------------------------------------------------------------------------------------------------------------
Cond5 <= Pro_signal and not state_counter_out(0) AND state_counter_out(1) AND state_counter_out(2) AND not state_counter_out(3)  AND not state_counter_out(4);


rst_current_img_ptr <= images_covered_xor_out and row_is_done and Cond2_sub; -- ??

five <= not filters_size(1);
operation_logic: entity work.CNN_Pyramid port map(clk,Cond5,conv_pool,five,filter(399 downto 0),window_0,window_1,window_2,window_3,window_4,bias,result);

wait_op_en <= Cond5;
--wait_op_rst <= Cond8 or Start_signal;
wait_operation: entity work.up_counter_top port map(clk,wait_op_en,Cond8,Start_signal,wait_op_out);
get_done_sig: entity work.xor_1bit_out_8bit port map(wait_op_out, "00010110",op_done);
--------------------------------------------------------------------------------------------------------------------------------------------
Cond6 <= Pro_signal and state_counter_out(0) AND state_counter_out(1) AND state_counter_out(2) AND not state_counter_out(3)  AND not state_counter_out(4);   

layers_number_out_sub <= "00000"&layers_number_out + "11111111";
its_time: entity work.xor_1bit_out_8bit port map(layers_number_out_sub, layers_covered_counter_out,last_cycle_flag);

new_row_rst <= row_is_done and Cond5;
new_row_logic: entity work.new_row_logic port map(clk,Cond6,new_row_rst,Start_signal,new_row,result,row_is_done,out_size,last_cycle_flag);

-------------------------------------------------------------------------------------------------
Cond6_sub <= Pro_signal and not state_counter_out(0) AND not state_counter_out(1) AND not state_counter_out(2) AND state_counter_out(3)  AND not state_counter_out(4);   

write_row_tri_en <= (row_is_done or last_cycle_flag) and Cond6_sub;
write_row_tri : entity work.tri_state generic map(16) port map(write_row_tri_en,new_current_img_ptr,ram_address);

-----------------------------------------------------------------------------------------------------------------------------------
Cond7 <= Pro_signal and state_counter_out(0) AND not state_counter_out(1) AND not state_counter_out(2) AND state_counter_out(3)  AND not state_counter_out(4);

---------------------------------------------------------------------------------------------------------------------------------------------
Cond8 <= Pro_signal and not state_counter_out(0) AND state_counter_out(1) AND not state_counter_out(2) AND state_counter_out(3)  AND not state_counter_out(4);


Weights_ptr <= current_img_ptr;

process(clk,Cond5,images_covered_xor_out, Cond3, row_is_done,filter_en,Start_signal)
	begin
		--if(Start_signal = '1') then Pro_signal <= '1'; end if;
		if(filter_en = '1') then 
			filter <= data_out;
		end if;
		
	
		if ((row_is_done = '1' or last_cycle_flag = '1') and Cond6_sub = '1') then
			data_in <= new_row;
		end if;
		
		
		
		if(clk'event and clk = '1') then 
			
			if(Cond2 = '1') then current_img_ptr <= img_ptr_value_force; end if;

			if(Start_signal = '1') then 
				Pro_signal <= '1';
				img_ptr <= "0000000000010000";
				alt_img_ptr <= "0000000000001000";
				current_img_ptr <= "0000000000010000";
				new_current_img_ptr <= "0000000000010000";
			end if;
			
			if(Cond8 ='1' and layers_covered_counter_en = '1') then
				if(current_img_ptr = "0000000000001000") then 
					new_current_img_ptr <= "0000000000001000";
				else
					new_current_img_ptr <= "0000000000010000";
				end if;
			end if;		
			
			if ((row_is_done = '1' or last_cycle_flag = '1') and Cond7 = '1') then
				new_current_img_ptr <= new_current_img_ptr + "0000000000000001";
				--new_row_rst <= '1';
			end if;
		end if;
		
		if(Cond5 = '1') then
			filter_loaded <= '1';
		end if; 
		--rst_current_img_ptr <= images_covered_xor_out and Cond8 and row_is_done;
		if(images_covered_xor_out = '1' and Cond3 = '1' and row_is_done = '1') then
			filter_loaded <= '0';
		end if;
end process;

Go_FC_Go <= Cond3 and row_is_done and filters_covered_xor_out and images_covered_xor_out and layers_covered_xor_out and rows_covered_xor_out;

end controlUnit;
