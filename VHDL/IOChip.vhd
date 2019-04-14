library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 



entity IOCHIP is	
Port ( 
--INPUTS:
OuterRead : in std_logic;
OuterWrite : in std_logic;
ActivateOuterAddress : in std_logic;
INCEnable : in std_logic;
PDone : in std_logic;
OuterAddress : in std_logic_vector(15 DOWNTO 0);
ResulIn :in std_logic_vector (3 Downto 0);

--OUTPUTS:
PClk : out std_logic;
DataFromRam : out std_logic_vector (255 DOWNTO 0);
ProcessEnable : out std_logic);

end IOCHIP;



architecture arch of IOCHIP is
---------------------------------------------------------------------------------Components
Component CPU is	
Port (
Done : in std_logic;
result : in std_logic_vector(3 Downto 0);
readen : in std_logic; -- read enable signal	
dataout : out std_logic_vector(15 downto 0);
CLK,LP,INTR,CNNIMAGE,Reset :out std_logic);
end Component;


Component processenablecircuit is	
Port (loadprocess : in std_logic; 
PDone : in std_logic;
INTR : in std_logic; -- pulse
reset :in std_logic;
processenable : out std_logic);
end Component;
---------------------------------------------
Component loadenablecircuit is	
Port (loadprocess : in std_logic; 
LDone : in std_logic;
INTR : in std_logic; -- pulse
reset :in std_logic;
loadenable : out std_logic);
end Component;
---------------------------------------------
Component LDONEcircuit is	
Port (
DataBus : in std_logic_vector(15 DOWNTO 0);
LoadEnable : in std_logic;
LDONE : out std_logic);
end Component;
---------------------------------------------
Component ramenablereadwrite is	
Port (loadenable : in std_logic; 
DecompressionDone : in std_logic;
ProcessEnable : in std_logic;
OuterWrite : in std_logic;
OuterRead : in std_logic;
readenable : out std_logic;
writeenable : out std_logic);
end Component;
---------------------------------------------
Component RamControl is	
Port ( 
DataIN : in std_logic_vector(255 DOWNTO 0);
Address : in std_logic_vector(15 Downto 0);
readenable : in std_logic;
writeenable : in std_logic;
CLK : in std_logic;
DataOut : out std_logic_vector (255 DOWNTO 0));
end Component;
----------------------------------------------
Component ADDRESSGENERATOR is	
Port ( 
Reset,CLK : in std_logic;
LoadEnable : in std_logic;
DecompressionDone : in std_logic;
ProcessEnable : in std_logic;
IncEnable : in std_logic;
OuterAddress : in std_logic_vector (15 DOWNTO 0);
ActivateOuterAddress : in std_logic;
Address : out std_logic_vector (15 DOWNTO 0));
end Component;
------------------------------------------------------------------------------------------------------Signals
Signal LDone,loadenable,DecompressionDone,ProcEn,readenable,writeenable : std_logic;
Signal Address : std_logic_vector (15 DOWNTO 0);
Signal CLK,LP,INTR,CNNIMGLOAD,Reset,Done:std_logic;
Signal DataBus : std_logic_vector(15 DOWNTO 0);
Signal EnableReadingFromCPU: std_logic;
Signal Result :std_logic_vector(3 Downto 0);
Signal DecompressedData : std_logic_vector(255 Downto 0);
------------------------------------------------------------------------------------------------------Logic
begin
Done <= LDone or PDone;
i:CPU Port Map (Done,Result,EnableReadingFromCPU,DataBus,CLK,LP,INTR,CNNIMGLOAD,Reset);
i0:processenablecircuit Port Map (LP,PDone,INTR,reset,procEn);
ProcessEnable <= ProcEn;
i1:loadenablecircuit Port Map (LP,LDone,INTR,reset,loadenable);
i2:LDONEcircuit Port Map (DataBus,LoadEnable,LDONE);
i3:ramenablereadwrite Port Map (loadenable,DecompressionDone,ProcEn,OuterWrite,OuterRead,readenable,writeenable);
i4:RamControl Port Map (DecompressedData,Address,readenable,writeenable,CLK,DataFromRam);
i5:ADDRESSGENERATOR Port Map (Reset,CLK,LoadEnable,DecompressionDone,ProcEn,IncEnable,OuterAddress,ActivateOuterAddress,Address);



end arch;