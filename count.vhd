----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:10:55 11/18/2013 
-- Design Name: 
-- Module Name:    count - Behavioral 
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

entity count is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           t : out  STD_LOGIC_VECTOR (3 downto 0));
end count;

architecture Behavioral of count is
signal numFlag : std_logic_vector(2 downto 0);
begin
process(clk,reset)
variable num:integer;
variable sum:integer :=0;
begin
if reset='0' then 
	numFlag<="111";
elsif clk'event and clk='1' then
	num:=sum rem 4;
	numFlag<=conv_std_logic_vector(num,3);
	sum:=sum+1;
end if;
end process;
process(numFlag)
begin 
case numFlag is
	when "000" => t<="0001";
	when "001" => t<="0010";
	when "010" => t<="0100";
	when "011" => t<="1000";
	when "111" => t<="0000";
	when others => t<="0000";
	end case;
end process;
end Behavioral;

