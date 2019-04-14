library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity ADDRESSGENERATOR is	
Port ( 
Reset,CLK : in std_logic;
LoadEnable : in std_logic;
DecompressionDone : in std_logic;
ProcessEnable : in std_logic;
IncEnable : in std_logic;
OuterAddress : in std_logic_vector (15 DOWNTO 0);
ActivateOuterAddress : in std_logic;
Address : out std_logic_vector (15 DOWNTO 0));
end ADDRESSGENERATOR;

architecture arch of ADDRESSGENERATOR is

Component FULLADDER IS
GENERIC (n : integer := 8);
PORT(A,B : IN std_logic_vector(n-1  DOWNTO 0);
Cin,en : IN std_logic;  
S : OUT std_logic_vector(n-1 DOWNTO 0);           
Cout : OUT std_logic);
end Component;

Component regster is
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
end Component;

Component MUX2 is	
GENERIC (n : integer := 8);
Port (
A : in std_logic_vector(n-1 DOWNTO 0);
B : in std_logic_vector(n-1 DOWNTO 0);
S : in std_logic;
Z : out std_logic_vector(n-1 DOWNTO 0));
end Component;

Signal FAEN,MS,dummy : std_logic;
Signal MARo,MARi,tempad,Zeroes : std_logic_vector (15 Downto 0);
begin
Zeroes <= (OTHERS => '0');
FAEN <= ((not Reset) and ((LoadEnable and DecompressionDone) or (ProcessEnable and IncEnable)));
MS <= (ActivateOuterAddress and (not (LoadEnable)));

r1 : MUX2 Generic Map (7) PORT MAP (MARo,OuterAddress,MS,tempad);
Address <= tempad;
r2 : FULLADDER Generic Map (7) PORT MAP (tempad,Zeroes,'1',FAEN,MARi,dummy);
MR : Regster Generic Map (7) PORT MAP ('1',MARi,CLK,Reset,"00",MARo);
end arch;