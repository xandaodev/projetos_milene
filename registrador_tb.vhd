--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:52:49 12/04/2025
-- Design Name:   
-- Module Name:   /export/convidado/XANDINHOO/registrador_tb.vhd
-- Project Name:  XANDINHOO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: registrador_32
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
 
ENTITY registrador_tb IS
END registrador_tb;
 
ARCHITECTURE behavior OF registrador_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registrador_32
    PORT(
         e_reg : IN  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         preset : IN  std_logic;
         clear : IN  std_logic;
         enable : IN  std_logic;
         saida_reg : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal e_reg : std_logic_vector(31 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal preset : std_logic := '0';
   signal clear : std_logic := '0';
   signal enable : std_logic := '0';

 	--Outputs
   signal saida_reg : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registrador_32 PORT MAP (
          e_reg => e_reg,
          clk => clk,
          preset => preset,
          clear => clear,
          enable => enable,
          saida_reg => saida_reg
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

      clear <= '1';
		wait for clk_period*3;
		      clear <= '0';
		e_reg <= x"FFFFFFFF";
		enable <= '1';
      wait;
   end process;

END;
