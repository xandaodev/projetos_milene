LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY somadorextra_tb IS
END somadorextra_tb;

ARCHITECTURE behavior OF somadorextra_tb IS

    COMPONENT somador_extra2
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         resultado : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

   -- Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');

   -- Output
   signal resultado : std_logic_vector(31 downto 0);

BEGIN

   uut: somador_extra2 PORT MAP (
          A => A,
          B => B,
          resultado => resultado
        );

   stim_proc: process
   begin

      -- Teste 1
      A <= x"00000005";
      B <= x"00000003";
      wait for 20 ns;

      -- Teste 2
      A <= x"FFFFFFFF";
      B <= x"00000001";
      wait for 20 ns;

      -- Teste 3
      A <= x"0000AAAA";
      B <= x"00005555";
      wait for 20 ns;

      -- Teste 4
      A <= x"12345678";
      B <= x"11111111";
      wait for 20 ns;

      wait;
   end process;

END;
