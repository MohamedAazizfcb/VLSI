library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity ram is	
Port ( Clk : in std_logic; -- processing clock	
write_en : in std_logic; -- write enable signal	 
read_en : in std_logic; -- read enable signal	
write_address : in std_logic_vector(15 downto 0); -- address to store the data into ram 
read_address:in std_logic_vector(15 downto 0);-- address to read the data from ram
data_in : in std_logic_vector(255 downto 0); -- input data to store into ram
data_out : out std_logic_vector(255 downto 0)); -- output data from memory	
end ram;

architecture Behavioral of ram is	
------------------------------------- RAM declaration 
type rama is array(32767 downto 0) of std_logic_vector(255 downto 0);	
signal ram1_1 : rama;	
-------------------------------------- Signal declaration 
signal dummy :std_logic;

begin	

process(Clk, write_en) 
begin
if rising_edge(write_en) then	-- In this process writing the input data into ram 
ram1_1(conv_integer(write_address)) <= data_in;
else
dummy <= '0';
end if;	
end process;	


process(Clk, read_en) 
begin
if rising_edge(clk) then	
if read_en = '1' then -- In this process reading the output data from ram 
data_out <= ram1_1(conv_integer(read_address)); -- Reading the data from RAM
else data_out<=(Others => 'Z');
end if;	
end if;	
end process;	


end Behavioral;