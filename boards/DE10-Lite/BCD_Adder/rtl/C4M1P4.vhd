library ieee;
use ieee.std_logic_1164.all;

entity BCD_Adder is
    port(
        SW    : in  std_logic_vector(9 downto 0);  -- SW9..SW0
        LEDR  : out std_logic_vector(9 downto 0);  -- LEDs
        HEX0  : out std_logic_vector(6 downto 0);  -- ones digit
        HEX1  : out std_logic_vector(6 downto 0)   -- tens digit
    );
end entity BCD_Adder;

architecture logic_only of BCD_Adder is

    --------------------------------------------------------------------
    -- Inputs to adder
    --------------------------------------------------------------------
    signal X, Y : std_logic_vector(3 downto 0);  -- X = SW7..4, Y = SW3..0

    --------------------------------------------------------------------
    -- Ripple-carry adder outputs
    --------------------------------------------------------------------
    signal V          : std_logic_vector(3 downto 0);  -- 4-bit sum
    signal c1, c2, c3 : std_logic;
    signal Cout       : std_logic;                     -- carry out

    --------------------------------------------------------------------
    -- Part II-style internal signals (reused)
    --------------------------------------------------------------------
    signal A    : std_logic_vector(3 downto 0);  -- Circuit A (V-10 for 10..15)
    signal Y0   : std_logic_vector(3 downto 0);  -- original d0 from Part II (0..9)
    signal z    : std_logic;                     -- comparator (>9) from Part II
    signal D1_IN : std_logic_vector(3 downto 0); -- original tens input (0 or 1)

    --------------------------------------------------------------------
    -- Extra logic for 16..19 correction
    --------------------------------------------------------------------
    signal Y16   : std_logic_vector(3 downto 0); -- ones digit for sums 16..19
    signal d0_bin: std_logic_vector(3 downto 0); -- final ones digit to HEX0
    signal d1_bin: std_logic_vector(3 downto 0); -- final tens digit to HEX1

    --------------------------------------------------------------------
    -- Error detection
    --------------------------------------------------------------------
    signal Xgt9, Ygt9, err : std_logic;

    --------------------------------------------------------------------
    -- 7-seg patterns before error blanking (same Font 1 as Part II)
    --------------------------------------------------------------------
    signal HEX0_digit : std_logic_vector(6 downto 0);
    signal HEX1_digit : std_logic_vector(6 downto 0);

