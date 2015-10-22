----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:44:08 12/23/2014 
-- Design Name: 
-- Module Name:    PressingMachine - Behavioral 
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

entity PressingMachine is
    Port ( strt : in  STD_LOGIC;
           part : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           locked : in  STD_LOGIC;
           press : in  STD_LOGIC;
           lock : in  STD_LOGIC;
           unlocked : in  STD_LOGIC;
           auto : in  STD_LOGIC;
           move : in  STD_LOGIC;
           intial : out  STD_LOGIC;
           check : out  STD_LOGIC;
           clamp : out  STD_LOGIC;
           unclamp : out  STD_LOGIC;
           pressing : out  STD_LOGIC;
           mov : out  STD_LOGIC);
end PressingMachine;

architecture Behavioral of PressingMachine is
type stat_type is (a,b,c,d,e,f);
signal p_s,n_s : stat_type ;
begin
seq: process(clock,reset)
      begin
       if (reset='1') then p_s <= a;
       elsif (rising_edge(clock)) then p_s <= n_s;
	    end if;
   end process seq;	
	
	com: process (strt,part,locked,unlocked,press,move,auto,p_s)
	    begin
		 intial <= '0';
		 check <= '0';
		clamp <= '0';
		 unclamp <= '0';
		 pressing <= '0';
		 mov <= '0';
		
		 case p_s is
	when a => intial <= '1';
			if (strt = '1') then  
				                 n_s<=b;
			else  n_s <=a;
         end if;
			
	when b => check <= '1';
			if (part = '1') then  
				                 n_s<=c;
			else  n_s <=a;
         end if;
			
	when c => clamp <= '1';
			if (locked = '1') then  
				                 n_s<=d;
			else  n_s <=c;
         end if;
			
			when d => pressing <= '1';
			if (press = '1') then  
				                 n_s<=e;
			else  n_s <=d;
         end if;
			
			when e => unclamp <= '1';
			if (unlocked = '1') then  
				                 n_s<=f;
			else  n_s <=e;
         end if;
			
			when f => mov <= '1';
			if (move = '0') then  
				                 n_s<=f;
			elsif (auto = '1') then n_s<=a;
			else  n_s <=b;
         end if;
		 end case;
			end process com;
			
  
end Behavioral;





