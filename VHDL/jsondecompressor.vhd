library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity jsondecompressor is
  port (reset : in std_logic;
	count : in  std_logic_vector (1 downto 0);
	pValue : in std_logic_vector(15 downto 0);
	loadenable : in std_logic;
	clk : in std_logic;
	tmp : inout std_logic;
	readfile,readtoRam: out std_logic;
	jsonout : out std_logic_vector (255 downto 0));
end;

architecture a_jsondecompressor of jsondecompressor is

component DownCounter is
   port (enable : in std_logic;
	d : in std_logic_vector(7 downto 0);
	clk,reset : in std_logic;
        q : out std_logic_vector(7 downto 0));
end component;

component decoder_4to16 is
    Port ( d  : in  STD_LOGIC_VECTOR (3 downto 0);
	   enable : in STD_LOGIC;  
           q  : out STD_LOGIC_VECTOR (15 downto 0));                    
end component;

component Reg16 is
  port (enable : in std_logic := '0';
	d : in std_logic_vector(15 downto 0);
	clr,LD : in std_logic := '0';
        q : inout std_logic_vector(15 downto 0));
end component;

signal reset1, reset2 : std_logic;
signal enable1, enable2 : std_logic;
signal read1, read2 : std_logic;
signal counterout1, counterout2 : std_logic_vector (7 downto 0);
signal regcount : std_logic_vector (7 downto 0);
signal decoderout : std_logic_vector (15 downto 0);
signal newline : std_logic ;
signal counttmp :  std_logic_vector (7 downto 0);
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
signal tmpvector : std_logic_vector (15 downto 0);
signal resetvector : std_logic_vector (15 downto 0);
signal regreset,counterreset : std_logic;
signal start : std_logic;
signal dummy : std_logic_vector (7 downto 0);
signal ramWrite : std_logic;
signal loadenableD : std_logic; 
signal loadenableRE : std_logic;
signal tmp1,tmp2 : std_logic;
begin
	process(reset,dummy,regcount)
	begin
		dummy <= regcount;
		if reset = '1' then
			regcount <= "00001111";
			
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
	process(start,read1,loadenable,clk,tmp,counterout1) 
	begin
		if start = '1' or read1 = '1' or loadenable = '0' then
			if rising_edge(clk) then
				reset1 <= '1';
			end if;
		elsif (read1 = '0' and counterout1 /= "00000000" and tmp /= '1') and loadenable = '1' then
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
	e1: enable1 <= '1' when (read2 = '0' or start = '1' or (tmp1 = '1' and reset1 = '1')) and loadenable = '1' else
		       '0';
	e2: enable2 <= '1' when read1 = '0' or start = '1' or (tmp1 = '1' and reset2 = '1') else
		       '0';

	counttmp <= std_logic_vector( unsigned("000000" & count) + 1 ) when reset1 = '1' else
		  counterout1;
	newline <= '1' when counterout1 = "00000000" and count = "00" and read1 = '1' else '0';	
	counterreset <= reset or reset1;
	regreset <= reset or reset2;
	counter1: DownCounter port map(enable1,counttmp,clk,counterreset,counterout1); 
	counter2: DownCounter port map(enable2,regcount,clk,regreset,counterout2);
	
	tmp <= '1' when counterout1 = "00000000" and reset1 = '1' and reset2 = '1' else
			'0' when counterout1 /= "00000001" and counterout2 /= "11111111" else tmp;
	process(counterout1,counterout2,reset1,reset2)
	begin
		if counterout1 = "00000001" and counterout2 = "11111111" and reset1 = '1' and reset2 = '1' then
			tmp1<= '1';
		elsif counterout1 /= "00000001" and counterout2 /= "11111111" then
			tmp1 <= '0';
		else tmp1 <= tmp1;
		end if;
	end process;
	tmp2 <= '1' when tmp = '1' or tmp1 = '1' else '0';
	process(counterout1,tmp2,start,count,clk)
	begin
		if ((counterout1 = "00000001" and tmp1 /= '1') or (counterout1 = "00000001" and counterout2 = "11111110" and tmp1 = '1')) or start = '1' or count = "00" then
			if counterout1 /= "00000000" or tmp /= '1' then
				read1 <= '1';
			elsif counterout1 /= "00000001" or tmp = '1' then
				read1 <= '0';		
			end if;
		elsif counterout1 /= "00000001" or tmp = '1' then
			if rising_edge(clk) then
				read1 <= '0';
			end if;
		elsif counterout1 = "00000000" and tmp = '1' then
			read1 <= '0';
		end if;
	end process;
	process(counterout2,tmp2,start,newline,clk)
	begin
		if (counterout2 = "11111111" and tmp1 /= '1') or start = '1' or newline = '1' then
			read2 <= '1';
		elsif counterout2 /= "11111111" or tmp1 = '1' then
			if rising_edge(clk) then
				read2 <= '0';
			end if;
		end if;
	end process;
	
	rd1 : readfile <= read1;

	process(counterout2,tmp2,newline,clk)
	begin
		if (counterout2 = "11111111" and tmp1 /= '1') or newline = '1' then
			ramWrite <= '1';
		elsif counterout2 /= "11111111" or tmp1 = '1' then
			if rising_edge(clk) then
				ramWrite <= '0';
			end if;
		end if;
	end process;
	readtoRam <= ramWrite after 10 ns;
	decoder: decoder_4to16 port map(counterout2(3 downto 0),'1',decoderout);
	
	tmpvector <= (15 downto 0 => newline) and decoderout;
	resetvector <= (15 downto 0 => reset2) or tmpvector or (15 downto 0 => reset); 
	r1: Reg16 port map(enable2,pValue,resetvector(0),decoderout(0),regout1);
	r2: Reg16 port map(enable2,pValue,resetvector(1),decoderout(1),regout2);
	r3: Reg16 port map(enable2,pValue,resetvector(2),decoderout(2),regout3);
	r4: Reg16 port map(enable2,pValue,resetvector(3),decoderout(3),regout4);
	r5: Reg16 port map(enable2,pValue,resetvector(4),decoderout(4),regout5);
	r6: Reg16 port map(enable2,pValue,resetvector(5),decoderout(5),regout6);
	r7: Reg16 port map(enable2,pValue,resetvector(6),decoderout(6),regout7);
	r8: Reg16 port map(enable2,pValue,resetvector(7),decoderout(7),regout8);
	r9: Reg16 port map(enable2,pValue,resetvector(8),decoderout(8),regout9);
	r10: Reg16 port map(enable2,pValue,resetvector(9),decoderout(9),regout10);
	r11: Reg16 port map(enable2,pValue,resetvector(10),decoderout(10),regout11);
	r12: Reg16 port map(enable2,pValue,resetvector(11),decoderout(11),regout12);
	r13: Reg16 port map(enable2,pValue,resetvector(12),decoderout(12),regout13);
	r14: Reg16 port map(enable2,pValue,resetvector(13),decoderout(13),regout14);
	r15: Reg16 port map(enable2,pValue,resetvector(14),decoderout(14),regout15);
	r16: Reg16 port map(enable2,pValue,resetvector(15),decoderout(15),regout16);

	output : jsonout <= regout16 & regout15 & regout14 & regout13 & regout12 & regout11 & regout10 & regout9 & regout8 & regout7 & regout6 & regout5 & regout4 & regout3 & regout2 & regout1 ;

end a_jsondecompressor;