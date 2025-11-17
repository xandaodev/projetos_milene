----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Julia Neves & Alexandre Vital
-- 
-- Create Date:    14:46:50 10/07/2025 
-- Design Name: 
-- Module Name:    somador - Behavioral 
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

entity somador is
	port(
	A, B : in std_logic;
	vai1, saida : out std_logic
	);
end somador;

architecture Behavioral of somador is

begin
	vai1 <= A and B;
	saida <= A xor B;
end Behavioral;
