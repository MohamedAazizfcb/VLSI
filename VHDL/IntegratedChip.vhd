library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity IntegratedChip is	
Port (
--Inputs:
CLK,LP,INTR,CNNIMGLOAD,Rst : in std_logic;
--outputs
Result : out std_logic_vector(3 Downto 0);
Done: out std_logic


);
end IntegratedChip;

architecture arch of IntegratedChip is
Component IOCHIP is	
Port ( 
--INPUTS:
OuterRead : in std_logic;
OuterWrite : in std_logic;
ActivateOuterAddress : in std_logic;
INCEnable : in std_logic;
PDone : in std_logic;
OuterAddress : in std_logic_vector(15 DOWNTO 0);
ResultIn :in std_logic_vector (3 Downto 0);
CLK,LP,INTR,CNNIMGLOAD,Rst : in std_logic;





-----------------------------------------------
--OUTPUTS:
PClk : out std_logic;
DataFromRam : out std_logic_vector (255 DOWNTO 0);
Result : out std_logic_vector(3 Downto 0);
Done: out std_logic;
ProcessEnable : out std_logic);

end component;
--Signals---------------------------------------------------------------------------------
Signal OuterRead :  std_logic;
Signal OuterWrite :  std_logic;
Signal ActivateOuterAddress :  std_logic;
Signal INCEnable : std_logic;
Signal PDone : std_logic;
Signal OuterAddress : std_logic_vector(15 DOWNTO 0);
Signal ResultIn : std_logic_vector (3 Downto 0);
Signal PClk : std_logic;
Signal DataFromRam : std_logic_vector (255 DOWNTO 0);
Signal ProcessEnable : std_logic;
begin	
r0:IOCHIP Port Map (OuterRead,OuterWrite,ActivateOuterAddress,INCEnable,PDone,OuterAddress,ResultIn,
			CLK,LP,INTR,CNNIMGLOAD,Rst,PClk,
			DataFromRam,Result,Done,ProcessEnable);

end arch;
