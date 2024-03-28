library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    Port ( clk    : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset  : in STD_LOGIC;
           address: in STD_LOGIC_VECTOR(2 downto 0);
           d      : in STD_LOGIC_VECTOR(3 downto 0);
           q      : out STD_LOGIC_VECTOR(3 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is
    type reg_array is array (7 downto 0) of STD_LOGIC_VECTOR(3 downto 0);
    signal registers : reg_array := (others => (others => '0'));
    signal selected_reg : STD_LOGIC_VECTOR(3 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            registers <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if enable = '1' then
                registers(to_integer(unsigned(address))) <= d;
            end if;
        end if;
    end process;

    selected_reg <= registers(to_integer(unsigned(address)));
    q <= selected_reg;
end Behavioral;

