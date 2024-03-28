library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AddSub4Bit is
    Port ( A        : in  STD_LOGIC_VECTOR(3 downto 0);
           B        : in  STD_LOGIC_VECTOR(3 downto 0);
           Op       : in  STD_LOGIC; -- '0' for add, '1' for subtract
           Sum      : out STD_LOGIC_VECTOR(3 downto 0);
           Overflow : out STD_LOGIC);
end AddSub4Bit;

architecture Behavioral of AddSub4Bit is
    signal extended_A : STD_LOGIC_VECTOR(4 downto 0);
    signal extended_B : STD_LOGIC_VECTOR(4 downto 0);
    signal result     : STD_LOGIC_VECTOR(4 downto 0);
begin
    extended_A(3 downto 0) <= A;
    extended_A(4) <= A(3);

    extended_B(3 downto 0) <= B when Op = '0' else not B;
    extended_B(4) <= B(3) when Op = '0' else not B(3);

    -- Perform addition or subtraction based on Op
    -- For subtraction, B is inverted (2's complement) and added to A
    result <= std_logic_vector(unsigned(extended_A) + unsigned(extended_B) + ("0000" & Op));

    Sum <= result(3 downto 0);
    Overflow <= result(4) xor result(3);
end Behavioral;
