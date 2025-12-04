--------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Milene
--
-- Create Date:   16:11:34 08/13/2024
-- Design Name:   
-- Module Name:   MIPS_32bits_tb.vhd
-- Project Name:  mips_digital
-- 
-- VHDL Test Bench Created by ISE for module: MIPS_32bits
-- 
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY MIPS_32bits_tb IS
END MIPS_32bits_tb;
 
ARCHITECTURE behavior OF MIPS_32bits_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT XANDINHO --aqui
    PORT(
         debugEndereco : IN  std_logic_vector(31 downto 0);
         debugPalavra : OUT  std_logic_vector(31 downto 0);
         clk : IN  std_logic;--aqui
         inicializar : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal DebugEndereco : std_logic_vector(31 downto 0) := (others => '0');
   signal Clock : std_logic := '0';
   signal Inicializar : std_logic := '0';

 	--Outputs
   signal DebugPalavra : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clock_period : time := 10 ns;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: XANDINHO PORT MAP (--aqui
          debugEndereco => DebugEndereco,
          debugPalavra => DebugPalavra,
          clk => Clock,
          inicializar => Inicializar
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clock_period*10;

      -- insert stimulus here 
		
		-- Inicializa o processador colocando o endereco inicial da memoria no PC
		-- Aguarda um pulso de clock e desativa a inicializacao
		Inicializar <= '1';
		wait for Clock_period;
		Inicializar <= '0';
		
		-- Espera por 50 pulsos de clock - numero aproximado para executar todo o 
		-- programa que gera as 10 primeiras posicoes da sequencia de fibonacci
		wait for Clock_period*50;
		
		-- Exibe as 11 primeiras posicoes da memoria de dados
		for i in 0 to 10 loop
			DebugEndereco <= std_logic_vector(to_unsigned(i*4,32));
			wait for Clock_period;
		end loop;

      wait;
   end process;

END;
