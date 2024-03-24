library IEEE;
use IEEE.std_logic_1164.all;

entity reg_tb is
end entity reg_tb;

architecture behavior of reg_tb is
    component reg
        port(
            d : in std_logic_vector(7 downto 0);
            en, clk, reset : in std_logic;
            q : out std_logic_vector(7 downto 0)
        );
    end component;
    
    signal d : std_logic_vector(7 downto 0) := (others => '0');
    signal en, clk, reset : std_logic := '0';
    
    signal q : std_logic_vector(7 downto 0);

    constant clk_period : time := 10 ns;

begin
    uut: reg port map (d => d, en => en, clk => clk, reset => reset, q => q);

    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    stim_proc: process
    begin        
        wait for 100 ns;    
        
        en <= '1'; 
        d <= "00001111"; 
        wait for clk_period*10;
        
        en <= '0'; 
        d <= "11110000"; 
        wait for clk_period*10;
        
        en <= '1'; 
        wait for clk_period*10;
        
        wait;
    end process;

end architecture;