library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity buzzer_warning is
 Port( buzzer_in : in std_logic;
       buzzer_warn: out std_logic
       );
end buzzer_warning;

architecture Behavioral of buzzer_warning is

begin

buzzer_warn <= buzzer_in;

end Behavioral;
