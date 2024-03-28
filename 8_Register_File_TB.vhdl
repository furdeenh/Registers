library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile_TB is
    -- Test bench has no ports.
end RegisterFile_TB;

architecture test of RegisterFile_TB is
    -- Component declaration for the Unit Under Test (UUT)
    component RegisterFile
        Port ( clk       : in STD_LOGIC;
               reset     : in STD_LOGIC;
               enable    : in STD_LOGIC_VECTOR(7 downto 0);
               address   : in STD_LOGIC_VECTOR(2 downto 0);
               data_in   : in STD_LOGIC_VECTOR(3 downto 0);
               data_out  : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    -- Signals for UUT
    signal clk       : STD_LOGIC := '0';
    signal reset     : STD_LOGIC := '0';
    signal enable    : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal address   : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal data_in   : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal data_out  : STD_LOGIC_VECTOR(3 downto 0);

    -- Clock process definitions
    clk_process: process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: RegisterFile port map (
        clk => clk,
        reset => reset,
        enable => enable,
        address => address,
        data_in => data_in,
        data_out => data_out
    );

    -- Test process
    stim_proc: process
    begin
        -- Reset the register file
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
        wait for 40 ns;

        -- Test writing and reading from each register
        for i in 0 to 7 loop
            -- Set address and enable line for current register
            address <= std_logic_vector(to_unsigned(i, address'length));
            enable <= (others => '0');
            enable(i) <= '1';  -- Enable only the current register
            
            -- Test data pattern for current register
            data_in <= std_logic_vector(to_unsigned(i, data_in'length));
            
            -- Wait two clock cycles between operations
            wait for 40 ns;

            -- Check that the correct register has been written to
            assert data_out = std_logic_vector(to_unsigned(i, data_out'length))
            report "Register write test failed for register at address " & integer'image(i) severity error;

            -- Disable writing for the next test
            enable <= (others => '0');
            
            -- Wait two clock cycles between operations
            wait for 40 ns;
        end loop;

        -- Test is complete
        report "End of Register File test bench simulation" severity note;
        wait;  -- Terminate the simulation
    end process;

end test;



