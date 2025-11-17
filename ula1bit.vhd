----------------------------------------------------------------------------------
-- Company: 
-- Engineer: xandão e xandona
-- 
-- Create Date:    14:17:48 10/21/2025 
-- Design Name: 
-- Module Name:    ula1bit - Behavioral 
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

entity ula1bit is
port(
	A_ula, B_ula, vem1_ula, less, Ainverte, Binverte, op_ula : in std_logic;
	vai1_ula, resultado_ula, set_ula : out std_logic
);
end ula1bit;

architecture Behavioral of ula1bit is
--COMPONENTES
--mux 2
component mux2 is
		port(
			A, B, s: in std_logic;
			resultado: out std_logic

		);
	end component;
--somador completo
component somador_completo is
	port(
	A, B, vem1 : in std_logic;
	vai1, resultado : out std_logic
	);
	end component;
--mux4
component mux4 is
	port(
	A, B, C, D, op: in std_logic;
	resultado: out std_logic
	);
	end component;
--FIOS:
	signal s_muxA, s_muxB, s_som, s_and, s_or, s_notB, s_notA : std_logic;

begin
m1 : mux2 port map(
	A => A_ula,
	B => s_notA,
	s => Ainverte,
	resultado => s_muxA
);

s_notA <= not A_ula;
s_notB <= not B_ula;

m2 : mux2 port map(
	A => B_ula,
	B => s_notB,
	s => Binverte,
	resultado => s_muxB
);

somador : somador_completo port map(
	A => s_muxA,
	B => s_muxB,
	vem1 => vem1_ula,
	vai1 => vai1_ula,
	resultado => s_som
);

s_and <= s_muxA and s_muxB;
s_or <= s_muxA or s_muxB;

m4bits : mux4 port map(
	A => s_or,
	B => s_and,
	C => s_som,
	D => less,
	op => op_ula,
	resultado => resultado_ula
);

end Behavioral;
