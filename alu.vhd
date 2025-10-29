----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:30:56 11/20/2013 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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

entity alu is
    Port ( ir : in  STD_LOGIC_VECTOR (15 downto 0);
           pcIn : in  STD_LOGIC_VECTOR (15 downto 0);
           RADR : in  STD_LOGIC_VECTOR (2 downto 0);
           RData : in  STD_LOGIC_VECTOR (7 downto 0);
           reset : in  STD_LOGIC;
           RE : in  STD_LOGIC;
           t1 : in  STD_LOGIC;
			  t2 : in std_logic;
           addr : out  STD_LOGIC_VECTOR (15 downto 0);
           aluOut : out  STD_LOGIC_VECTOR (7 downto 0);
           pcNOut : out  STD_LOGIC_VECTOR (15 downto 0);
		   DataOut : out std_logic_vector(7 downto 0);
		   rd,wr : out std_logic;
           cy : out  STD_LOGIC;
           z : out  STD_LOGIC);
end alu;

architecture Behavioral of alu is
type reg IS array(0 to 7) of std_logic_vector(7 downto 0);
signal regSet : reg;
signal addrReg : std_logic_vector(15 downto 0);
signal A,B,result : std_logic_vector(7 downto 0);
signal regA,regB,regC : std_logic_vector(2 downto 0);
signal tmpA : std_logic_vector(8 downto 0):="000000000";
signal tmpB : std_logic_vector(8 downto 0):="000000000";
signal tmpC : std_logic_vector(8 downto 0):="000000000";
signal tmpResult:std_logic_vector(8 downto 0):="000000000";
signal tmpAdd : std_logic_vector(15 downto 0);
signal cyt : std_logic:='0';
signal zt : std_logic:='0';
signal pctmp : std_logic_vector(15 downto 0);
signal change : std_logic :='1';
begin
process(RE,RADR,RData)
begin
if RE='1' then
regSet(conv_integer(ir(10 downto 8)))<=RData;
end if;
end process;
process(t1,ir,tmpA,tmpB,tmpC,tmpResult,A,B,tmpAdd)
begin 
rd<='0';
wr<='0';
if t1='1' then
case ir(15 downto 11) is
	when "00000" =>
		aluOut<=ir(7 downto 0);
	when "00001" =>
		addr<=regSet(7) & ir(7 downto 0);
		rd<='1';
	when "00010" =>
		addr<=regSet(7) & ir(7 downto 0);
		DataOut<=regSet(conv_integer(ir(10 downto 8)));
		wr<='1';
	when "00011" => 
      --regB<=ir(2 downto 0);
		aluOut<=regSet(conv_integer(ir(2 downto 0)));
	when "00100" =>
		tmpA<="0" & regSet(conv_integer(ir(10 downto 8)));
		tmpB<="0" & ir(7 downto 0);
		tmpC<="00000000" & cyt;
		tmpResult<=tmpA+tmpB+tmpC;
		--cyt<=tmpResult(8);
		aluOut<=tmpResult(7 downto 0);
		 if tmpResult(7 downto 0)="00000000" then
		 z<='1';
		else
		  z<='0';
		 end if;
		-- aluOut<=result;
	when "00101" =>
		--regA<=ir(5 downto 3);
      --regB<=ir(2 downto 0);
		tmpA<="0" & regSet(conv_integer(ir(10 downto 8)));
		tmpB<="0" & regSet(conv_integer(ir(2 downto 0)));
		tmpC<="00000000" & cyt;
		tmpResult<=tmpA+tmpB+tmpC;
		--cyt<=tmpResult(8);
		aluOut<=tmpResult(7 downto 0);
		  if tmpResult(7 downto 0)="00000000" then
		 z<='1';
		else
		  z<='0';
		 end if;
		-- aluOut<=result;
	when "00110" =>
		tmpA<='0'& regSet(conv_integer(ir(10 downto 8)));
		tmpB<='0'& ir(7 downto 0);
		tmpC<="00000000" & cyt;
		tmpResult<=tmpA-tmpB-tmpC;
		--cyt<=tmpResult(8);
		aluOut<=tmpResult(7 downto 0);
		   if tmpResult(7 downto 0)="00000000" then
		 z<='1';
		else
		  z<='0';
		 end if;
		-- aluOut<=result;
	when "00111" =>
		-- regA<=ir(5 downto 3);
		-- regB<=ir(2 downto 0);
		tmpA<="0" & regSet(conv_integer(ir(10 downto 8)));
		tmpB<="0" & regSet(conv_integer(ir(2 downto 0)));
		tmpC<="00000000" & cyt;
		tmpResult<=tmpA-tmpB-tmpC;
		--cyt<=tmpResult(8);
		aluOut<=tmpResult(7 downto 0);
		  if tmpResult(7 downto 0)="00000000" then
		 z<='1';
		else
		  z<='0';
		 end if;
		-- aluOut<=result;
	when "01000" =>
		A<= regSet(conv_integer(ir(10 downto 8)));
		B<=ir(7 downto 0);
		aluOut<=A and B;
	when "01001" =>
		-- regA<=ir(5 downto 3);
  --     regB<=ir(2 downto 0);
		A<=regSet(conv_integer(ir(10 downto 8)));
		B<=regSet(conv_integer(ir(2 downto 0)));
		aluOut<=A and B;
	when "01010" =>
		A<=regSet(conv_integer(ir(10 downto 8)));
		B<=ir(7 downto 0);
		aluOut<=A or B;
	when "01011" =>
		-- regA<=ir(5 downto 3);
  --     regB<=ir(2 downto 0);
		A<=regSet(conv_integer(ir(10 downto 8)));
		B<=regSet(conv_integer(ir(2 downto 0)));
		aluOut<=A or B;
	when "01100" =>
		cyt<='0';
	when "01101" =>
		cyt<='1';
	when "01110" =>
		pcNOut<=regSet(7) & ir(7 downto 0);
	when "01111" =>
		if ir(7)='0' then
		tmpAdd<="00000000" & ir(7 downto 0);
		elsif ir(7)='1' then
		tmpAdd<="11111111" & ir(7 downto 0);
		end if;
		pcNOut<=pcIn+tmpAdd;
	when "10000" =>
		if ir(7)='0' then
		tmpAdd<="00000000" & ir(7 downto 0);
		elsif ir(7)='1' then
		tmpAdd<="11111111" & ir(7 downto 0);
		end if;
		pcNOut<=pcIn+tmpAdd;
	when "10001" =>
		addr<=regSet(7) & regSet(conv_integer(ir(2 downto 0)));
	when "10010" =>
		addr<=change+(regSet(7) & ir(7 downto 0));
		rd<='1';
	when others => null;
	end case;
	--cyt<=tmpResult(8);
	--cy<=cyt;	
	--aluOut<=result;
	--addr<=addrReg;
	-- if tmpResult(7 downto 0)="00000000" then
	-- 	zt<='1';
	-- end if;
	--pcNOut<=pctmp;

	--z<=zt;

end if;
if t2='1' then
if ir(15 downto 11)="00100" or ir(15 downto 11)="00101" or ir(15 downto 11)="00110" or ir(15 downto 11)="00111" then
cyt<=tmpResult(8);
cy<=cyt;
end if;
end if;
end process;
	

end Behavioral;

