library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AddSub4Bit_TB is
-- Testbench has no ports.
end AddSub4Bit_TB;

architecture test of AddSub4Bit_TB is
    signal A, B   : STD_LOGIC_VECTOR(3 downto 0);
    signal Op     : STD_LOGIC;
    signal Sum    : STD_LOGIC_VECTOR(3 downto 0);
    signal Overflow : STD_LOGIC;

begin
    uut: entity work.AddSub4Bit
        port map(
            A => A,
            B => B,
            Op => Op,
            Sum => Sum,
            Overflow => Overflow
        );

    -- Test stimulus
    process
    begin
        -- Test case 1: Addition
        A <= "0101"; B <= "0011"; Op <= '0'; wait for 20 ns;
        assert Sum = "1000" report "Addition failed for 0101 + 0011" severity error;

        -- Test case 2: Subtraction without overflow (7 - 1 = 6)
        A <= "0111"; B <= "0001"; Op <= '1'; wait for 20 ns;
        assert Sum = "0110" report "Subtraction failed for 0111 - 0001" severity error;

        -- Test case 3: Subtraction with overflow (0 - 1 = -1, in two's complement)
        A <= "0000"; B <= "0001"; Op <= '1'; wait for 20 ns;
        assert Sum = "1111" and Overflow = '1' report "Subtraction with overflow failed for 0000 - 0001" severity error;

        -- Test case 4: Subtraction with underflow (-8 - 1 = 7, in two's complement)
        A <= "1000"; B <= "0001"; Op <= '1'; wait for 20 ns;
        assert Sum = "0111" and Overflow = '1' report "Subtraction with underflow failed for 1000 - 0001" severity error;

        -- Test case 5: Addition with overflow (7 + 1 = 8, overflow from positive side)
        A <= "0111"; B <= "0001"; Op <= '0'; wait for 20 ns;
        assert Sum = "1000" and Overflow = '1' report "Addition with overflow failed for 0111 + 0001" severity error;

        -- End the simulation
        report "Simulation complete." severity note;
        wait;
    end process;
end test;
