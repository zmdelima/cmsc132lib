--Authors:
	--Joseph Alcantara
	--Zydrick Delima

library IEEE;
use IEEE.std_logic_1164.all;

entity priority_encoder_8_3 is
	port(valid: out std_logic; encoded: out std_logic_vector (2 downto 0); i7, i6, i5, i4, i3, i2, i1, i0: in std_logic);
end entity;

architecture pr of priority_encoder_8_3 is
begin
	process (i7, i6, i5, i4, i3, i2, i1, i0) is
	begin
		if (i7 = '1') then encoded <= "111";
		elsif (i6 = '1') then encoded <= "110";
		elsif (i5 = '1') then encoded <= "101";
		elsif (i4 = '1') then encoded <= "100";
		elsif (i3 = '1') then encoded <= "011";
		elsif (i2 = '1') then encoded <= "010";
		elsif (i1 = '1') then encoded <= "001";
		else encoded <= "000";
		end if;

		if ((i7 = '1') or (i6 = '1') or (i5 = '1') or (i4 = '1') or (i3 = '1') or (i2 = '1') or (i1 = '1') or (i0 = '1')) 
			then valid <= '1';
		else 
			valid <= '0';
			encoded <= "XXX";
		end if;

	end process;
end architecture;