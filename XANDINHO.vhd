----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Xandão e Xandona
-- 
-- Create Date:    14:38:16 11/25/2025 
-- Design Name: 
-- Module Name:    xandinho - Behavioral 
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

entity xandinho is
port(
	clk, inicializar : in std_logic;
	debugEndereco : in std_logic_vector (9 downto 2);
	debugPalavra : out std_logic (9 downto 2)
);
end xandinho;

architecture Behavioral of xandinho is
--pc
	component pc_component is
		port(
			ini, clk : in std_logic;
			entrada : in std_logic_vector(31 downto 0);
			saida : out std_logic_vector(31 dowto 0)
		);
		end component;
--memInstrucoes
	component memInstrucoes is
	port (
		Endereco : in std_logic_vector(31 downto 0);
		Palavra : out std_logic_vector(31 downto 0)
	);
end component;
	
--unidade_controle
	component unidade_controle is
    port(
        op_uc : in std_logic_vector(5 downto 0); 
        ALU_op_uc : out std_logic_vector (1 downto 0); 
        reg_write, reg_dst, ALU_src, branch, mem_write, mem_toReg, jump, mem_read : out std_logic
    );
end component;
--mux2
	component mux2 is
	port(
		A, B, s: in std_logic;
		resultado : out std_logic
	);
end component;
--banco_registradores
	component banco_registradores is
    port(
        clk, escreverReg : in std_logic;
        dadoEscrita : in std_logic_vector (31 downto 0); -- alexandre - mudei pra down to 
        endEscrita : in std_logic_vector (4 downto 0); -- mudei

        endL1 : in std_logic_vector(4 downto 0);
        endL2 : in std_logic_vector(4 downto 0);

        dadoL1 : out std_logic_vector(31 downto 0); 
        dadoL2 : out std_logic_vector(31 downto 0)
    );
end component;

--extensor_sinal
	component extensor_sinal is
    port(
        entrada_16 : in std_logic_vector (15 downto 0);
        saida_32   : out std_logic_vector (31 downto 0)
    );
end component;
--uc_ula
	component uc_ula is
    port(
    ALU_op : in std_logic_vector (1 downto 0);
    funct : in std_logic_vector (5 downto 0);
    Ainverte, Binverte : out std_logic;
    operacao : out std_logic_vector (1 downto 0)
    );
end component;
--ula_32
	component ula_32 is
	port(
		a : in std_logic_vector (31 downto 0); -- mudei pra downto
        b : in std_logic_vector (31 downto 0); -- mudei pra downto
		Ainverte, Binverte : in std_logic;
		op : in std_logic_vector(1 downto 0);--alexandre - corrigi auqi pra um vetor de 2 
		result : out std_logic_vector (31 downto 0); -- mudei pra downto
		zero : out std_logic
	);
end component;
--memDados
	component memDados is
	port (
		DadoLido : out std_logic_vector (31 downto 0);
		DadoEscrita : in std_logic_vector (31 downto 0);
		Endereco : in std_logic_vector (31 downto 0);
		EscreverMem : in std_logic;
		Clock : in std_logic;
		LerMem : in std_logic;
		DebugEndereco : in std_logic_vector(31 downto 0);
		DebugPalavra : out std_logic_vector(31 downto 0));
end component;
--somador
	component somador is
	port(
	A, B : in std_logic;
	vai1, saida : out std_logic
	);
end component;
--deslocador_2
	component deslocador_2 is
    port(
        entrada_32 : in std_logic_vector (31 downto 0);
        saida_32   : out std_logic_vector (31 downto 0)
    );
end component;

begin


end Behavioral;

