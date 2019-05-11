library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.all;

entity bias_logic is
    Port ( CLK: in std_logic;
           enable: in std_logic;
           reset : in  STD_LOGIC;     -- input clock
           biases : in  STD_LOGIC_VECTOR (399 downto 0);
	   bias: out std_logic_vector(15 downto 0));
end bias_logic;

architecture bias_logic_arc of bias_logic is

    signal countt: integer := 0;
    signal result   : std_logic_vector (15 downto 0) := "0000000000000000";
begin
    --count<= ;
    process (CLK)
    begin 

	if (CLK'Event and CLK = '1') then
		if(enable = '1') then	
			if (countt = 0) then
				result <= biases(15 downto 0);
			elsif (countt = 1) then
				result <= biases(31 downto 16);
			elsif (countt = 2) then
				result <= biases(47 downto 32);
			elsif (countt = 3) then
				result <= biases(63 downto 48);
			elsif (countt = 4) then
				result <= biases(79 downto 64);
			elsif (countt = 5) then
				result <= biases(95 downto 80);
			elsif (countt = 6) then
				result <= biases(111 downto 96);
			elsif (countt = 7) then
				result <= biases(127 downto 112);
			elsif (countt = 8) then
				result <= biases(143 downto 128);
			elsif (countt = 9) then
				result <= biases(159 downto 144);
			elsif (countt = 10) then
				result <= biases(175 downto 160);
			elsif (countt = 11) then
				result <= biases(191 downto 176);
			elsif (countt = 12) then
				result <= biases(207 downto 192);
			elsif (countt = 13) then
				result <= biases(223 downto 208);
			elsif (countt = 14) then
				result <= biases(239 downto 224);
			elsif (countt = 15) then
				result <= biases(255 downto 240);
			elsif (countt = 16) then
				result <= biases(271 downto 256);
			elsif (countt = 17) then
				result <= biases(287 downto 272);
			elsif (countt = 18) then
				result <= biases(303 downto 288);
			elsif (countt = 19) then
				result <= biases(319 downto 304);
			elsif (countt = 20) then
				result <= biases(335 downto 320);
			elsif (countt = 21) then
				result <= biases(351 downto 336);
			elsif (countt = 22) then
				result <= biases(367 downto 352);
			elsif (countt = 23) then
				result <= biases(383 downto 368);
			elsif (countt = 24) then
				result <= biases(399 downto 384);
			
			end if;
			countt <= countt + 1;
		end if;
	end if;
        if (reset = '1') then
		countt <= 0;
         end if;

    end process;
	    bias <= result;
end bias_logic_arc;
