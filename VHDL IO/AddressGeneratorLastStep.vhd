library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity AddressGeneratorLS is
GENERIC (n : integer := 8);
Port ( 
loadenable : in std_logic;
reset : in std_logic;	 
ImgAddress : in std_logic;
CNNAddress : in std_logic;
clk : in std_logic;
Address : out std_logic_vector(n-1 DOWNTO 0)
);
end AddressGeneratorLS;

architecture Behavioral of AddressGeneratorLS is
component regster is
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
end component;


Component FULLADDER IS
GENERIC (n : integer := 8);
PORT(A,B : IN std_logic_vector(n-1  DOWNTO 0);
Cin,en : IN std_logic;  
S : OUT std_logic_vector(n-1 DOWNTO 0);           
Cout : OUT std_logic);
End Component;

signal dummy1,incen:std_logic; 
Signal curr,tempcurr,nxt,dummyn,zed,zeroes,Imagadd,cnnadd:std_logic_vector(n-1 Downto 0);
begin	
zed<=(others=>'Z');
zeroes<=(others=>'0');

Crload:regster Generic Map (n) Port Map (incen,nxt,clk,reset,"00",tempcurr);

Img:regster Generic Map (n) Port Map ('0',zed,clk,'0',"01",Imagadd);
Cnn:regster Generic Map (n) Port Map ('0',zed,clk,'0',"10",CNNadd);

process(loadenable,reset,CNNAddress,IMGAddress,Imagadd,curr,tempcurr) 
begin
if (reset = '1') then
	curr<=zeroes;
	Address<=curr;
	incen<='0';
elsif (ImgAddress = '1' and loadenable = '1') then
	Address<=Imagadd;
	curr<=Imagadd;
	incen<='1';
elsif (CNNAddress = '1' and loadenable = '1') then
	Address<= CNNadd;
	curr<=CNNAdd;
	incen <='1';
elsif (loadenable = '1') then
	curr<=tempcurr;
	Address<= curr;
	incen <= '1';
else 
	curr<=tempcurr;
	Address<=curr;
	incen<='0';
end if;
end process;	

Crplus1:fulladder Generic Map (n) Port Map (curr,zeroes,'1',incen,nxt,dummy1);

end Behavioral;
