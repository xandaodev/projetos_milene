----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:38:27 12/02/2025 
-- Design Name: 
-- Module Name:    somador_extra2 - Behavioral 
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

entity somador_extra2 is
	port(
	A, B : in std_logic_vector(31 downto 0);
	resultado : out std_logic_vector (31 downto 0)
	);
end somador_extra2;

architecture Behavioral of somador_extra2 is
component somador_completo is
port(
	vem1, A, B : in std_logic;
	vai1, resultado : out std_logic
);
end component;
signal vemvai1 : std_logic_vector (0 to 32);
begin
vemvai1(0) <= '0';
gerar : for i in 0 to 31 generate
	s: somador_completo port map(
		A => A(i),
		B => B(i),
		vem1 => vemvai1(i),
		vai1 => vemvai1 (i+1),
		soma => result (i)
	);
end generate;


end Behavioral;

