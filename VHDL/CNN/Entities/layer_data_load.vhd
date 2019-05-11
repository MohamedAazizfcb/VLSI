library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

entity load_layer_data is
    Port ( state1_en : in std_logic;
		   data_out : in std_logic_vector(511 downto 0);
		   filters_size : out std_logic_vector(2 downto 0) := "000";
		   in_depth,out_depth : out std_logic_vector(6 downto 0) := "0000000";
		   in_size,out_size : out std_logic_vector(4 downto 0) := "00000";
		   conv_pool : out std_logic := '0';
		   filters_number : out std_logic_vector(3 downto 0) := "0000";
		   biases : out std_logic_vector(399 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
end load_layer_data;

architecture a_load_layer_data of load_layer_data is

begin

	process(state1_en)
	   begin
			if (state1_en = '1') then
				filters_size <= data_out(2 downto 0);
				in_depth <= data_out(9 downto 3);
				out_depth <= data_out(16 downto 10);
				in_size <= data_out(21 downto 17);
				out_size <= data_out(26 downto 22);
				conv_pool <= data_out(27);
				filters_number <= data_out(31 downto 28);
				biases <= data_out(455 downto 56);
			end if;

		end process;
    
	
	
	
end a_load_layer_data;
