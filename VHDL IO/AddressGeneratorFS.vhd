library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity AddressGeneratorFS is	
Port ( loadenable : in std_logic;
INTR : in std_logic; -- A PULSE	 
CNNLoad : in std_logic;
IMGLoad : in std_logic;
CNNAddress : out std_logic;
IMGAddress : out std_logic);
end AddressGeneratorFS;

architecture Behavioral of AddressGeneratorFS is
Signal S:std_logic;
begin	

process(S, loadenable,INTR,CNNLoad,IMGLoad) 
begin
S <= loadenable and INTR;
CNNAddress <= S and CNNLoad;
IMGAddress <= S and IMGLoad;
end process;	

end Behavioral;