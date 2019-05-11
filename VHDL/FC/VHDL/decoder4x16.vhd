library ieee;
use ieee.std_logic_1164.all;

entity decoder4x16 is
    port ( 
      selector_decoder  : in  std_logic_vector (3 downto 0);
      decoder_output    : out std_logic_vector (15 downto 0);
      enable_decoder    : in  std_logic
    );
end decoder4x16;

architecture a_decoder4x16 of decoder4x16 is
  begin
    process(enable_decoder,selector_decoder)
      begin
        if enable_decoder = '0' then 
          decoder_output <= "0000000000000000";     -- Disabled
        elsif enable_decoder = '1' and selector_decoder = "0000" then
          decoder_output <= "0000000000000001";     -- Lab1
        elsif enable_decoder = '1' and selector_decoder = "0001" then
          decoder_output <= "0000000000000010";     -- Lab2
        elsif enable_decoder = '1' and selector_decoder = "0010" then
          decoder_output <= "0000000000000100";     -- Lab3 
        elsif enable_decoder = '1' and selector_decoder = "0011" then
          decoder_output <= "0000000000001000";     -- Lab4
        elsif enable_decoder = '1' and selector_decoder = "0100" then
          decoder_output <= "0000000000010000";     -- Lab5
        elsif enable_decoder = '1' and selector_decoder = "0101" then
          decoder_output <= "0000000000100000";     -- Lab6
        elsif enable_decoder = '1' and selector_decoder = "0110" then
          decoder_output <= "0000000001000000";     -- Lab7
        elsif enable_decoder = '1' and selector_decoder = "0111" then
          decoder_output <= "0000000010000000";     -- Lab8
        elsif enable_decoder = '1' and selector_decoder = "1000" then
          decoder_output <= "0000000100000000";     -- Lab9
        elsif enable_decoder = '1' and selector_decoder = "1001" then
          decoder_output <= "0000001000000000";     -- Lab10
        elsif enable_decoder = '1' and selector_decoder = "1010" then
          decoder_output <= "0000010000000000";     -- Garbage
        elsif enable_decoder = '1' and selector_decoder = "1011" then
          decoder_output <= "0000100000000000";     -- Garbage 
        elsif enable_decoder = '1' and selector_decoder = "1100" then
          decoder_output <= "0001000000000000";     -- Garbage
        elsif enable_decoder = '1' and selector_decoder = "1101" then
          decoder_output <= "0010000000000000";     -- Garbage
        elsif enable_decoder = '1' and selector_decoder = "1110" then
          decoder_output <= "0100000000000000";     -- Garbage
	else 
	  decoder_output <=  "1111111111111111";
        end if;
      end process;
end a_decoder4x16;
