----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:28:18 11/23/2014 
-- Design Name: 
-- Module Name:    WashingMachine - Behavioral 
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

entity WashingMachine is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  emp : in  STD_LOGIC;
           strt : in  STD_LOGIC;
           shot : in  STD_LOGIC;
           full : in  STD_LOGIC;
           too : in  STD_LOGIC;
           empty : in  STD_LOGIC;
			  ohot : out  STD_LOGIC;
           ag : out  STD_LOGIC;
           idle : out  STD_LOGIC;
           pumpfill : out  STD_LOGIC;
           stime : out  STD_LOGIC;
           ptime : out  STD_LOGIC;
			  agitate : out  STD_LOGIC;
			  drain : out  STD_LOGIC;
			  rins1 : out  STD_LOGIC;
			  rins2 : out  STD_LOGIC;
			  spinit : out  STD_LOGIC;
           pump : out  STD_LOGIC;
           strtoff : out  STD_LOGIC;
           spin : out  STD_LOGIC);
end WashingMachine;


architecture Behavioral of WashingMachine is
type stat_type is (a,b,c,d,e,f);
signal p_s,n_s : stat_type ;
begin
  seq: process(clock,reset)
      begin
       if (reset='1') then p_s <= a;
       elsif (rising_edge(clock)) then p_s <= n_s;
	    end if;
   end process seq;	
	
	com: process (strt,shot,full,p_s)
	    begin
		 idle <= '0';
		 agitate <= '0';
		 drain <= '0';
		 rins1 <= '0';
		 rins2 <= '0';
		 spin <= '0';
		 case p_s is
	when a => idle <= '1';
			if (strt = '1') then 
			    if (shot='1') then ohot <='1'; 
			                       if ( full = '1') then stime<='1'; n_S<=b;
								      	else pumpfill<='1'; n_S<=a;
								      	end if;
			    else   if ( full = '0') then stime<='1' ; n_S<=b;
								        	else  pumpfill<='1'; n_S<=a;
											end if ;
			    end if;
			else  n_s <=a;
         end if;
			
	when b => agitate <= '1'; 
			if (strt = '1') then ptime<='1' ; n_s<=b;

			    elsif (too='1') then n_S<=c;
				 
        else  ag<='1' ; n_S<=b;
		 end if ;
   when c => drain <= '1'; 
			if (strt = '0') then  n_s<=c;

			    elsif (empty='1') then n_S<=d;
				 
        else  pump<='1' ; n_S<=c;
		 end if ;	
   when d => rins1 <= '1'; 
			if (strt = '0') then  n_s<=d;

			    elsif (full='1') then stime<='1'; n_S<=e;
				 
        else  pumpfill<='1' ; n_S<=d;
		 end if ;		 
when e => rins2 <= '1';
			if (strt = '1') then 
			    if (too='1') then  
			                       if ( emp = '1') then stime<='1' ; n_S<=f;
								      	else ptime<='1'; n_S<=e;
								      	end if;
			    else   ag<='1'; n_s<=e;
			    end if;
			else ag<='1'; n_s <=e;
         end if;
	when f => spinit <= '1'; 
			if (strt = '0') then ptime<='1' ; n_s<=f;

			    elsif (too='1') then strtoff<='1'; n_S<=a;
				 
        else  spin<='1' ; n_S<=f;
		 end if ;
		 end case;
			end process com;
			
  


end Behavioral;

