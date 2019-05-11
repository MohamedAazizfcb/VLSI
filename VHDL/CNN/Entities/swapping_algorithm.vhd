library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity swap is
    Port ( enable : in  STD_LOGIC;   
           A,B,C: in STD_LOGIC_vector(15 downto 0);
           F : out  STD_LOGIC_VECTOR (15 downto 0) 
	  );    
end swap;

architecture Behavioral of swap is
    signal hold: std_logic_vector(15 downto 0);
begin
    process (enable,A,B,C)
    begin 

	if (enable'Event and enable = '1' ) then
	if ( A=C) then
                hold <= B;   
            elsif ( B=C) then
                hold <=A;
            end if;
	end if;

    end process;

    F <= hold;
end Behavioral;
