library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    Port ( clk       : in STD_LOGIC;
           reset     : in STD_LOGIC;
           enable    : in STD_LOGIC_VECTOR(7 downto 0); -- Enable for each register
           address   : in STD_LOGIC_VECTOR(2 downto 0); -- Address to select which register
           data_in   : in STD_LOGIC_VECTOR(3 downto 0); -- Data input for selected register
           data_out  : out STD_LOGIC_VECTOR(3 downto 0) -- Data output from selected register
           );
end RegisterFile;

architecture Behavioral of RegisterFile is
    -- Signal declaration for internal register array
    type reg_array is array (0 to 7) of STD_LOGIC_VECTOR(3 downto 0);
    signal registers : reg_array := (others => (others => '0'));

    -- Component declaration of the 4-bit register
    component Register4Bit is
        Port ( clk    : in STD_LOGIC;
               enable : in STD_LOGIC;
               reset  : in STD_LOGIC;
               d      : in STD_LOGIC_VECTOR(3 downto 0);
               q      : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    -- Internal signals for the multiplexer
    signal selected_data_out : STD_LOGIC_VECTOR(3 downto 0);

begin
    -- Multiplexer for selecting which register to output
    selected_data_out <= registers(to_integer(unsigned(address)));

    -- Instantiate the 8 4-bit registers
    Gen_Registers: for i in 0 to 7 generate
        reg_inst : Register4Bit port map(
            clk => clk,
            enable => enable(i),
            reset => reset,
            d => data_in,
            q => registers(i)
        );
    end generate Gen_Registers;

    -- Assign the selected register output to the data_out
    data_out <= selected_data_out;

end Behavioral;

