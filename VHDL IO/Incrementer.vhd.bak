library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity Incrementer is	
generic(N : integer := 4);
Port (data : inout std_logic_vector(N-1 DOWNTO 0);
enable: in std_logic);
end Incrementer;

architecture Behavioral of Incrementer is

Signal S:std_logic;
begin	

process(enable) 
begin
if enable = '1' then
std_logic_vector(to_unsigned(((to_integer(unsigned(data))) + 1),4))
end if
end process;	

end Behavioral;