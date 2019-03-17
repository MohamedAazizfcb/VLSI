LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY FULLADDER IS
GENERIC (n : integer := 8);
PORT(A,B : IN std_logic_vector(n-1  DOWNTO 0);
Cin,en : IN std_logic;  
S : OUT std_logic_vector(n-1 DOWNTO 0);           
Cout : OUT std_logic);
END Entity FULLADDER;

ARCHITECTURE struct_nadder OF FULLADDER IS
COMPONENT BitAdder IS  
	Port(A,B,Cin,en:in std_logic;
	S,Cout:out std_logic
	);
END COMPONENT;

SIGNAL temp : std_logic_vector(n DOWNTO 0);

BEGIN
f0: BitAdder PORT MAP(A(0),B(0),Cin,en,S(0),temp(0));
  loop1: FOR i IN 1 TO n-1 GENERATE
          fx: BitAdder  PORT MAP  (A(i),B(i),temp(i-1),en,S(i),temp(i));
    END GENERATE;
    Cout <= temp(n-1);
END ARCHITECTURE;
