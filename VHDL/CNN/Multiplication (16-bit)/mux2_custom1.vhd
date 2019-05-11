LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mux2_c1 IS 
	PORT ( 	a1,nall : IN std_logic_vector (15 DOWNTO 0);
			b : IN std_logic_vector (31 DOWNTO 0);
			s : IN  std_logic;
			x : OUT std_logic_vector (31 DOWNTO 0));
END entity mux2_c1;

ARCHITECTURE a_mux_c1 OF mux2_c1 IS
signal a : std_logic_vector(31 downto 0);
BEGIN
a <= nall & a1;
x <= a when (s = '0') else b;
END architecture a_mux_c1 ;
