library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity MYMUX is	
GENERIC (n : integer := 8);
Port (
A : in std_logic_vector(n-1 DOWNTO 0);
B : in std_logic_vector(n-1 DOWNTO 0);
S : in std_logic;
Z : out std_logic_vector(n-1 DOWNTO 0));
end MYMUX;

architecture Behavioral of MYMUX is
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
