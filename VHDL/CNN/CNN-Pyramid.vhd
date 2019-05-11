LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY CNN_Pyramid is 
GENERIC (n:integer :=16; np:integer :=32);
PORT ( 	clk,set,conv,five: in std_logic;
	filter_arrin : in std_logic_vector(399 downto 0);
	window_arr0,window_arr1,window_arr2,window_arr3,window_arr4 : in std_logic_vector(79 downto 0);
	bias: in std_logic_vector(n-1 downto 0);
	new_pixel : out std_logic_vector(n-1 downto 0)

);
END CNN_Pyramid;

ARCHITECTURE cnn_pyramid_arc OF cnn_pyramid IS


type np_array is array (natural range <>) of std_logic_vector(np-1 DOWNTO 0);
signal mul_arr,mux_arr : np_array(24 DOWNTO 0);
signal add1_arr : np_array(11 DOWNTO 0);
signal add2_arr : np_array(5 DOWNTO 0);
signal add3_arr : np_array(2 DOWNTO 0);
signal add4_arr : np_array(1 DOWNTO 0);
signal rc0_temp,rc1_temp,bias_ext : std_logic_vector(np-1 downto 0);
signal rc0,rc1,nall : std_logic_vector(n-1 downto 0);
signal nall4 : std_logic_vector(3 downto 0);
signal nall2 : std_logic_vector(1 downto 0);
BEGIN

--nallvec: entity work.my_nDFF GENERIC MAP (n) PORT MAP (clk,'1',nall ,nall,'0');
--nallvec4: entity work.my_nDFF GENERIC MAP (4) PORT MAP (clk,'1',nall4 ,nall4,'0');
--nallvec2: entity work.my_nDFF GENERIC MAP (2) PORT MAP (clk,'1',nall2 ,nall2,'0');

mul_loop: FOR i IN 0 TO 4 GENERATE 	
	mul_bank0: entity work.booth_integration_c1 PORT MAP(set,clk,filter_arrin(16*i+15  downto 16*i),    window_arr0(16*i+15 downto 16*i),mul_arr(i)    ); 
	mul_bank1: entity work.booth_integration_c1 PORT MAP(set,clk,filter_arrin(16*i+95  downto 16*i+80), window_arr1(16*i+15 downto 16*i),mul_arr(i+5)  ); 
	mul_bank2: entity work.booth_integration_c1 PORT MAP(set,clk,filter_arrin(16*i+175 downto 16*i+160),window_arr2(16*i+15 downto 16*i),mul_arr(i+10) ); 
	mul_bank3: entity work.booth_integration_c1 PORT MAP(set,clk,filter_arrin(16*i+255 downto 16*i+240),window_arr3(16*i+15 downto 16*i),mul_arr(i+15) ); 
	mul_bank4: entity work.booth_integration_c1 PORT MAP(set,clk,filter_arrin(16*i+335 downto 16*i+320),window_arr4(16*i+15 downto 16*i),mul_arr(i+20) );
END GENERATE;


--mul_sign_loop: for i in 0 to 24 generate mul_arr(i)(np-1) <= filter_arrin(8*i+7); END GENERATE;

mux_loop: FOR i IN 0 TO 4 GENERATE
	mux_bank0: entity work.mux2_c1 PORT MAP (window_arr0(16*i+15 downto 16*i),nall,mul_arr(i), conv, mux_arr(i));
	mux_bank1: entity work.mux2_c1 PORT MAP (window_arr1(16*i+15 downto 16*i),nall,mul_arr(i+5), conv, mux_arr(i+5));
	mux_bank2: entity work.mux2_c1 PORT MAP (window_arr2(16*i+15 downto 16*i),nall,mul_arr(i+10), conv, mux_arr(i+10));
	mux_bank3: entity work.mux2_c1 PORT MAP (window_arr3(16*i+15 downto 16*i),nall,mul_arr(i+15), conv, mux_arr(i+15));
	mux_bank4: entity work.mux2_c1 PORT MAP (window_arr4(16*i+15 downto 16*i),nall,mul_arr(i+20), conv, mux_arr(i+20));

END GENERATE;

add1_loop: FOR i IN 0 TO 11 GENERATE
	add1_bank:entity work.nadder_c1 GENERIC MAP (np) PORT MAP (mux_arr(2*i),mux_arr(2*i+1), add1_arr(i)); 
END GENERATE;

add2_loop: FOR i IN 0 TO 5 GENERATE
	add2_bank:entity work.nadder_c1 GENERIC MAP (np) PORT MAP (add1_arr(2*i),add1_arr(2*i+1), add2_arr(i)); 
END GENERATE;

add3_loop: FOR i IN 0 TO 2 GENERATE
	add3_bank:entity work.nadder_c1 GENERIC MAP (np) PORT MAP (add2_arr(2*i),add2_arr(2*i+1), add3_arr(i)); 
END GENERATE;

add4_1: entity work.nadder_c1 GENERIC MAP (np) PORT MAP (add3_arr(0),add3_arr(1), add4_arr(0));
add4_2: entity work.nadder_c1 GENERIC MAP (np) PORT MAP (add3_arr(2),mux_arr(24), add4_arr(1));

add5: entity work.nadder_c1 GENERIC MAP (np) PORT MAP (add4_arr(0),add4_arr(1),rc0_temp);

bias_ext <= nall & bias;
nall <= X"0000";
nall4 <= "0000";
nall2 <= "00";

add6: entity work.nadder_c1 GENERIC MAP (np) PORT MAP (rc0_temp, bias_ext, rc1_temp);

rc0 <= 	rc0_temp(np-1) & nall4 & rc0_temp(np-1 downto np-11) when (five = '1') else
		rc0_temp(np-1) & nall2 & rc0_temp(np-1 downto np-13); --what does the sign bit really add? does this allow negative pixels?

rc1 <= 	rc1_temp(np-1 downto np-16) when (rc1_temp(np-1) = '0') else nall;   --zero if negative

new_pixel <= rc0 when (conv='0') else rc1;

END cnn_pyramid_arc;
