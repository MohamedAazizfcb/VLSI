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
ResultIn :in std_logic_vector (3 Downto 0);
CLK,LP,INTR,CNNIMGLOAD,Reset : in std_logic;


-----------------------------------------------
EnableReadingFromCPU,DecompressionDone,DecompressionDone1,DecompressionDone2,readenable : inout std_logic;
DataBus : inout std_logic_vector (15 DOWNTO 0);
Address : inout std_logic_vector (15 DOWNTO 0);
DecompressedData,DecompressedData1,DecompressedData2 : inout std_logic_vector(255 Downto 0);
EnableReadingFromCPU1,EnableReadingFromCPU2: inout std_logic;
loadingimg,loadingCNN : inout std_logic;
-----------------------------------------------
--OUTPUTS:
PClk : out std_logic;
DataFromRam : out std_logic_vector (255 DOWNTO 0);
Result : inout std_logic_vector(3 Downto 0);
Done: inout std_logic;
ProcessEnable : out std_logic);

end IOCHIP;

architecture arch of IOCHIP is
---------------------------------------------------------------------------------Components
Component CPU is	
Port (
Done,reset,clk : in std_logic;
result : in std_logic_vector(3 Downto 0);
readen : in std_logic; -- read enable signal	
dataout : out std_logic_vector(15 downto 0)
);
end Component;
---------------------------------------------
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
LoadEnable,loadingCNN : in std_logic;
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
----------------------------------------------
Component decompressor is
  port (reset : in std_logic;
	count : in  std_logic_vector (7 downto 0);
	pValue : in std_logic_vector(7 downto 0);
	loadenable : in std_logic;
	clk : in std_logic;
	readfile,readtoRam: out std_logic;
	decoderout : inout std_logic_vector (27 downto 0);
	imout : out std_logic_vector (255 downto 0));
end Component;
----------------------------------------------
Component jsondecompressor is
  port (reset : in std_logic;
	count : in  std_logic_vector (1 downto 0);
	pValue : in std_logic_vector(15 downto 0);
	loadenable : in std_logic;
	clk : in std_logic;
	tmp : inout std_logic;
	readfile,readtoRam: out std_logic;
	jsonout : out std_logic_vector (255 downto 0));
end Component;
----------------------------------------------
Component MYMUX is	
GENERIC (n : integer := 8);
Port (
A : in std_logic_vector(n-1 DOWNTO 0);
B : in std_logic_vector(n-1 DOWNTO 0);
S : in std_logic;
Z : out std_logic_vector(n-1 DOWNTO 0));
end Component;
------------------------------------------------------------------------------------------------------Signals
Signal LDone,loadenable,ProcEn,writeenable : std_logic;



Signal toWritetoRam,zed :std_logic;
signal  allz : std_logic_vector(27 downto 0);
signal jsoninput : std_logic_vector (15 downto 0);
------------------------------------------------------------------------------------------------------Logic
begin
toWritetoRam <= DecompressionDone1 or DecompressionDone2 or writeenable ;
DecompressionDone<=DecompressionDone1 or DecompressionDone2;
Done <= LDone or PDone;
Result <= Resultin;
Pclk <= CLK;
loadingimg <= '1' when loadenable = '1' and CNNIMGLOAD = '0' else '0';
loadingcnn <= loadenable and CNNIMGLOAD;
EnableReadingFromCPU <= EnableReadingFromCPU2 when CNNIMGLOAD = '1' and loadenable = '1' else EnableReadingFromCPU1 when CNNIMGLOAD = '0' else '0';
i:CPU Port Map (Done,reset,clk,Result,EnableReadingFromCPU,DataBus);
i0:processenablecircuit Port Map (LP,PDone,INTR,reset,procEn);
ProcessEnable <= ProcEn;
i1:loadenablecircuit Port Map (LP,LDone,INTR,reset,loadenable);
i2:LDONEcircuit Port Map (DataBus,LoadEnable,loadingcnn,LDONE);
i3:ramenablereadwrite Port Map (loadenable,DecompressionDone,ProcEn,OuterWrite,OuterRead,readenable,writeenable);
i4:RamControl Port Map (DecompressedData,Address,readenable,toWritetoRam,CLK,DataFromRam);
i5:ADDRESSGENERATOR Port Map (Reset,CLK,LoadEnable,toWritetoRam,ProcEn,IncEnable,OuterAddress,ActivateOuterAddress,Address);
jsoninput <= DataBus(13) & DataBus(13) & DataBus(13 DOWNTO 0);
zed <= 'Z';
allz <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
i7:decompressor Port Map(reset,DataBus(15 DOWNTO 8),DataBus(7 DOWNTO 0),loadingimg,clk,EnableReadingFromCPU1,DecompressionDone1,allz,DecompressedData1);
i8:jsondecompressor Port Map (reset,DataBus(15 DOWNTO 14),jsoninput,loadingcnn,clk,zed,EnableReadingFromCPU2,DecompressionDone2,DecompressedData2);
i9 : MYMUX Generic Map (256) Port Map(DecompressedData1,DecompressedData2,CNNIMGLOAD,DecompressedData);
end arch;