begin

    --------------------------------------------------------------------
    -- Map switches to X, Y
    --------------------------------------------------------------------
    X <= SW(7 downto 4);
    Y <= SW(3 downto 0);

    --------------------------------------------------------------------
    -- Error: X > 9 or Y > 9
    --------------------------------------------------------------------
    Xgt9 <= X(3) and (X(2) or X(1));
    Ygt9 <= Y(3) and (Y(2) or Y(1));
    err  <= Xgt9 or Ygt9;

    LEDR(9) <= err;            -- error indicator
    LEDR(7 downto 5) <= "000"; -- unused

    --------------------------------------------------------------------
    -- 4-bit ripple-carry adder using your FA, Cin = SW(8)
    --------------------------------------------------------------------
    FA0: entity work.FA
        port map(
            A    => X(0),
            B    => Y(0),
            Cin  => SW(8),
            S    => V(0),
            Cout => c1
        );

    FA1: entity work.FA
        port map(
            A    => X(1),
            B    => Y(1),
            Cin  => c1,
            S    => V(1),
            Cout => c2
        );

    FA2: entity work.FA
        port map(
            A    => X(2),
            B    => Y(2),
            Cin  => c2,
            S    => V(2),
            Cout => c3
        );

    FA3: entity work.FA
        port map(
            A    => X(3),
            B    => Y(3),
            Cin  => c3,
            S    => V(3),
            Cout => Cout
        );

    -- Show raw sum + carry on LEDs
    LEDR(4) <= Cout;
    LEDR(3 downto 0) <= V;

    --------------------------------------------------------------------
    -- >>> PART II LOGIC REUSED ON V (0..15) <<<
    -- Comparator z, Circuit A, and MUX to produce Y0 (ones digit 0..9)
    --------------------------------------------------------------------

    -- Comparator: z = 1 for V=10..15
    z <= V(3) and (V(2) or V(1));

    -- Circuit A: (V - 10) for V=10..15
    -- A0 = V0
    -- A1 = V2 and not V1
    -- A2 = V2 and V1
    -- A3 = '0'
    A(0) <= V(0);
    A(1) <= V(2) and (not V(1));
    A(2) <= V(2) and V(1);
    A(3) <= '0';

    -- 4-bit MUX:
    -- Y0 = V when z=0
    -- Y0 = A when z=1
    Y0(0) <= ((not z) and V(0)) or (z and A(0));
    Y0(1) <= ((not z) and V(1)) or (z and A(1));
    Y0(2) <= ((not z) and V(2)) or (z and A(2));
    Y0(3) <= ((not z) and V(3)) or (z and A(3));

    -- Original tens digit input from Part II:
    -- D1_IN = 0000 for V<=9
    -- D1_IN = 0001 for V>=10
    D1_IN <= "000" & z;

    --------------------------------------------------------------------
    -- >>> EXTENSION TO 19 USING Cout <<<
    -- For sums 16..19, V = 0..3 and Cout='1'
    -- Desired ones digit (decimal):
    --   V=0 -> 6   (0110)
    --   V=1 -> 7   (0111)
    --   V=2 -> 8   (1000)
    --   V=3 -> 9   (1001)
    -- Boolean for these 4 cases (using V1,V0):
    --   bit3 = V1
    --   bit2 = not V1
    --   bit1 = not V1
    --   bit0 = V(0)
    --------------------------------------------------------------------
    Y16(3) <= V(1);
    Y16(2) <= not V(1);
    Y16(1) <= not V(1);
    Y16(0) <= V(0);

    -- Final ones digit:
    --  For Cout='0' (sum <=15): use Y0 (Part II result)
    --  For Cout='1' (sum 16..19): use Y16
    d0_bin(3) <= ((not Cout) and Y0(3)) or (Cout and Y16(3));
    d0_bin(2) <= ((not Cout) and Y0(2)) or (Cout and Y16(2));
    d0_bin(1) <= ((not Cout) and Y0(1)) or (Cout and Y16(1));
    d0_bin(0) <= ((not Cout) and Y0(0)) or (Cout and Y16(0));

    -- Final tens digit (0 or 1):
    --  Part II gave tens=1 when z=1 (V>=10)
    --  For sums 16..19, Cout='1' so tens must be 1 regardless of z.
    d1_bin(3 downto 1) <= "000";
    d1_bin(0) <= D1_IN(0) or Cout;

    --------------------------------------------------------------------
    -- HEX0: 7-seg decoder for ones digit (d0_bin)
    -- Active-LOW, Font 1 (DE10-Lite), order: "a b c d e f g"
    --------------------------------------------------------------------
    with d0_bin select
        HEX0_digit <=
            "1000000" when "0000", -- 0
            "1111001" when "0001", -- 1
            "0100100" when "0010", -- 2
            "0110000" when "0011", -- 3
            "0011001" when "0100", -- 4
            "0010010" when "0101", -- 5
            "0000010" when "0110", -- 6
            "1111000" when "0111", -- 7
            "0000000" when "1000", -- 8
            "0010000" when "1001", -- 9
            "1111111" when others; -- off

    --------------------------------------------------------------------
    -- HEX1: 7-seg decoder for tens digit (d1_bin = 0 or 1)
    --------------------------------------------------------------------
    with d1_bin select
        HEX1_digit <=
            "1000000" when "0000", -- 0
            "1111001" when "0001", -- 1
            "1111111" when others; -- off

    --------------------------------------------------------------------
    -- ERROR BLANKING: when err=1, blank both HEX displays
    --------------------------------------------------------------------
    with err select
        HEX0 <= "1111111" when '1',
                HEX0_digit when others;

    with err select
        HEX1 <= "1111111" when '1',
                HEX1_digit when others;

end architecture logic_only;
