library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity up_counter_top is
generic ( n : integer := 8);
    Port ( CLK : in  STD_LOGIC;     -- input clock
           enable: in std_logic := '0';-- zero : out std_logic;
	   reset,flag : in  STD_LOGIC := '0';	-- LEDs to display count
           LED : out  STD_LOGIC_VECTOR (n-1 downto 0));    -- direction of counter (up or down)
	   
end up_counter_top;

architecture Behavioral of up_counter_top is
    signal count   : STD_LOGIC_VECTOR (n-1 downto 0) := "00000000";
    --signal dummy: std_logic:= '0';
begin
    --count<= ;
    process (CLK)
    begin 

	if (CLK'Event and CLK = '1') then
		if(enable = '1') then
			--count <= LED;
                	count <= count + '1';   -- counting up
			--dummy <= '0';
		end if;
	end if;
        if (reset = '1' or flag = '1') then
                count<= "00000000";
		--reset <= '0';
        end if;

    end process;
    LED <= count;
    --enable <= dummy;
end Behavioral;
