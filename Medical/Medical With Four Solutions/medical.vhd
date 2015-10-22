----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:12:50 12/23/2014 
-- Design Name: 
-- Module Name:    medical - Behavioral 
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

entity medical is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           l1 : in  STD_LOGIC;
           l2 : in  STD_LOGIC;
           l3 : in  STD_LOGIC;
           l4 : in  STD_LOGIC;
           strt : in  STD_LOGIC;
           empty : in  STD_LOGIC;
           auto : in  STD_LOGIC;
           v0 : out  STD_LOGIC;
           v1 : out  STD_LOGIC;
           v2 : out  STD_LOGIC;
           v3 : out  STD_LOGIC;
           v4 : out  STD_LOGIC;
           stop : out  STD_LOGIC;
           t : in  STD_LOGIC;
           timer : out  STD_LOGIC;
			  intial : out  STD_LOGIC;
           mixer : out  STD_LOGIC);
end medical;

architecture Behavioral of medical is
type stat_type is (a,b,c,d,e,f,g);
signal p_s,n_s : stat_type ;
begin seq: process(clock,reset)
      begin
       if (reset='1') then p_s <= a;
       elsif (rising_edge(clock)) then p_s <= n_s;
	    end if;
   end process seq;	
	
	com: process (strt,l1,l2,l3,l4,empty,t,auto,p_s)
	    begin
		 intial <= '0';
		 v0 <= '0';
		 v1 <= '0';
		 v2 <= '0';
		 v3 <= '0';
		 v4 <= '0';
		 mixer <= '0';
		 stop <= '0';
		 case p_s is
	when a => intial <= '1';
			if (strt = '1') then  
				                 n_s<=b;
			else  n_s <=a;
         end if;
			
	when b => v0 <= '1';v1 <= '0';
		 v2 <= '0';
		 v3 <= '0';
		 v4 <= '0';		
		 if (empty = '1') then  n_s<=c;

        else n_S<=b;
		 end if ;
   when c => v1 <= '1'; v0<= '0';
		 v2 <= '0';
		 v3 <= '0';
		 v4 <= '0';		
		 if (l1 = '1') then  n_s<=d;

        else  n_S<=c;
		 end if ;	
  when d => v2 <= '1'; v0<= '0';
		 v1 <= '0';
		 v3 <= '0';
		 v4 <= '0';		
		 if (l2 = '1') then  n_s<=e;

        else  n_S<=d;
		 end if ;
		  when e => v3 <= '1'; v0<= '0';
		 v1 <= '0';
		 v2 <= '0';
		 v4 <= '0';		
		 if (l3 = '1') then  n_s<=f;

        else  n_S<=e;
		 end if ;
		  when f => v4 <= '1'; v0<= '0';
		 v2 <= '0';
		 v1 <= '0';
		 v3 <= '0';		
		 if (l4 = '1') then  n_s<=f;

        else  timer<='1' ; v0<='0' ; v1 <= '0'; v2<='0';
		 v3 <= '0';
		 v4 <= '0';
		  n_S<=g;
		 end if ;
		 
		  when g => mixer <= '1'; 
		 		
		 if (t = '1') then  stop<='1'; elsif (auto = '1') then n_s<=b;
        else v0<='1'; n_s<=a;		 
		 end if;
		 end case;
			end process com;
			
  
end Behavioral;

