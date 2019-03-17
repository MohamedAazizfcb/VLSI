library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity ramenablereadwrite is	
Port (loadenable : in std_logic; 
reset : in std_logic;
readenable : out std_logic;
writeenable : out std_logic);
end ramenablereadwrite;

architecture Behavioral of ramenablereadwrite is
begin	

process(loadenable,reset) 
begin
readenable <= (not loadenable) and (not reset);
writeenable <= loadenable and (not reset);
end process;	

end Behavioral;