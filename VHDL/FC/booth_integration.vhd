LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
ENTITY booth_integration IS
Generic (n:integer :=16);
     PORT(   set: in std_logic;
             clk : in std_logic;
	     rst : in std_logic;
             M,R : in std_logic_vector(n-1 downto 0);
	     booth_output : out std_logic_vector(2*n-1 downto 0)
	     
);
END booth_integration;

ARCHITECTURE my_booth_integration OF booth_integration IS
signal shift_reg_output : std_logic_vector(n-7 downto 0);
signal S,A,p_initial,cmp_add_sub_output: std_logic_vector(2*n downto 0);
signal R_twos_complement : std_logic_vector (n-1 downto 0);
signal p_reg_input,p_reg_output : std_logic_vector (2*n downto 0);
signal p_reg_en : std_logic;
BEGIN 
---------------- initialization
p_initial <= (p_initial'length downto M'length+2=>'0')&M&'0';
a <= R&(R'length downto 0 =>'0');
Twos_Complement:entity work.Twos_Complement  generic map (n) port map ( R,R_twos_complement);
--R_twos_complement <= (not R) + '1';
s <= R_twos_complement&(R_twos_complement'length downto 0=>'0');
p_reg_en <= not (shift_reg_output(n-7));
-------------------------------
shift_Reg:entity work.shift_reg  generic map (n-6) port map ( set, clk , rst ,shift_reg_output);
cmp_add_sub:entity work.compare_add_sub  generic map (2*n+1)port map ( p_reg_output, A , S ,cmp_add_sub_output);  
p_Reg:entity work.my_nDFF  generic map (2*n+1) port map (clk,rst,p_reg_input,p_reg_output,p_reg_en);
p_reg_input<=p_initial when shift_reg_output(0) = '1'
else cmp_add_sub_output when shift_reg_output(0) = '0';
booth_output <= p_reg_output(2*n downto 1);
END my_booth_integration;
