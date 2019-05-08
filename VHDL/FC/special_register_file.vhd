library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity special_register_file is
    port (
      clk               : in std_logic;
      clk_inv           : in std_logic;
      rst               : in std_logic;
      enable_mar_in     : in std_logic;
      enable_mdr_in     : in std_logic;
      enable_mdr_out    : in std_logic;
      enable_write      : in std_logic;
      address 		: in std_logic_vector(7 downto 0);
      mdr_data_out      : out std_logic_vector(255 downto 0)
    );
end entity special_register_file;

architecture a_special_register_file of special_register_file is
    signal mdr_out    : std_logic_vector(255 downto 0);
    signal data_out   : std_logic_vector(255 downto 0);
    signal mar_out    : std_logic_vector(7 downto 0);
    begin
        mar    : entity work.N_Dff generic map (8) port map ( clk , rst , enable_mar_in , address , mar_out );

        mdr    : entity work.N_Dff generic map (256) port map ( clk , rst , enable_mdr_in , data_out , mdr_data_out );
        -- tri_state_mdr_bus : entity work.tri_state generic map ( 256 ) port map ( enable_mdr_out , mdr_out , mdr_data_out );

        my_ram : entity work.ram generic map ( 256 , 64 , 8 ) port map ( clk_inv , enable_write , address , mdr_out , data_out );
        

	
        -- if enable_write = 1 then i need to write to the memory from the data exists in the bus.
        --mdr_input <= external_data  when enable_write = '1' else 
        --             data_out when enable_write = '0';
end a_special_register_file;

