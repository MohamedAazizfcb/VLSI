library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_5to28 is
    Port ( d  : in  STD_LOGIC_VECTOR (4 downto 0);
	   enable : in STD_LOGIC;  
           q  : out STD_LOGIC_VECTOR (27 downto 0));                    
end decoder_5to28;

architecture Behavioral of decoder_5to28 is
begin
process (d,enable)
begin
    q <= (others => '0');        -- default output value
    if (enable = '1') then
        case d is
            when "00000" => q(0) <= '1';
            when "00001" => q(1) <= '1';
            when "00010" => q(2) <= '1';
            when "00011" => q(3) <= '1';
	    when "00100" => q(4) <= '1';
	    when "00101" => q(5) <= '1';
	    when "00110" => q(6) <= '1';
	    when "00111" => q(7) <= '1';
	    when "01000" => q(8) <= '1';	
	    when "01001" => q(9) <= '1';
	    when "01010" => q(10) <= '1';
	    when "01011" => q(11) <= '1';
	    when "01100" => q(12) <= '1';
	    when "01101" => q(13) <= '1';
	    when "01110" => q(14) <= '1';
	    when "01111" => q(15) <= '1';
	    when "10000" => q(16) <= '1';
	    when "10001" => q(17) <= '1';
	    when "10010" => q(18) <= '1';
	    when "10011" => q(19) <= '1';
	    when "10100" => q(20) <= '1';
	    when "10101" => q(21) <= '1';
	    when "10110" => q(22) <= '1';
	    when "10111" => q(23) <= '1';
	    when "11000" => q(24) <= '1';
            when "11001" => q(25) <= '1';
	    when "11010" => q(26) <= '1';
	    when "11011" => q(27) <= '1';
            when others => q <= (others => '0');
        end case;
    end if;
end process;
end Behavioral;
