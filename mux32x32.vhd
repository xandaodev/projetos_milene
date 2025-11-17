library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.tipo.all;

entity mux32x32 is
	port (
		E : in tipo_vetor_de_palavras(0 to 31);
		Sel : in std_logic_vector(4 downto 0);
		Saida : out tipo_palavra
	);
end mux32x32;

architecture arq of mux32x32 is
    component mux_32 is
        port (
            E : in std_logic_vector(0 to 31);
            Sel : in std_logic_vector(4 downto 0);
            Saida : out std_logic
        );
    end component;
    
	signal matriz_invertida : tipo_matriz_transposta(31 downto 0);
begin    
	genM : for i in 0 to 31 generate
    	-- transformar as palavras do vetor de palavras em colunas de uma matriz. 
        -- Assim, as linhas da matriz passam a ser o enesimo bit de cada palavra
    	gen_colunas: for j in 31 downto 0 generate 
            matriz_invertida(i)(j) <= E(j)(i);
        end generate;
        
    	mux : mux_32 port map (
        	E => matriz_invertida(i),
            Sel => Sel,
            Saida => Saida(i)
        );
    end generate;

end arq;
