library ieee;
use ieee.std_logic_1164.all;

entity compare_add_sub is
	Generic (n:integer :=17);
        port(P,A,S: in std_logic_vector(n-1 downto 0);
             Output: out std_logic_vector(n-1 downto 0));
    end compare_add_sub ;

architecture my_compare_add_sub  of compare_add_sub is
signal second_operand  :  std_logic_vector (n-1 downto 0);
signal unused_cout : std_logic;
signal O : std_logic_vector(n-1 downto 0);
begin 
second_operand<= a when (p(1)='0' and p(0)='1')
else s when (p(1)='1' and p(0)='0')
else (second_operand'length-1 downto 0 =>'0');
add_n:  entity work.nadder GENERIC MAP (n) port map (P ,second_operand,'0',O,unused_cout);  
Output(n-1 downto 0) <= O(n-1)&O(n-1 downto 1);                    
end my_compare_add_sub;