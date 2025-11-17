----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Alexandre e Julia
-- 
-- Create Date:    14:54:58 11/04/2025 
-- Design Name: 
-- Module Name:    ffd - Behavioral 
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

entity ffd is
    port(
        D, clk, enable, preset, clear : in  std_logic;
        Q : out std_logic
    );
end ffd;

architecture Behavioral of ffd is

signal mestre_q, mestre_qb, mestre_set, mestre_reset, mestre_enable : std_logic;
signal escravo_q, escravo_qb, escravo_set, escravo_reset, escravo_enable : std_logic;
signal not_clk, not_D, not_mestre_q : std_logic;

begin
not_clk <= not clk;
not_D <= not D;
not_mestre_q <= not mestre_q;

    mestre_enable  <= enable and clk;         
    escravo_enable <= enable and not_clk;    

    mestre_set   <= mestre_enable and D;
    mestre_reset <= mestre_enable and not_D;

    mestre_q       <= not (mestre_reset or mestre_qb);
    mestre_qb <= not (mestre_set or mestre_q);

    escravo_set   <= (escravo_enable and mestre_q) or preset;
    escravo_reset <= (escravo_enable and not_mestre_q) or clear;

    escravo_q       <= not (escravo_reset or escravo_qb);
    escravo_qb <= not (escravo_set or escravo_q);

    Q <= escravo_q;

end Behavioral;


-- "C:\ghdl\bin\ghdl.exe" -a "nome"  --> compila o arquivo isoladamente (se depender de outro(s) componente(s), tem que compilar -todos- ele(s) antes)
-- & "C:\ghdl\bin\ghdl.exe" -a *.vhd  --> compila todos os arquivos de uma vez