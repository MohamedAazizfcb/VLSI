library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.all;

entity window_logic is
    Port ( CLK: in std_logic;
           enable: in std_logic;
           reset : in  STD_LOGIC;     -- input clock
           row : in  STD_LOGIC_VECTOR (511 downto 0);
	   window: out std_logic_vector(79 downto 0);
	   filter_size: in std_logic_vector(2 downto 0));
end window_logic;

architecture Behavioral of window_logic is

    signal countt: integer := 0;
    signal result   : std_logic_vector (79 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
begin
    --count<= ;
    process (CLK)
    begin 

	if (CLK'Event and CLK = '1') then
		if(enable = '1') then	

			if (countt = 0) then
				result <= row(79 downto 0);
			elsif (countt = 1) then
				result <= row(95 downto 16);
			elsif (countt = 2) then
				result <= row(111 downto 32);
			elsif (countt = 3) then
				result <= row(127 downto 48);
			elsif (countt = 4) then
				result <= row(143 downto 64);
			elsif (countt = 5) then
				result <= row(159 downto 80);
			elsif (countt = 6) then
				result <= row(175 downto 96);
			elsif (countt = 7) then
				result <= row(191 downto 112);
			elsif (countt = 8) then
				result <= row(207 downto 128);
			elsif (countt = 9) then
				result <= row(223 downto 144);
			elsif (countt = 10) then
				result <= row(239 downto 160);
			elsif (countt = 11) then
				result <= row(255 downto 176);
			elsif (countt = 12) then
				result <= row(271 downto 192);
			elsif (countt = 13) then
				result <= row(287 downto 208);
			elsif (countt = 14) then
				result <= row(303 downto 224);
			elsif (countt = 15) then
				result <= row(319 downto 240);
			elsif (countt = 16) then
				result <= row(335 downto 256);
			elsif (countt = 17) then
				result <= row(351 downto 272);
			elsif (countt = 18) then
				result <= row(367 downto 288);
			elsif (countt = 19) then
				result <= row(383 downto 304);
			elsif (countt = 20) then
				result <= row(399 downto 320);
			elsif (countt = 21) then
				result <= row(415 downto 336);
			elsif (countt = 22) then
				result <= row(431 downto 352);
			elsif (countt = 23) then
				result <= row(447 downto 368);
			elsif (countt = 24) then
				result <= row(463 downto 384);
			elsif (countt = 25) then
				result <= row(479 downto 400);
			elsif (countt = 26) then
				result <= row(495 downto 416);
			elsif (countt = 27) then
				result <= row(511 downto 432);
			end if;	
			countt <= countt + 1;
		end if;
	end if;
        if (reset = '1') then
			countt <= 0;
         end if;
	if(filter_size(1) = '1') then
		result(79 downto 48) <= "00000000000000000000000000000000";
	end if;

    end process;
	    window <= result;
end Behavioral;
