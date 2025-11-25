----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Xandão e Xandona
-- 
-- Create Date:    11:00:58 25/11/2025 
-- Design Name: 
-- Module Name:    uc_ula - Behavioral 
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

entity uc_ula is
    port(
    ALU_op : in std_logic_vector (1 downto 0);
    funct : in std_logic_vector (5 downto 0);
    Ainverte, Binverte : out std_logic;
    operacao : out std_logic_vector (1 downto 0)
    );
end uc_ula;

architecture Behavioral of uc_ula is


begin
    process(ALU_op, funct)
    begin
        if ALU_op = "10" then
---------------------INSTRUÇÕES FUNCT---------------------------------
            if funct = "100000" then--soma
                Ainverte <= '0';
                Binverte <= '0';
                operacao <= "10";

                elsif funct = "100100" then --and
                    Ainverte <= '0';
                    Binverte <= '0';
                    operacao <= "00";

                elsif funct = "100111" then --nor
                    Ainverte <= '1';
                    Binverte <= '1';
                    operacao <= "00";

                elsif funct = "100101" then --or
                    Ainverte <= '0';
                    Binverte <= '0';
                    operacao <= "01";

                elsif funct = "101010" then --slt
                    Ainverte <= '0';
                    Binverte <= '1';
                    operacao <= "11";

                elsif funct = "100010" then --subtração
                    Ainverte <= '0';
                    Binverte <= '1';
                    operacao <= "10";

            end if;
-----------------------------------------------------------------------
---------LW e SW---------
        elsif ALU_op = "00" then
            Ainverte <= '0';
            Binverte <= '0';
            operacao <= "10";

---------BEQ---------
        elsif ALU_op = "01" then
            Ainverte <= '0';
            Binverte <= '1';
            --operacao <= "xx";

    end if;
    end process;

end Behavioral;
