library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_3to1 is
generic(n : integer := 16);
    Port ( SEL1,SEL2 : in  STD_LOGIC;
           A,B,C   : in  STD_LOGIC_VECTOR (n-1 downto 0);
           X   : out STD_LOGIC_VECTOR (n-1 downto 0));
end mux_3to1;

architecture Behavioral of mux_3to1 is
begin
    X <= A when (SEL2 = '0' and (SEL1 = '1' or SEL1 = '0')) 
    else B when (SEL2 = '1' and SEL1 = '1')
    else C;
end Behavioral;
