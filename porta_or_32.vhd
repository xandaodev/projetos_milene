----------------------------------------------------------------------------------
-- Company: 
-- Engineer: alexandre e julia
-- 
-- Create Date:    14:14:24 11/04/2025 
-- Design Name: 
-- Module Name:    porta_or_32 - Behavioral 
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

entity porta_or_32 is
	port(
		e : in std_logic_vector (31 downto 0); -- mudei pra downto 0
		saida : out std_logic
	);
end porta_or_32;


architecture Behavioral of porta_or_32 is
	signal saidaPrimeiraCamada : std_logic_vector (0 to 7);
	signal saidaSegundaCamada : std_logic_vector (0 to 1);
	
	
begin
	genPrimeiraCamada : for i in 0 to 7 generate
		saidaPrimeiraCamada(i) <= e(4*i) or e(4*i+1) or e(4*i+2) or e(4*i+3);
	end generate;

	genSegundaCamada : for i in 0 to 1 generate
		saidaSegundaCamada(i) <= saidaPrimeiraCamada(4*i) or saidaPrimeiraCamada(4*i+1) or saidaPrimeiraCamada(4*i+2) or saidaPrimeiraCamada(4*i+3);
	end generate;
	
	saida <= saidaSegundaCamada(0) or saidaSegundaCamada(1);
end Behavioral;

