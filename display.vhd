----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:33:41 30/12/2014 
-- Design Name: 
-- Module Name:    LicznikWyswietlacz - Behavioral 
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


entity LicznikWyswietlacz is
    Port ( CLK : in  STD_LOGIC;                         
           R : in  STD_LOGIC;									  
           EC : in  STD_LOGIC;								  
           ES : in  STD_LOGIC;								  
           BAZA : out  STD_LOGIC_VECTOR (3 downto 0);   
           CYFRA : out  STD_LOGIC_VECTOR (6 downto 0);  
           ZPK : out  STD_LOGIC);							  
end LicznikWyswietlacz;

architecture Behavioral of LicznikWyswietlacz is

	function bin7seg(a : STD_LOGIC_VECTOR(3 downto 0)) return STD_LOGIC_VECTOR is   	

	variable TMP : STD_LOGIC_VECTOR(6 downto 0);          
	begin
		case a is
			when "0000" => TMP := "0000001";--0
			when "0001" => TMP := "1001111";--1
			when "0010" => TMP := "0010010";--2
			when "0011" => TMP := "0000110";--3
			when "0100" => TMP := "1001100";--4
			when "0101" => TMP := "0100100";--5
			when "0110" => TMP := "0100000";--6
			when "0111" => TMP := "0001111";--7
			when "1000" => TMP := "0000000";--8
			when "1001" => TMP := "0000100";--9
			when others => TMP := "1111111";
		end case;
		return TMP;
	end bin7seg;
	

	signal c1 : STD_LOGIC_VECTOR (3 downto 0);
	signal c2 : STD_LOGIC_VECTOR (3 downto 0);
	signal c3 : STD_LOGIC_VECTOR (3 downto 0);
	signal c4 : STD_LOGIC_VECTOR (3 downto 0);
	

	signal d1 : STD_LOGIC_VECTOR (3 downto 0);
	signal d2 : STD_LOGIC_VECTOR (3 downto 0);
	signal d3 : STD_LOGIC_VECTOR (3 downto 0);
	signal d4 : STD_LOGIC_VECTOR (3 downto 0);
	
	signal counter : STD_LOGIC_VECTOR (2 downto 0);

	signal stop : STD_LOGIC;
		
begin


	process(CLK,R,EC,ES)
	begin	
		if R = '1' then 							
			counter <= (others => '0');
			c1 <= (others => '0');
			c2 <= (others => '0');
			c3 <= (others => '0');
			c4 <= (others => '0');
			stop <= '0';
		elsif (rising_edge(CLK) and EC = '1' and stop = '0')  then 
			counter <= counter +1;											 
			if counter = 5 then												  
				counter <= (others => '0');						
				if (stop = '0') then											  
					c1 <= c1 + 1; 
					if c1 = 9 then												 
						c1 <= (others => '0');
						c2 <= c2 + 1;
						if c2 = 9 then 
							c2 <= (others => '0');						
							c3 <= c3 + 1;
							if c3 = 9 then
								c3 <= (others => '0');							
								c4 <= c4 + 1; 
								if c4 = 9 then 
									c4 <= (others => '0');
									stop <= '1';
								end if;
							end if;
						end if;
					end if;
				end if;				
			end if;
		end if;
		
	
		if (rising_edge(CLK) and ES = '1') then						  
			d1 <= c1;															  
			d2 <= c2;
			d3 <= c3;
			d4 <= c4;
			if stop = '1' then
				d1 <= "1001";
				d2 <= "1001";
				d3 <= "1001";
				d4 <= "1001";
			end if;			
		end if;
	end process;
	
	
	
	process(CLK)
		variable cout : STD_LOGIC_VECTOR(1 downto 0);			
		variable cout2 : STD_LOGIC_VECTOR(25 downto 0);
		variable cout3 : STD_LOGIC_VECTOR(3 downto 0);		  
		variable kropka : STD_LOGIC;								
	begin
		if rising_edge(CLK) then											
			
			cout := cout + 1;		
			cout2 := cout2 + 1;	

		
								
						
			ZPK <= '1';														
			case cout is													
				when "00" =>
						BAZA <= "1000";									
						CYFRA <= bin7seg(d4);
				when "01" =>
						BAZA <= "0100";
						CYFRA <= bin7seg(d3);
						ZPK <='0';
						if stop = '1' then
							
						end if;						
						
				when "10" =>
						BAZA <= "0010";
						CYFRA <= bin7seg(d2);						
				when others =>
						BAZA <= "0001";
						CYFRA <= bin7seg(d1);								
			end case;
			if CLK='0' and stop='1' then
				ZPK <='0';
			end if;
			if CLK='1' and stop='0' then
				ZPK <='1';
			end if;
				
		
				
		end if;	
	end process;
	
	
end Behavioral;

