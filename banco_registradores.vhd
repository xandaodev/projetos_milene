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
        dadoEscrita : in_std_logic_vector(0 to 31);
        endEscrita : in std_logic_vector (0 to 4);

        endL1 : in std_logic_vector(4 downto 0);
        endL2 : in std_logic_vector(4 downto 0);

        dadoL1 : out std_logic_vector(31 downto 0); 
        dadoL2 : out std_logic_vector(31 downto 0)
    );
end banco_registradores;

architecture Behavioral of banco_registradores is
    component decod_5_32 is
        port(
            e_decod : in std_logic_vector(0 to 4);
            sel : in std_logic;
            resultado_decod : out std_logic_vector(0 to 31)
        );
    end component;

    component registrador_32 is
        port(
            e_reg : in std_logic_vector (0 to 31);
            clk, preset, clear, enable : in std_logic;
            saida_reg : out std_logic_vector (0 to 31)
        );
    end component;

    component mux_32 is
        port(
            E : in tipo_vetor_de_palavras(0 to 31);
            Sel : in std_logic_vector(4 downto 0);
            Saida : out tipo_palavra
        );
    end component;

--FIOS
signal saida_decod : std_logic_vector (0 to 31);--saida dos decods, entra nos enables
signal saida_32regs : std_logic_vector (0 to 31); -- saida dos regs, entra nos muxes

begin

--PRIMEIRA coluna
decod: decod_5_32 port map (
    e_decod => endEscrita,
    sel => escreverReg,
    resultado_decod => saida_decod
);

--SEGUNDA coluna - 32 registradores

ge_registradores : for i in 0 to 32 generate
    inst_reg : registrador_32 port map(
        preset => '0';
        clear =>'0';
        enable => saida_decod(i);
        e_reg => dadoEscrita;
        saida_reg => saida32_regs(i)
        );
    end generate;
        





    
reg: registrador_32 port map(
    enable => saida_decod,
    clk => clk,

);

end Behavioral;

-- "C:\ghdl\bin\ghdl.exe" -a "nome"  --> compila o arquivo isoladamente (se depender de outro(s) componente(s), tem que compilar -todos- ele(s) antes)
-- & "C:\ghdl\bin\ghdl.exe" -a *.vhd  --> compila todos os arquivos de uma vez


