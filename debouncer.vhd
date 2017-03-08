----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:45:55 7/01/2015 
-- Design Name: 
-- Module Name:    DrganiaStykow - Behavioral 
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


entity DrganiaStykow is
    Port ( CLK : in  STD_LOGIC;   
           x : in  STD_LOGIC;		 
           y : out  STD_LOGIC);	
end DrganiaStykow;

architecture Behavioral of DrganiaStykow is


	signal dx : STD_LOGIC_VECTOR(4 downto 0); 
	

begin

	process(CLK)
	begin
		if rising_edge(CLK) then		
			dx <= dx(3 downto 0) & x;	
			if (dx = "00000") then		
				y <= '1';					
			elsif (dx = "11111") then  
				y <= '0';					
			end if;
		end if;
	end process;
		
end Behavioral;

