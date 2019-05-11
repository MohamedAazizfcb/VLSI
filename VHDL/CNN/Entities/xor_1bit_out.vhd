library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_1bit_out is
generic(n : integer := 16);
    Port ( 
           A   : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B   : in  STD_LOGIC_VECTOR (n-1 downto 0);
           F   : out STD_LOGIC);
end xor_1bit_out;

architecture Behavioral of xor_1bit_out is
signal temp: std_logic_vector(n-1 downto 0);
begin
    temp <= A xor B;
    F <= '1' when (temp = X"0000") else '0';
end Behavioral;
