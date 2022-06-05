library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity distance_sensor is
    Port ( clk         : in  STD_LOGIC;
           trigger     : out STD_LOGIC;
           echo        : in  STD_LOGIC;
           seg_choose     : out STD_LOGIC_VECTOR (3 downto 0);
           segments    : out STD_LOGIC_VECTOR (6 downto 0);
           buzzer : out STD_LOGIC := '0';
           distance_slc : in STD_LOGIC_VECTOR (2 downto 0) := "000"
           );

end distance_sensor;
 
architecture Behavioral of distance_sensor is
   
       signal count  : unsigned(16 downto 0) := (others => '0');
       signal cm    : unsigned(15 downto 0) := (others => '0');
       signal cm_unit : unsigned(3 downto 0)  := (others => '0');
       signal cm_decimal  : unsigned(3 downto 0)  := (others => '0');
       signal out_unit    : unsigned(3 downto 0)  := (others => '0');
       signal out_decimal : unsigned(3 downto 0)  := (others => '0');
       signal digit  : unsigned(3 downto 0)  := (others => '0');
       signal echo_last  : std_logic := '0';
       signal echo_current  : std_logic := '0';
       signal echo_not_current : std_logic := '0';
       signal waitt  : std_logic := '0'; 
       signal segment_counter : unsigned(15 downto 0) := (others => '0');

       COMPONENT sevensegment_decoder
       Port ( digit : in unsigned (3 downto 0);
              segments : out STD_LOGIC_VECTOR (6 downto 0)
             );
       END COMPONENT;      
       
       begin
         decoder : sevensegment_decoder PORT MAP (digit => digit, 
         segments => segments);
              
       seven_seg: process(clk)
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
 
process(clk)
    begin
        if rising_edge(clk) then
            
            if waitt = '0' then
                
                if count = 1000 then  -- 10us trigger
                   trigger     <= '0';
                   waitt     <= '1';
                   count       <= (others => '0');
                else
                   trigger <= '1';
                   count <= count+1;
                end if;
            
            elsif echo_last = '0' and echo_current = '1' then
                count <= (others => '0');
                cm  <= (others => '0');
                cm_unit <= (others => '0');
                cm_decimal  <= (others => '0');
            
            elsif echo_last = '1' and echo_current = '0' then
                out_unit <= cm_unit; 
                out_decimal <= cm_decimal;  
                       
                if distance_slc = "001" then         
                   if (cm_decimal < "0001") then
                    buzzer <= '1';
                  
                   else
                    buzzer <= '0';               
                   end if;    
                
                 elsif distance_slc = "010" then 
                    if (cm_decimal <"0010") then
                     buzzer <= '1';
                     
                    else
                      buzzer <= '0';               
                    end if;    
                                                         
                  elsif distance_slc = "100" then 
                    if (cm_decimal <"0011") then
                     buzzer <= '1';
                    
                    else 
                     buzzer <= '0';               
                    end if;
                 
                  else 
                   buzzer <= '0';                 
                  end if;
            
            elsif count = 5799 then --5800-1 distance = time/58
                
                if cm_unit = 9 then
                    cm_unit <= (others => '0');
                    cm_decimal  <= cm_decimal + 1;
                else
                    cm_unit <= cm_unit + 1;
                end if;
                
                cm <= cm + 1;
                count <= (others => '0');
                
                if cm = 3448 then
                    waitt <= '0';
                end if;
            
            else
                count <= count + 1;                
            
            end if;
            
            echo_last  <= echo_current;
            echo_current <= echo_not_current;
            echo_not_current <= echo;
        
        end if;
 
    end process;
      end Behavioral;