----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:37:36 22/12/2014 
-- Design Name: 
-- Module Name:    chronometr - Behavioral 
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

entity chronometr is
    Port ( CLK : in  STD_LOGIC;
           START : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           BAZA : out  STD_LOGIC_VECTOR (3 downto 0);
           CYFRA : out  STD_LOGIC_VECTOR (6 downto 0);
           ZPK : out  STD_LOGIC;
			  Y : out STD_LOGIC_VECTOR(5 downto 0));
end chronometr;

architecture Behavioral of chronometr is

	component display
		 Port ( CLK : in  STD_LOGIC;
           R : in  STD_LOGIC;
           EC : in  STD_LOGIC;
           ES : in  STD_LOGIC;
           BAZA : out  STD_LOGIC_VECTOR (3 downto 0);
           CYFRA : out  STD_LOGIC_VECTOR (6 downto 0);
           ZPK : out  STD_LOGIC);
	end component;
	
	component stateMachine
			Port ( PB1 : in  STD_LOGIC;
           PB2 : in  STD_LOGIC;
			  CLK : in  STD_LOGIC;
           R : out  STD_LOGIC;
           EC : out  STD_LOGIC;
           ES : out  STD_LOGIC;
			  Y : out STD_LOGIC_VECTOR(5 downto 0));
	end  component;
	
	component debouncer
		Port ( CLK : in  STD_LOGIC;
           x : in  STD_LOGIC;
           y : out  STD_LOGIC);
	end component;
	
	
	component prescaler
		Port ( x : in  STD_LOGIC;
           y : buffer  STD_LOGIC);
	end component;
	
	component prescaler2
		Port ( x : in  STD_LOGIC;
           y : buffer  STD_LOGIC);
	end component;
	
	---sygna³y wewnêtrzne
	signal qclk : STD_LOGIC;
	signal qclk2 : STD_LOGIC;
	signal qpb1 : STD_LOGIC;
	signal qpb2 : STD_LOGIC;
	signal qr : STD_LOGIC;
	signal qec : STD_LOGIC;
	signal qes : STD_LOGIC;

begin

--------------------------------------------------------- Mapowanie  sygnalow ( przypisanie do komponentow ).

	P1 : prescaler port map(CLK,qclk);								--- Wysylamy do preskaler CLK i qclk
	
	P2 : debouncer port map(qclk,START,qpb1);							--- Wysylamy do dStyk qclk START i qpb1
	
	P3 : debouncer port map(qclk,RESET,qpb2);							--- ect.
	
	P4 : stateMachine port map(qpb1,qpb2,qclk,qr,qec,qes,Y);
	
	P5 : display port map(qclk,qr,qec,qes,BAZA,CYFRA,ZPK);

	P6 : prescaler2 port map(CLK,qclk2);								--- Wysylamy do preskaler CLK i qclk

end Behavioral;

