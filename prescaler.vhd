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


entity preskaler is
    Port ( x : in  STD_LOGIC;				
           y : buffer  STD_LOGIC);		
end preskaler;



architecture Behavioral of preskaler is

	signal counter : STD_LOGIC_VECTOR(16 downto 0); 
begin

	
	process(x)
		
	begin
		if rising_edge(x) then					
			counter <= counter + 1;				
			if counter = 42000 then 			
				counter <= (others => '0');	
				
				y <= not y;							
			end if;
		end if;		
		
	end process;
end Behavioral;

