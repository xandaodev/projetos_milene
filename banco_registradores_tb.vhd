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
-- para escrita e leitura de todos os 32 registradores. (Versão mais robusta para ISE)
--
-- Dependencies: banco_registradores, tipo.all
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- ESSENCIAL para to_unsigned e to_integer
use work.tipo.all;

entity banco_registradores_tb is
-- Não possui portas
end banco_registradores_tb;

architecture Behavioral of banco_registradores_tb is

    -- Componente a ser testado (DUT - Device Under Test)
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

    -- Sinais de interconexão
    signal clk_s, escreverReg_s : std_logic := '0';
    signal dadoEscrita_s : std_logic_vector (31 downto 0) := (others => '0');
    signal endEscrita_s : std_logic_vector (4 downto 0) := (others => '0');

    signal endL1_s : std_logic_vector(4 downto 0) := (others => '0');
    signal endL2_s : std_logic_vector(4 downto 0) := (others => '0');

    signal dadoL1_s : std_logic_vector(31 downto 0);
    signal dadoL2_s : std_logic_vector(31 downto 0);

    -- Constantes
    constant T_CLK : time := 10 ns;
    -- Constante base de 32 bits para o valor de teste (0xAA000000)
    constant C_BASE_DATA : std_logic_vector(31 downto 0) := X"AA000000";

begin

    -- Instanciação da Unidade Sob Teste
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
        -- Variável para armazenar o valor esperado e o índice
        variable v_dado_index_32 : std_logic_vector(31 downto 0);
        variable v_index_5 : std_logic_vector(4 downto 0);
    begin
        report "--- INICIANDO TESTE ---" severity NOTE;

        -- 1. Inicialização
        escreverReg_s <= '0';
        wait for 2 * T_CLK;

        -- 2. Loop de Escrita em Todos os Registradores (R0 a R31)
        report "--- ESCRITA EM REGISTRADORES (R0 A R31) ---" severity NOTE;

        for i in 0 to 31 loop
            -- a) Endereço de Escrita (5 bits)
            v_index_5 := std_logic_vector(to_unsigned(i, 5));
            endEscrita_s <= v_index_5;

            -- b) Dado de Escrita (32 bits): C_BASE_DATA OR índice
            -- O índice (i) é convertido para 32 bits, garantindo que apenas os 5 bits LSBs sejam alterados.
            v_dado_index_32 := std_logic_vector(to_unsigned(i, 32));
            dadoEscrita_s <= C_BASE_DATA or v_dado_index_32;

            -- c) Escrita no Clock
            escreverReg_s <= '1';
            wait until rising_edge(clk_s);
            escreverReg_s <= '0';

            report "Escrita em R" & integer'image(i) & " concluída. Endereço (Bin): " & v_index_5 severity NOTE;
        end loop;

        wait for 2 * T_CLK;

        -- 3. Loop de Leitura e Verificação
        report "--- LEITURA E VERIFICACAO ---" severity NOTE;

        for i in 0 to 31 loop
            -- a) Endereços de Leitura
            v_index_5 := std_logic_vector(to_unsigned(i, 5));
            endL1_s <= v_index_5;
            endL2_s <= v_index_5;

            -- b) Valor Esperado
            v_dado_index_32 := C_BASE_DATA or std_logic_vector(to_unsigned(i, 32));

            -- c) Espera para Leitura
            wait for T_CLK / 2;

            -- d) Verificação L1
            if dadoL1_s = v_dado_index_32 then
                report "SUCESSO: R" & integer'image(i) & " lido em L1." severity NOTE;
            else
                report "ERRO na leitura L1 de R" & integer'image(i) & ". Esperado (Hex): AA0000" & integer'image(i) severity ERROR;
            end if;

            -- e) Verificação L2
            if dadoL2_s = v_dado_index_32 then
                report "SUCESSO: R" & integer'image(i) & " lido em L2." severity NOTE;
            else
                report "ERRO na leitura L2 de R" & integer'image(i) & ". Esperado (Hex): AA0000" & integer'image(i) severity ERROR;
            end if;

        end loop;

        -- 4. Finalização
        report "--- TESTE CONCLUIDO. Verifique o console ou a forma de onda (waveform) ---" severity NOTE;
        wait;
    end process TEST_PROCESS;

end Behavioral;
