library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity regster is
generic(N : integer := 8);
port( 
writ : in STD_LOGIC;
datain : in STD_LOGIC_VECTOR(N-1  downto 0);
clk : in STD_LOGIC;
reset : in STD_LOGIC;
typ : in STD_LOGIC_vector(1 DOWNTO 0); 
--if 00 then it is General 
--if 01 the start of image
--if 10 the start of CNN
dataout :out STD_LOGIC_VECTOR(N-1  downto 0));
end regster;

architecture behav of regster is 
begin
process(clk, reset,typ)
begin
if typ = "01" then
dataout <= (others=> '0'); --image address
elsif typ = "10" then
dataout <= (others=>'0'); -- CNN address
else
	if reset = '1' then
	dataout <= (others=> '0');
	elsif rising_edge(clk) then
		if writ= '1' then
		dataout<= datain;
		end if;
	end if;
end if;
end process;
end behav;
