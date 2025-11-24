----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Alexandre e julia
-- 
-- Create Date:    20:43:27 24/11/2025 
-- Design Name: 
-- Module Name:    deslocador_2 - Behavioral 
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

entity deslocador_2 is
    port(
        entrada_32 : in std_logic_vector (31 downto 0);
        saida_32   : out std_logic_vector (31 downto 0)
    );
end deslocador_2;

architecture Behavioral of deslocador_2 is
begin
    
    saida_32(31 downto 2) <= entrada_32(29 downto 0);    
    saida_32(1 downto 0) <= "00";
    
end Behavioral;
