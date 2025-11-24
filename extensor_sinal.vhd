----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Xandão e Xandona
-- 
-- Create Date:    20:37:38 24/11/2025 
-- Design Name: 
-- Module Name:    extensor_sinal - Behavioral 
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

entity extensor_sinal is
    port(
        entrada_16 : in std_logic_vector (15 downto 0);
        saida_32   : out std_logic_vector (31 downto 0)
    );
end extensor_sinal;

architecture Behavioral of extensor_sinal is
    -- sinal que armazena o bit mais significativo (msb) da entrada,  que sera replicado 16 vezesa
    signal bit_msb : std_logic;
begin
    saida_32(15 downto 0) <= entrada_16;
    bit_msb <= entrada_16(15);
    --generate
    gen_extensao : for i in 16 to 31 generate
        saida_32(i) <= bit_msb;
    end generate;
    
end Behavioral;
