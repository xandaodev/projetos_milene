----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Julia e Alexandre
-- 
-- Create Date:    14:35:55 11/18/2025 
-- Design Name: 
-- Module Name:    mux_2entradas_5 - Behavioral 
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

entity mux_2entradas_5 is
port(
	e0_mux_2_5 : in std_logic_vector (0 to 31);
	e1_mux_2_5 : in std_logic_vector (0 to 31);
	sel_mux_2_5 : in std_logic;
	saida_mux_2_5 : out std_logic_vector (0 to 31)
);
end mux_2entradas_5;

architecture Behavioral of mux_2entradas_5 is
component mux2 is
	port(
		A, B, s: in std_logic;
		resultado : out std_logic
	);
end component;

begin
gen_mux32: for i in 0 to 4 generate
	mux : mux2 port map(
		A => e0_mux_2_5(i),
		B => e1_mux_2_5(i),
		s => sel_mux_2_5,
		resultado => saida_mux_2_5(i)
	);
end generate;

end Behavioral;
