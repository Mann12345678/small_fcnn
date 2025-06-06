library ieee;
use ieee.std_logic_1164.all;

entity Comparator is
  generic (N : integer := 5);
  port (
    A, B : in std_logic_vector(N-1 downto 0);
    A_gt_B, A_eq_B, A_lt_B : out std_logic
  );
end entity Comparator;

architecture Behavioral of Comparator is
begin
  process(A, B)
  variable greater, less, equal : std_logic :='0';
  
  begin
    equal := '1';
    greater := '0';
    less := '0';
        
      
    for i in N-1 downto 0 loop
    if A(i) /= B(i) then
      equal := '0';
      if A(i) = '1' then
      greater := '1';
      less := '0';
    else
      greater := '0';
      less := '1';
      end if;
     exit;
   end if;
   end loop;
   A_gt_B <= greater;
   A_eq_B <= equal;
   A_lt_B <= less;
  end process;
end  Behavioral;



library ieee;
use ieee.std_logic_1164.all; 
entity LogicalShiftLeft is
  generic (
    N : integer 
  );
  port (
    Data_in : in std_logic_vector(N-1 downto 0);
    Shift_Amount : in std_logic_vector(4 downto 0);
    Data_out : out std_logic_vector(N-1 downto 0)
  );
end entity LogicalShiftLeft;

architecture Behavioral of LogicalShiftLeft is

begin
  process(Data_in, Shift_Amount)
    variable temp : std_logic_vector(N-1 downto 0);
  begin
    case Shift_Amount is
      when "00000" => temp := Data_in;
      when "00001" => temp := Data_in(N-2 downto 0) & '0';
      when "00010" => temp := Data_in(N-3 downto 0) & "00";
      when "00011" => temp := Data_in(N-4 downto 0) & "000";
      when "00100" => 
        if N >= 5 then
          temp := Data_in(N-5 downto 0) & "0000";
        else
          temp := (others => '0');
        end if;
      when "00101" => 
        if N >= 6 then
          temp := Data_in(N-6 downto 0) & "00000";
        else
          temp := (others => '0');
        end if;
      when "00110" => 
        if N >= 7 then
          temp := Data_in(N-7 downto 0) & "000000";
        else
          temp := (others => '0');
        end if;
      when "00111" => 
        if N >= 8 then
          temp := Data_in(N-8 downto 0) & "0000000";
        else
          temp := (others => '0');
        end if;
      when "01000" => 
        if N >= 9 then
          temp := Data_in(N-9 downto 0) & "00000000";
        else
          temp := (others => '0');
        end if;
      when "01001" => 
        if N >= 10 then
          temp := Data_in(N-10 downto 0) & "000000000";
        else
          temp := (others => '0');
        end if;
      when "01010" => 
        if N >= 11 then
          temp := Data_in(N-11 downto 0) & "0000000000";
        else
          temp := (others => '0');
        end if;
      when "01011" => 
        if N >= 12 then
          temp := Data_in(N-12 downto 0) & "00000000000";
        else
          temp := (others => '0');
        end if;
      when "01100" => 
        if N >= 13 then
          temp := Data_in(N-13 downto 0) & "000000000000";
        else
          temp := (others => '0');
        end if;
      when "01101" => 
        if N >= 14 then
          temp := Data_in(N-14 downto 0) & "0000000000000";
        else
          temp := (others => '0');
        end if; 
        
        when "01110" => 
        if N >= 14 then
          temp := Data_in(N-15 downto 0) & "00000000000000";
        else
          temp := (others => '0');
        end if; 
        
         when "01111" => 
        if N >= 15 then
          temp := Data_in(N-16 downto 0) & "000000000000000";
        else
          temp := (others => '0');
        end if; 
        
          when "10000" => 
        if N >= 16 then
          temp := Data_in(N-17 downto 0) & "0000000000000000";
        else
          temp := (others => '0');
        end if;  
        
         when "10001" => 
        if N >= 17 then
          temp := Data_in(N-18 downto 0) & "00000000000000000";
        else
          temp := (others => '0');
        end if; 
        
         when "10010" => 
        if N >= 18 then
          temp := Data_in(N-19 downto 0) & "000000000000000000";
        else
          temp := (others => '0');
        end if; 
        
         when "10011" => 
        if N >= 20 then
          temp := Data_in(N-20 downto 0) & "0000000000000000000";
        else
          temp := (others => '0');
        end if; 
        
         when "10100" => 
        if N >= 21 then
          temp := Data_in(N-21 downto 0) & "00000000000000000000";
        else
          temp := (others => '0');
        end if; 
        
         when "10101" => 
        if N >= 22 then
          temp := Data_in(N-22 downto 0) & "000000000000000000000";
        else
          temp := (others => '0');
        end if; 
        
         when "10110" => 
        if N >= 23 then
          temp := Data_in(N-23 downto 0) & "0000000000000000000000";
        else
          temp := (others => '0');
        end if; 
        
          when "10111" => 
        if N >= 24 then
          temp := Data_in(N-24 downto 0) & "00000000000000000000000";
        else
          temp := (others => '0');
        end if; 
        
          when "11000" => 
        if N >= 25 then
          temp := Data_in(N-25 downto 0) & "000000000000000000000000";
        else
          temp := (others => '0');
        end if; 
        
          when "11001" => 
        if N >= 26 then
          temp := Data_in(N-26 downto 0) & "0000000000000000000000000";
        else
          temp := (others => '0');
        end if; 
        
          when "11010" => 
        if N >= 27 then
          temp := Data_in(N-27 downto 0) & "00000000000000000000000000";
        else
          temp := (others => '0');
        end if; 
        
          when "11011" => 
        if N >= 28 then
          temp := Data_in(N-28 downto 0) & "000000000000000000000000000";
        else
          temp := (others => '0');
        end if; 
        
         when "11100" => 
        if N >= 29 then
          temp := Data_in(N-29 downto 0) & "0000000000000000000000000000";
        else
          temp := (others => '0');
        end if;
        
         when "11101" => 
        if N >= 30 then
          temp := Data_in(N-30 downto 0) & "00000000000000000000000000000";
        else
          temp := (others => '0');
        end if;
        
         when "11110" => 
        if N >= 31 then
          temp := Data_in(N-31 downto 0) & "000000000000000000000000000000";
        else
          temp := (others => '0');
        end if;       
        
        ------
      when others => 
        temp := (others => '0');
    end case;

      Data_out <= temp;
  end process; 
