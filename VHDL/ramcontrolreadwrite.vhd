library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity ramenablereadwrite is	
Port (loadenable : in std_logic; 
DecompressionDone : in std_logic;
ProcessEnable : in std_logic;
OuterWrite : in std_logic;
OuterRead : in std_logic;
readenable : out std_logic;
writeenable : out std_logic);
end ramenablereadwrite;

architecture Behavioral of ramenablereadwrite is
begin	

process(loadenable,ProcessEnable,OuterRead,DecompressionDone,OuterWrite)
begin
readenable <= (ProcessEnable and OuterRead);
writeenable <= ((DecompressionDone) or (ProcessEnable and OuterWrite));
end process;	

end Behavioral;