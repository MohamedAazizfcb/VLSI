library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
entity DownCounter is
  port (enable : in std_logic;
	d : in std_logic_vector(7 downto 0);
	clk,reset : in std_logic;
        q : out std_logic_vector(7 downto 0));
end;

architecture a_DownCounter of DownCounter is
signal tmp : std_logic_vector(7 downto 0);
begin
     process (enable,d,clk,reset) 
     begin
	if enable = '1' then
		if  rising_edge(clk) then
	   		if reset = '1' then
              			tmp <= d;     
           		else
              			tmp <= tmp - 1;
           		end if;
		end if;
	end if;
     end process;
     q <= tmp;	
end a_DownCounter;