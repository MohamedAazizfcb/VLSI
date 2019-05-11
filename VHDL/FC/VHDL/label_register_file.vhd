library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity label_register_file is
    port ( 
        clk : in std_logic;
        rst : in std_logic;
        enable_decoder_dst : in std_logic;
        sel_dst : in std_logic_vector(3 downto 0);

        label_1_input  : in std_logic_vector(15 downto 0);
        label_2_input  : in std_logic_vector(15 downto 0);
        label_3_input  : in std_logic_vector(15 downto 0);
        label_4_input  : in std_logic_vector(15 downto 0);
        label_5_input  : in std_logic_vector(15 downto 0);
        label_6_input  : in std_logic_vector(15 downto 0);
        label_7_input  : in std_logic_vector(15 downto 0);
        label_8_input  : in std_logic_vector(15 downto 0);
        label_9_input  : in std_logic_vector(15 downto 0);
        label_10_input : in std_logic_vector(15 downto 0);


        ---------------- Labels Ports --------------------------
        label_1_output : out std_logic_vector(15 downto 0);
        label_2_output : out std_logic_vector(15 downto 0);
        label_3_output : out std_logic_vector(15 downto 0);
        label_4_output : out std_logic_vector(15 downto 0);
        label_5_output : out std_logic_vector(15 downto 0);
        label_6_output : out std_logic_vector(15 downto 0);
        label_7_output : out std_logic_vector(15 downto 0);
        label_8_output : out std_logic_vector(15 downto 0);
        label_9_output : out std_logic_vector(15 downto 0);
        label_10_output: out std_logic_vector(15 downto 0)

       );
end entity label_register_file;

architecture a_label_register_file of label_register_file is
    
    signal decoder_out_dst : std_logic_vector ( 15 downto 0 );    
    begin
      
    dst_decoder: entity work.decoder4x16 port map ( sel_dst , decoder_out_dst , enable_decoder_dst );

    
    label1  : entity work.n_dff generic map ( 16 ) port map ( clk , rst , decoder_out_dst(0) , label_1_input   , label_1_output  );
    label2  : entity work.n_dff generic map ( 16 ) port map ( clk , rst , decoder_out_dst(1) , label_2_input   , label_2_output  );
    label3  : entity work.n_dff generic map ( 16 ) port map ( clk , rst , decoder_out_dst(2) , label_3_input   , label_3_output  );
    label4  : entity work.n_dff generic map ( 16 ) port map ( clk , rst , decoder_out_dst(3) , label_4_input   , label_4_output  );
    label5  : entity work.n_dff generic map ( 16 ) port map ( clk , rst , decoder_out_dst(4) , label_5_input   , label_5_output  );
    label6  : entity work.n_dff generic map ( 16 ) port map ( clk , rst , decoder_out_dst(5) , label_6_input   , label_6_output  );
    label7  : entity work.n_dff generic map ( 16 ) port map ( clk , rst , decoder_out_dst(6) , label_7_input   , label_7_output  );
    label8  : entity work.n_dff generic map ( 16 ) port map ( clk , rst , decoder_out_dst(7) , label_8_input   , label_8_output  );
    label9  : entity work.n_dff generic map ( 16 ) port map ( clk , rst , decoder_out_dst(8) , label_9_input   , label_9_output  );
    label10 : entity work.n_dff generic map ( 16 ) port map ( clk , rst , decoder_out_dst(9) , label_10_input  , label_10_output );

end a_label_register_file;


