library ieee;
use ieee.std_logic_1164.all;

entity shift_reg_adder is
	Generic (n:integer :=17);
        port(set: in std_logic;
             clk : in std_logic;

output : out std_logic_vector (n-1 downto 0));
    end shift_reg_adder ;

architecture my_shift_reg_adder of shift_reg_adder is

signal  count : std_logic_vector (n-1 downto 0);



begin 



process(clk,set)
begin

if set = '0' then 
count <= (n-1 downto 1 =>'0')&'1';


elsif clk'event and clk = '1'then 
	if count(n-1) = '0' then
		count(n-1 downto 0) <= count(n-2 downto 0) &'0'; 
	end if;           

end if;
end process;
output<=count;
end my_shift_reg_adder;