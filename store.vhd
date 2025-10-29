----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:14:06 11/25/2013 
-- Design Name: 
-- Module Name:    store - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity store is
    Port ( aluIn,MDRIN : in  STD_LOGIC_VECTOR (7 downto 0);
           IR : in  STD_LOGIC_VECTOR (15 downto 0);
           t2 : in  STD_LOGIC;
           ROUT : out  STD_LOGIC_VECTOR(7 downto 0)
		   );
end store;
architecture Behavioral of store is
--signal rtemp : std_logic_vector(7 downto 0);
begin
 
process(t2,IR)
begin 
if t2='1' then
case ir(15 downto 11) is
	when "00000" =>
		ROUT<=aluIn;
	when "00001" =>
		ROUT<=MDRIN;
	when "00011" => 
    	 ROUT<=aluIn;
	when "00100" =>
		 ROUT<=aluIn;
	when "00101" =>
		 ROUT<=aluIn;
	when "00110" =>
		 ROUT<=aluIn;
	when "00111" =>
	 	 ROUT<=aluIn;
	when "01000" =>
		 ROUT<=aluIn;
	when "01001" =>
		 ROUT<=aluIn;
	when "01010" =>
		 ROUT<=aluIn;
	when "01011" =>
		 ROUT<=aluIn;
   when "10010" =>
		 ROUT<=MDRIN;
   when "10001" =>
		 ROUT<=MDRIN;
	when others => null;
	end case;	
--	ROUT<=aluIn;
end if;

end process;
end Behavioral;

