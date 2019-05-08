library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maximum_ic is
    port (
        clk            : in    std_logic; 
        rst            : in    std_logic;
        start_comp     : in    std_logic;
        done_comp      : out   std_logic;
        label1_out     : in    std_logic_vector(15 downto 0);
        label2_out     : in    std_logic_vector(15 downto 0);
        label3_out     : in    std_logic_vector(15 downto 0);
        label4_out     : in    std_logic_vector(15 downto 0);
        label5_out     : in    std_logic_vector(15 downto 0);
        label6_out     : in    std_logic_vector(15 downto 0);
        label7_out     : in    std_logic_vector(15 downto 0);
        label8_out     : in    std_logic_vector(15 downto 0);
        label9_out     : in    std_logic_vector(15 downto 0);
        label10_out    : in    std_logic_vector(15 downto 0);
        answer         : out   std_logic_vector(15 downto 0)
    );
end entity maximum_ic;

architecture a_maximum_ic of maximum_ic is
  
  
  
  -- First Comparator
  signal comparator_first_inp1     : std_logic_vector(15 downto 0);
  signal comparator_first_inp2	   : std_logic_vector(15 downto 0);
  signal comparator_first_output   : std_logic_vector(15 downto 0);

  -- Second Comparator
  signal comparator_second_inp1    : std_logic_vector(15 downto 0);
  signal comparator_second_inp2	   : std_logic_vector(15 downto 0);
  signal comparator_second_output  : std_logic_vector(15 downto 0);
  
  -- Third Comparator
  signal comparator_third_inp1     : std_logic_vector(15 downto 0);
  signal comparator_third_inp2	   : std_logic_vector(15 downto 0);
  signal comparator_third_output   : std_logic_vector(15 downto 0);
  
  -- Forth Comparator
  signal comparator_fourth_inp1    : std_logic_vector(15 downto 0);
  signal comparator_fourth_inp2	   : std_logic_vector(15 downto 0);
  signal comparator_fourth_output  : std_logic_vector(15 downto 0);
  
  -- Fifth Comparator
  signal comparator_fifth_inp1     : std_logic_vector(15 downto 0);
  signal comparator_fifth_inp2	   : std_logic_vector(15 downto 0);
  signal comparator_fifth_output   : std_logic_vector(15 downto 0);
  

  -- answers signals
  signal ans1 : std_logic_vector(15 downto 0);
  signal ans2 : std_logic_vector(15 downto 0);
  signal ans3 : std_logic_vector(15 downto 0);
  signal ans4 : std_logic_vector(15 downto 0);
  signal ans5 : std_logic_vector(15 downto 0);
  signal ans6 : std_logic_vector(15 downto 0);
  signal ans7 : std_logic_vector(15 downto 0);
  signal ans8 : std_logic_vector(15 downto 0);
  
  signal start: std_logic;

  
  signal state : std_logic_vector(3 downto 0);
  -- idle == 0000
  -- state_1 == 0001
  -- ..


  begin
    process(clk,rst)
    begin
      if(rst = '1') then
        state <= "0000";
        start <= '0';
        answer <= (15 downto 0 => '0');
        done_comp <= '0';

      elsif(clk'event and clk='1') then
        if start_comp = '1' and start = '0' then
          start <= '1';
          state <= "0001";

        elsif (start = '1') then
            if (state = "0001") then
              -- First Comparator Ports
              comparator_first_inp1 <= label1_out;
              comparator_first_inp2 <= label2_out;

              -- Second Comparator Ports
              comparator_second_inp1 <= label3_out;
              comparator_second_inp2 <= label4_out;

              -- Third Comparator Ports
              comparator_third_inp1 <= label5_out;
              comparator_third_inp2 <= label6_out;

              -- Forth Comparator Ports
              comparator_fourth_inp1 <= label7_out;
              comparator_fourth_inp2 <= label8_out;

              -- Fifth Comparator Ports
              comparator_fifth_inp1 <= label9_out;
              comparator_fifth_inp2 <= label10_out;
              
              -- state = next_state
              state <= "0010";

            elsif (state = "0010") then
              ans1 <= comparator_first_output;
              ans2 <= comparator_second_output;
              ans3 <= comparator_third_output;
              ans4 <= comparator_fourth_output;
              ans5 <= comparator_fifth_output;
              state <= "0011";

            elsif (state = "0011") then
              -- First Comparator Ports
              comparator_first_inp1 <= ans1;
              comparator_first_inp2 <= ans2;

              -- Second Comparator Ports
              comparator_second_inp1 <= ans3;
              comparator_second_inp2 <= ans4;

              -- Third Comparator Ports
              comparator_third_inp1 <= (others => '0');
              comparator_third_inp2 <= (others => '0');

              -- Forth Comparator Ports
              comparator_fourth_inp1 <= (others => '0');
              comparator_fourth_inp2 <= (others => '0');

              -- Fifth Comparator Ports
              comparator_fifth_inp1 <= label9_out;
              comparator_fifth_inp2 <= label10_out;

              -- state = next_state
              state <= "0100";
            
            elsif (state = "0100") then
              
              ans6 <= comparator_first_output;
              ans7 <= comparator_second_output;
              ans3 <= (others => '0');
              ans4 <= (others => '0');
              ans5 <= comparator_fifth_output;
              state <= "0101";
            
            elsif (state = "0101") then
              -- First Comparator Ports
              comparator_first_inp1 <= ans6;
              comparator_first_inp2 <= ans7;

              -- Second Comparator Ports
              comparator_second_inp1 <= (others => '0');
              comparator_second_inp2 <= (others => '0');

              -- Third Comparator Ports
              comparator_third_inp1 <= (others => '0');
              comparator_third_inp2 <= (others => '0');

              -- Forth Comparator Ports
              comparator_fourth_inp1 <= (others => '0');
              comparator_fourth_inp2 <= (others => '0');

              -- Fifth Comparator Ports
              comparator_fifth_inp1 <= label9_out;
              comparator_fifth_inp2 <= label10_out;

              -- state = next_state
              state <= "0110";
            
            elsif (state = "0110") then
              ans8 <= comparator_first_output;
              ans5 <= comparator_fifth_output;
              state <= "0111";

            elsif (state = "0111") then
               -- First Comparator Ports
               comparator_first_inp1 <= ans5;
               comparator_first_inp2 <= ans8;
 
               -- Second Comparator Ports
               comparator_second_inp1 <= (others => '0');
               comparator_second_inp2 <= (others => '0');
 
               -- Third Comparator Ports
               comparator_third_inp1 <= (others => '0');
               comparator_third_inp2 <= (others => '0');
 
               -- Forth Comparator Ports
               comparator_fourth_inp1 <= (others => '0');
               comparator_fourth_inp2 <= (others => '0');
 
               -- Fifth Comparator Ports
               comparator_fifth_inp1 <= (others => '0');
               comparator_fifth_inp2 <= (others => '0');
               
               -- state = next_state
               state <= "1000";
               
            elsif (state = "1000") then
              answer <= comparator_first_output;
              done_comp <= '1';
              state <= "0000";
            else
              state <= "0000";
	    end if;
        end if;
      end if;      
    end process;

    comparator_1: 
    entity work.comparator
    port map ( 
      comparator_inp_1  => comparator_first_inp1,
      comparator_inp_2  => comparator_first_inp2,
      comparator_output => comparator_first_output
    );

    comparator_2: 
    entity work.comparator
    port map ( 
      comparator_inp_1  => comparator_second_inp1,
      comparator_inp_2  => comparator_second_inp2,
      comparator_output => comparator_second_output
    );

    comparator_3: 
    entity work.comparator
    port map ( 
      comparator_inp_1  => comparator_third_inp1,
      comparator_inp_2  => comparator_third_inp2,
      comparator_output => comparator_third_output
    );

    comparator_4: 
    entity work.comparator
    port map ( 
      comparator_inp_1  => comparator_fourth_inp1,
      comparator_inp_2  => comparator_fourth_inp2,
      comparator_output => comparator_fourth_output
    );

    comparator_5: 
    entity work.comparator
    port map ( 
      comparator_inp_1  => comparator_fifth_inp1,
      comparator_inp_2  => comparator_fifth_inp2,
      comparator_output => comparator_fifth_output
    );

end architecture;