end  Behavioral;

--library ieee;
--use ieee.std_logic_1164.all;

--entity LogicalShiftRight is
--  generic (
--    N : integer := 5 -- Data width (default 5 for mantissa)
--  );
--  port (
    
--    Data_in     : in std_logic_vector(N-1 downto 0);
--    Shift_Amount : in std_logic_vector(4 downto 0); -- 4-bit shift amount
--    Data_out    : out std_logic_vector(N+N downto 0)
--  );
--end entity LogicalShiftRight;

--architecture Behavioral of LogicalShiftRight is
--begin
--  process (Data_in, Shift_Amount)
--    variable temp : std_logic_vector(N-1 downto 0);
--  begin
--    temp := Data_in;

--    case Shift_Amount is
--      when "00000" => temp := Data_in;
--      when "00001" => temp := '0' & Data_in(N-1 downto 1);
--      when "00010" => temp := "00" & Data_in(N-1 downto 2);
--      when "00011" => temp := "000" & Data_in(N-1 downto 3);
--      when "00100" => temp := "0000" & Data_in(N-1 downto 4);
--      when "00101" => temp := "00000" & Data_in(N-1 downto 5);
--      when "00110" => temp := "000000" & Data_in(N-1 downto 6); 
--      when "00111" => temp := "0000000" & Data_in(N-1 downto 7);
--      when "01000" => temp := "00000000" & Data_in(N-1 downto 8);
--      when "01001" => temp := "000000000" & Data_in(N-1 downto 9);
--      when "01010" => temp := "0000000000" & Data_in(N-1 downto 10);
--      when "01011" => temp := "00000000000" & Data_in(N-1 downto 11);  
--      when "01100" => temp := "000000000000" & Data_in(N-1 downto 12);
--      when "01101" => temp := "0000000000000" & Data_in(N-1 downto 13);
--      when "01110" => temp := "00000000000000" & Data_in(N-1 downto 14);
--      when "01111" => temp := "000000000000000" & Data_in(N-1 downto 15);
--      when "10000" => temp := "0000000000000000" & Data_in(N-1 downto 16);
--      when "10001" => temp := "00000000000000000" & Data_in(N-1 downto 17);
--      when "10010" => temp := "000000000000000000" & Data_in(N-1 downto 18);
--      when "10011" => temp := "0000000000000000000" & Data_in(N-1 downto 19);
--      when "10100" => temp := "00000000000000000000" & Data_in(N-1 downto 20);
--      when "10101" => temp := "000000000000000000000" & Data_in(N-1 downto 21);
--      when "10110" => temp := "0000000000000000000000" & Data_in(N-1 downto 22);
--      when "10111" => temp := "00000000000000000000000" & Data_in(N-1 downto 23);
--      when "11000" => temp := "000000000000000000000000" & Data_in(N-1 downto 24);
--      when "11001" => temp := "0000000000000000000000000" & Data_in(N-1 downto 25);
--      when "11010" => temp := "00000000000000000000000000" & Data_in(N-1 downto 26);
--      when "11011" => temp := "000000000000000000000000000" & Data_in(N-1 downto 27);
--      when "11100" => temp := "0000000000000000000000000000" & Data_in(N-1 downto 28);
--      when "11101" => temp := "00000000000000000000000000000" & Data_in(N-1 downto 29);
--      when "11110" => temp := "000000000000000000000000000000" & Data_in(N-1 downto 30);
--      when others => temp := (others => '0'); -- Shift beyond N bits results in zero
--    end case;

