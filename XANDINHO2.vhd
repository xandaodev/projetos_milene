library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

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
--mux 2 entradas de 32 bits
	component mux_2entradas_32 is
	port(
		e0_mux_2_32 : in std_logic_vector (0 to 31);
		e1_mux_2_32 : in std_logic_vector (0 to 31);
		sel_mux_2_32 : in std_logic;
		saida_mux_2_32 : out std_logic_vector (0 to 31)
	);
	end component; --***************************** Mudei para 'end component'
                                       
-- mux 2 entradas de 5 bits
	component mux_2entradas_5 is
	port(
	e0_mux_2_5 : in std_logic_vector (4 downto 0); -- corrigi, agr sao 5 bits mesmo
	e1_mux_2_5 : in std_logic_vector (4 downto 0); -- corrigi, agr sao 5 bits mesmo
	sel_mux_2_5 : in std_logic;
	saida_mux_2_5 : out std_logic_vector (4 downto 0) -- corrigi, agr sao 5 bits mesmo
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
end component; --***************************** Mudei a vírgula para ponto e vírgula na linha 1182 (não visível aqui)

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
--somador completo
	component somador_completo is
	port(
	A, B, vem1 : in std_logic;
	vai1, resultado : out std_logic
	);
end component;
--somador completo
--	component somador_completo is
--	port(
--	A, B, vem1 : in std_logic;
--	vai1, resultado : out std_logic
--	);
--end component;
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
	signal saidaMemoInstru : std_logic_vector(31 downto 0);
	--signal 3 :
	signal saidaUC_regDst : std_logic;
	--signal 4:
	signal saidaMuxA_bancoReg : std_logic_vector(4 downto 0);
	--signal 5:
	signal saidaMuxC_writeData_bancoReg : std_logic_vector(31 downto 0);
	--signal 6:
	signal saidaUC_regWrite : std_logic;
	--signal 7:
	signal saidaData1_ULA : std_logic_vector(31 downto 0);
	--signal 8:
	signal saidaData2 : std_logic_vector(31 downto 0);
	--signal 9:
	signal saidaExtSinal_deslocA : std_logic_vector(31 downto 0);
	--signal 10:
	signal saidaUC_muxB : std_logic;
	--signal 11:
	signal saidaMuxB_ULA : std_logic_vector(31 downto 0);
	--signal 12:
	signal saidaUC_UCula : std_logic;
	--signal 13:
	signal saidaUCula_ULA : std_logic_vector(1 downto 0);-- mais de 1 sinal
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
	signal saidaSomadorB_muxD : std_logic_vector(31 downto 0);
	--signal 25:
	signal saidaUC_branch : std_logic;
	--signal 26:
	signal saidaAnd_muxD : std_logic;
	--signal 27:
	signal saidaMuxD_muxE : std_logic_vector(31 downto 0);
	--signal 28:
	signal saidaUC_jump : std_logic;
	--signal 29:
	signal saidaMuxE_pc : std_logic_vector(31 downto 0);


	--novos signals para o fatiamento dos signals necessarios:
	signal opcode_signal : std_logic_vector(5 downto 0); 
	signal ALU_op_control : std_logic_vector(1 downto 0);
	signal funct_signal : std_logic_vector(5 downto 0);   
	signal rs_addr : std_logic_vector(4 downto 0);      
	signal rt_addr : std_logic_vector(4 downto 0);      
	signal rd_addr : std_logic_vector(4 downto 0);      
	signal inst_jump_26 : std_logic_vector(25 downto 0);
	
	-- signal que marcely e digao falou pra colocar
	signal Sainverte, Sbinverte : std_logic;

	
begin

	--fatiamento dos signals:
	opcode_signal  <= saidaMemoInstru(31 downto 26);
	rs_addr     <= saidaMemoInstru(25 downto 21);
	rt_addr     <= saidaMemoInstru(20 downto 16);
	rd_addr     <= saidaMemoInstru(15 downto 11);
	funct_signal   <= saidaMemoInstru(5 downto 0);
	inst_jump_26   <= saidaMemoInstru(25 downto 0);

	--atribuiçoes nos port maps:


	--port map do pc:
	PC_reg: pc port map(
		ini => inicializar,
		clk => clk,
		entrada => saidaMuxE_pc, -- 29
		saida => saidaPC -- 1
		);

	-- port map memoria de instrucao
	memoria_inst: memInstrucoes port map(
		Endereco => saidaPC,
		Palavra => saidaMemoInstru -- fio 2
    	);

	-- port map unidade de controle
	uc_principal: unidade_controle port map(
		op_uc => saidaMemoInstru(31 downto 26), 
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

	--port map muxA
	mux_A : mux_2entradas_5  port map(
		--e0_mux_2_5  => saidaMemoInstru(20 downto 16),
		e0_mux_2_5  => rt_addr,
		
		--e1_mux_2_5   => saidaMemoInstru(15 downto 11),
		e1_mux_2_5   => rd_addr,
		--sel_mux_2_5   => saidaUC_regDst, -- fio 3
		sel_mux_2_5   => saidaUC_regDst, -- fio 3
		--saida_mux_2_5   => saidaMuxA_bancoReg
		saida_mux_2_5   => saidaMuxA_bancoReg
		);

	-- port map unidade de controla da ula
	UC_ula : uc_ula port map(
		--ALU_op => saidaUC_UCula, --fio 12
		ALU_op => ALU_op_control, -- mudei aqui, n sei se ta certo
		operacao => saidaUCula_ULA, -- fio 13, obs: na imagemd e caminho da dados fala "mais de 1 sinal"
		--funct => saidaMemoInstru(5 downto 0)
		funct => funct_signal,
		Ainverte => Sainverte,
		Binverte => Sbinverte
		);

	--port map extensor de sinal
	extensor_de_sinal : extensor_sinal port map(
		entrada_16 => saidaMemoInstru(15 downto 0),
		saida_32 => saidaExtSinal_deslocA -- fio 9
		);


	--port map banco de registradores
	banco_de_resgistradores : banco_registradores port map(
		clk => clk,
		endL1 => rs_addr,
		endL2 => rt_addr,
		endEscrita => saidaMuxA_bancoReg, --***************************** FIX: endEscrita adicionado
		--escreverReg => saidaMuxA_bancoReg, --fio 4
		escreverReg => saidaUC_regWrite, -- fio corrigido, espero que seja o certo agr, fio 6 agr
		dadoEscrita => saidaMuxC_writeData_bancoReg, -- fio5
		dadoL1 => saidaData1_ULA, -- fio 7
		dadoL2 => saidaData2 -- aqui tem q ver pq ele vai pra dois lugares
	    );

	--port map muxB
	mux_B : mux_2entradas_32 port map(
		--e0_mux_2_32  => saidaData1_ULA, -- fio 8
		e0_mux_2_32  => saidaData2,
		e1_mux_2_32  => saidaExtSinal_deslocA, -- fio 9, tem q ver aqui pq esse fio vai pra 2 lugares
		sel_mux_2_32  => saidaUC_muxB, --fio 10
		saida_mux_2_32  => saidaMuxB_ULA -- fio 11
		);

	--port map ula
	ula_principal : ula_32 port map(
		a => saidaData1_ULA,  -- fio 7
		b => saidaMuxB_ULA, -- fio 11
		op => saidaUCula_ULA, -- fio 13
		zero => saidaZeroULA_and, -- fio 14
		result => saidaULA, -- fio 15, tem q ver aqui pq ele vai pra dois lugares diferentes
		Ainverte => Sainverte, --aqui tava ligada em zero mas milene falou pra fazer isso
		Binverte => Sbinverte --aqui tava ligada em zero mas milene falou pra fazer isso
		);

	-- port map memoria de dados
	memoria_de_dados : memDados port map(
		--DadoLido => saidaULA, -- fio 15, tem q ver aqui pq esse fio vai pra 2 lugares7
		DadoLido => saidaDataMem_muxC, -- fio 17
		DadoEscrita => saidaData2, -- fio 8,  tem q ver aqui pq esse fio vai pra 2 lugares7
		Clock => clk,
		LerMem => saidaUC_memRead, -- fio 18
		Endereco => saidaULA, -- fio 15
		EscreverMem => saidaUC_memWrite, -- fio 16
		--DebugEndereco => debugEndereco,
		DebugEndereco => X"000000" & debugEndereco, --***************************** FIX: Concatenando para 32 bits
		DebugPalavra => open --***************************** FIX: Aberto para conectar ao output
		);
	-- Conexão da Saída de Debug (Top-level)
	debugPalavra <= saidaDataMem_muxC(9 downto 2); --***************************** FIX: Slicing da saída de 32 bits para a porta de 8 bits (9:2)

	--port map mux c
	mux_C : mux_2entradas_32 port map(
		e1_mux_2_32  => saidaDataMem_muxC, -- fio 17
		e0_mux_2_32  => saidaULA, -- fio 15, tem q ver aqui pq esse fio vai pra 2 lugares
		sel_mux_2_32  => saidaUC_memtoReg, -- fio 19
		saida_mux_2_32  => saidaMuxC_writeData_bancoReg -- fio 5
	    );

	--port map somador A
	-- somador_A is somador_completo port map(
	somador_A : ula_32 port map(
		a => saidaPC,                 
	    b => X"00000004",             
	    Ainverte => '0', 
		 Binverte => '0', 
	    op => "10",                    
	    result => saidaSomadorA,
	    zero => open --***************************** FIX: Conectando zero
		);

	-- port map deslocador B
	deslocador_jump : deslocador_2 port map( --***************************** FIX: Renomeado de deslocador_B para evitar redeclaração
	   --entrada_32 => inst_jump_26,
		entrada_32 => X"000000" & inst_jump_26, --***************************** FIX: Padronizando a entrada para 32 bits (6 zeros)
		saida_32 => saidaDeslocB_muxE -- fio 22
		);

	-- port map deslocador A 
	deslocador_branch : deslocador_2 port map( --***************************** FIX: Renomeado de deslocador_B para evitar redeclaração
		entrada_32 => saidaExtSinal_deslocA,
		saida_32 => saidaDeslocA_somadorB -- fio 23
		);

	--port map somador B
	--somador_B is somador_completo port map(
	somador_B_ULA: ula_32 port map(
		a => saidaSomadorA, -- fio 21
		b => saidaDeslocA_somadorB, -- fio 23
		Ainverte => '0',
    	Binverte => '0',
		op => "10", -- codigo da soma
		result => saidaSomadorB_muxD,
		zero => open --***************************** FIX: Conectando zero
		);

		--and:
		saidaAnd_muxD <= saidaZeroULA_and AND saidaUC_branch;


	--port map muxD
	mux_D : mux_2entradas_32 port map(
		e0_mux_2_32  => saidaSomadorA, -- FIO 21
		e1_mux_2_32  => saidaSomadorB_muxD, -- FIO 24
		sel_mux_2_32 => saidaAnd_muxD, -- fio 26
		saida_mux_2_32  => saidaMuxD_muxE -- fio 27
		);

	--port map muxE
	mux_E : mux_2entradas_32 port map(
		e0_mux_2_32  => saidaMuxD_muxE, -- FIO 27 --***************************** FIX: Trocado e0/e1 para seguir a lógica do Jump (Jump é e1/1)
		e1_mux_2_32  => saidaDeslocB_muxE, -- FIO 22
		sel_mux_2_32 => saidaUC_jump, -- fio 28
		saida_mux_2_32  => saidaMuxE_pc -- fio 29
		);

	
end Behavioral;
