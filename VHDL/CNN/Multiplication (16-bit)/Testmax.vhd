library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity TestnMax is
end TestnMax;

architecture TestBenchArch of TestnMax is

  type buffRE is array (0 to 199) of std_logic_vector(31 downto 0);
  type buffOP is array (0 to 199) of std_logic_vector(15 downto 0);
  signal inputArrayM : buffOP;
  signal inputArrayR : buffOP;
  signal ResultArray : buffRE;
  signal M,R:std_logic_vector(15 downto 0);
  signal result :std_logic_vector(31 downto 0);
  signal clk,set,rst : std_logic;
begin
  maxEnt : entity work.booth_integration generic map(16) port map (set,clk,rst,M,R,result); --modified

  process
  begin
    inputArrayM <= 
      ( x"2264", x"8f8b", x"9aa2", x"2354", x"b10c", x"2657", x"2516", x"6aec", x"aa38", x"aa71", x"4d6b", x"2d41", x"88a0", x"6db3", x"875e", x"85ae", x"9e1c", x"899f", x"b09e", x"ca53", x"7649", x"206d", x"926d", x"2ed2", x"18f1", x"0d7d", x"ebd8", x"d6b0", x"724e", x"fb0e", x"44e8", x"5d7e", x"7cf8", x"3a89", x"ffae", x"5935", x"9587", x"6658", x"4218", x"95bc", x"051c", x"8389", x"686b", x"1742", x"7608", x"7e62", x"bb7b", x"ea10", x"7601", x"df50", x"1419", x"1e2a", x"6f44", x"36ec", x"5e09", x"000d", x"4a5d", x"680c", x"9ce5", x"8f2c", x"0886", x"73ad", x"61ae", x"4f83", x"3d1b", x"5e2a", x"1c59", x"e068", x"1de5", x"fb14", x"a71f", x"7088", x"3feb", x"cdd4", x"3bac", x"cf05", x"f3ef", x"5ecf", x"774a", x"3362", x"a6ad", x"5e7a", x"6765", x"8995", x"2a85", x"26ef", x"9ad3", x"c38a", x"b723", x"171b", x"2d40", x"5d9b", x"37e4", x"e45e", x"7b43", x"ae25", x"06fd", x"b4c4", x"6288", x"aa02", x"c3a7", x"1836", x"1f54", x"11ee", x"0198", x"11b3", x"9f87", x"af30", x"27c5", x"f0ad", x"0a57", x"d699", x"f756", x"9d04", x"0d68", x"9f89", x"69a8", x"318c", x"da56", x"2ebb", x"6e10", x"f006", x"c279", x"b39d", x"a3b5", x"d42e", x"96b3", x"a733", x"08b4", x"e532", x"4e8a", x"f1b1", x"b0da", x"2f90", x"10c2", x"2a47", x"aa3a", x"9916", x"d0b1", x"d868", x"cbdf", x"17b2", x"b6ea", x"e209", x"ca36", x"b9a8", x"cacb", x"e22b", x"7d41", x"9d9c", x"d137", x"120a", x"9509", x"2ec7", x"fe36", x"7ea0", x"c820", x"9b0f", x"f2ff", x"6d37", x"3456", x"604e", x"8773", x"2424", x"c639", x"77ad", x"b9de", x"a848", x"e270", x"2204", x"0f1e", x"6d3d", x"3321", x"6864", x"9aad", x"8c62", x"8304", x"ba5a", x"3ee2", x"5d3d", x"52dd", x"e524", x"9848", x"9f61", x"b48a", x"9856", x"86ce", x"d929", x"c1da", x"5888", x"bf93", x"a1a7", x"cbfc", x"eef4", x"8892", x"5213", x"f9b2", x"ff8f", x"2678", x"9c32");
    inputArrayR <= 
    	( x"d41e", x"8066", x"a1e4", x"44e8", x"c672", x"0b39", x"bc82", x"1a90", x"0c19", x"3138", x"3541", x"a08d", x"1098", x"a52e", x"68a5", x"1ebc", x"a488", x"7a79", x"c2be", x"0c2d", x"4aec", x"31a4", x"58f0", x"993d", x"d4a7", x"886b", x"73ee", x"7ac7", x"bc74", x"b57c", x"0802", x"19b6", x"8bf7", x"c1df", x"57cb", x"5ef0", x"7e64", x"3f96", x"86f7", x"c0f1", x"d82b", x"cfe7", x"58a1", x"f3f1", x"2901", x"1ad7", x"ca23", x"4f07", x"4be4", x"9431", x"2ef2", x"2bc1", x"dc78", x"4e84", x"38a2", x"becf", x"8e44", x"c474", x"bfd1", x"dc46", x"8227", x"6c5b", x"ae09", x"6107", x"727c", x"76f6", x"3166", x"e72d", x"1536", x"8cb5", x"144a", x"c791", x"137b", x"6235", x"8e4a", x"c252", x"697b", x"3465", x"17c1", x"6289", x"2efa", x"3f35", x"94ed", x"95b0", x"e53e", x"aca7", x"3845", x"6825", x"77c5", x"5134", x"64e7", x"0ea9", x"abbc", x"7f3c", x"fdbf", x"25a0", x"e7b3", x"daeb", x"0bd4", x"9808", x"f1e3", x"ca06", x"bb44", x"b8ef", x"b973", x"00e4", x"3591", x"376b", x"ecaa", x"3185", x"f505", x"a4c5", x"db0e", x"e0dc", x"a575", x"36b5", x"aa5d", x"d3f0", x"d79c", x"5686", x"2c6a", x"c58b", x"bb91", x"976f", x"91de", x"db2f", x"ec4e", x"03d4", x"eb4f", x"12e5", x"b652", x"52d7", x"e58f", x"eb44", x"c5e4", x"4e03", x"828b", x"6c99", x"6f4a", x"cc2c", x"c6e8", x"c85e", x"28f4", x"48ba", x"1210", x"eac6", x"4cf4", x"7edb", x"29f2", x"595a", x"5e6b", x"bb81", x"1a58", x"fca8", x"2d4e", x"e39e", x"b934", x"6c05", x"e576", x"63eb", x"72e5", x"5b4c", x"6457", x"2bb6", x"0ccb", x"37f7", x"7696", x"4023", x"bc4b", x"da83", x"c385", x"fb5a", x"0268", x"0964", x"d4df", x"114f", x"9bb3", x"047b", x"26ff", x"8558", x"b193", x"c05c", x"3376", x"687c", x"d5b5", x"f040", x"6654", x"6b3b", x"20e3", x"93bd", x"c34c", x"67bc", x"493f", x"7cb5", x"94f4", x"532f", x"7798", x"34c3", x"46d8", x"8fed");
    resultArray <= 
    	( x"fa1ad7b8", x"380db162", x"25439a48", x"09825420", x"11c01f58", x"01ae465f", x"f638fd2c", x"0b181cc0", x"fbf23f78", x"ef8ce9b8", x"101acf2b", x"ef208ccd", x"f8431f00", x"d915152a", x"ceb06f96", x"f1508fc8", x"22f9eee0", x"c75dd227", x"12fed144", x"fd727497", x"229e254c", x"0649a2d4", x"d9eebe30", x"ed34aa0a", x"fbc6d937", x"f9b30b3f", x"f6df4ad0", x"ec2fc2d0", x"e1d71358", x"017080c8", x"0227c9d0", x"0963c594", x"c75b3b48", x"f1cb4657", x"ffe3e0fa", x"211517b0", x"cb6edabc", x"196b9f90", x"e0c05528", x"1a2cf5fc", x"ff347bb4", x"1762779f", x"2426734b", x"fee78b22", x"12e7be08", x"0d40184e", x"0e6aafd1", x"f93a5670", x"22fb63e4", x"0dc3fe50", x"03af7da2", x"0527cbaa", x"f08e97e0", x"10d839b0", x"14cd79b2", x"fffcb083", x"def656b4", x"e7cc5570", x"18d8f1f5", x"0fbef608", x"fbcf586a", x"30f61a7f", x"e0b9b31e", x"1e22cf95", x"1b539f14", x"2bc1d85c", x"05785476", x"03104a48", x"027a174e", x"02377524", x"f8f4baf6", x"e7317508", x"04dd26e9", x"ecc0c4e4", x"e57ea7b8", x"0bcd199a", x"fb073ad5", x"136773ab", x"0b1194ca", x"13c70372", x"ef9bdaf2", x"17539542", x"d4c11c81", x"312d4f70", x"fb8e4536", x"f352f9e9", x"e9c2e2df", x"e76752f2", x"dde932ef", x"07543c7c", x"11d5d4c0", x"055c4553", x"ed9a5770", x"f2442808", x"feea2dfd", x"f3f83020", x"ff562de7", x"0ae5d7ec", x"048d70a0", x"22ec8010", x"0353b415", x"fae52d44", x"f796ae50", x"fb05cd32", x"ff8f8f48", x"000fc36c", x"ebd04e77", x"ee818910", x"fcff04d2", x"fd0926e1", x"ff8e76b3", x"0ec127bd", x"014018b4", x"0c0a6f70", x"fb422888", x"eb62b1dd", x"dca7f208", x"f778d740", x"05f14668", x"0fcb47e2", x"131852a0", x"03a5f142", x"10728989", x"1f337c13", x"27b47bf6", x"064d4e72", x"0819ee8a", x"feac0f3c", x"ff4beb8c", x"fe0589ba", x"e9654434", x"fb5eada7", x"082ccbc6", x"fc25d240", x"fc3236c8", x"0ce220d5", x"2a08e17e", x"d457c626", x"eb6f122a", x"080411e0", x"0ba03c18", x"fad9c35c", x"f44ee708", x"f77cc28a", x"fc346f60", x"05d527f0", x"f0018d7c", x"f137a4c9", x"1485d072", x"dda8a4d8", x"eebea3fd", x"fb2c650a", x"f4fe2518", x"ff639698", x"ffaef274", x"f1f606c0", x"0f73c680", x"d5685b4b", x"01591c8a", x"2aa0867d", x"177d1cee", x"22585128", x"d0bff415", x"062bbd98", x"fd1cdb33", x"1a29a2eb", x"df833c14", x"ea0601d8", x"07d196d0", x"fb04d00c", x"fc6db496", x"fe043672", x"007b0768", x"03d44b10", x"111200b3", x"f82ed43e", x"30f807cc", x"fec7f13e", x"09942f1e", x"d353bdf8", x"e69d61e7", x"06ad58f0", x"eb268930", x"d8909afc", x"0c777792", x"0660b580", x"cf8e4f98", x"efbb2f73", x"f804244e", x"da8f7468", x"0f46d8a4", x"d9c4e7a4", x"f11e0f04", x"f7b22284", x"31f09328", x"1aab3a7d", x"fd0dffb0", x"ffe8b5ed", x"0aa54540", x"2bb1884a");     

    set <= '0';
	rst<='0';
    
    wait for 100 ps;
   

    l1: for i in 199 downto 0 loop
          M <= inputArrayM(i);
          R <= inputArrayR(i);

          set <= '1';
		  
          wait for 2000 ps;  --modified
          assert result = ResultArray(i)
          report "Fail out label "
          severity error;
          set <= '0';
          wait for 100 ps;
    end loop;
   report "TestDone";
   
   wait;
  end process;

  process
  begin
    clk <= '1';
    wait for 50 ps;
    clk <= '0';
    wait for 50 ps;
  end process;
end TestBenchArch;

