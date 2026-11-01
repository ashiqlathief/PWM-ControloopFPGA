-- Self-checking testbench for the commutation lookup table (entity "lut").
--
-- Inputs a, b, c are the three Hall-sensor signals, d and e are the PWM-derived
-- inputs. All 32 input combinations are applied and the six outputs
-- (u v w x y z) are compared with the expected pattern.
--
-- The expected table below is a regression table taken from src/Commutation_Logic.vhd:
-- it locks in the current behaviour and catches accidental changes. It has not been
-- checked against the original design documents (see docs/commutation_truth_table.pdf).
--
-- Note: d = '1' forces all six outputs to '1', and the invalid Hall states
-- 000 and 111 also give all '1'.

library ieee;
use ieee.std_logic_1164.all;

entity commutation_logic_tb is
end commutation_logic_tb;

architecture behavior of commutation_logic_tb is

  component lut
    port (
      a : in  std_logic;
      b : in  std_logic;
      c : in  std_logic;
      d : in  std_logic;
      e : in  std_logic;
      u : out std_logic;
      v : out std_logic;
      w : out std_logic;
      x : out std_logic;
      y : out std_logic;
      z : out std_logic
    );
  end component;

  signal a, b, c, d, e : std_logic := '0';
  signal u, v, w, x, y, z : std_logic;
  signal got : std_logic_vector(5 downto 0);

  type table_t is array (0 to 31) of std_logic_vector(5 downto 0);

  -- Index = a*16 + b*8 + c*4 + d*2 + e; value = u v w x y z
  constant expected : table_t := (
    --  abcde
    "111111",  -- 00000
    "111111",  -- 00001
    "111111",  -- 00010 (d = 1)
    "111111",  -- 00011 (d = 1)
    "110011",  -- 00100
    "011110",  -- 00101
    "111111",  -- 00110 (d = 1)
    "111111",  -- 00111 (d = 1)
    "101110",  -- 01000
    "110101",  -- 01001
    "111111",  -- 01010 (d = 1)
    "111111",  -- 01011 (d = 1)
    "101011",  -- 01100
    "011101",  -- 01101
    "111111",  -- 01110 (d = 1)
    "111111",  -- 01111 (d = 1)
    "011101",  -- 10000
    "101011",  -- 10001
    "111111",  -- 10010 (d = 1)
    "111111",  -- 10011 (d = 1)
    "110101",  -- 10100
    "101110",  -- 10101
    "111111",  -- 10110 (d = 1)
    "111111",  -- 10111 (d = 1)
    "011110",  -- 11000
    "110011",  -- 11001
    "111111",  -- 11010 (d = 1)
    "111111",  -- 11011 (d = 1)
    "111111",  -- 11100 (invalid Hall state 111)
    "111111",  -- 11101 (invalid Hall state 111)
    "111111",  -- 11110 (d = 1)
    "111111"   -- 11111 (d = 1)
  );

begin

  uut : entity work.lut
    port map (
      a => a, b => b, c => c, d => d, e => e,
      u => u, v => v, w => w, x => x, y => y, z => z
    );

  got <= u & v & w & x & y & z;

  stim_proc : process
    variable errors : integer := 0;
  begin
    for i in 0 to 31 loop
      if ((i / 16) mod 2) = 1 then a <= '1'; else a <= '0'; end if;
      if ((i / 8)  mod 2) = 1 then b <= '1'; else b <= '0'; end if;
      if ((i / 4)  mod 2) = 1 then c <= '1'; else c <= '0'; end if;
      if ((i / 2)  mod 2) = 1 then d <= '1'; else d <= '0'; end if;
      if (i mod 2) = 1        then e <= '1'; else e <= '0'; end if;

      wait for 10 ns;

      if got /= expected(i) then
        errors := errors + 1;
        report "Mismatch for input combination " & integer'image(i) &
               " (a b c d e = index a*16+b*8+c*4+d*2+e)"
          severity error;
      end if;
    end loop;

    if errors = 0 then
      report "commutation_logic_tb: all 32 input combinations match" severity note;
    else
      report "commutation_logic_tb: " & integer'image(errors) & " mismatches"
        severity failure;
    end if;

    wait;
  end process;

end behavior;
