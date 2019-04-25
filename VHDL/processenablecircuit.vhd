
library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity processenablecircuit is	
Port (loadprocess : in std_logic; 
PDone : in std_logic;
INTR : in std_logic; -- pulse
reset :in std_logic;
processenable : out std_logic);
end processenablecircuit;

architecture Behavioral of processenablecircuit is
component DFLIPFL is
PORT( D,CLOCK: in std_logic;
Q: out std_logic);
end component;

Signal C,D:std_logic;
begin	

process(loadprocess,PDone,INTR,reset) 
begin
D <= (loadprocess and ((not PDone) or INTR) and (not reset));
C <= (((INTR OR PDone) and (not reset)) OR reset);
end process;	
L:DFLIPFL PORT MAP (D,C,processenable);

end Behavioral;