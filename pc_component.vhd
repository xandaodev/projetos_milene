----------------------------------------------------------------------------------
-- Company: 
-- Engineer: xandao e xandona
-- 
-- Create Date:    13:49:34 11/18/2025 
-- Design Name: 
-- Module Name:    pc_ - Behavioral 
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

entity pc is
	port(
		ini, clk : in std_logic;
		entrada : in std_logic_vector(31 downto 0);
		saida : out std_logic_vector(31 dowto 0)
	);

end pc;

architecture Behavioral of pc is

component ffd_borda_subida is
    port (
		  clear, preset : in std_logic; 
        D, clk, enable_ffd : in std_logic;
        Q, Qb : out std_logic
	 );
	 end component;

begin

--primeiros ffds
gen_ffds : for i in 0 to 9 generate
	ffds : ffd_borda_subida port map(	
		clear => ini,
		preset => '0',
		D => entrada(i),
		enable_ffd => '1',
		clk => clk,
		Q => saida(i)
   );
end generate;

--ffd do meio(décimo)

ffd_meio : ffd_borda_subida port map(
	clear => '0',
	preset => ini,
	D => entrada(10),
	enable_ffd => '1',
	clk => clk,
	Q => saida(10)
);

--ultimos ffds

gen2_ffds : for i in 11 to 31 generate
	ffds2 : ffd_borda_subida port map(	
		clear => ini,
		preset => '0',
		D => entrada(i),
		enable_ffd => '1',
		clk => clk,
		Q => saida(i)
);
end generate;


end Behavioral;
