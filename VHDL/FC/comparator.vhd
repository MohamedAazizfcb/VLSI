library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator is
    port (
        comparator_inp_1    : in std_logic_vector(15 downto 0);
        comparator_inp_2    : in std_logic_vector(15 downto 0);
        comparator_output   : out std_logic_vector(15 downto 0)
    );
end entity comparator;

architecture a_comparator of comparator is
  signal alu_out : std_logic_vector(15 downto 0);
  signal alu_cout : std_logic;
	begin
		comparator_output <= comparator_inp_2 when alu_out(15) = '1' else 
												 comparator_inp_1 when alu_out(15) = '0';
		alu_subtractor_adder1 : entity work.alu generic map ( 16 ) port map ( comparator_inp_1  , comparator_inp_2  , '1'  , '0'  , alu_out  , alu_cout  );
end architecture;
