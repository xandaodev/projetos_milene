----------------------------------------------------------------------------------
-- Company: 
-- Engineer: xandão e xandona
-- 
-- Create Date:    14:02:36 11/11/2025 
-- Design Name: 
-- Module Name:    decod_5_32 - Behavioral 
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

entity decod_5_32 is
port(
	e_decod : in std_logic_vector(4 downto 0);
	sel : in std_logic;
	resultado_decod : out std_logic_vector(31 downto 0)--alexandre  - mudei aqui
);
end decod_5_32;

architecture Behavioral of decod_5_32 is
	component decod_2_4 is
		port(
			e : in std_logic_vector(0 to 1);
			sel : in std_logic;
			resultado_4 : out std_logic_vector(0 to 3)
		);
	end component;

signal not4, saida_and0, saida_and1 : std_logic;
signal saida_decod0 : std_logic_vector(0 to 3);
signal saida_decod1 : std_logic_vector(0 to 3);

begin

not4 <= not e_decod(4);

--primeira coluna
saida_and0 <= not4 and sel;
saida_and1 <= e_decod(4) and sel;

--segunda coluna
decod0 : decod_2_4 port map(
	sel => saida_and0,
	e(0) => e_decod(2),
	e(1) => e_decod(3),
	resultado_4 => saida_decod0
);

decod1 : decod_2_4 port map(
	sel => saida_and1,
	e(0) => e_decod(2),
	e(1) => e_decod(3),
	resultado_4 => saida_decod1
);

--terceira coluna

gen_decods0 : for i in 0 to 3 generate
	decod0 : decod_2_4 port map(	
			sel => saida_decod0(i),
			e(0) => e_decod(0),
			e(1) => e_decod(1),
			--resultado_4 => resultado_decod(4*i to 4*i+3)
			resultado_4 => resultado_decod(4*i+3 downto 4*i) -- alexandre - mudança necessaria devido a outras nudanças
);
end generate;

gen_decods1 : for i in 0 to 3 generate
	decod1 : decod_2_4 port map(	
			sel => saida_decod1(i),
			e(0) => e_decod(0),
			e(1) => e_decod(1),
			--resultado_4 => resultado_decod(4*i+16 to 4*i+19)
			resultado_4 => resultado_decod(4*i+19 downto 4*i+16) -- alexandre - mudança necessaria devido a outras nudanças
);
end generate;


end Behavioral;


