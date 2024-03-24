library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplier_tb is
end entity multiplier_tb;

architecture behavior of multiplier_tb is
    component multiplier is
        port (
            clk, reset : in std_logic;
            multiplicand, multiplier : in std_logic_vector(7 downto 0);
            product : out std_logic_vector(8 downto 0)
              );
    end component;

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';  -- renamed to avoid conflict with 'reset' within the multiplier
    signal mplier : std_logic_vector(7 downto 0) := (others => '0');  -- renamed to avoid conflict with 'multiplier'
    signal mcand : std_logic_vector(7 downto 0) := (others => '0');  -- renamed to avoid conflict with 'multiplicand'

    signal prod : std_logic_vector(8 downto 0);

    constant clk_period : time := 10 ns;

begin
    uut: multiplier
        port map (
            clk => clk,
            reset => rst,
            multiplicand => mcand,
            multiplier => mplier,
            product => prod
        );

    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    stim_proc: process
    begin
        wait for clk_period * 2;
        rst <= '0';

        -- Test Case a) 1101 x 1010
        mcand <= "00001101";
        mplier <= "00001010";
        wait for clk_period * 10; 
        assert prod = "1111010" report "Test case a) failed" severity error;

        rst <= '1';
        wait for clk_period * 2;
        rst <= '0';
        
        -- Test Case b) 1111 x 1111
        mcand <= "00001111";
        mplier <= "00001111";
        wait for clk_period * 10; 
        assert prod = "11100001" report "Test case b) failed" severity error;
        
        rst <= '1';
        wait for clk_period * 2;
        rst <= '0';

        -- Test Case c) 1111 x 0000
        mcand <= "00001111";
        mplier <= "00000000";
        wait for clk_period * 10; 
        assert prod = "00000000" report "Test case c) failed" severity error;

        assert false report "End of Testbench" severity failure;
        
    end process;
end architecture behavior;