----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Xandão e Xandona
-- 
-- Create Date:    10:52:00 25/11/2025 
-- Design Name: 
-- Module Name:    unidade_controle - Behavioral 
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

entity unidade_controle is
    port(
        op_uc : in std_logic_vector(5 downto 0); 
        ALU_op_uc : out std_logic_vector (1 downto 0); 
        reg_write, reg_dst, ALU_src, branch, mem_write, mem_toReg, jump, mem_read : out std_logic
    );
end unidade_controle;

architecture Behavioral of unidade_controle is


begin
    process(op_uc)
    begin
        if op_uc = "000000" then
            ALU_op_uc <= "10";
            reg_write <= '1';
            reg_dst <= '1';
            ALU_src <= '0';
            branch <= '0';
            mem_write <= '0';
            mem_toReg <= '0';
            jump <= '0';
            mem_read <= '0';

        elsif op_uc = "001000" then
            ALU_op_uc <= "00";
            reg_write <= '1';
            reg_dst <= '0';
            ALU_src <= '1';
            branch <= '0';
            mem_write <= '0';
            mem_toReg <= '0';
            jump <= '0';
            mem_read <= '0';
        
        elsif op_uc = "100011" then
            ALU_op_uc <= "00";
            reg_write <= '1';
            reg_dst <= '0';
            ALU_src <= '1';
            branch <= '0';
            mem_write <= '0';
            mem_toReg <= '1';
            jump <= '0';
            mem_read <= '1';

        elsif op_uc = "101011" then
            ALU_op_uc <= "00";
            reg_write <= '0';
            --reg_dst <= '';
            ALU_src <= '1';
            branch <= '0';
            mem_write <= '1';
            --mem_toReg <= '';
            jump <= '0';
            mem_read <= '0';

        elsif op_uc = "000100" then
            ALU_op_uc <= "01";
            reg_write <= '0';
            --reg_dst <= '';
            ALU_src <= '0';
            branch <= '1';
            mem_write <= '0';
            --mem_toReg <= '';
            jump <= '0';
            mem_read <= '0';

        elsif op_uc = "000010" then
            --ALU_op_uc <= "";
            reg_write <= '0';
            --reg_dst <= '';
            --ALU_src <= '';
            branch <= '0';
            mem_write <= '0';
            --mem_toReg <= '';
            jump <= '1';
            mem_read <= '0';
    end if;
    end process;
end Behavioral;

