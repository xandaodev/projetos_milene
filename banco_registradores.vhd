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
        clk, escreverReg, dadoEscrita : in std_logic;
        endEscrita : in std_logic_vector (0 to 4);
        dadoL1, dadoL2 : out std_logic
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
            e_mux_32 : in std_logic_vector (0 to 31);
            sel : in std_logic_vector (0 to 4);
            saida_mux_32 : out std_logic
        );
    end component;

--FIOS
signal saida_decod : std_logic_vector (0 to 31);
signal saida_32regs : std_logic_vector (0 to 31); 

begin

--PRIMEIRA coluna
decod: decod_5_32 port map (
    e_decod => endEscrita,
    sel => escreverReg,
    resultado_decod => saida_decod
);

reg: registrador_32 port map(
    enable => saida_decod,
    clk => clk,

);

end Behavioral;

-- "C:\ghdl\bin\ghdl.exe" -a "nome"  --> compila o arquivo isoladamente (se depender de outro(s) componente(s), tem que compilar -todos- ele(s) antes)
-- & "C:\ghdl\bin\ghdl.exe" -a *.vhd  --> compila todos os arquivos de uma vez

