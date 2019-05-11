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
Signal DataFromRam, DataToRam : std_logic_vector (511 DOWNTO 0); -- added
Signal ProcessEnable : std_logic;



--------------CNN Signals----------
signal CNN_init 	: std_logic;   -- signal from IO to initiate CNN
signal MFC		: std_logic    --temp


---------- FC Signals -------------
signal FC_init 			: std_logic;   -- signal from CNN to initiate FC
signal neuron_address	: std_logic_vector(15 downto 0); -- address of first neuron in ram from CNN to FC
signal clk_inv			: std_logic;
----------------------------------
begin	
r0:IOCHIP Port Map (OuterRead,OuterWrite,ActivateOuterAddress,INCEnable,PDone,OuterAddress,ResultIn,
			CLK,LP,INTR,CNNIMGLOAD,Rst,PClk,
			DataFromRam,Result,Done,ProcessEnable);

clk_inv <= not(CLK);
FC: entity work.FC_controller port map(
				clk_inv,
				Rst,
				FC_init,
				OuterRead,
				OuterAddress,
				DataFromRam,
				Result,
				PDone,
				neuron_address
			);
	
	
CNN: entity work.control_unit port map(
				CLK,
				MFC, --added
				DataFromRam,
				DataToRam, -- added
				OuterAddress,
				OuterWrite,
				OuterRead,
				neuron_address,
				CNN_init,
				FC_init
			);

end arch;
