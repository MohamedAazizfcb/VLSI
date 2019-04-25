library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity loadenablecircuit is	
Port (loadprocess : in std_logic; 
LDone : in std_logic;
INTR : in std_logic; -- pulse
reset :in std_logic;
loadenable : out std_logic);
end loadenablecircuit;

architecture Behavioral of loadenablecircuit is
component DFLIPFL is
PORT( D,CLOCK: in std_logic;
Q: out std_logic);
end component;

Signal C,D:std_logic;
begin	

process(loadprocess,LDone,INTR,reset) 
begin
D <= ((not loadprocess) and ((not LDone) or INTR) and (not reset));
C <= (((INTR OR LDone) and (not reset)) OR reset);
end process;	
L:DFLIPFL PORT MAP (D,C,loadenable);

end Behavioral;
