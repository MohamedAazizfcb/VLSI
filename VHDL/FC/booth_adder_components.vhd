LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY booth_adder_components IS
Generic (n:integer :=16);
	PORT (
               clk : in std_logic ;
               rst: in std_logic ; 
               set : IN  std_logic;
               done : out  std_logic;
	      neuron : in std_logic_vector(n-1 downto 0);
	      weight_0 : in std_logic_vector(n-1 downto 0);
              weight_1 : in std_logic_vector(n-1 downto 0);
              weight_2 : in std_logic_vector(n-1 downto 0);
              weight_3 : in std_logic_vector(n-1 downto 0);
              weight_4 : in std_logic_vector(n-1 downto 0);
              weight_5 : in std_logic_vector(n-1 downto 0);
              weight_6 : in std_logic_vector(n-1 downto 0);
              weight_7 : in std_logic_vector(n-1 downto 0);
	      weight_8 : in std_logic_vector(n-1 downto 0);
              weight_9 : in std_logic_vector(n-1 downto 0);
              -- output to regestir
              label_0 : out std_logic_vector(n-1 downto 0);
              label_1 : out std_logic_vector(n-1 downto 0);
              label_2 : out std_logic_vector(n-1 downto 0);
              label_3 : out std_logic_vector(n-1 downto 0);
              label_4 : out std_logic_vector(n-1 downto 0);
              label_5 : out std_logic_vector(n-1 downto 0);
              label_6 : out std_logic_vector(n-1 downto 0);
              label_7 : out std_logic_vector(n-1 downto 0);
	      label_8 : out std_logic_vector(n-1 downto 0);
              label_9 : out std_logic_vector(n-1 downto 0);

              adderInput_0 : in std_logic_vector(n-1 downto 0);
              adderInput_1 : in std_logic_vector(n-1 downto 0);
              adderInput_2 : in std_logic_vector(n-1 downto 0);
              adderInput_3 : in std_logic_vector(n-1 downto 0);
              adderInput_4 : in std_logic_vector(n-1 downto 0);
              adderInput_5 : in std_logic_vector(n-1 downto 0);
              adderInput_6 : in std_logic_vector(n-1 downto 0);
              adderInput_7 : in std_logic_vector(n-1 downto 0);
	      adderInput_8 : in std_logic_vector(n-1 downto 0);
              adderInput_9 : in std_logic_vector(n-1 downto 0);
	      
              dec_enable : out std_logic;
		dec_sel : out std_logic_vector (3 downto 0)
	     
                        
 );
END booth_adder_components;

ARCHITECTURE my_booth_adder_components OF booth_adder_components IS

signal shift_reg_output : std_logic_vector(n+3 downto 0);
-----------------------------------------------------------------------
signal temp_cout_0: std_logic;
signal temp_cout_1: std_logic;
signal temp_cout_2: std_logic;
signal temp_cout_3: std_logic;
signal temp_cout_4: std_logic;
signal temp_cout_5: std_logic;
signal temp_cout_6: std_logic;
signal temp_cout_7: std_logic;
signal temp_cout_8: std_logic;
signal temp_cout_9: std_logic;
-------------------------------------------------------------------
signal booth_integration_output_0 : std_logic_vector (2*n-1 downto 0);

-----------------------------------------------------------------------------------------------------------------------------------------
signal booth_integration_output_1 : std_logic_vector (2*n-1 downto 0);

-----------------------------------------------------------------------------------------------------------------------------------------
signal booth_integration_output_2 : std_logic_vector (2*n-1 downto 0);

-----------------------------------------------------------------------------------------------------------------------------------------
signal booth_integration_output_3 : std_logic_vector (2*n-1 downto 0);

-----------------------------------------------------------------------------------------------------------------------------------------
signal booth_integration_output_4 : std_logic_vector (2*n-1 downto 0);

-----------------------------------------------------------------------------------------------------------------------------------------
signal booth_integration_output_5 : std_logic_vector (2*n-1 downto 0);

-----------------------------------------------------------------------------------------------------------------------------------------
signal booth_integration_output_6 : std_logic_vector (2*n-1 downto 0);

-----------------------------------------------------------------------------------------------------------------------------------------
signal booth_integration_output_7 : std_logic_vector (2*n-1 downto 0);

-----------------------------------------------------------------------------------------------------------------------------------------
signal booth_integration_output_8 : std_logic_vector (2*n-1 downto 0);

