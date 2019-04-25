library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_4to16 is
    Port (d  : in  STD_LOGIC_VECTOR (3 downto 0);
	   enable : in STD_LOGIC;  
           q  : out STD_LOGIC_VECTOR (15 downto 0));                  
end decoder_4to16;

architecture Behavioral of decoder_4to16 is
begin
process (d,enable)
begin
    q <= (others => '0');        -- default output value
    if (enable = '1') then
        case d is
            when "0000" => q(0) <= '1';
            when "0001" => q(1) <= '1';
            when "0010" => q(2) <= '1';
            when "0011" => q(3) <= '1';
	    when "0100" => q(4) <= '1';
	    when "0101" => q(5) <= '1';
	    when "0110" => q(6) <= '1';
	    when "0111" => q(7) <= '1';
	    when "1000" => q(8) <= '1';	
	    when "1001" => q(9) <= '1';
	    when "1010" => q(10) <= '1';
	    when "1011" => q(11) <= '1';
	    when "1100" => q(12) <= '1';
	    when "1101" => q(13) <= '1';
	    when "1110" => q(14) <= '1';
	    when "1111" => q(15) <= '1';    
            when others => q <= (others => '0');
        end case;
    end if;
end process;
end Behavioral;
