library ieee;
use ieee.std_logic_1164.all;

entity shift_reg is
	Generic (n:integer :=17);
        port(set: in std_logic;
             clk : in std_logic;
	     rst : in std_logic;
output : out std_logic_vector (n-1 downto 0));
    end shift_reg ;

architecture my_shift_reg of shift_reg is

signal  count : std_logic_vector (n-1 downto 0);
signal en : std_logic;
signal o :  std_logic_vector (n-1 downto 0);

begin 

 Reg:entity work.my_nDFF  generic map (n) port map ( clk , rst ,count, o,en);   

process(clk,set)
begin

if set = '0' then 
count <= (n-1 downto 1 =>'0')&'1';
en <= '1';

elsif clk'event and clk = '1'then 
	if o(n-1) = '0' then
		count(n-1 downto 0) <= o(n-2 downto 0) &'0';
 		en <= '1'; 
	end if;           

end if;
end process;
output<=o;
end my_shift_reg;
