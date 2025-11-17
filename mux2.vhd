----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: xandao e xandona
-- 
-- Create Date:    13:36:31 10/09/2025 
-- Design Name: 
-- Module Name:    mux2 - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
	port(
		A, B, s: in std_logic;
		resultado : out std_logic
	);
end mux2;

architecture Behavioral of mux2 is

begin
	resultado <= (A and not s) or (B and s);

end Behavioral;
