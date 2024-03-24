library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shift_adder_tb is
end shift_adder_tb;

architecture behavior of shift_adder_tb is
    component shift_adder is
        Port (
            clk        : in std_logic;
            reset      : in std_logic;
            load       : in std_logic;
            d          : in std_logic_vector(7 downto 0);
            augend_tb  : in std_logic_vector(7 downto 0);
            sum_tb     : out std_logic_vector(7 downto 0)
        );
    end component;

    signal clk        : std_logic := '0';
    signal reset      : std_logic := '0';
    signal load       : std_logic := '0';
    signal d          : std_logic_vector(7 downto 0) := (others => '0');
    signal augend_tb  : std_logic_vector(7 downto 0) := (others => '0');

    signal sum_tb     : std_logic_vector(7 downto 0);

    constant clk_period : time := 10 ns;

begin
    uut: shift_adder
        port map (
            clk => clk,
            reset => reset,
            load => load,
            d => d,
            augend_tb => augend_tb,
            sum_tb => sum_tb );

    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    stim_proc: process
    begin
        reset <= '1'; 
        wait for clk_period * 2;
        reset <= '0'; 
        wait for clk_period;

        load <= '1';
        d <= "10011011";
        wait for clk_period;
        load <= '0';

        wait for clk_period * 8;
 
        augend_tb <= "00100110"; 
        wait for clk_period;

        wait;
    end process;

end behavior;