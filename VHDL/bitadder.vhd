LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

Entity BitAdder is
Port(A,B,Cin,en:in std_logic;
S,Cout:out std_logic
);
End Entity BitAdder;

Architecture dataflow_fulladder of BitAdder is
begin
	process(A,B,Cin,en)
	begin
	if en = '0' then
		S<=A;
		Cout<=Cin;
	else
		S <= (A xor B) xor Cin;
		Cout <= (Cin and (A xor B)) or (A and B);
	end if;
	End Process;
End Architecture;