-----------------------------------------------------------------------------------------------------------------------------------------
signal booth_integration_output_9 : std_logic_vector (2*n-1 downto 0);

-----------------------------------------------------------------------------------------------------------------------------------------
begin
shift_Reg_adder_0:entity work.shift_reg_adder  generic map (n+4) port map ( set, clk,shift_reg_output);
------------------------------------------------------------------------------------------------------------------------------------------
booth_integrtaion_0:entity work.booth_integration  generic map (n)port map ( set, clk , rst ,neuron,weight_0,booth_integration_output_0);
adder_0:entity work.nadder  generic map (n) port map (booth_integration_output_0(15 downto 0),  adderInput_0 , '0' ,label_0,temp_cout_0);
----------------------------------------------------------------------------------------------------------------------------------------------
booth_integrtaion_1:entity work.booth_integration  generic map (n)port map ( set, clk , rst ,neuron,weight_1,booth_integration_output_1);
adder_1:entity work.nadder  generic map (n) port map (booth_integration_output_1(15 downto 0),  adderInput_1 , '0' ,label_1,temp_cout_1);
----------------------------------------------------------------------------------------------------------------------------------------------
booth_integrtaion_2:entity work.booth_integration  generic map (n)port map ( set, clk , rst ,neuron,weight_2,booth_integration_output_2);
adder_2:entity work.nadder  generic map (n) port map (booth_integration_output_2(15 downto 0),  adderInput_2 , '0' ,label_2,temp_cout_2);
----------------------------------------------------------------------------------------------------------------------------------------------
booth_integrtaion_3:entity work.booth_integration  generic map (n)port map ( set, clk , rst ,neuron,weight_3,booth_integration_output_3);
adder_3:entity work.nadder  generic map (n) port map (booth_integration_output_3(15 downto 0),  adderInput_3 , '0' ,label_3,temp_cout_3);
----------------------------------------------------------------------------------------------------------------------------------------------
booth_integrtaion_4:entity work.booth_integration  generic map (n)port map ( set, clk , rst ,neuron,weight_4,booth_integration_output_4);
adder_4:entity work.nadder  generic map (n) port map (booth_integration_output_4(15 downto 0),  adderInput_4 , '0' ,label_4,temp_cout_4);
----------------------------------------------------------------------------------------------------------------------------------------------
booth_integrtaion_5:entity work.booth_integration  generic map (n)port map ( set, clk , rst ,neuron,weight_5,booth_integration_output_5);
adder_5:entity work.nadder  generic map (n) port map (booth_integration_output_5(15 downto 0),  adderInput_5 , '0' ,label_5,temp_cout_5);
----------------------------------------------------------------------------------------------------------------------------------------------
booth_integrtaion_6:entity work.booth_integration  generic map (n)port map ( set, clk , rst ,neuron,weight_6,booth_integration_output_6);
adder_6:entity work.nadder  generic map (n) port map (booth_integration_output_6(15 downto 0),  adderInput_6 , '0' ,label_6,temp_cout_6);
----------------------------------------------------------------------------------------------------------------------------------------------
booth_integrtaion_7:entity work.booth_integration  generic map (n)port map ( set, clk , rst ,neuron,weight_7,booth_integration_output_7);
adder_7:entity work.nadder  generic map (n) port map (booth_integration_output_7(15 downto 0),  adderInput_7 , '0' ,label_7,temp_cout_7);
----------------------------------------------------------------------------------------------------------------------------------------------
booth_integrtaion_8:entity work.booth_integration  generic map (n)port map ( set, clk , rst ,neuron,weight_8,booth_integration_output_8);
adder_8:entity work.nadder  generic map (n) port map (booth_integration_output_8(15 downto 0),  adderInput_8 , '0' ,label_8,temp_cout_8);
----------------------------------------------------------------------------------------------------------------------------------------------
booth_integrtaion_9:entity work.booth_integration  generic map (n)port map ( set, clk , rst ,neuron,weight_9,booth_integration_output_9);
adder_9:entity work.nadder  generic map (n) port map (booth_integration_output_9(15 downto 0),  adderInput_9 , '0' ,label_9,temp_cout_9);
------------------------------------------------------------------------------------------------------------------------------------------
 dec_enable <= shift_reg_output(n+2);
dec_sel <= "1111" when shift_reg_output(n+2)='1'
else  "0000" ;
done <= shift_reg_output(n+3);
------------------------------------------------------------------------------------------------------------------------------------------
END my_booth_adder_components;
