library IEEE; use IEEE.std_logic_1164.all;

entity priority_encoder_behavioral_4_2 is
    port (valid: out std_logic; encoded: out std_logic_vector (1 downto 0); i3,i2,i1,i0: in std_logic);
end entity;

architecture behav of priority_encoder_behavioral_4_2 is
begin
     valid <= i3 or i2 or i1 or i0;
     encoded(1) <= (i3 or i2);
     encoded(0) <= (i3 or (i1 and (not i2))); 
end architecture behav;
