library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Register4Bit_TB is
-- Test bench has no ports.
end Register4Bit_TB;

architecture test of Register4Bit_TB is
    component Register4Bit
        Port ( clk    : in STD_LOGIC;
               enable : in STD_LOGIC;
               reset  : in STD_LOGIC;
               d      : in STD_LOGIC_VECTOR(3 downto 0);
               q      : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    signal clk    : STD_LOGIC := '0';
    signal enable : STD_LOGIC := '0';
    signal reset  : STD_LOGIC := '0';
    signal d      : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal q      : STD_LOGIC_VECTOR(3 downto 0);

begin
    uut: Register4Bit port map (
        clk => clk,
        enable => enable,
        reset => reset,
        d => d,
        q => q
    );

    -- Clock process definitions
    clk_process : process
    begin
        for i in 0 to 9 loop  -- Only generates 10 clock cycles
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
        wait;  -- Stops the simulation after 10 cycles
    end process

    -- Test process
    stim_proc: process
    begin        
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;

        d <= "1010";
        enable <= '1';
        wait for 40 ns;
        assert q = "1010" report "Test case 1 failed: q should be 1010" severity error;

        d <= "0101";
        enable <= '0';
        wait for 40 ns;
        assert q = "1010" report "Test case 2 failed: q should remain 1010" severity error;

        d <= "1111";
        enable <= '1';
        wait for 20 ns;
        assert q = "1111" report "Test case 3 failed: q should be 1111" severity error;

        report "End of simulation" severity note;
        wait; -- Stop the simulation
    end process;



