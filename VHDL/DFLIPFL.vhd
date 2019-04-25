library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

entity DFLIPFL is
PORT( D,CLOCK: in std_logic;
Q: out std_logic);
end DFLIPFL;

architecture behavioral of DFLIPFL is
begin
process(CLOCK)
begin
if(rising_edge(CLOCK)) then
Q <= D;
end if;
end process;
end behavioral;
