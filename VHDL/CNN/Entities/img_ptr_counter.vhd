
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity img_ptr_counter is
generic ( n : integer := 16);
    Port ( CLK,enable,reset : in  STD_LOGIC;     -- input clock
           LED : out  STD_LOGIC_VECTOR (n-1 downto 0);
	   Force: in std_logic;
	   value_force: in std_logic_vector(n-1 downto 0));
end img_ptr_counter;

architecture Behavioral of img_ptr_counter is
    signal count   : STD_LOGIC_VECTOR (n-1 downto 0) := "0000000000000000";
begin
    --count<= ;
    process (CLK)
    begin 

	if (CLK'Event and CLK = '1') then
		if(enable = '1') then	
                	count <= count + '1';   -- counting up
		end if;
	end if;
        if (reset = '1') then
                count<= "0000000000000000";
         end if;
	if(Force = '1') then
		count <= value_force;
	end if;

    end process;
    LED <= count;
end Behavioral;
