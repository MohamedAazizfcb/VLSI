library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity MUX2 is	
GENERIC (n : integer := 8);
Port (
A : in std_logic_vector(n-1 DOWNTO 0);
B : in std_logic_vector(n-1 DOWNTO 0);
S : in std_logic;
Z : out std_logic_vector(n-1 DOWNTO 0));
end MUX2;

architecture Behavioral of MUX2 is
begin	

process(A,B,S) 
begin
if (S = '0') then
	Z <= A;
else
	Z <= B;
end if;
end process;	

end Behavioral;
