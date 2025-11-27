library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Necessário para X"..." e concatenação

entity xandinho is
port(
	clk, inicializar : in std_logic;
	debugEndereco : in std_logic_vector (9 downto 2);
	debugPalavra : out std_logic_vector (9 downto 2)
);
end xandinho;

architecture Behavioral of xandinho is
-- Componentes (Manter lista completa de declarações)

-- SINAIS INTERNOS
signal saidaPC : std_logic_vector(31 downto 0);
signal saidaMemoInstru : std_logic_vector(31 downto 0);
signal saidaUC_regDst : std_logic;
signal saidaMuxA_bancoReg : std_logic_vector(4 downto 0);
signal saidaMuxC_writeData_bancoReg : std_logic_vector(31 downto 0);
signal saidaUC_regWrite : std_logic;
signal saidaData1_ULA : std_logic_vector(31 downto 0);
signal saidaData2 : std_logic_vector(31 downto 0);
signal saidaExtSinal_deslocA : std_logic_vector(31 downto 0);
signal saidaUC_muxB : std_logic;
signal saidaMuxB_ULA : std_logic_vector(31 downto 0);
signal saidaUC_UCula : std_logic;
signal saidaUCula_ULA : std_logic_vector(1 downto 0);
signal saidaZeroULA_and : std_logic;
signal saidaULA : std_logic_vector(31 downto 0);
signal saidaUC_memWrite : std_logic;
signal saidaDataMem_muxC : std_logic_vector(31 downto 0);
signal saidaUC_memRead : std_logic;
signal saidaUC_memtoReg : std_logic;
signal saidaSomadorA : std_logic_vector(31 downto 0);
signal saidaDeslocB_muxE : std_logic_vector(31 downto 0);
signal saidaDeslocA_somadorB : std_logic_vector(31 downto 0);
signal saidaSomadorB_muxD : std_logic_vector(31 downto 0);
signal saidaUC_branch : std_logic;
signal saidaAnd_muxD : std_logic;
signal saidaMuxD_muxE : std_logic_vector(31 downto 0);
signal saidaUC_jump : std_logic;
signal saidaMuxE_pc : std_logic_vector(31 downto 0);
signal opcode_signal : std_logic_vector(5 downto 0); 
signal ALU_op_control : std_logic_vector(1 downto 0);
signal funct_signal : std_logic_vector(5 downto 0);   
signal rs_addr : std_logic_vector(4 downto 0);      
signal rt_addr : std_logic_vector(4 downto 0);      
signal rd_addr : std_logic_vector(4 downto 0);      
signal inst_jump_26 : std_logic_vector(25 downto 0);
signal Sainverte, Sbinverte : std_logic; -- Sinais adicionados por você

	
begin
	
-- FATIAMENTO DA INSTRUÇÃO
opcode_signal  <= saidaMemoInstru(31 downto 26);
rs_addr     <= saidaMemoInstru(25 downto 21);
rt_addr     <= saidaMemoInstru(20 downto 16);
rd_addr     <= saidaMemoInstru(15 downto 11);
funct_signal   <= saidaMemoInstru(5 downto 0);
inst_jump_26   <= saidaMemoInstru(25 downto 0);

-- 1. PC
PC_reg: pc port map(
	ini => inicializar,
	clk => clk,
	entrada => saidaMuxE_pc,
	saida => saidaPC
);

-- 2. Somador PC + 4 (Usando ULA_32)
somador_PC4: ula_32 port map(
    a => saidaPC,                 
    b => X"00000004",             
    Ainverte => '0', Binverte => '0', 
    op => "10",                    
    result => saidaSomadorA,       -- PC + 4 (21)
    zero => open
);

-- 3. Memória de Instruções
memoria_inst: memInstrucoes port map(
	Endereco => saidaPC,
	Palavra => saidaMemoInstru
);

-- 4. Unidade de Controle Principal
uc_principal: unidade_controle port map(
	op_uc => opcode_signal, 
    ALU_op_uc => ALU_op_control,
    reg_write => saidaUC_regWrite,
    reg_dst => saidaUC_regDst,
    ALU_src => saidaUC_muxB,
    branch => saidaUC_branch,
    mem_write => saidaUC_memWrite,
    mem_toReg => saidaUC_memtoReg,
    jump => saidaUC_jump,
    mem_read => saidaUC_memRead
);

-- 5. MUX A (RegDst): MUX 5-BIT CORRIGIDO
mux_A : mux_2entradas_5 port map(
    e0_mux_2_5  => rt_addr, -- 5 bits
    e1_mux_2_5  => rd_addr, -- 5 bits
    sel_mux_2_5 => saidaUC_regDst,
    saida_mux_2_5 => saidaMuxA_bancoReg -- 5 bits
);

