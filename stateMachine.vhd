----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:37:12 28/12/2014 
-- Design Name: 
-- Module Name:    MaszynaStanow - Behavioral 
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


entity MaszynaStanow is
    Port ( PB1 : in  STD_LOGIC;								
           PB2 : in  STD_LOGIC;								
			  CLK : in  STD_LOGIC;								
           R : out  STD_LOGIC;								
           EC : out  STD_LOGIC;								
           ES : out  STD_LOGIC;								
			  Y : out STD_LOGIC_VECTOR(5 downto 0));		
end MaszynaStanow;

architecture Behavioral of MaszynaStanow is

	
	type stan is (S0,S1,S2,S3,S4,S5);
	signal obecny_stan : stan ; 
	signal nastepny_stan : stan ; 
	
	
	signal pb11 : STD_LOGIC;
	signal pb12 : STD_LOGIC;
	signal pb21 : STD_LOGIC;
	signal pb22 : STD_LOGIC;
	
	
begin

	process(CLK)
	begin
		if rising_edge(CLK) then					
			obecny_stan <= nastepny_stan;
			pb12 <= pb11;
			pb11 <= PB1;
			pb22 <= pb21;
			pb21 <= PB2;
					
		end if;
	end process;


	process(pb11,pb12,pb21,pb22,obecny_stan,clk)
	begin
	if rising_edge(CLK) then						
		R <= '0';	
		EC <= '0';
		ES <= '0';		
		case obecny_stan is										
			when S0 =>															
					R <= '1';																
					ES <= '1';
					Y <="100000";
					if pb11 = '1' and pb12 = '0' then nastepny_stan <= S1;					
					end if;
					if pb21 = '1' and pb22 = '0' then nastepny_stan <= S0;					
					end if;
			when S1 =>
					EC <= '1';																
					ES <= '1';
					Y <="010000";
					if pb11 = '1' and pb12 = '0' then nastepny_stan <= S2;
					end if;
					if pb21 = '1' and pb22 = '0' then nastepny_stan <= S3;
					end if;
			when S2 =>
					Y <="001000";
					if pb11 = '1' and pb12 = '0' then nastepny_stan <= S1;
					end if;
					if pb21 = '1' and pb22 = '0' then nastepny_stan <= S0;
					end if;
			when S3 =>
					EC <= '1';
					Y <="000100";
					if pb11 = '1' and pb12 = '0' then nastepny_stan <= S4;
					end if;
					if pb21 = '1' and pb22 = '0' then nastepny_stan <= S1;
					end if;
			when S4 =>
					Y <="000010";
					if pb11 = '1' and pb12 = '0' then nastepny_stan <= S4;
					end if;
					if pb21 = '1' and pb22 = '0' then nastepny_stan <= S5;
					end if;
			when S5 =>
					ES <= '1';
					Y <="000001";
					if pb11 = '1' and pb12 = '0' then nastepny_stan <= S5;
					end if;
					if pb21 = '1' and pb22 = '0' then nastepny_stan <= S0;
					end if;	
			end case;
		end if;
	end process;

end Behavioral;

