library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux5x1 is
generic(n : integer := 16);
    Port ( 
	   five_three : in std_logic;
	   SEL : in  STD_LOGIC_vector(2 downto 0);
           A   : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B   : in  STD_LOGIC_VECTOR (n-1 downto 0);
           C   : in  STD_LOGIC_VECTOR (n-1 downto 0);
           D   : in  STD_LOGIC_VECTOR (n-1 downto 0);
           E   : in  STD_LOGIC_VECTOR (n-1 downto 0);
	   X   : out STD_LOGIC_VECTOR (n-1 downto 0));
end mux5x1;

architecture Behavioral of mux5x1 is
begin
    
X <= A when (SEL = "000" and five_three = '0')
else B when (SEL = "001" and five_three = '0') 
else C when (SEL = "010" and five_three = '0')
else D when (SEL = "011" and five_three = '0')
else E when (SEL = "100" and five_three = '0')
else D when (SEL = "001" and five_three = '1')
else E when (SEL = "010" and five_three = '1')
else A when (SEL = "011" and five_three = '1')
else B when (SEL = "100" and five_three = '1')
else C when (SEL = "000" and five_three = '1');

end Behavioral;
