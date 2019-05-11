library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity state_counter is
generic ( n : integer := 8);
    Port ( CLK : in  STD_LOGIC;     -- input clock
           enable: in std_logic := '0';-- zero : out std_logic;
	   Cond8,reset : in  STD_LOGIC := '0';	-- LEDs to display count
           LED : out  STD_LOGIC_VECTOR (n-1 downto 0));
	   
end state_counter;

architecture Behavioral of state_counter is
    signal count   : STD_LOGIC_VECTOR (n-1 downto 0) := "00000000";
begin
    process (CLK)
    begin 

	if (CLK'Event and CLK = '1') then
		if(enable = '1') then
                	count <= count + '1';   -- counting up
		end if;
		
        	if (Cond8 = '1') then
        	        if(reset = '1') then
				count<= "00000000";
			else
				count<= "00000010";
			end if;

        	end if;
	end if;

    end process;
    LED <= count;
end Behavioral;
