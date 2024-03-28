library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter is
    Port ( clk     : in STD_LOGIC;
           reset   : in STD_LOGIC;
           incdec  : in STD_LOGIC;  -- '1' for increment, '0' for decrement
           q       : out STD_LOGIC_VECTOR(3 downto 0));
end Counter;

architecture Structural of Counter is
    signal internal_reg : STD_LOGIC_VECTOR(3 downto 0);
    signal next_value   : STD_LOGIC_VECTOR(3 downto 0);
    component Register4Bit
        Port ( clk    : in STD_LOGIC;
               enable : in STD_LOGIC;
               reset  : in STD_LOGIC;
               d      : in STD_LOGIC_VECTOR(3 downto 0);
               q      : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

begin
    -- Instantiate the 4-bit Register
    reg_inst: Register4Bit
        port map ( clk => clk, enable => '1', reset => reset, d => next_value, q => internal_reg );

    -- Logic to determine the next value of the counter based on incdec and reset signals
    process(clk, reset)
    begin
        if reset = '1' then
            next_value <= (others => '0');
        elsif rising_edge(clk) then
            case incdec is
                when '1' =>  -- Increment
                    next_value <= std_logic_vector(unsigned(internal_reg) + 1) mod 16;
                when '0' =>  -- Decrement
                    next_value <= std_logic_vector(unsigned(internal_reg) - 1) mod 16;
                when others => 
                    next_value <= internal_reg; -- Hold value in case of undefined incdec
            end case;
        end if;
    end process;

    -- Output assignment
    q <= internal_reg;

end Structural;

