library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity RamControl is	
Port ( 
DataIN : in std_logic_vector(511 DOWNTO 0);
Address : in std_logic_vector(15 Downto 0);
readenable : in std_logic;
writeenable : in std_logic;
CLK : in std_logic;
DataOut : out std_logic_vector (511 DOWNTO 0);
MFC : out std_logic);
end RamControl;

architecture arch of RamControl is
Component ram is	
Port ( Clk : in std_logic; -- processing clock	
write_en : in std_logic; -- write enable signal	 
read_en : in std_logic; -- read enable signal	
write_address : in std_logic_vector(15 downto 0); -- address to store the data into ram 
read_address:in std_logic_vector(15 downto 0);-- address to read the data from ram
data_in : in std_logic_vector(511 downto 0); -- input data to store into ram
data_out : out std_logic_vector(511 downto 0);
MFC : out std_logic); -- output data from memory	
end Component;
begin
r1: ram PORT MAP (CLK,writeenable,Readenable,ADDRESS,ADDRESS,DataIN,DataOut,MFC);
end arch;
