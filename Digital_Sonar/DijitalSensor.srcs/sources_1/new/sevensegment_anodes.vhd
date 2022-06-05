library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity sevensegment_anodes is
Port ( clk : in STD_LOGIC;
      seg_choose : out STD_LOGIC_VECTOR (3 downto 0);
      out_unit  : in unsigned(3 downto 0)  := (others => '0');
      out_decimal  : in unsigned(3 downto 0)  := (others => '0');
      segments : out STD_LOGIC_VECTOR (6 downto 0)
      );
end sevensegment_anodes;

architecture Behavioral of sevensegment_anodes is
 signal segment_counter : unsigned(15 downto 0) := (others => '0');
 signal digit :  unsigned(3 downto 0)  := (others => '0');

 begin

 process(clk)
    begin
        if rising_edge(clk) then
            
            if segment_counter(segment_counter'high) = '1' then
                digit <= out_unit;
                seg_choose   <= "1110";
            else
                digit <= out_decimal;
                seg_choose   <= "1101";
            end if;        
            segment_counter <= segment_counter +1; 
        end if;
    end process;
  end behavioral;