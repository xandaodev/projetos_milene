----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Julia e Alexandre
-- 
-- Create Date:    14:54:58 11/04/2025 
-- Design Name: 
-- Module Name:    ula_32 - Behavioral 
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

entity mux_32 is
    port(
        e_mux_32 : in std_logic_vector (0 to 31);
        sel : in std_logic_vector (4 downto 0);
        saida_mux_32 : out std_logic
    );
end mux_32;

architecture Behavioral of mux_32 is
    component mux4 is
        port(
            e : in std_logic_vector (0 to 3);
            op: in std_logic_vector (1 downto 0);
            resultado : out std_logic
        );
    end component;

    component mux2 is
        port(
            A, B, s: in std_logic;
		    resultado : out std_logic
        );
    end component;

-- PRIMEIRA coluna de mux
signal saida_bloco0_mux : std_logic_vector (0 to 3);
signal saida_bloco1_mux : std_logic_vector (0 to 3);
-- SEGUNDA coluna de mux
signal saida_mux0 : std_logic;
signal saida_mux1 : std_logic;

begin
--PRIMEIRA COLUNA
--primeiro bloco de mux da primeira coluna
gen_bloco0 : for i in 0 to 3 generate   --são 4 mux
    bloco0 : mux4 port map(
        e(0) => e_mux_32(4*i),
        e(1) => e_mux_32(4*i+1),
        e(2) => e_mux_32(4*i+2),
        e(3) => e_mux_32(4*i+3),
        --isso aqui é fixo pros 8 
        op(0) => sel(0),
        op(1) => sel(1),

        resultado => saida_bloco0_mux(i)
    );
end generate;

--segundo bloco de mux da primeira coluna
gen_bloco1 : for i in 0 to 3 generate
    bloco1 : mux4 port map(
        e(0) => e_mux_32(4*i+16),
        e(1) => e_mux_32(4*i+17),
        e(2) => e_mux_32(4*i+18),
        e(3) => e_mux_32(4*i+19),
        --isso aqui é fixo pros 8
        op(0) => sel(0),
        op(1) => sel(1),

        resultado => saida_bloco1_mux(i) 
    );
end generate;

--SEGUNDA COLUNA
--primeiro mux
mux0 : mux4 port map(
    e(0) => saida_bloco0_mux(0),
    e(1) => saida_bloco0_mux(1),
    e(2) => saida_bloco0_mux(2),
    e(3) => saida_bloco0_mux(3),
--isso aqui é fixo pros 2
    op(0) => sel(2),
    op(1) => sel(3),

    resultado => saida_mux0
);

mux1 : mux4 port map(
    e(0) => saida_bloco1_mux(0),
    e(1) => saida_bloco1_mux(1),
    e(2) => saida_bloco1_mux(2),
    e(3) => saida_bloco1_mux(3),
--isso aqui é fixo pros 2
    op(0) => sel(2),
    op(1) => sel(3),

    resultado => saida_mux1
);

mux_final : mux2 port map(
    A => saida_mux0,
    B => saida_mux1,
    s => sel(4),
    resultado => saida_mux_32
);

end Behavioral;

-- "C:\ghdl\bin\ghdl.exe" -a "nome"  --> compila o arquivo isoladamente (se depender de outro(s) componente(s), tem que compilar -todos- ele(s) antes)
-- & "C:\ghdl\bin\ghdl.exe" -a *.vhd  --> compila todos os arquivos de uma vez