--    Data_out <= temp;
--  end process; 

--end Behavioral;

library ieee; 
use ieee.std_logic_1164.all;

entity FP_Adder_Fixed is
  port (
        clk : in std_logic;
        A, B : IN std_logic_vector(15 DOWNTO 0);
        Sum  : OUT std_logic_vector(15 DOWNTO 0)
  );
end FP_Adder_Fixed;

architecture Structural of FP_Adder_Fixed is
  signal sign_A, sign_B, result_sign : std_logic := '0';
  signal exp_A, exp_B, result_exp, result_exp_temp1, result_exp_temp2, result_exp_temp3 ,result_exp_temp4 : std_logic_vector(4 downto 0):= "00000";
  signal man_A, man_B : std_logic_vector(41 downto 0) := "000000000000000000000000000000000000000000";
  signal A_greater : std_logic;
  signal exp_diff : std_logic_vector(4 downto 0):= "00000";
  signal aligned_man_A, aligned_man_B : std_logic_vector(41 downto 0):= "000000000000000000000000000000000000000000";
  signal Mantissa_smaller,  Mantissa_Larger , result_man_temp ,sum_result, sub_result: std_logic_vector(41 downto 0):= "000000000000000000000000000000000000000000";
  
  
  signal  normalized_man_temp2 , result_man , adding_unit_temp, man_result  : std_logic_vector(10 downto 0):= "00000000000";
     
  signal temp_bit , adding_unit : std_logic;
  signal exp_A_mux, exp_B_mux : std_logic_vector(4 downto 0):= "00000";

  signal shift_count , go : std_logic_vector(4 downto 0):= "00000";
  signal normalized_man,normalized_man_temp , normalized_man_temp1  : std_logic_vector(10 downto 0):= "00000000000";
  signal exp_gt , exp_gt_reg, exp_eq , exp_eq_reg, exp_lt , exp_lt_reg : std_logic;
  signal man_gt, man_gt_reg, man_eq, man_lt : std_logic;
  signal bias : std_logic_vector(4 downto 0) := "01111";

  signal sum_temp : std_logic_vector(15 DOWNTO 0):= "0000000000000000";
  signal function_decide,temp1 : std_logic;
  signal N1 : integer;
--  signal A_var,B_var : std_logic_vector( 2 downto 0);
  
