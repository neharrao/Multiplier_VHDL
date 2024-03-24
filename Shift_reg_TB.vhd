library IEEE;
use IEEE.std_logic_1164.all;

entity shift_reg_tb is
end shift_reg_tb;

architecture behavior of shift_reg_tb is

    component shift_reg is
        Port (
            clk         : in std_logic;
            reset       : in std_logic;
            load        : in std_logic;
            data_in     : in std_logic_vector(3 downto 0);
            data_out    : out std_logic_vector(3 downto 0)
        );
    end component;
    
    signal clk      : std_logic := '0';
    signal reset    : std_logic := '0';
    signal load     : std_logic := '0';
    signal data_in  : std_logic_vector(3 downto 0) := (others => '0');
    signal data_out : std_logic_vector(3 downto 0);

begin

    uut: shift_reg
        port map (
            clk => clk,
            reset => reset,
            load => load,
            data_in => data_in,
            data_out => data_out
        );

    clocking_process : process
    begin
        while true loop
            clk <= '0';
            wait for 10 ns; 
            clk <= '1';
            wait for 10 ns; 
        end loop;
    end process clocking_process;

    stim_proc : process
    begin
        reset <= '1';
        wait for 20 ns; 
        reset <= '0';

        data_in <= "1001";
        load <= '0'; 
        wait for 20 ns;

        load <= '1';
        wait for 60 ns; 

        load <= '0';
        wait for 40 ns; 

        load <= '1';
        wait for 40 ns; 

        wait;
    end process stim_proc;

end behavior;