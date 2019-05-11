LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
--------------------------------------------------
entity alu is
Generic (m : integer := 17);
Port(	
    A , B	: in  std_logic_vector(m-1 downto 0);
	S , cin : in  std_logic;
	F       : out std_logic_vector(m-1 downto 0) ;
	cout    :out std_logic);
			
end entity alu;
-------------------------------------------------------
Architecture AddBehavioral of alu is----------
-----------------------------------------------------
 component nadder is 
        Generic (n:integer :=8);
  port (a,b :in std_logic_vector(n-1 downto 0);
       cin :in std_logic;
       s:out std_logic_vector (n-1 downto 0);
       cout :out std_logic);
         end component ;
---------------------------------------------------------         
signal input1 : std_logic_vector(m-1 downto 0);
signal input2 : std_logic_vector(m-1 downto 0);
signal temp : std_logic;

--------------------------------------------------------------
begin----------------------------------------------
------------------------------------------------------
   PROCESS(A,B,Cin,S)    
          BEGIN   
	IF(S = '0') THEN  
	 input1 <=  a;
         input2 <= b;              --a+b
	 temp <='0';
------------------------------------		 	 
    ELSIF (S = '1') THEN 
      	 input1 <=  a;
         input2 <= not b;    --a-b
         temp <='1';  
---------------------------------------
	END IF;
    END PROCESS;
----------------------------------------
 n: nadder GENERIC MAP (m) port map (input1 ,input2,temp,f,cout);
---------------------------------------------------------------
end Architecture;
