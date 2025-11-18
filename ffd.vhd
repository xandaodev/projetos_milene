----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Alexandre e Julia
-- 
-- Create Date:    14:54:58 11/04/2025 
-- Design Name: 
-- Module Name:    ffd - Behavioral 
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

entity ffd is
    port(
        clear, preset : in std_logic; 
        D, clk, enable_ffd_ffd : in std_logic;
        Q, Qb : out std_logic
    );
end ffd;

architecture Behavioral of ffd is
    signal n : std_logic := '0';
begin
    process(clear, preset, clk)
    begin

        if preset = '0' then
            n <= '1';

        elsif clear = '0' then
            n <= '0';

        elsif falling_edge(clk) then
            
            if enable_ffd = '1' then
                n <= D;
            end if;
        
        end if;

    end process;

    Q  <= n;
    Qb <= not n;

end Behavioral;
