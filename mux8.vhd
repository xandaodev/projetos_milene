----------------------------------------------------------------------------------
-- Company: 
-- Engineer: alexandre e julia
-- 
-- Create Date:    13:37:53 11/04/2025 
-- Design Name: 
-- Module Name:    mux8 - Behavioral 
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

entity mux8 is
	port(
		e : in std_logic_vector(0 to 7);
		sel : in std_logic_vector (2 downto 0);
		saida : out std_logic 
	);
end mux8;

architecture Behavioral of mux8 is
	component mux2 is
		port(
			A, B, s: in std_logic;
			resultado : out std_logic
		);
end component;
	signal saidaPrimeiraCamada : std_logic_vector (0 to 3);
	signal saidaSegundaCamada : std_logic_vector (0 to 1);

begin
	genPrimeiraCamada : for i in 0 to 3 generate 
	muxPrimeiraCamada : mux2 port map(
		A => e(2*i), 
		B => e(2*i+1), 
		s => sel(0),
		resultado => saidaPrimeiraCamada(i)
	);
	end generate ;
	
	genSegundaCamada : for i in 0 to 1 generate 
	
	muxSegundaCamada : mux2 port map(
		A => saidaPrimeiraCamada(2*i), 
		B => saidaPrimeiraCamada(2*i+1), 
		s => sel(1),
		resultado => saidaSegundaCamada(i)
	);
	
	end generate ;
	
	muxTerceiraCamada : mux2 port map(
		A => saidaSegundaCamada(0), 
		B => saidaSegundaCamada(1), 
		s => sel(2),
		resultado => saida
	);

end Behavioral;
