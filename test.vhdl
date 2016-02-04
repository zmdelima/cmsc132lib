library IEEE;
use IEEE.std_logic_1164.all;

entity adder is
    port (a, b, cin: in std_logic; s, cout: out std_logic);
end adder;

architecture rtl of adder is 
begin
    s <= a xor b xor cin;
    cout <= (a and b) or (cin and (a xor b));
end rtl;

