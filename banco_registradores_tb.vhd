----------------------------------------------------------------------------------
-- Company:
-- Engineer: Gerado por Gemini
--
-- Create Date: 11/04/2025
-- Design Name:
-- Module Name: banco_registradores_tb - Behavioral
-- Project Name: Testbench para banco_registradores
-- Target Devices:
-- Description: Teste funcional do Banco de Registradores, incluindo loop
-- para escrita e leitura de todos os 32 registradores. (Versão sem to_string)
--
-- Dependencies: banco_registradores, tipo.all
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Necessário para to_unsigned e to_integer
use work.tipo.all;

entity banco_registradores_tb is
-- Não possui portas
end banco_registradores_tb;

architecture Behavioral of banco_registradores_tb is

    -- Componente a ser testado
    component banco_registradores is
        port(
            clk, escreverReg : in std_logic;
            dadoEscrita : in std_logic_vector (31 downto 0);
            endEscrita : in std_logic_vector (4 downto 0);

            endL1 : in std_logic_vector(4 downto 0);
            endL2 : in std_logic_vector(4 downto 0);

            dadoL1 : out std_logic_vector(31 downto 0);
            dadoL2 : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Sinais de interconexão (portas do DUT)
    signal clk_s, escreverReg_s : std_logic := '0';
    signal dadoEscrita_s : std_logic_vector (31 downto 0) := (others => '0');
    signal endEscrita_s : std_logic_vector (4 downto 0) := (others => '0');

    signal endL1_s : std_logic_vector(4 downto 0) := (others => '0');
    signal endL2_s : std_logic_vector(4 downto 0) := (others => '0';

    signal dadoL1_s : std_logic_vector(31 downto 0);
    signal dadoL2_s : std_logic_vector(31 downto 0);

    -- Constantes para o clock
    constant T_CLK : time := 10 ns;

begin

    -- Instanciação da Unidade Sob Teste (DUT)
    DUT : banco_registradores
        port map(
            clk => clk_s,
            escreverReg => escreverReg_s,
            dadoEscrita => dadoEscrita_s,
            endEscrita => endEscrita_s,
            endL1 => endL1_s,
            endL2 => endL2_s,
            dadoL1 => dadoL1_s,
            dadoL2 => dadoL2_s
        );

    -- Processo de Geração de Clock
    CLOCK_GEN : process
    begin
        loop
            clk_s <= '0';
            wait for T_CLK / 2;
            clk_s <= '1';
            wait for T_CLK / 2;
        end loop;
    end process CLOCK_GEN;

    -- Processo Principal de Teste
    TEST_PROCESS : process
        -- Variável para o valor a ser escrito/verificado
        variable v_dado : std_logic_vector(31 downto 0);
        -- Constante base para o valor de teste (ex: X"AA000000")
        constant C_BASE_DATA : std_logic_vector(31 downto 0) := X"AA000000";
    begin
        -- 1. Inicialização (Reset implícito)
        escreverReg_s <= '0';
        wait for 2 * T_CLK;

        -- 2. Loop de Escrita em Todos os Registradores (R0 a R31)
        report "--- INICIANDO TESTE DE ESCRITA ---" severity NOTE;

        for i in 0 to 31 loop
            -- Configura o endereço de escrita (R_i)
            endEscrita_s <= std_logic_vector(to_unsigned(i, 5));

            -- Configura o dado a ser escrito: C_BASE_DATA | índice do registrador
            v_dado := C_BASE_DATA or std_logic_vector(to_unsigned(i, 32));
            dadoEscrita_s <= v_dado;

            -- Ativa a escrita
            escreverReg_s <= '1';
            wait until rising_edge(clk_s); -- Sobe o clock para escrita
            escreverReg_s <= '0'; -- Desativa a escrita

            report "Escreveu R" & integer'image(i) & ". Dado (Hex): AA0000xx" severity NOTE;
        end loop;

        wait for T_CLK;

        -- 3. Loop de Leitura e Verificação
        report "--- INICIANDO TESTE DE LEITURA E VERIFICACAO ---" severity NOTE;

        for i in 0 to 31 loop
            -- Configura os endereços de leitura
            endL1_s <= std_logic_vector(to_unsigned(i, 5));
            endL2_s <= std_logic_vector(to_unsigned(i, 5));

            -- Valor esperado (calculado dinamicamente)
            v_dado := C_BASE_DATA or std_logic_vector(to_unsigned(i, 32));

            -- Espera um ciclo para a leitura se propagar (combinação do mux)
            wait for T_CLK / 2;

            -- Verifica se o dado lido em L1 corresponde ao valor esperado
            if dadoL1_s = v_dado then
                report "SUCESSO: R" & integer'image(i) & " lido em L1. Esperado (Hex): AA0000" & integer'image(i) severity NOTE;
            else
                report "ERRO: R" & integer'image(i) & " lido em L1. Valor lido é diferente do esperado." severity ERROR;
            end if;

            -- Verifica se o dado lido em L2 corresponde ao valor esperado
            if dadoL2_s = v_dado then
                report "SUCESSO: R" & integer'image(i) & " lido em L2. Esperado (Hex): AA0000" & integer'image(i) severity NOTE;
            else
                report "ERRO: R" & integer'image(i) & " lido em L2. Valor lido é diferente do esperado." severity ERROR;
            end if;

        end loop;

        -- 4. Finalização do Teste
        report "--- TESTE CONCLUIDO ---" severity NOTE;
        wait; -- Suspende o processo para sempre
    end process TEST_PROCESS;

end Behavioral;
                                                      --elefanet
