library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Reg16 is
  port (enable : in std_logic := '0';
	d : in std_logic_vector(15 downto 0);
	clr,LD : in std_logic := '0';
        q : inout std_logic_vector(15 downto 0));
end;

architecture behav of Reg16 is
begin
     process (enable,d,clr,LD) 
     begin
	if enable = '1' then
		if clr = '1' then
        	    q <= "0000000000000000";
        	elsif LD = '1' then
        	    q <= d;
		end if;
	elsif clr = '1' then
        	q <= "0000000000000000";
	end if;
     end process;
end behav;