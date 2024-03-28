library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile_TB is
-- Testbench has no ports.
end RegisterFile_TB;

architecture test of RegisterFile_TB is
    signal clk    : STD_LOGIC := '0';
    signal enable : STD_LOGIC := '0';
    signal reset  : STD_LOGIC := '0';
    signal address: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal d      : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal q      : STD_LOGIC_VECTOR(3 downto 0);

    component RegisterFile is
        Port ( clk    : in STD_LOGIC;
               enable : in STD_LOGIC;
               reset  : in STD_LOGIC;
               address: in STD_LOGIC_VECTOR(2 downto 0);
               d      : in STD_LOGIC_VECTOR(3 downto 0);
               q      : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

begin
    uut: RegisterFile port map (
        clk => clk,
        enable => enable,
        reset => reset,
        address => address,
        d => d,
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
        -- Reset the register file
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;

        -- Test the register file behavior
        for i in 0 to 7 loop
            -- Write to the register
            address <= std_logic_vector(to_unsigned(i, 3));
            d <= std_logic_vector(to_unsigned(i+1, 4)); -- Write a unique value to each register
            enable <= '1';
            wait for 20 ns;
            enable <= '0'; -- Disable to hold the value

            -- Read from the register and check
            address <= std_logic_vector(to_unsigned(i, 3));
            wait for 20 ns;
            assert q = std_logic_vector(to_unsigned(i+1, 4)) report "Register read failed" severity error;
        end loop;

        -- End the simulation
        report "Simulation complete." severity note;
        wait;
    end process;
end test;
