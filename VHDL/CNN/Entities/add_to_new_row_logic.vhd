library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.all;

entity new_row_logic is
    Port ( CLK: in std_logic;
           enable: in std_logic;
           reset,flag : in  STD_LOGIC;     -- input clock
           row : out  STD_LOGIC_VECTOR (511 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
	   result: in std_logic_vector(15 downto 0);
	   row_is_done: out std_logic := '0';
       out_size: in std_logic_vector(4 downto 0);
	   last_cycle_flag : in std_logic);
		
end new_row_logic;

architecture Behavioral of new_row_logic is

    signal count_elements: std_logic_vector (4 downto 0) := "00000";
    signal countt: integer := 0;
begin

row_is_done <= (count_elements(4) xnor out_size(4)) and (count_elements(3) xnor out_size(3)) and (count_elements(2) xnor out_size(2)) and (count_elements(1) xnor out_size(1)) and (count_elements(0) xnor out_size(0)); 

    process (CLK)
    begin 

	if (CLK'Event and CLK = '1') then
		if(enable = '1' and last_cycle_flag = '0') then	
			if (countt = 0) then
				row(15 downto 0) <= result;
			elsif (countt = 1) then
				row(31 downto 16) <= result;
			elsif (countt = 2) then
				row(47 downto 32) <= result;
			elsif (countt = 3) then
				row(63 downto 48) <= result;
			elsif (countt = 4) then
				row(79 downto 64) <= result;
			elsif (countt = 5) then
				row(95 downto 80) <= result;
			elsif (countt = 6) then
				row(111 downto 96) <= result;
			elsif (countt = 7) then
				row(127 downto 112) <= result;
			elsif (countt = 8) then
				row(143 downto 128) <= result;
			elsif (countt = 9) then
				row(159 downto 144) <= result;
			elsif (countt = 10) then
				row(175 downto 160) <= result;
			elsif (countt = 11) then
				row(191 downto 176) <= result;
			elsif (countt = 12) then
				row(207 downto 192) <= result;
			elsif (countt = 13) then
				row(223 downto 208) <= result;
			elsif (countt = 14) then
				row(239 downto 224) <= result;
			elsif (countt = 15) then
				row(255 downto 240) <= result;
			elsif (countt = 16) then
				row(271 downto 256) <= result;
			elsif (countt = 17) then
				row(287 downto 272) <= result;
			elsif (countt = 18) then
				row(303 downto 288) <= result;
			elsif (countt = 19) then
				row(319 downto 304) <= result;
			elsif (countt = 20) then
				row(335 downto 320) <= result;
			elsif (countt = 21) then
				row(351 downto 336) <= result;
			elsif (countt = 22) then
				row(367 downto 352) <= result;
			elsif (countt = 23) then
				row(383 downto 368) <= result;
			elsif (countt = 24) then
				row(399 downto 384) <= result;
			elsif (countt = 25) then
				row(415 downto 400) <= result;
			elsif (countt = 26) then
				row(431 downto 416) <= result;
			elsif (countt = 27) then
				row(447 downto 432) <= result;
			elsif (countt = 28) then
				row(463 downto 448) <= result;
			elsif (countt = 29) then
				row(479 downto 464) <= result;
			elsif (countt = 30) then
				row(495 downto 480) <= result;
			elsif (countt = 31) then
				row(511 downto 496) <= result;
			end if;	
			
		elsif(enable = '1' and last_cycle_flag = '1') then
			row <= "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"&result;
		end if;
		
		countt <= countt + 1;
		count_elements <= count_elements + 1;
		
	end if;
        if (reset = '1' or flag = '1') then
		countt <= 0;
		count_elements <= "00000";
		row <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        end if;


    end process;
end Behavioral;