-- 6. Banco de Registradores
banco_de_resgistradores : banco_registradores port map(
	clk => clk,
	escreverReg => saidaUC_regWrite, 
	dadoEscrita => saidaMuxC_writeData_bancoReg,
	endEscrita => saidaMuxA_bancoReg, -- FIX CRÍTICO: endEscrita adicionado
	
	endL1 => rs_addr, 
	endL2 => rt_addr, 
	
	dadoL1 => saidaData1_ULA, 
	dadoL2 => saidaData2
);

-- 7. Extensor de Sinal
extensor_de_sinal: extensor_sinal port map(
	entrada_16 => saidaMemoInstru(15 downto 0),
	saida_32 => saidaExtSinal_deslocA
);

-- 8. MUX B (ALUSrc): 2ª Entrada da ULA (Fio 11)
mux_B: mux_2entradas_32 port map(
	e0_mux_2_32 => saidaData2,                 
	e1_mux_2_32 => saidaExtSinal_deslocA,       
	sel_mux_2_32 => saidaUC_muxB,              
	saida_mux_2_32 => saidaMuxB_ULA            
);

-- 9. Unidade de Controle da ULA (ALU Control)
UC_ula_control : uc_ula port map(
	ALU_op => ALU_op_control,
	operacao => saidaUCula_ULA, 
	funct => funct_signal,
	Ainverte => Sainverte,
	Binverte => Sbinverte
);

-- 10. ULA Principal (ALU)
ula_principal : ula_32 port map(
	a => saidaData1_ULA,  
	b => saidaMuxB_ULA,   
	op => saidaUCula_ULA, 
	zero => saidaZeroULA_and,
	result => saidaULA, 
	Ainverte => Sainverte, -- Lógica Correta (pino Ainverte do uc_ula)
	Binverte => Sbinverte -- Lógica Correta (pino Binverte do uc_ula)
);

-- 11. Memória de Dados
memoria_de_dados : memDados port map(
    DadoLido => saidaDataMem_muxC,              
	DadoEscrita => saidaData2,                  
	Clock => clk,
	LerMem => saidaUC_memRead,                  
	EscreverMem => saidaUC_memWrite,            
	Endereco => saidaULA,                       
	
	-- Conexão para Debug (FIX: Concatenando para 32 bits)
	DebugEndereco => X"00000000" & debugEndereco,
	DebugPalavra => open -- Conectamos a 'debugPalavra' diretamente ao pino do top-level
);
debugPalavra <= debugPalavra(9 downto 2); -- Slicing da saída de 32 bits para 8 bits, se debugPalavra for 32 bits.

-- 12. MUX C (MemToReg)
mux_C: mux_2entradas_32 port map(
	e0_mux_2_32 => saidaULA,                       
	e1_mux_2_32 => saidaDataMem_muxC,              
	sel_mux_2_32 => saidaUC_memtoReg,             
	saida_mux_2_32 => saidaMuxC_writeData_bancoReg 
);

-- 13. Deslocador de Sinal Estendido (Para Branch Target)
deslocador_branch_target: deslocador_2 port map(
	entrada_32 => saidaExtSinal_deslocA,
	saida_32 => saidaDeslocA_somadorB              
);

-- 14. Somador Branch Target (PC+4 + Offset Deslocado)
somador_B_ULA: ula_32 port map(
    a => saidaSomadorA,                            
    b => saidaDeslocA_somadorB,                   
    Ainverte => '0', Binverte => '0',
    op => "10",                                    
    result => saidaSomadorB_muxD,                  
    zero => open
);

-- 15. Lógica da Condição Branch (AND Gate - 26)
saidaAnd_muxD <= saidaZeroULA_and AND saidaUC_branch;

-- 16. MUX D (Branch/Next PC Selection)
mux_D: mux_2entradas_32 port map(
	e0_mux_2_32 => saidaSomadorA,                  
	e1_mux_2_32 => saidaSomadorB_muxD,             
	sel_mux_2_32 => saidaAnd_muxD,                
	saida_mux_2_32 => saidaMuxD_muxE               
);

-- 17. Lógica de Jump (Deslocador e Concatenação)
saidaDeslocB_muxE <= saidaSomadorA(31 downto 28) & inst_jump_26 & "00";

-- 18. MUX E (Jump/Final PC Selection)
mux_E: mux_2entradas_32 port map(
	e0_mux_2_32 => saidaMuxD_muxE,                
	e1_mux_2_32 => saidaDeslocB_muxE,             
	sel_mux_2_32 => saidaUC_jump,                 
	saida_mux_2_32 => saidaMuxE_pc                
);
