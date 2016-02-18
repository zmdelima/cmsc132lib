library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_priority_encoder_4_2 is
	constant MAX_COMB: integer := 16;
	constant DELAY: time := 10 ns;
end entity;

architecture pr of tb_priority_encoder_4_2 is

	component priority_encoder_behavioral_4_2 is
		port (valid: out std_logic; encoded: out std_logic_vector (1 downto 0); i3,i2,i1,i0: in std_logic);
	end component;
	
	signal valid: std_logic;
	signal encoded: std_logic_vector (1 downto 0);
	signal i3,i2,i1,i0: std_logic;
	
begin --architecture

	uut: component priority_encoder_behavioral_4_2 port map (valid, encoded, i3,i2,i1,i0);
	main: process is
	
			variable temp: unsigned(3 downto 0);
			variable expected_valid: std_logic;
			variable expected_encoded: std_logic_vector(1 downto 0);
			variable error_count: integer := 0;
			
	begin --process
	
		report "start simulation";
		
		for i in 0 to 15 loop
			temp := TO_UNSIGNED(i, 4);
			--assign each input a value from temp
			i3 <= temp(3);
			i2 <= temp(2);
			i1 <= temp(1);
			i0 <= temp(0);
			
			if (i=0) then 
					expected_valid := '0';
					expected_encoded := "XX";
			else
				expected_valid := '1';
				if(i = 1) then expected_encoded := "00";
				elsif (i <= 3 ) then expected_encoded := "01";
				elsif (i <= 7 ) then expected_encoded := "10";
				else expected_encoded := "11";
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