component Comparator is
  generic (N : integer);
  port (
    A, B : in std_logic_vector(N-1 downto 0);
    A_gt_B, A_eq_B, A_lt_B : out std_logic
  );
end component;

component  n_bit_subtractor IS
    GENERIC (N : INTEGER );
    PORT (
        A, B     : IN std_logic_vector(N-1 DOWNTO 0);
        Bin      : IN std_logic;
        D        : OUT std_logic_vector(N-1 DOWNTO 0);
        Bout     : OUT std_logic
    );
END component;

component N_Bit_Adder is
    generic ( N : integer  );  -- Default is 4-bit adder
    port(
        A, B: in std_logic_vector(N-1 downto 0);
        Cin: in std_logic;  -- Initial carry-in (usually 0)
        Sum: out std_logic_vector(N-1 downto 0);
        Cout: out std_logic  -- Final carry-out
    );
end component;
  
component LogicalShiftLeft is
generic (
        N : integer 
      );
port (  
        Data_in : in std_logic_vector(N-1 downto 0);
        Shift_Amount : in std_logic_vector(4 downto 0);
        Data_out : out std_logic_vector(N-1 downto 0)
);
end component;
    
--component LogicalShiftRight is
--generic (
--            N : integer 
--);
--port (     
--            Data_in : in std_logic_vector(N-1 downto 0);
--            Shift_Amount : in std_logic_vector(4 downto 0);
--            Data_out : out std_logic_vector(N-1 downto 0)
--          );
--end component;
 
   
begin
  -- Step 1: Extract sign, exponent, and mantissa bits
  sign_A <= A(15);
  sign_B <= B(15);
  exp_A <= A(14 downto 10);
  exp_B <= B(14 downto 10);
  man_A <= "0000000000000000000000000000000" & "1" & A(9 downto 0);
  man_B <= "0000000000000000000000000000000" &"1"  & B(9 downto 0);
              
  function_decide <= sign_A xor sign_B;
  
     
    Exp_Comparator : Comparator
      generic map(N => 5)
      port map(A => exp_A, B => exp_B, A_gt_B => exp_gt_reg, A_eq_B => exp_eq_reg, A_lt_B => exp_lt_reg);
      
--  Sub_Unbiased_expA: n_bit_subtractor  generic map(N=>3) port map(A => exp_A, B => bias,Bin => '0', D => unbiased_exp_A, Bout => open);
  
--  Sub_Unbiased_expB: n_bit_subtractor generic map(N=>3) port map(A => exp_B, B => bias, Bin => '0', D => unbiased_exp_B, Bout => open);
--   --     Mantissa Comparison
        
    Man_Comparator : Comparator
      generic map(N => 42)
      port map(A => man_A, B => man_B, A_gt_B => man_gt_reg, A_eq_B => man_eq, A_lt_B => man_lt); 
    
    process(clk)
begin
    if rising_edge(clk) then
        exp_gt <= exp_gt_reg;
        exp_eq <= exp_eq_reg;
        exp_lt <= exp_lt_reg;
        man_gt<= man_gt_reg;
        
    end if;
end process;
    -- Determine A_greater ,sign of result using the comparators
    process(exp_gt, exp_eq, exp_lt , sign_A , sign_B, exp_A, exp_B , man_gt)
    begin
      if exp_gt = '1' then
        A_greater <= '1'; --exponent of A is greater
        result_exp_temp1 <= exp_A;
        result_sign <= sign_A;
      elsif exp_lt = '1' then
        A_greater <= '0'; --exponent of B is greater
        result_exp_temp1 <= exp_B;
        result_sign <= sign_B;
      elsif( exp_eq ='1') then
        if man_gt = '1' then
          A_greater <= '1';
          result_exp_temp1 <= exp_A;
          result_sign <= sign_A;
        else
          A_greater <= '0';
          result_exp_temp1  <= exp_B;
          result_sign <= sign_B;
        end if;
      end if;
    end process;
    

    -- Determine which exponent should be larger (to avoid negative results)
   
    exp_A_mux <= exp_A when  exp_gt = '1' else exp_B;
    exp_B_mux <= exp_B when  exp_gt = '1' else exp_A;
  
    -- Perform a single subtraction (exp_larger - exp_smaller)
    Subtractor_Exp: n_bit_subtractor generic map ( N=>5 ) 
      port map(
        A => exp_A_mux,
        B => exp_B_mux,
        Bin => '0',
        D => exp_diff,
        Bout => temp1
      );

