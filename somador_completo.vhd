----------------------------------------------------------------------------------
-- Company: 
-- Engineer: xandão e xandona
-- 
-- Create Date:    14:53:32 10/07/2025 
-- Design Name: 
-- Module Name:    somador_completo - Behavioral 
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

entity somador_completo is
	port(
	A, B, vem1 : in std_logic;
	vai1, resultado : out std_logic
	);

end somador_completo;

architecture Behavioral of somador_completo is
	
	component somador is
		port(
		A, B : in std_logic;
		vai1, saida : out std_logic
		);
	end component;
	signal s1, s2, s3, s4 : std_logic;
	
begin
m1 : somador port map(
	A => A,
	B => B,
	saida => s1,
	vai1 => s2
);

m2: somador port map(
	A => s1,
	B => vem1,
	saida => resultado,
	vai1 => s4
);
vai1 <= s2 or s4;

end Behavioral;
