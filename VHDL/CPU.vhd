library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity CPU is	
Port (
Done,reset,clk : in std_logic;
result : in std_logic_vector(3 Downto 0);
readen : in std_logic; -- read enable signal	
dataout : out std_logic_vector(15 downto 0)
);
end CPU;
architecture Behavioral of CPU is	
------------------------------------- RAM declaration 
type ramcpu is array(32767 downto 0) of std_logic_vector(15 downto 0);	
signal ramcpu_1 : ramcpu;	
---------------------------------------------------------------------
---------------------------------------------------------------------
--Component : 
Component FULLADDER IS
GENERIC (n : integer := 8);
PORT(A,B : IN std_logic_vector(n-1  DOWNTO 0);
Cin,en : IN std_logic;  
S : OUT std_logic_vector(n-1 DOWNTO 0);           
Cout : OUT std_logic);
END  Component;
-------------------------------------- Signal declaration :
Signal Dummy : std_logic;
Signal Address : std_logic_vector(15 downto 0);
Signal nextAddress : std_logic_vector(15 downto 0);
begin	
i0: FULLADDER Generic Map(16) Port Map (Address,"0000000000000001",'0','1',nextAddress,dummy);
process(CLK, readen , Address) 
begin
	if rising_edge(readen) then
		if( reset = '0') then -- In this process reading the output data from cpu 
			dataout <= ramcpu_1(conv_integer(Address)); -- Reading the data from CPU
			Address <= NextAddress;
		else
			dataout<="ZZZZZZZZZZZZZZZZ";
			Address <= "0000000000000000";
		end if;
	elsif (reset = '1') then
		dataout<="ZZZZZZZZZZZZZZZZ";
		Address <= "0000000000000000";
	else
		dummy <= dummy;
	end if;
end process;	
end Behavioral;