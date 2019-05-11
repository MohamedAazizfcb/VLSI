LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mux2 IS 
	PORT ( a,b : IN std_logic_vector (7 DOWNTO 0);
			s : IN  std_logic;
			x : OUT std_logic_vector (7 DOWNTO 0));
END entity mux2;

ARCHITECTURE a_mux OF mux2 IS
BEGIN
x <= a when (s = '0') else b;
END architecture a_mux ;
