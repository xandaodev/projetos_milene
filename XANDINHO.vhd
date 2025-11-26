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
	debugPalavra : out std_logic_vector (9 downto 2)
);
end xandinho;

architecture Behavioral of xandinho is
--pc
	component pc is
		port(
			ini, clk : in std_logic;
			entrada : in std_logic_vector(31 downto 0);
			saida : out std_logic_vector(31 downto 0)
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
	--signal 1 :
	signal saidaPC : std_logic_vector(31 downto 0);
	--signal 2 :
	signal saidaMemoInstru : std_logic_vector(5 downto 0);
	--signal 3 :
	signal saidaUC_regDst : std_logic;
	--signal 4:
	signal saidaMuxA_bancoReg : std_logic;
	--signal 5:
	signal saidaMuxC_writeData_bancoReg : std_logic;
	--signal 6:
	signal saidaUC_regWrite : std_logic;
	--signal 7:
	signal saidaData1_ULA : std_logic_vector(31 downto 0);
	--signal 8:
	signal saidaData2 : : std_logic_vector(31 downto 0);
	--signal 9:
	signal saidaExtSinal_deslocA : std_logic_vector(31 downto 0);
	--signal 10:
	signal saidaUC_muxB : std_logic;
	--signal 11:
	signal saidaMuxB_ULA : std_logic_vector(31 downto 0);
	--signal 12:
	signal saidaUC_UCula : std_logic;
	--signal 13:
	signal saidaUCula_ULA -- mais de 1 sinal
	--signal 14:
	signal saidaZeroULA_and : std_logic;
	--signal 15:
	signal saidaULA : std_logic_vector(31 downto 0);
	--signal 16:
	signal saidaUC_memWrite : std_logic;
	--signal 17:
	signal saidaDataMem_muxC : std_logic_vector(31 downto 0);
	--signal 18:
	signal saidaUC_memRead : std_logic;
	--signal 19:
	signal saidaUC_memtoReg : std_logic;
	--signal 20: (esse n tem)
	--signal
	--signal 21:
	signal saidaSomadorA : std_logic_vector(31 downto 0);--acho q esse aqui vai ter q ser vetor
	--signal 22:
	signal saidaDeslocB_muxE : std_logic_vector(31 downto 0);--atecnao pra esse aqui, ele meio q se junta com esse de cima
	--signal 23:
	signal saidaDeslocA_somadorB : std_logic_vector(31 downto 0);
	--signal 24:
	signal saidaSomadorB_muxD : std_logic;
	--signal 25:
	signal saidaUC_branch : std_logic;
	--signal 26:
	signal saidaAnd_muxD : std_logic;
	--signal 27:
	signal saidaMuxD_muxE : std_logic;
	--signal 28:
	signal saidaUC_jump : std_logic;
	--signal 29:
	signal saidaMuxE_pc : std_logic;

	
begin
	


end Behavioral;

