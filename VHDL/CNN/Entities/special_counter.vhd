library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity up_counter_top_filter_special is
generic ( n : integer := 16);
    Port ( CLK,enable,reset,flag : in  STD_LOGIC;     -- input clock
          -- zero : out std_logic;
		-- LEDs to display count
           LED : out  STD_LOGIC_VECTOR (n-1 downto 0));    -- direction of counter (up or down)
end up_counter_top_filter_special;

architecture a_up_counter_top_filter_special of up_counter_top_filter_special is
    signal count   : STD_LOGIC_VECTOR (n-1 downto 0) := "0000000000000001";
begin
    --count<= ;
    process (CLK)
    begin 

	if (CLK'Event and CLK = '1') then
		if(enable = '1') then
                	count <= count + '1';   -- counting up
		end if;
	end if;
        if (reset = '1' or flag = '1') then
                count<= "0000000000000001";
        end if;

    end process;
    LED <= count;
end a_up_counter_top_filter_special;