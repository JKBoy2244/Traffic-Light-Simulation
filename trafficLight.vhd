library IEEE;
use IEEE.std_logic_1164.all;

entity trafficLight is 

  port (

    clk : in std_logic;
    reset : in std_logic;  --reset states the traffic light to red anytime
    flash_light : out std_logic_vector(2 downto 0) --Here, we are naming 4 state types which are red, red-amber, yellow, green which is the reference and each state type represents a 3 bit output (leading to 2 downto 0 vector)

 );

end trafficLight;

architecture behavioural of trafficLight is

  type state_type is (red, red_amber, amber, green); --This tells the 4 state types which control the traffic light system
  signal current_state, next_state : state_type; --This part tells you the behaviour of the traffic light system in terms of changes. Current state is the colour it shows now and next state is the colour it will show after the change

begin
  
  process(clk, reset)
  begin

    if (reset = '1') then
      current_state <= red;      --reset = 1 means reset has been enabled so hence, reset means the traffic light is set to red again
    elsif rising_edge(clk) then
      current_state <= next_state;  --state changes to the next colour
    end if;
  end process;

  
  process(current_state)
  begin

    case current_state is

      when red =>
      
        flash_light <= "100";       --Currently it's a red signal. so red = '1', red-amber = '0', green = '0'. amber = '0'.
        next_state <= red_amber;    --red_amber is next after the red signal changes.

      when red_amber =>
      
        flash_light <= "110";     --Currently it's a red signal. so red = '0', red-amber = '1', green = '0'. amber = '0'.
        next_state <= green;      --green is next after the red_amber signal changes.

      when green =>
        
        flash_light <= "001";     --Currently it's a red signal. so red = '0', red-amber = '0', green = '1'. amber = '0'.
        next_state <= amber;      --yellow is next after the green signal changes.
 
      when amber =>
        
        flash_light <= "010";     --Currently it's a red signal. so red = '0', red-amber = '0', green = '0'. amber = '1'.
        next_state <= red;        --red is next after the yellow signal changes.

    end case;
  end process;
end behavioural;
      

