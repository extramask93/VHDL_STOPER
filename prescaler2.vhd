----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:15:56 22/12/2014 
-- Design Name: 
-- Module Name:    preskaler - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity preskaler2 is
    Port ( x : in  STD_LOGIC;				
           y : buffer  STD_LOGIC);		
end preskaler2;



architecture Behavioral of preskaler2 is

	signal counter : STD_LOGIC_VECTOR(25 downto 0); 
begin

	
	process(x)
		
	begin
		if rising_edge(x) then					
			counter <= counter + 1;				
			if counter = 42000000 then 			
				counter <= (others => '0');	 
				
				y <= not y;							
			end if;
		end if;		
		
	end process;
end Behavioral;

