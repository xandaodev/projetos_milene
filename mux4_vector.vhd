----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: xandao e xandona
-- 
-- Create Date:    14:26:33 10/09/2025 
-- Design Name: 
-- Module Name:    mux4 - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4 is
	port(
		e : in std_logic_vector (0 to 3);
        op: in std_logic_vector (0 to 1);
		resultado : out std_logic
	);
end mux4;

architecture Behavioral of mux4 is
	component mux2 is
		port(
			A, B, s: in std_logic;
			resultado : out std_logic
		);
	end component;
	signal s13, s23 : std_logic;
begin
	M1 : mux2 port map (
		A => e(0),
		B => e(1),
		s => op(0),
		resultado => s13
	);

	M2 : mux2 port map (
		A => e(2),
		B => e(3),
		s => op(0),
		resultado => s23
	);

	M3 : mux2 port map (
		A => s13, 
		B => s23,
		s => op(1),
		resultado => resultado
	);


end Behavioral;