-- Step 4: Align the smaller mantissa using logical shift left
   
       Align_Mantissa_A: LogicalShiftLeft generic map(N => 42) port map(
           
              Data_in => man_A,
              Shift_Amount => exp_diff,
              Data_out => aligned_man_A
            );    
          
   
          Align_Mantissa_B: LogicalShiftLeft generic map(N => 42) port map(
           
                  Data_in => man_B,
                  Shift_Amount => exp_diff,
                  Data_out => aligned_man_B
                );
    
  -- Select which aligned mantissa is valid
  Mantissa_Larger <= aligned_man_A when  A_greater = '1' else aligned_man_B;
   

  Mantissa_smaller <= man_B  when  A_greater = '1' else man_A;
         
 -- Step 5: Perform Addition or Subtraction based on sign bits
          BitAdder_Inst:  N_Bit_Adder generic map ( N => 42 ) 
            port map(
                    A => Mantissa_Larger,
                    B => Mantissa_smaller,
                    Cin => '0',
                    Sum => sum_result,
                    Cout => temp1
                  );
                
          Subtractor_Result: n_bit_subtractor generic map( N => 42)
          port map(
            A => Mantissa_Larger,
            B => Mantissa_smaller,
            Bin => '0',
            D  => sub_result,
            Bout => temp1 
         );
         
       result_man_temp <= sub_result when function_decide = '1' else sum_result;
       
       process(exp_diff , result_man_temp)
       begin
       if(exp_diff = "00000") then
       result_man <= result_man_temp( 10 downto 0);
       temp_bit <= result_man_temp(11);
       adding_unit <= '0';
       
      elsif(exp_diff = "00001") then
       result_man <= result_man_temp( 11 downto 1);
       temp_bit <= result_man_temp(12);
       adding_unit <= result_man_temp(0);
       
      elsif(exp_diff = "00010") then
       result_man <= result_man_temp( 12 downto 2);
       temp_bit <= result_man_temp(13);
       adding_unit <= result_man_temp(1);
       
      elsif(exp_diff = "00011") then
       result_man <= result_man_temp( 13 downto 3);
       temp_bit <= result_man_temp(14);
       adding_unit <= result_man_temp(2);
       
      elsif(exp_diff = "00100") then
       result_man <= result_man_temp( 14 downto 4);
       temp_bit <= result_man_temp(15);
       adding_unit <= result_man_temp(3);
       
       elsif(exp_diff = "00101") then
       result_man <= result_man_temp( 15 downto 5);
       temp_bit <= result_man_temp(16);
       adding_unit <= result_man_temp(4);
       
       elsif(exp_diff = "00110") then
       result_man <= result_man_temp( 16 downto 6);
       temp_bit <= result_man_temp(17);
       adding_unit <= result_man_temp(5);
       
       elsif(exp_diff = "00111") then
       result_man <= result_man_temp( 17 downto 7);
       temp_bit <= result_man_temp(18);
       adding_unit <= result_man_temp(6);
       
       elsif(exp_diff = "01000") then
       result_man <= result_man_temp( 18 downto 8);
       temp_bit <= result_man_temp(19);
       adding_unit <=  result_man_temp(7);
       
       elsif(exp_diff = "01001") then
       result_man <= result_man_temp( 19 downto 9);
       temp_bit <= result_man_temp(20);
       adding_unit <= result_man_temp(8);
       
       elsif(exp_diff = "01010") then
       result_man <= result_man_temp( 20 downto 10);
       temp_bit <= result_man_temp(21);
       adding_unit <=  result_man_temp(9);
       
       elsif(exp_diff = "01011") then
       result_man <= result_man_temp( 21 downto 11);
       temp_bit <= result_man_temp(22);
       adding_unit <=  result_man_temp(10);
       
       elsif(exp_diff = "01100") then
       result_man <= result_man_temp( 22 downto 12);
       temp_bit <= result_man_temp(23);
       adding_unit <=  result_man_temp(11);
       
       elsif(exp_diff = "01101") then
       result_man <= result_man_temp( 23 downto 13);
       temp_bit <= result_man_temp(24);
       adding_unit <=  result_man_temp(12);
       
        elsif(exp_diff = "01110") then
       result_man <= result_man_temp( 24 downto 14);
       temp_bit <= result_man_temp(25);
       adding_unit <=  result_man_temp(13);
       
       elsif(exp_diff = "01111") then
       result_man <= result_man_temp( 25 downto 15);
       temp_bit <= result_man_temp(26);
       adding_unit <=  result_man_temp(14);
       
       elsif(exp_diff = "10000") then
       result_man <= result_man_temp( 26 downto 16);
       temp_bit <= result_man_temp(27);
       adding_unit <=  result_man_temp(15);
       
       elsif(exp_diff = "10001") then
       result_man <= result_man_temp( 27 downto 17);
       temp_bit <= result_man_temp(27);
       adding_unit <=  result_man_temp(15);
       
       elsif(exp_diff = "10010") then
       result_man <= result_man_temp( 28 downto 18);
       temp_bit <= result_man_temp(27);
       adding_unit <=  result_man_temp(15);
       
       elsif(exp_diff = "10011") then
       result_man <= result_man_temp( 29 downto 19);
       temp_bit <= result_man_temp(27);
       adding_unit <=  result_man_temp(15);
       
       elsif(exp_diff = "10100") then
       result_man <= result_man_temp( 30 downto 20);
       temp_bit <= result_man_temp(27);
       adding_unit <=  result_man_temp(19);
       
       elsif(exp_diff = "10101") then
       result_man <= result_man_temp( 31 downto 21);
       temp_bit <= result_man_temp(32);
       adding_unit <=  result_man_temp(20);
       
       elsif(exp_diff = "10110") then
       result_man <= result_man_temp( 32 downto 22);
       temp_bit <= result_man_temp(33);
       adding_unit <=  result_man_temp(21);
       
       elsif(exp_diff = "10111") then
       result_man <= result_man_temp( 33 downto 23);
       temp_bit <= result_man_temp(34);
       adding_unit <=  result_man_temp(22);
       
       elsif(exp_diff = "11000") then
       result_man <= result_man_temp( 34 downto 24);
       temp_bit <= result_man_temp(35);
       adding_unit <=  result_man_temp(23);
       
       elsif(exp_diff = "11001") then
       result_man <= result_man_temp( 35 downto 25);
       temp_bit <= result_man_temp(36);
       adding_unit <=  result_man_temp(24);
       
       elsif(exp_diff = "11010") then
       result_man <= result_man_temp( 36 downto 26);
       temp_bit <= result_man_temp(37);
       adding_unit <=  result_man_temp(25);
       
       elsif(exp_diff = "11011") then
       result_man <= result_man_temp( 37 downto 27);
       temp_bit <= result_man_temp(38);
       adding_unit <=  result_man_temp(26);
       
       elsif(exp_diff = "11100") then
       result_man <= result_man_temp( 38 downto 28);
       temp_bit <= result_man_temp(39);
       adding_unit <=  result_man_temp(27);
       
       elsif(exp_diff = "11101") then
       result_man <= result_man_temp( 39 downto 29);
       temp_bit <= result_man_temp(40);
       adding_unit <=  result_man_temp(28);
       
       elsif(exp_diff = "11110") then
       result_man <= result_man_temp( 40 downto 30);
       temp_bit <= result_man_temp(41);
       adding_unit <=  result_man_temp(29);
       
       
       
       end if;
       end process;
       
       man_result <= result_man;
       
        process(sub_result, sum_result , result_man_temp, function_decide, man_result ,temp_bit)
        begin
            if ((result_man_temp = sub_result) and (function_decide = '1')) then
                if man_result(10) = '1' then
                    shift_count <= "00000"; -- Already normalized
                elsif man_result(9) = '1' then
                    shift_count <= "00001";
                elsif man_result(8) = '1' then
                    shift_count <= "00010";
                elsif man_result(7) = '1' then
                    shift_count <= "00011";
                elsif man_result(6) = '1' then
                    shift_count <= "00100"; -- Maximum shift required
                elsif man_result(5) = '1' then
                    shift_count <= "00101"; -- Maximum shift required   
                elsif man_result(4) = '1' then
                    shift_count <= "00110"; -- Maximum shift required
                elsif man_result(3) = '1' then
                    shift_count <= "00111"; -- Maximum shift required
                elsif man_result(2) = '1' then
                    shift_count <= "01000"; -- Maximum shift required 
                elsif man_result(1) = '1' then
                    shift_count <= "01001"; -- Maximum shift required
                elsif man_result(0) = '1' then
                    shift_count <= "01010"; -- Maximum shift required       
                else
                    shift_count <= "00000"; -- Edge case (all zeros)
                end if;
            elsif ((result_man_temp = sum_result) and (function_decide = '0')) then
                if (temp_bit = '1') then
                    normalized_man_temp1 <= '0' & man_result(10 downto 1);
                    go <= "00001";
                else
                    normalized_man_temp1 <='0' & man_result(9 downto 0);
                    go <= "00000";
                end if;
            end if;
        end process;

 ---if there was a subtraction mantissa is adjusted for 1.xxxx
    Normalized_mantissa: LogicalShiftLeft generic map(N => 11) port map(
             
              Data_in => man_result,
              Shift_Amount => shift_count,
              Data_out => normalized_man_temp2
            );
            
   normalized_man_temp <= normalized_man_temp1 when function_decide = '0' else  normalized_man_temp2;  
  
   ---if there was a subtraction then exponent is also adjusted    
   Result_Exponent: n_bit_subtractor generic map( N =>5)  port map(
                    A => result_exp_temp1,
                    B => shift_count,
                    Bin => '0',
                    D => result_exp_temp2,
                    Bout => temp1
                  );
                  
                  
     process(result_exp_temp1,shift_count,result_exp_temp2)
     begin
     if(result_exp_temp1 >= shift_count) then
       result_exp_temp4 <= result_exp_temp2;
     else
        result_exp_temp4 <= "00000";
     end if;
     end process;  
      
    ----if there was a addition and carry was generted then exponent is incremented            
   g01: N_Bit_Adder generic map (N => 5) port map(
                    A => result_exp_temp1,
                    B =>  go,
                    Cin => '0',
                    Sum => result_exp_temp3,
                    Cout => temp1
                  );

     result_exp <= result_exp_temp4 when result_man_temp = sub_result else result_exp_temp3;    
   
    adding_unit_temp <= "00000000001" when adding_unit = '1' else "00000000000";
       AM: N_Bit_Adder generic map ( N => 11 ) 
            port map(
                    A => normalized_man_temp,
                    B => adding_unit_temp,
                    Cin => '0',
                    Sum => normalized_man,
                    Cout => temp1
                  );
        
   process(A , B , result_sign , result_exp, normalized_man)
     begin 
     if((A = "1000000000000000") or (A ="0000000000000000")) then 
        sum_temp <= B ;
     elsif( (B = "1000000000000000") or (B ="0000000000000000"))then   
        sum_temp  <= A; 
      else
        sum_temp(15) <= result_sign;
        sum_temp(14) <= result_exp(4); 
        sum_temp(13) <= result_exp(3); 
        sum_temp(12) <= result_exp(2); 
        sum_temp(11) <= result_exp(1); 
        sum_temp(10) <= result_exp(0);
        sum_temp(9) <= normalized_man(9);
        sum_temp(8) <= normalized_man(8);
        sum_temp(7) <= normalized_man(7);
        sum_temp(6) <= normalized_man(6);
        sum_temp(5) <= normalized_man(5);
        sum_temp(4) <= normalized_man(4); 
        sum_temp(3) <= normalized_man(3);
        sum_temp(2) <= normalized_man(2);
        sum_temp(1) <= normalized_man(1);
        sum_temp(0) <= normalized_man(0);
      end if;
     end process;
   
    Sum <= sum_temp(15 downto 0);
  
 end Structural;
 