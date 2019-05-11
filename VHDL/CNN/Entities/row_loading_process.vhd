library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

entity row_loading_process is
    Port ( 
		   Cond3,Cond8,x_MFC,zero_flag_rows : in  STD_LOGIC;
           row0_en,row1_en,row2_en,row3_en,row4_en,row_counter_en : out std_logic;
		   row_ptr : out std_logic_vector(2 downto 0) := "000";
		   flag : out std_logic_vector(7 downto 0) := "00000000";
		   first_time_temp : out std_logic := '1';
		   images_covered_xor_out, row_is_done,Cond2_sub: in std_logic);
end row_loading_process;

architecture a_row_loading_process of row_loading_process is

signal flago: std_logic_vector(7 downto 0):= "00000000";
signal row_ptro : std_logic_vector(2 downto 0) := "000";
begin

	process(Cond3,x_MFC,row_ptro,zero_flag_rows,Cond8)

		begin
			if(x_MFC'Event and x_MFC = '1') then
				if(Cond3 = '1'  and not zero_flag_rows = '1') then
					if(row_ptro = "000") then
						row0_en <= '1';
						row1_en <= '0';
						row2_en <= '0';
						row3_en <= '0';
						row4_en <= '0';
						row_counter_en <= '1';
						row_ptro <= "001";
						flago <= flago + "00000001";
					elsif(row_ptro = "001") then
						row0_en <= '0';
						row1_en <= '1';
						row2_en <= '0';
						row3_en <= '0';
						row4_en <= '0';
						row_counter_en <= '1';
						row_ptro <= "010";
						flago <= flago + "00000001";
					elsif(row_ptro = "010") then
						row0_en <= '0';
						row1_en <= '0';
						row2_en <= '1';
						row3_en <= '0';
						row4_en <= '0';
						row_counter_en <= '1';
						row_ptro <= "011";
						flago <= flago + "00000001";
					elsif(row_ptro = "011") then
						row0_en <= '0';
						row1_en <= '0';
						row2_en <= '0';
						row3_en <= '1';
						row4_en <= '0';
						row_counter_en <= '1';
						row_ptro <= "100";
						flago <= flago + "00000001";
					elsif(row_ptro = "100") then
						row0_en <= '0';
						row1_en <= '0';
						row2_en <= '0';
						row3_en <= '0';
						row4_en <= '1';
						row_counter_en <= '1';
						row_ptro <= "000";
						flago <= flago + "00000001";
					end if; 
				end if;
	
			end if;
			if (Cond3 = '0') then
				row0_en <= '0';
				row1_en <= '0';
				row2_en <= '0';
				row3_en <= '0';
				row4_en <= '0';
				row_counter_en <= '0';
			end if;

			if(Cond8 = '1') then 
				flago <= "00000000";
				first_time_temp <= '0';
			end if; 	
			if(images_covered_xor_out = '1' and Cond2_sub = '1' and row_is_done = '1') then 
				row_ptro <= "000";
 		  	end if;
	end process; 
		
	flag <= flago;
	row_ptr <= row_ptro;
end a_row_loading_process;
