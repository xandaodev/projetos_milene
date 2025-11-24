----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Xandão e Xandona
-- 
-- Create Date:    14:54:58 11/04/2025 
-- Design Name: 
-- Module Name:    registrador_32 - Behavioral 
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

entity registrador_32 is
    port(
        e_reg : in std_logic_vector (31 downto 0); -- alexandre - mudei pra down to 
        clk, preset, clear, enable : in std_logic;
        saida_reg : out std_logic_vector (31 downto 0) -- alexandre - mudei pra down to 
    );
end registrador_32;

architecture Behavioral of registrador_32 is
    component ffd is 
        port(
            D, clk, enable, preset, clear : in  std_logic;
            Q : out std_logic
        );
    end component;

begin
gen_registrador : for i in 0 to 31 generate
    flipFlops : ffd port map(
        D => e_reg(i),
        clk => clk,
        preset => preset,
        clear => clear,
        enable => enable,
        Q => saida_reg(i)
    );
end generate;

end Behavioral;

-- "C:\ghdl\bin\ghdl.exe" -a "nome"  --> compila o arquivo isoladamente (se depender de outro(s) componente(s), tem que compilar -todos- ele(s) antes)
-- & "C:\ghdl\bin\ghdl.exe" -a *.vhd  --> compila todos os arquivos de uma vez


