----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:44:54 11/28/2013 
-- Design Name: 
-- Module Name:    memctrl - Behavioral 
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

entity memctrl is
    Port ( 	addr : in  STD_LOGIC_VECTOR (15 downto 0);
    	   	pcaddr : in STD_LOGIC_VECTOR(15 downto 0);
		   	rdata : in std_logic_vector(7 downto 0);
           	IRE : in  STD_LOGIC;
           	Abus : out  STD_LOGIC_VECTOR (15 downto 0);
           	Dbus : inout  STD_LOGIC_VECTOR (15 downto 0);
           	ir : out  STD_LOGIC_VECTOR (15 downto 0);
           	mdr : out  STD_LOGIC_VECTOR (7 downto 0);
           	nbhe,nble,nmerq,NRD,NWR : out  STD_LOGIC;
		   	wr,rd : in std_logic);
end memctrl;

architecture Behavioral of memctrl is
begin

process(wr,rd,addr,IRE,rdata,pcaddr)
begin
if IRE='1' then
Abus<=pcaddr;
NRD<='0';
NWR<='1';
nbhe<='0';
nble<='0';
nmerq<='0';
ir<=Dbus;
Dbus<="ZZZZZZZZZZZZZZZZ";
elsif rd='1' then
Abus<=addr;
nbhe<='1';
nble<='0';
nmerq<='0';
NRD<='0';
NWR<='1';
mdr<=Dbus(7 downto 0);
Dbus<="ZZZZZZZZZZZZZZZZ";
elsif wr='1' then
Abus<=addr;
nbhe<='1';
nble<='0';
nmerq<='0';
NRD<='1';
NWR<='0';
Dbus(7 downto 0)<=rdata;
Dbus(15 downto 8)<="00000000";
else
nbhe<='1';
nble<='1';
nmerq<='1';
NRD<='1';
NWR<='1';
Abus<="ZZZZZZZZZZZZZZZZ";
Dbus<="ZZZZZZZZZZZZZZZZ";
end if;
end process;
end Behavioral;

