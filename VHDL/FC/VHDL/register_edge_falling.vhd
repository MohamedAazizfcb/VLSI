library ieee;
use ieee.std_logic_1164.all;

entity register_edge_falling is
    generic(n: integer := 16);
    port(
        clk, rst, en    : in  std_logic;
        din             : in  std_logic_vector(n-1 downto 0);
        dout            : out std_logic_vector(n-1 downto 0)
    );
end entity;

architecture arch_register_edge_falling of register_edge_falling is
begin
    process(clk, rst)
    begin
        if (clk'event and clk = '0') then
            if rst='1' then
                dout <= (others => '0');
            elsif en='1' then
                dout <= din;
            end if;
        end if;
    end process;
end architecture;