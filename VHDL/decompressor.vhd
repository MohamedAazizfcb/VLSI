library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity decompressor is
  port (reset : in std_logic;
	count : in  std_logic_vector (7 downto 0);
	pValue : in std_logic_vector(15 downto 0);
	loadenable : in std_logic;
	clk : in std_logic;
	readfile,readtoRam: out std_logic;
	decoderout : inout std_logic_vector (27 downto 0);
	imout : out std_logic_vector (511 downto 0));
end;

architecture a_decompressor of decompressor is

component DownCounter is
   port (enable : in std_logic;
	d : in std_logic_vector(7 downto 0);
	clk,reset : in std_logic;
        q : out std_logic_vector(7 downto 0));
end component;

component decoder_5to28 is
    Port ( d  : in  STD_LOGIC_VECTOR (4 downto 0);
	   enable : in STD_LOGIC;  
           q  : out STD_LOGIC_VECTOR (27 downto 0));                    
end component;

component Reg8 is
  port (enable : in std_logic := '0';
	d : in std_logic_vector(15 downto 0);
	clr,LD : in std_logic := '0';
        q : inout std_logic_vector(15 downto 0));
end component;

signal reset1, reset2 : std_logic;
signal enable1, enable2 : std_logic;
signal read1, read2 : std_logic;
signal counterout1, counterout2 : std_logic_vector (7 downto 0);
Signal Zeroes : std_logic_vector(63 DOWNTO 0) := (Others=> '0');
signal regcount : std_logic_vector (7 downto 0);
signal count1 :  std_logic_vector (7 downto 0);
signal Regout1 : std_logic_vector (15 downto 0);
signal Regout2 : std_logic_vector (15 downto 0);
signal Regout3 : std_logic_vector (15 downto 0);
signal Regout4 : std_logic_vector (15 downto 0);
signal Regout5 : std_logic_vector (15 downto 0);
signal Regout6 : std_logic_vector (15 downto 0);
signal Regout7 : std_logic_vector (15 downto 0);
signal Regout8 : std_logic_vector (15 downto 0);
signal Regout9 : std_logic_vector (15 downto 0);
signal Regout10 : std_logic_vector (15 downto 0);
signal Regout11 : std_logic_vector (15 downto 0);
signal Regout12 : std_logic_vector (15 downto 0);
signal Regout13 : std_logic_vector (15 downto 0);
signal Regout14 : std_logic_vector (15 downto 0);
signal Regout15 : std_logic_vector (15 downto 0);
signal Regout16 : std_logic_vector (15 downto 0);
signal Regout17 : std_logic_vector (15 downto 0);
signal Regout18 : std_logic_vector (15 downto 0);
signal Regout19 : std_logic_vector (15 downto 0);
signal Regout20 : std_logic_vector (15 downto 0);
signal Regout21 : std_logic_vector (15 downto 0);
signal Regout22 : std_logic_vector (15 downto 0);
signal Regout23 : std_logic_vector (15 downto 0);
signal Regout24 : std_logic_vector (15 downto 0);
signal Regout25 : std_logic_vector (15 downto 0);
signal Regout26 : std_logic_vector (15 downto 0);
signal Regout27 : std_logic_vector (15 downto 0);
signal Regout28 : std_logic_vector (15 downto 0);
signal tmp : std_logic;
signal regreset,counterreset : std_logic;
signal start : std_logic;
signal dummy : std_logic_vector (7 downto 0);
signal loadenableD : std_logic; 
signal loadenableRE : std_logic;
begin
	process(reset,dummy,regcount)
	begin
		dummy <= regcount;
		if reset = '1' then
			regcount <= "00011011";
			
		else 
			regcount <= dummy;
		end if;
	end process;
	loadenableD <= loadenable when rising_edge(clk); 
	loadenableRE <= not loadenableD and loadenable; 
	process(loadenableRE,clk)
	begin
		if loadenableRE = '1' then
			start <= '1';
			
		elsif rising_edge(clk) then
			if reset1 = '1' and reset2 = '1' then
				start <= '0';
			end if;
		end if;
	end process;
	process(start,read1,loadenable,clk) 
	begin
		if start = '1' or read1 = '1' or loadenable = '0' then
			if rising_edge(clk) then
				reset1 <= '1';
			end if;
		elsif read1 = '0' and loadenable = '1' then
		  	reset1 <= '0';
		end if;
	end process;
	process(start,read2,loadenable,clk) 
	begin
		if start = '1' or read2 = '1' or loadenable = '0' then
			if rising_edge(clk) then
				reset2 <= '1';
			end if;
		elsif read2 = '0' and loadenable = '1' then
		  	reset2 <= '0';
		end if;
	end process;
	
	e1: enable1 <= '1' when (read2 = '0' or start = '1' or (tmp = '1' and reset1 = '1')) and loadenable = '1' else
		       '0';
	e2: enable2 <= '1' when read1 = '0' or start = '1' or (tmp = '1' and reset2 = '1') else
		       '0';

	count1 <= std_logic_vector( unsigned(count) + 1 ) when reset1 = '1' else
		  counterout1;
	counterreset <= reset1 or reset;
	
	counter1: DownCounter port map(enable1,count1,clk,counterreset,counterout1); 
	counter2: DownCounter port map(enable2,regcount,clk,regreset,counterout2);
	process(counterout1,counterout2,reset1,reset2)
	begin
		if counterout1 = "00000001" and counterout2 = "11111111" and reset1 = '1' and reset2 = '1' then
			tmp<= '1';
		elsif counterout1 /= "00000001" and counterout2 /= "11111111" then
			tmp <= '0';
		else tmp <= tmp;
		end if;
	end process;
	process(counterout1,tmp,start,clk)
	begin
		if (counterout1 = "00000001" and tmp /= '1') or start = '1' then
			read1 <= '1';
		elsif counterout1 /= "00000001" or tmp = '1' then
			if rising_edge(clk) then
				read1 <= '0';
			end if;
		end if;
	end process;
	process(counterout2,tmp,start,clk)
	begin
		if (counterout2 = "11111111" and tmp /= '1') or start = '1' then
			read2 <= '1';
		elsif counterout2 /= "11111111" or tmp = '1' then
			if rising_edge(clk) then
				read2 <= '0';
			end if;
		end if;
	end process;
	rd1 : readfile <= read1;
	process(counterout2,tmp,clk)
	begin
		if counterout2 = "11111111" and tmp /= '1' then
			readtoRam <= '1';
		elsif counterout2 /= "11111111" or tmp = '1' then
			if rising_edge(clk) then
				readtoRam <= '0';
			end if;
		end if;
	end process;
	--reset2 <= reset2 or reset;
	regreset <= reset2 or reset;
	decoder: decoder_5to28 port map(counterout2(4 downto 0),loadenable,decoderout);
	
	r1: Reg8 port map(enable2,pValue,regreset,decoderout(0),regout1);
	r2: Reg8 port map(enable2,pValue,regreset,decoderout(1),regout2);
	r3: Reg8 port map(enable2,pValue,regreset,decoderout(2),regout3);
	r4: Reg8 port map(enable2,pValue,regreset,decoderout(3),regout4);
	r5: Reg8 port map(enable2,pValue,regreset,decoderout(4),regout5);
	r6: Reg8 port map(enable2,pValue,regreset,decoderout(5),regout6);
	r7: Reg8 port map(enable2,pValue,regreset,decoderout(6),regout7);
	r8: Reg8 port map(enable2,pValue,regreset,decoderout(7),regout8);
	r9: Reg8 port map(enable2,pValue,regreset,decoderout(8),regout9);
	r10: Reg8 port map(enable2,pValue,regreset,decoderout(9),regout10);
	r11: Reg8 port map(enable2,pValue,regreset,decoderout(10),regout11);
	r12: Reg8 port map(enable2,pValue,regreset,decoderout(11),regout12);
	r13: Reg8 port map(enable2,pValue,regreset,decoderout(12),regout13);
	r14: Reg8 port map(enable2,pValue,regreset,decoderout(13),regout14);
	r15: Reg8 port map(enable2,pValue,regreset,decoderout(14),regout15);
	r16: Reg8 port map(enable2,pValue,regreset,decoderout(15),regout16);
	r17: Reg8 port map(enable2,pValue,regreset,decoderout(16),regout17);
	r18: Reg8 port map(enable2,pValue,regreset,decoderout(17),regout18);
	r19: Reg8 port map(enable2,pValue,regreset,decoderout(18),regout19);
	r20: Reg8 port map(enable2,pValue,regreset,decoderout(19),regout20);
	r21: Reg8 port map(enable2,pValue,regreset,decoderout(20),regout21);
	r22: Reg8 port map(enable2,pValue,regreset,decoderout(21),regout22);
	r23: Reg8 port map(enable2,pValue,regreset,decoderout(22),regout23);
	r24: Reg8 port map(enable2,pValue,regreset,decoderout(23),regout24);
	r25: Reg8 port map(enable2,pValue,regreset,decoderout(24),regout25);
	r26: Reg8 port map(enable2,pValue,regreset,decoderout(25),regout26);
	r27: Reg8 port map(enable2,pValue,regreset,decoderout(26),regout27);
	r28: Reg8 port map(enable2,pValue,regreset,decoderout(27),regout28);

	output : imout <= Zeroes & regout1 & regout2 & regout3 & regout4 & regout5 & regout6 & regout7 & regout8 & regout9 & regout10 & regout11 & regout12 & regout13 & regout14 & regout15 & regout16 & regout17 & regout18 & regout19 & regout20 & regout21 & regout22 & regout23 & regout24 & regout25 & regout26 & regout27 & regout28;

end a_decompressor;