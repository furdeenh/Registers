library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_TB is
-- Testbench has no ports.
end Counter_TB;

architecture test of Counter_TB is
    -- Component declaration for the Unit Under Test (UUT)
    component Counter
        Port ( clk     : in STD_LOGIC;
               reset   : in STD_LOGIC;
               incdec  : in STD_LOGIC;
               q       : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    -- Signals for UUT
    signal clk    : STD_LOGIC := '0';
    signal reset  : STD_LOGIC := '0';
    signal incdec : STD_LOGIC := '0';
    signal q      : STD_LOGIC_VECTOR(3 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Counter port map (
        clk => clk,
        reset => reset,
        incdec => incdec,
        q => q
    );

    -- Clock process definitions
    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Test process
    stim_proc: process
    begin        
        -- Reset the counter
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
        wait for 20 ns;

        -- Check if the counter is reset to "0000"
        assert q = "0000" report "Counter reset failed" severity error;

        -- Increment the counter
        incdec <= '1'; -- Set to increment mode
        wait for 80 ns; -- Wait for 4 clock cycles

        -- Check if the counter has incremented correctly
        assert q = "0100" report "Counter increment failed" severity error;

        -- Decrement the counter
        incdec <= '0'; -- Set to decrement mode
        wait for 40 ns; -- Wait for 2 clock cycles

        -- Check if the counter has decremented correctly
        assert q = "0010" report "Counter decrement failed" severity error;

        -- Test wrap-around
        -- Increment to maximum value "1111"
        incdec <= '1';
        wait for 320 ns; -- Wait to reach max value
        assert q = "1111" report "Counter max value failed" severity error;

        -- Increment once more to check wrap-around to "0000"
        wait for 20 ns;
        assert q = "0000" report "Counter wrap-around increment failed" severity error;

        -- Decrement once to check wrap-around to "1111"
        incdec <= '0';
        wait for 20 ns;
        assert q = "1111" report "Counter wrap-around decrement failed" severity error;

        -- Finish the simulation
        report "End of simulation" severity note;
        wait;
    end process;
end test;

