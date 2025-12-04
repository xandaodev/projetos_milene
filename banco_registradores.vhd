--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:19:37 12/04/2025
-- Design Name:   
-- Module Name:   /export/convidado/XANDINHOO/banco_registradores_tb.vhd
-- Project Name:  XANDINHOO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: banco_registradores
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
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
    

   --Inputs
   signal clk : std_logic := '0';
   signal escreverReg : std_logic := '0';
   signal dadoEscrita : std_logic_vector(31 downto 0) := (others => '0');
   signal endEscrita : std_logic_vector(4 downto 0) := (others => '0');
   signal endL1 : std_logic_vector(4 downto 0) := (others => '0');
   signal endL2 : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
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

   -- Clock process definitions
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
