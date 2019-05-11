library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity Reg8 is
  port (enable : in std_logic := '0';
	d : in std_logic_vector(7 downto 0);
	clr,LD : in std_logic := '0';
        q : inout std_logic_vector(7 downto 0));
end;

architecture a_Reg8 of Reg8 is
begin
     process (enable,d,clr,LD) 
     begin
	if enable = '1' then
		if clr = '1' then
        	    q <= "00000000";
        	elsif LD = '1' then
        	    q <= d;
        	end if;
	elsif clr = '1' then
		q <= "00000000";
	end if;
     end process;
end a_Reg8;