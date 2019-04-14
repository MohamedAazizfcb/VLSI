library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity CPU is	
Port (
Done : in std_logic;
result : in std_logic_vector(3 Downto 0);
readen : in std_logic; -- read enable signal	
dataout : out std_logic_vector(15 downto 0);
CLK,LP,INTR,CNNIMAGE,Reset :out std_logic);
end CPU;
architecture Behavioral of CPU is	
------------------------------------- RAM declaration 
type rama is array(255 downto 0) of std_logic_vector(15 downto 0);	
signal ram1_1 : rama;	
-------------------------------------- Signal declaration 
Signal CPUCLK,LOADPROCESS,INTERRUPT,CNNIMAGELOAD,rst :std_logic;
Signal ResetCPU : std_logic;--resets the address of reading of the cpu and the chip
Signal Address : std_logic_vector(7 downto 0) := "00000000";
begin	

process(CPUClk, readen , Address) 
begin
if CPUClk'event and CPUClk = '1' and ResetCPU = '0' then	
if readen = '1' then -- In this process reading the output data from cpu 
dataout <= ram1_1(conv_integer(Address)); -- Reading the data from CPU
Address <= Address + 1;
else dataout<=(Others => 'Z');
end if;
elsif resetCPU = '1' then
Address <= "00000000";
end if;	
end process;	

CLK <= CPUCLK;
LP <= LOADPROCESS;	
INTR <= INTERRUPT;
CNNIMAGE <= CNNIMAGELOAD;
reset <= rst or ResetCPU;

end Behavioral;