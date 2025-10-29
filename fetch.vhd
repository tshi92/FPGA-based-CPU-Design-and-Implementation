----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:45:13 11/18/2013 
-- Design Name: 
-- Module Name:    fetch - Behavioral 
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

entity fetch is
    Port ( t0 : in  STD_LOGIC;
           pcNew : in  STD_LOGIC_VECTOR (15 downto 0);
           pcE : in  STD_LOGIC;
           irNew : in  STD_LOGIC_VECTOR (15 downto 0);
           irE : out  STD_LOGIC;
           irOut : out  STD_LOGIC_VECTOR (15 downto 0);
           pcOut : out  STD_LOGIC_VECTOR (15 downto 0);
           reset : in  STD_LOGIC);
end fetch;

architecture Behavioral of fetch is
signal pc: std_logic_vector(15 downto 0):="0000000000000000";
signal ir: std_logic_vector(15 downto 0);

begin
process(pcE,pcNew,t0,reset,irNew)
begin
 irE<='0';
if pcE='1' then
    pc<=pcNew;
end if;
if reset='0' then
  ir<="ZZZZZZZZZZZZZZZZ";
  irE<='0';
elsif t0='1' then
  irE<='1';
  irOut<=irNew;
  pcOut<=pc;
  end if;
end process;
 -- irOut<=ir;
end Behavioral;

