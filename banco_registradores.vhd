----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Xandão e Xandona
-- 
-- Create Date:    14:54:58 11/04/2025 
-- Design Name: 
-- Module Name:    banco_registradores - Behavioral 
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
use work.tipo.all; --atualizacoes, pesquisei aqui e parece que tem que ter essa biblioteca tipo pra funcionar

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity banco_registradores is
    port(
        clk, escreverReg : in std_logic;
        dadoEscrita : in std_logic_vector (31 downto 0); -- alexandre - mudei pra down to 
        endEscrita : in std_logic_vector (4 downto 0); -- mudei

        endL1 : in std_logic_vector(4 downto 0);
        endL2 : in std_logic_vector(4 downto 0);

        dadoL1 : out std_logic_vector(31 downto 0); 
        dadoL2 : out std_logic_vector(31 downto 0)
    );
end banco_registradores;

architecture Behavioral of banco_registradores is
    component decod_5_32 is
        port(
            e_decod : in std_logic_vector(4 downto 0);  -- mudei pra down to 
            sel : in std_logic;
            resultado_decod : out std_logic_vector(31 downto 0) -- alexandre - mudei pra downto
        );
    end component;

    component registrador_32 is
        port(
            e_reg : in std_logic_vector (31 downto 0);--mudei
            clk, preset, clear, enable : in std_logic;
            saida_reg : out std_logic_vector (31 downto 0)--mudei
        );
    end component;

    component mux32x32 is --aqui tava o mux_32, mas na verdade o que vamos usar é o que a millene postou, mux32x32
        port(
            E : in tipo_vetor_de_palavras(31 downto 0); -- alexandre - mudei pra downto
            Sel : in std_logic_vector(4 downto 0);
            Saida : out tipo_palavra
        );
    end component;

--FIOS
signal saida_decod : std_logic_vector (31 downto 0);--saida dos decods, entra nos enables -- mudei
signal saida_32regs : tipo_vetor_de_palavras (31 downto 0); -- saida dos regs, entra nos muxes -- mudei down to 

begin

--PRIMEIRA coluna
decod: decod_5_32 port map (
    e_decod => endEscrita,
    sel => escreverReg,
    resultado_decod => saida_decod
);

--SEGUNDA coluna - 32 registradores

gen_registradores : for i in 0 to 31 generate
    inst_reg : registrador_32 port map(
		  clk => clk, -- conectei os clocks
        preset => '0',
        clear =>'0',
        enable => saida_decod(i),
        e_reg => dadoEscrita,
        saida_reg => saida_32regs(i) -- aqui tava saida_32_regs
);
    end generate;

-- TERCEIRA coluna,  muxes
muxL1 : mux32x32 port map(
    E => saida_32regs,
    Sel => endL1,
    Saida => dadoL1
);

muxL2 : mux32x32 port map(
    E => saida_32regs, -- aqui tava saida_32_regs
    Sel => endL2,
    Saida => dadoL2
);
        


end Behavioral;






