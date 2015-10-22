----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:01:27 12/28/2014 
-- Design Name: 
-- Module Name:    Garage - Behavioral 
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

entity Garage is
 Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			 
           E : in  STD_LOGIC;
          L : in  STD_LOGIC;
        
			 full : out  STD_LOGIC;
           empty : out  STD_LOGIC
          );
end Garage;

architecture Behavioral of Garage is
type stat_type is (a,b,c);
signal p_s,n_s : stat_type ;
begin
 seq: process(clock,reset)
      begin
       if (reset='1') then p_s <= a;
       elsif (rising_edge(clock)) then p_s <= n_s;
	    end if;
   end process seq;	
	
	com: process (E,L,p_s)
	variable car : integer;
	    begin
		 case p_s is
 when a => 
    empty <= '1';
	 Full <= '0';
		
				
		 if (E = '1') then  car:=car+1; n_S<=b;

        else n_S<=a;
		 end if ;
		 
 when b => 
    empty <= '0';
	 Full <= '0';
		
				
		 if (E = L) then   n_S<=b;
         elsif(E='1' and L='0') then car:=car+1;
			     if(car=50) then n_s<=c;
				  else n_s<=b;
				  end if;
        else car:=car-1;
            if (car=0) then	n_S<=a;
				else n_s<=b;
				end if;
		 end if ;
 when c => 
    empty <= '0';
	 Full <= '1';
		
				
		 if (L = '1') then  car:=car-1; n_S<=b;

        else n_S<=c;
		 end if ;
end case;
end process com;

end Behavioral;






