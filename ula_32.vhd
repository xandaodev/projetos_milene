----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:54:58 11/04/2025 
-- Design Name: 
-- Module Name:    ula_32 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ula_32 is
	port(
		a : in std_logic_vector (31 downto 0); -- mudei pra downto
        b : in std_logic_vector (31 downto 0); -- mudei pra downto
		Ainverte, Binverte : in std_logic;
		op : in std_logic_vector(1 downto 0);--alexandre - corrigi auqi pra um vetor de 2 
		result : out std_logic_vector (31 downto 0); -- mudei pra downto
		zero : out std_logic
	);
end ula_32;

architecture Behavioral of ula_32 is

--ULA 1 BIT
	component ula1bit is
		port(
			A_ula, B_ula, vem1_ula, less, Ainverte, Binverte : in std_logic;
			op_ula : in std_logic_vector(1 downto 0); -- alexandre - corrigido para 2 bits
			vai1_ula, resultado_ula, set_ula : out std_logic
		);
	end component;
    
--OR 32 ENTRADAS
	component porta_or_32 is
    port(
    	e : in std_logic_vector (31 downto 0);--corrigido para downto
		saida : out std_logic
    );
    end component;
   
signal vaivem: std_logic_vector(31 downto 0);--mudei aqui tmb
signal or_result : std_logic; -- novo : sinal para a saida da porta or
begin

--PRIMEIRA ULA
ula_0: ula1bit port map(
	Ainverte => Ainverte,
    Binverte => Binverte,
    op_ula => op,
    
    vem1_ula => Binverte,
    
    A_ula => a(0),
    B_ula => b(0),
    less => vaivem(31),
   
    vai1_ula => vaivem(0),
    resultado_ula => result(0)
);

--ULAS INTERMEDIARIAS

gen_ulas : for i in 1 to 30 generate
	ulas: ula1bit port map(
      Ainverte => Ainverte,
      Binverte => Binverte,
      op_ula => op,

      vem1_ula => vaivem(i-1),

      A_ula => a(i),
      B_ula => b(i),
      less => '0',

      vai1_ula => vaivem(i),
      resultado_ula => result(i)
    );
    end generate;
    
--ULTIMA ULA
ula_31: ula1bit port map(
	Ainverte => Ainverte,
    Binverte => Binverte,
    op_ula => op,
    
    vem1_ula => vaivem(30),
    
    A_ula => a(31),
    B_ula => b(31),
    less => '0',
   
    set_ula => vaivem(31),	--só muda isso
    resultado_ula => result(31)
);

--RESULTADO FINAL
resultado_or_32: porta_or_32 port map(
  e => result,
  saida => or_result
);
--alexandre mudanças
zero <= not or_result;


end Behavioral;

-- erro que ta dando aqui: ERROR:HDLParsers:1411 - "/export/convidado/modulo_processador/ula_32.vhd" Line 119. Parameter result of mode out can not be associated with a formal port of mode in.


