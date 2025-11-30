library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_BCD_Adder is
end entity tb_BCD_Adder;

architecture test of tb_BCD_Adder is

    signal SW   : std_logic_vector(9 downto 0) := (others => '0');
    signal LEDR : std_logic_vector(9 downto 0);
    signal HEX0 : std_logic_vector(6 downto 0);
    signal HEX1 : std_logic_vector(6 downto 0);

begin

    --------------------------------------------------------------------
    -- Instantiate the DUT (Device Under Test)
    --------------------------------------------------------------------
    DUT: entity work.BCD_Adder
        port map(
            SW   => SW,
            LEDR => LEDR,
            HEX0 => HEX0,
            HEX1 => HEX1
        );

    --------------------------------------------------------------------
    -- Test Process
    --------------------------------------------------------------------
    stim_proc : process
        variable X, Y : integer;
    begin

        -- Simple sweep of valid inputs X = 0..9, Y = 0..9
        for X in 0 to 9 loop
            for Y in 0 to 9 loop
                SW(7 downto 4) <= std_logic_vector(to_unsigned(X, 4)); -- X
                SW(3 downto 0) <= std_logic_vector(to_unsigned(Y, 4)); -- Y
                wait for 20 ns;
            end loop;
        end loop;

        -- A few error cases (X > 9 or Y > 9)
        SW(7 downto 4) <= "1010"; -- X = 10 (invalid)
        SW(3 downto 0) <= "0011"; -- Y = 3
        wait for 20 ns;

        SW(7 downto 4) <= "1100"; -- X = 12 (invalid)
        SW(3 downto 0) <= "1111"; -- Y = 15 (invalid)
        wait for 20 ns;

        SW(7 downto 4) <= "1001"; -- X = 9
        SW(3 downto 0) <= "1110"; -- Y = 14 (invalid)
        wait for 20 ns;

        wait;
    end process;

end architecture test;

