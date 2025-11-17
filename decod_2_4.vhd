----------------------------------------------------------------------------------
-- Company: 
-- Engineer: xandão e xandona
-- 
-- Create Date:    14:10:44 11/11/2025 
-- Design Name: 
-- Module Name:    decod_2_4 - Behavioral 
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

entity decod_2_4 is
port(
	e : in std_logic_vector(0 to 1);
	sel : in std_logic;
	resultado_4 : out std_logic_vector(0 to 3)
);
end decod_2_4;

architecture Behavioral of decod_2_4 is
	
signal not0, not1 : std_logic;
begin
not0 <= not e(0);
not1 <= not e(1);

resultado_4(0) <= e(0) and e(1) and sel;
resultado_4(1) <= not0 and e(1) and sel;
resultado_4(2) <= e(0) and not1 and sel;
resultado_4(3) <= not0 and not1 and sel;

end Behavioral;