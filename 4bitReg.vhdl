library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Register4Bit is
    Port ( clk    : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset  : in STD_LOGIC;
           d      : in STD_LOGIC_VECTOR(3 downto 0);
           q      : out STD_LOGIC_VECTOR(3 downto 0));
end Register4Bit;

architecture Behavioral of Register4Bit is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            q <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                q <= d;
            end if;
        end if;
    end process;
end Behavioral;

