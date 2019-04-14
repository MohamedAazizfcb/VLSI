library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity LDONEcircuit is	
Port (
DataBus : in std_logic_vector(15 DOWNTO 0);
LoadEnable : in std_logic;
LDONE : out std_logic);
end LDONEcircuit;

architecture Behavioral of LDONEcircuit is
begin	

process(LoadEnable, DataBus) 
begin
if (LoadEnable = '1' and DataBus = "0000000000000000") then
	LDone <= '1';
else
	LDone <= '0';
end if;
end process;	

end Behavioral;