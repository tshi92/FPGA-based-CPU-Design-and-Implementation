----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:27:43 11/25/2013 
-- Design Name: 
-- Module Name:    writeback - Behavioral 
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

entity writeback is
    Port ( IR,pcIn,pcnIn  : in  STD_LOGIC_VECTOR (15 downto 0);
           RIN : in  STD_LOGIC_VECTOR (7 downto 0);
           cy,t3,z : in  STD_LOGIC;
           pcnOut : out  STD_LOGIC_VECTOR (15 downto 0);
           RADROUT : out  STD_LOGIC_VECTOR (2 downto 0);
           RDataOUT : out  STD_LOGIC_VECTOR (7 downto 0);
           PCE : out  STD_LOGIC;
           RE : out  STD_LOGIC);
end writeback;

architecture Behavioral of writeback is
--signal Raddr : std_logic_vector(2 downto 0);
--signal Rdata : std_logic_vector(7 downto 0);

begin
process(t3,IR,pcIn,RIN,pcnIn)
begin 
if t3='1' then
RE<='0';
PCE<='0';
case ir(15 downto 11) is
	when "00000" =>
		RADROUT<=IR(10 downto 8);
		RDataOUT<=RIN;
		pcnOut<=pcIn+'1';
		RE<='1';
		PCE<='1';
	when "00001" =>
		RADROUT<=IR(10 downto 8);
		RDataOUT<=RIN;
		pcnOut<=pcIn+'1';
		RE<='1';
		PCE<='1';
	when "00011" => 
        RADROUT<=IR(10 downto 8);
		RDataOUT<=RIN;
		pcnOut<=pcIn+'1';
		RE<='1';
		PCE<='1';
	when "00100" =>
		RADROUT<=IR(10 downto 8);
		RDataOUT<=RIN;
		pcnOut<=pcIn+'1';
		RE<='1';
		PCE<='1';
	when "00101" =>
		RADROUT<=IR(10 downto 8);
		RDataOUT<=RIN;
		pcnOut<=pcIn+'1';
		RE<='1';
		PCE<='1';
	when "00110" =>
		RADROUT<=IR(10 downto 8);
		RDataOUT<=RIN;
		pcnOut<=pcIn+'1';
		RE<='1';
		PCE<='1';
	when "00111" =>
		RADROUT<=IR(10 downto 8);
		RDataOUT<=RIN;
		pcnOut<=pcIn+'1';
		RE<='1';
		PCE<='1';
	when "01000" =>
		RADROUT<=IR(10 downto 8);
		RDataOUT<=RIN;
		pcnOut<=pcIn+'1';
		RE<='1';
		PCE<='1';
	when "01001" =>
		RADROUT<=IR(10 downto 8);
		RDataOUT<=RIN;
		pcnOut<=pcIn+'1';
		RE<='1';
		PCE<='1';
	when "01010" =>
		RADROUT<=IR(10 downto 8);
		RDataOUT<=RIN;
		pcnOut<=pcIn+'1';
		RE<='1';
		PCE<='1';
	when "01011" =>
		RADROUT<=IR(10 downto 8);
		RDataOUT<=RIN;
		pcnOut<=pcIn+'1';
		RE<='1';
		PCE<='1';
	when "01110" =>
		pcnOut<=pcnIn;
		PCE<='1';
	when "01111" =>
      if cy='1' then
			pcnOUT<=pcnIn;
			PCE<='1';
		 else 
		 	pcnOUT<=pcIn+'1';
		 	PCE<='1';
		end if;
	when "10000" =>
		 if z='1' then
			pcnOUT<=pcnIn;
			PCE<='1';
		  else
		 pcnOUT<=pcIn+'1';
		 PCE<='1';
		  end if;
	when "10001" =>
		RADROUT<=IR(10 downto 8);
		RDataOUT<=RIN;
		pcnOut<=pcIn+'1';
		RE<='1';
		PCE<='1';
	when "10010" =>
		RADROUT<=IR(10 downto 8);
		RDataOUT<=RIN;
		pcnOut<=pcIn+'1';
		RE<='1';
		PCE<='1';
	when others =>-- null;
		pcnOut<=pcIn+'1';
		PCE<='1';
	end case;
	--RDataOUT<=Rdata;
	--RADROUT<=Raddr;	
end if;
	
end process;

end Behavioral;

