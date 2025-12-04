--------------------------------------------------------------------------------
-- Company: 
-- Engineer: Xandão
--
-- Create Date:   15:19:37 12/04/2025
-- Design Name:   banco_registradores
-- Module Name:   banco_registradores_tb.vhd
-- Project Name:  XANDINHOO
-- Tool versions:  
-- Description:   Testbench simples para testar escrita e leitura em registradores.
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY banco_registradores_tb IS
END banco_registradores_tb;
 
ARCHITECTURE behavior OF banco_registradores_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT banco_registradores
    PORT(
         clk : IN  std_logic;
         escreverReg : IN  std_logic;
         dadoEscrita : IN  std_logic_vector(31 downto 0);
         endEscrita : IN  std_logic_vector(4 downto 0);
         endL1 : IN  std_logic_vector(4 downto 0);
         endL2 : IN  std_logic_vector(4 downto 0);
         dadoL1 : OUT  std_logic_vector(31 downto 0);
         dadoL2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

   -- Inputs
   signal clk : std_logic := '0';
   signal escreverReg : std_logic := '0';
   signal dadoEscrita : std_logic_vector(31 downto 0) := (others => '0');
   signal endEscrita : std_logic_vector(4 downto 0) := (others => '0');
   signal endL1 : std_logic_vector(4 downto 0) := (others => '0');
   signal endL2 : std_logic_vector(4 downto 0) := (others => '0');

   -- Outputs
   signal dadoL1 : std_logic_vector(31 downto 0);
   signal dadoL2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: banco_registradores PORT MAP (
          clk => clk,
          escreverReg => escreverReg,
          dadoEscrita => dadoEscrita,
          endEscrita => endEscrita,
          endL1 => endL1,
          endL2 => endL2,
          dadoL1 => dadoL1,
          dadoL2 => dadoL2
        );

   -- Clock process
   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- Aguarda início da simulação
      wait for 50 ns;

      ----------------------------------------------------------------------
      -- TESTE 1 : ESCREVER valor DEADBEEF NO REGISTRADOR 5 e LER
      ----------------------------------------------------------------------
      escreverReg <= '1';
      dadoEscrita <= x"DEADBEEF";
      endEscrita  <= "00101";   -- reg 5
      wait for clk_period * 3;      -- borda do clock

      escreverReg <= '0';       -- desabilita escrita
      endL1 <= "00101";
      endL2 <= "00001";
      wait for clk_period*3;

      ----------------------------------------------------------------------
      -- TESTE 2 : ESCREVER A5A5A5A5 NO REGISTRADOR 10 e LER
      ----------------------------------------------------------------------
      escreverReg <= '1';
      dadoEscrita <= x"A5A5A5A5";
      endEscrita  <= "01010";   -- reg 10
      wait for clk_period;

      escreverReg <= '0';
      endL1 <= "01010";
      endL2 <= "01010";
      wait for clk_period*3;

      ----------------------------------------------------------------------
      -- TESTE 3 : Ler valores diferentes (reg 5 e reg 10)
      ----------------------------------------------------------------------
      endL1 <= "00101"; -- reg 5
      endL2 <= "01010"; -- reg 10
      wait for clk_period*3;

      ----------------------------------------------------------------------
      -- FIM
      ----------------------------------------------------------------------
      wait;
   end process;

END behavior;
