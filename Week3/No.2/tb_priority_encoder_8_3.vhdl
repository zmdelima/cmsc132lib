--Authors:
	--Joseph Alcantara
	--Zydrick Delima

library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_priority_encoder_8_3 is
	constant MAX_COMB: integer := 256;
	constant DELAY: time := 10 ns;
end entity;

architecture pr of tb_priority_encoder_8_3 is

	component priority_encoder_8_3 is
		port(valid: out std_logic; encoded: out std_logic_vector (2 downto 0); i7, i6, i5, i4, i3, i2, i1, i0: in std_logic);
	end component;
	
	signal valid: std_logic;
	signal encoded: std_logic_vector (2 downto 0);
	signal i7,i6,i5,i4,i3,i2,i1,i0: std_logic;
	
begin --architecture

	uut: component priority_encoder_8_3 port map(valid, encoded, i7,i6,i5,i4,i3,i2,i1,i0);
	main: process is
	
			variable temp: unsigned(7 downto 0);
			variable expected_valid: std_logic;
			variable expected_encoded: std_logic_vector(2 downto 0);
			variable error_count: integer := 0;
			
	begin --process
	
		report "start simulation";
		
		for i in 0 to 255 loop
			temp := TO_UNSIGNED(i, 8);
			--assign each input a value from temp
			i7 <= temp(7);
			i6 <= temp(6);
			i5 <= temp(5);
			i4 <= temp(4);
			i3 <= temp(3);
			i2 <= temp(2);
			i1 <= temp(1);
			i0 <= temp(0);
			
			if (i=0) then 
					expected_valid := '0';
					expected_encoded := "XXX";
			else
				expected_valid := '1';
				if(i = 1) then expected_encoded := "000";
				elsif (i <= 3 ) then expected_encoded := "001";
				elsif (i <= 7 ) then expected_encoded := "010";
				elsif (i <= 15 ) then expected_encoded := "011";
				elsif (i <= 31 ) then expected_encoded := "100";
				elsif (i <= 63 ) then expected_encoded := "101";
				elsif (i <= 127 ) then expected_encoded := "110";
				else expected_encoded := "111";
				end if;
			end if;
			wait for DELAY;
			
			assert((expected_valid = valid) and (expected_encoded = encoded))
				report "ERROR: Expected Valid " & std_logic'image(expected_valid)& " and encoded " &
					std_logic'image(expected_encoded(1)) & std_logic'image(expected_encoded(0)) & " /= actual valid " & 
					std_logic'image(valid) & " and encoded " & std_logic'image(encoded(1)) & std_logic'image(encoded(0)) &
					" at time " & time'image(now);
				
			if  ((expected_valid /= valid) and (expected_encoded /= encoded))
				then error_count := error_count + 1;
			end if;
		end loop;
		
		wait for DELAY;
		assert (error_count = 0)
			report "ERROR: There were " &
				integer'image(error_count) & " errors!";
			if(error_count = 0)
				then report "Simulation completed with NO errors.";
			end if;
		wait;
	end process;
end architecture;

--CHOICES:
--take note, some other answers to the blanks are not included below:

--1) component priority_encoder_4_2 port map(valid, encoded, i3,i2,i1,i0);
--2) tb_arch
--3) tb_priority_encoder_4_2
--4) port (valid: out std_logic; encoded: out std_logic_vector(1 downto 0); i3,i2,i1,i0: in std_logic );