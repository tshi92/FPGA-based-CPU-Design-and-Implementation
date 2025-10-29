----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:33:27 11/29/2013 
-- Design Name: 
-- Module Name:    cpu - Behavioral 
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

entity cpu is
 Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           abus : out  STD_LOGIC_VECTOR (15 downto 0);
           dbus : inout  STD_LOGIC_VECTOR (15 downto 0);
           nmerq : out  STD_LOGIC;
           nrd,cyout : out  STD_LOGIC;
           nwr : out  STD_LOGIC;
           nbhe : out  STD_LOGIC;
           nble : out  STD_LOGIC;
		   abusout,irout : out  STD_LOGIC_VECTOR (15 downto 0);
           dbusout : out  STD_LOGIC_VECTOR (15 downto 0);
           nmerqout : out  STD_LOGIC;
           nrdout : out  STD_LOGIC;
           nwrout : out  STD_LOGIC;
           nbheout : out  STD_LOGIC;
			  tout:out std_logic_vector(3 downto 0);
           nbleout : out  STD_LOGIC;
           reout : out std_logic;
			  Raddrout : out std_logic_vector(2 downto 0));
end cpu;

architecture Behavioral of cpu is
component alu is
  Port ( ir : in  STD_LOGIC_VECTOR (15 downto 0);
           pcIn : in  STD_LOGIC_VECTOR (15 downto 0);
           RADR : in  STD_LOGIC_VECTOR (2 downto 0);
           RData : in  STD_LOGIC_VECTOR (7 downto 0);
           reset : in  STD_LOGIC;
           RE : in  STD_LOGIC;
           t1 : in  STD_LOGIC;
			  t2 : in  std_logic;
           addr : out  STD_LOGIC_VECTOR (15 downto 0);
           aluOut : out  STD_LOGIC_VECTOR (7 downto 0);
           pcNOut : out  STD_LOGIC_VECTOR (15 downto 0);
		   DataOut : out std_logic_vector(7 downto 0);--Ïò´æ´¢Ä£¿éÐ´16Î»Êý
		   rd,wr : out std_logic;
           cy : out  STD_LOGIC;
           z : out  STD_LOGIC);
end component;
component count is
	 Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           t : out  STD_LOGIC_VECTOR (3 downto 0));
end component;
component fetch is
 Port ( t0 : in  STD_LOGIC;
           pcNew : in  STD_LOGIC_VECTOR (15 downto 0);
           pcE : in  STD_LOGIC;
           irNew : in  STD_LOGIC_VECTOR (15 downto 0);
           irE : out  STD_LOGIC;
           irOut : out  STD_LOGIC_VECTOR (15 downto 0);
           pcOut : out  STD_LOGIC_VECTOR (15 downto 0);
           reset : in  STD_LOGIC);
end component;
component memctrl is
 Port ( addr : in  STD_LOGIC_VECTOR (15 downto 0);
    	   pcaddr : in STD_LOGIC_VECTOR(15 downto 0);
		   rdata : in std_logic_vector(7 downto 0);
           IRE : in  STD_LOGIC;
           Abus : out  STD_LOGIC_VECTOR (15 downto 0);
           Dbus : inout  STD_LOGIC_VECTOR (15 downto 0);
           ir : out  STD_LOGIC_VECTOR (15 downto 0);
           mdr : out  STD_LOGIC_VECTOR (7 downto 0);
           nbhe,nble,nmerq,NRD,NWR : out  STD_LOGIC;
			  wr,rd : in std_logic);
end component;
component store is
  Port ( aluIn,MDRIN : in  STD_LOGIC_VECTOR (7 downto 0);
           IR : in  STD_LOGIC_VECTOR (15 downto 0);
           t2 : in  STD_LOGIC;
           ROUT : out  STD_LOGIC_VECTOR(7 downto 0));
end component;
component writeback is
  Port ( IR,pcIn,pcnIn  : in  STD_LOGIC_VECTOR (15 downto 0);
           RIN : in  STD_LOGIC_VECTOR (7 downto 0);
           cy,t3,z : in  STD_LOGIC;
           pcnOut : out  STD_LOGIC_VECTOR (15 downto 0);
           RADROUT : out  STD_LOGIC_VECTOR (2 downto 0);
           RDataOUT : out  STD_LOGIC_VECTOR (7 downto 0);
           PCE : out  STD_LOGIC;
           RE : out  STD_LOGIC);
end component;
signal t : std_logic_vector(3 downto 0);
signal irnOut,pcOut,MAR,pcNew,irNew,addr,pcNOut,pcnNout,tmpOut,pcaddr: std_logic_vector(15 downto 0);
signal Raddr : std_logic_vector(2 downto 0);
signal Rdata,result,Rout,Mdrout,Mdrin,data : std_logic_vector(7 downto 0);
signal rd,wr,ire,pcE ,cy,z: std_logic;
signal RE : std_logic:='0';
signal tabus : STD_LOGIC_VECTOR (15 downto 0);
signal tnmerq : STD_LOGIC;
signal tnrd : STD_LOGIC;
signal tnwr : STD_LOGIC;
signal tnbhe : STD_LOGIC;
signal tnble : STD_LOGIC;
begin
c1 : count port map(clk,reset,t);
c2 : fetch port map(t(0),pcNew,pcE,irNew,ire,irnOut,pcOut,reset);
c3 : alu   port map(irnOut,pcOut,Raddr,Rdata,reset,RE,t(1),t(2),addr,result,pcNOut,data,rd,wr,cy,z);
c4 : store port map(result,Mdrin,irnOut,t(2),Rout);
c5 : memctrl port map(addr,pcOut,data,ire,tabus,dbus,irNew,Mdrin,tnbhe,tnble,tnmerq,tnrd,tnwr,wr,rd);
c6 : writeback port map(irnOut,pcOut,pcNOut,Rout,cy,t(3),z,pcNew,Raddr,Rdata,pcE,RE);
nrdout<=tnrd;
nwrout<=tnwr;
abusout<=tabus;
dbusout<=dbus;
irout<=irnOut;
nmerqout<=tnmerq;
tout<=t;
nbheout<=tnbhe;
nbleout<=tnble;
cyout<=cy;
nrd<=tnrd;
nwr<=tnwr;
abus<=tabus;
nmerq<=tnmerq;
nbhe<=tnbhe;
nble<=tnble;
reout<=RE;
Raddrout<=Raddr;
end Behavioral;

