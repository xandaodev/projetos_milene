library IEEE;
use IEEE.STD_LOGIC_1164.all;

package tipo is
	subtype tipo_palavra is std_logic_vector(31 downto 0);
	type tipo_vetor_de_palavras is array (natural range <>) of tipo_palavra;
	type tipo_matriz_transposta is array (natural range <>) of std_logic_vector(0 to 31);
end package;