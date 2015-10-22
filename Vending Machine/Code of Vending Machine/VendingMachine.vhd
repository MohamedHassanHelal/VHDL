----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:40:18 12/28/2014 
-- Design Name: 
-- Module Name:    VendingMachine - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VendingMachine is
port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           twenty : in  STD_LOGIC;
           ten : in  STD_LOGIC;
			  ready : out  STD_LOGIC;
           ret : out  STD_LOGIC;
           dispense: out  STD_LOGIC;
           coin : out  STD_LOGIC
            );
end VendingMachine;

architecture Behavioral of VendingMachine is
type stat_type is (a,b,c,d,f,i);
signal p_s,n_s : stat_type ;
begin
 seq: process(clock,reset)
      begin
       if (reset='1') then p_s <= a;
       elsif (rising_edge(clock)) then p_s <= n_s;
	    end if;
   end process seq;	
	
	com: process (twenty,ten,p_s)
	    begin
		 ready <= '0';
		 ret  <= '0';
		 dispense <= '0';
		 coin <= '0';
 case p_s is
when a => ready <= '1'; 
			if (twenty = '1') then  n_s<=d;

			    elsif (ten='1') then n_S<=c;
				 
        else  n_S<=a;
		 end if ;
		 
when b => dispense <= '1'; 
			 n_s<=a;
			
when c => coin <= '1'; 
			if (twenty = '1') then  n_s<=f;

			    elsif (ten='1') then n_S<=d;
				 
        else  n_S<=c;
		 end if ;
when d => coin <= '1'; 
			if (twenty = '1') then  n_s<=b;

			    elsif (ten='1') then n_S<=f;
				 
        else  n_S<=d;
		 end if ;
when f => coin <= '1'; 
			if (twenty = '1') then  n_s<=i;

			    elsif (ten='1') then n_S<=b;
				 
        else  n_S<=f;
		 end if ;
when i => ret <= '1'; 
			  n_s<=a;
			 end case;
			end process com;
end Behavioral;





