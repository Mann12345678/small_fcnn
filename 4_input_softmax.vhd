library ieee;
use ieee.std_logic_1164.all;

entity Approximate_softmax_function is 
    generic (N : integer := 4 ); -- Number of inputs
    port (
        clk : in std_logic;
        input : in  std_logic_vector(63 downto 0); 
        output  : out std_logic_vector( 2 downto 0)
    );
end Approximate_softmax_function;

architecture Structural of Approximate_softmax_function is 

    component  FP_Adder_Fixed is
      port (
            clk : in std_logic;
            A, B : IN std_logic_vector(15 DOWNTO 0);
          
            Sum  : OUT std_logic_vector(15 DOWNTO 0)
      );
    end component;
    
      component  n_bit_subtractor IS
        GENERIC (N : INTEGER := 4);
        PORT (
            A, B     : IN std_logic_vector(N-1 DOWNTO 0);
            Bin      : IN std_logic;
            D        : OUT std_logic_vector(N-1 DOWNTO 0);
            Bout     : OUT std_logic
        );
    END component ;
    
    
    component N_Bit_Adder is
    generic ( N : integer := 4 );  -- Default is 4-bit adder
    port(
        A, B: in std_logic_vector(N-1 downto 0);
        Cin: in std_logic;  -- Initial carry-in (usually 0)
        Sum: out std_logic_vector(N-1 downto 0);
        Cout: out std_logic  -- Final carry-out
    );
    end component ;
    
    component Comparator is
    generic (N : integer);
      port (
        A, B : in std_logic_vector(N-1 downto 0);
        A_gt_B, A_eq_B, A_lt_B : out std_logic
      );
    end component;

   
TYPE fixed_point_array IS ARRAY (natural RANGE <>) OF std_logic_vector(15 downto 0);   
signal  out1, out2 ,out3 , out4 : std_logic_vector(15 downto 0);
--signal temp_sum : fixed_point_array(0 to N-1); 
signal temp1 , temp2 , temp3  , temp4 ,temp5 ,temp6,temp7,temp8 : std_logic_vector(15 downto 0);
signal exp1, exp2,exp3 , exp4, expsum,  expProb1, expProb2, expProb3 , expProb4 : std_logic_vector(4 downto 0);
signal mantsum, mantsum1, mantsum2, temp9, temp10 : std_logic_vector(10 downto 0);
signal signsoft : std_logic;
signal Mant1 , Mant2 , Mant3 , Mant4 , mantf : std_logic_vector(9 downto 0);
signal a , b , flag1 , A_gt_B , A_eq_B , A_lt_B ,T1_gt_C, T1_eq_C, T1_lt_C  ,T2_gt_C, T2_eq_C, T2_lt_C ,T3_gt_C, T3_eq_C, T3_lt_C : std_logic;


begin  

 

out1 <= input(63 downto 48);
exp1 <= out1(14 downto 10);
Mant1 <= out1(9 downto 0);
out2 <= input(47 downto 32);
exp2 <= out2(14 downto 10);
Mant2 <= out2(9 downto 0);
out3 <= input(31 downto 16);
exp3 <= out2(14 downto 10);
Mant3 <= out2(9 downto 0);
out4 <= input(15 downto 0);
exp4 <= out2(14 downto 10);
Mant4 <= out2(9 downto 0);



            
      
      C2 :  Comparator
      generic map(N => 15)
      port map(A => out1(14 downto 0), B => out2(14 downto 0), A_gt_B => T1_gt_C, A_eq_B => T1_eq_C, A_lt_B => T1_lt_C);
      
        process(out1 , out2 ,T1_gt_C ,T1_lt_C)
      begin
      if((out1(15)= '0') and (out2(15) = '1')) then
      temp2 <= temp1;
      elsif((out1(15)= '1') and (out2(15) = '0'))then
      temp2 <= out2;
      elsif((out1(15)= '0') and (out2(15) = '0'))then
           if (T1_gt_C = '1')then
           temp2 <= out1;
           elsif(T1_lt_C= '1') then
           temp2 <= out2 ;
           end if;
       end if;
       end process; 
       
       C3 :  Comparator
      generic map(N => 15)
      port map(A => temp2(14 downto 0), B => out3(14 downto 0), A_gt_B => T2_gt_C, A_eq_B => T2_eq_C, A_lt_B => T2_lt_C);
      
        process(temp2 , out3 ,T2_gt_C ,T2_lt_C)
      begin
      if((temp2(15)= '0') and (out3(15) = '1')) then
      temp3 <= temp2;
      elsif((temp2(15)= '1') and (out3(15) = '0'))then
      temp3 <= out3;
      elsif((temp2(15)= '0') and (out3(15) = '0'))then
           if (T2_gt_C = '1')then
           temp3 <= temp2;
           elsif(T2_lt_C= '1') then
           temp3 <= out3 ;
           end if;
       end if;
       end process; 
       
        C4 :  Comparator
        generic map(N => 15)
      port map(A => temp3(14 downto 0), B => out4(14 downto 0), A_gt_B => T3_gt_C, A_eq_B => T3_eq_C, A_lt_B => T3_lt_C);
      
        process(temp3 , out4 ,T3_gt_C ,T3_lt_C)
      begin
      if((temp3(15)= '0') and (out4(15) = '1')) then
      temp4 <= temp3;
      elsif((temp3(15)= '1') and (out4(15) = '0'))then
      temp4 <= out4;
      elsif((temp3(15)= '0') and (out4(15) = '0'))then
           if (T3_gt_C = '1')then
           temp4 <= temp3;
           elsif(T3_lt_C= '1') then
           temp4 <= out4 ;
           end if;
       end if;
       end process;
      
--                g2: for i in  0 to N-2 generate
--                signal a_in , b_in : std_logic_vector(15 downto 0);
--                begin
--                    a_in <= input(0) when i= 0 else temp_sum(i-1);
--                    b_in <= input(i+1);
                
--                      F1:FP_Adder_Fixed port map (A => a_in ,B => b_in, Sum => temp_sum(i));
                     
--                end generate;
                
--                temp1 <= temp_sum(N-2);
--                temp_sum(N-1) <= "0000000000000000";
              F2:FP_Adder_Fixed port map (clk => clk,A => out1 ,B => out2, Sum => temp6);
              F3:FP_Adder_Fixed port map (clk => clk,A => temp6 ,B => out3, Sum => temp7);
              F4:FP_Adder_Fixed port map (clk => clk,A => temp7 ,B => out4, Sum => temp8);
              
        signsoft <= temp8(15);
        expsum <= temp8(14 downto 10);
        mantsum <= '1' & temp8(9 downto 0);
        mantsum1 <= "00" & mantsum(10 downto 2);
        mantsum2 <= "0000" & mantsum(10 downto 4);
        
        -------calculation of reciprocal of the the mantsum --------
        
        
                 BitAdder_Inst :  N_Bit_Adder generic map ( N => 11 ) 
                            port map(
                                    A => mantsum1,
                                    B => mantsum2,
                                    Cin => '0',
                                    Sum => temp9,
                                    Cout => a
                                  );
                                  
                 Subtractor : n_bit_subtractor generic map( N => 11)
                              port map(
                                A => "10010000000",
                                B => temp9,
                                Bin => '0',
                                D  =>  temp10,
                                Bout => b 
                             );
               mantf <= temp10(9 downto 0);
               
        ----------------------exp of probabilites-----------------
       
                  
                   BitAdder_Inst2 :  N_Bit_Adder generic map ( N => 5 ) 
                            port map(
                                    A => exp1,
                                    B => expsum,
                                    Cin => '0',
                                    Sum => expProb1,
                                    Cout => b
                                  );
                  
                   BitAdder_Inst3 :  N_Bit_Adder generic map ( N => 5 ) 
                        port map(
                                A => exp2,
                                B => expsum,
                                Cin => '0',
                                Sum => expProb2,
                                Cout => a
                              );
                              
                   BitAdder_Inst4 :  N_Bit_Adder generic map ( N => 5 ) 
                        port map(
                                A => exp3,
                                B => expsum,
                                Cin => '0',
                                Sum => expProb3,
                                Cout => b
                              );
                    BitAdder_Inst5 :  N_Bit_Adder generic map ( N => 5 ) 
                        port map(
                                A => exp4,
                                B => expsum,
                                Cin => '0',
                                Sum => expProb4,
                                Cout => a
                              );
           



--softmaxoutput(0) <= "00" & expProb1(3 downto 0) & mantf;
--softmaxoutput(1) <= "00" & expProb2(3 downto 0) & mantf;
--softmaxoutput(2) <= "00" & expProb3(3 downto 0) & mantf;

process(clk, expProb1 , expProb2, expProb3,expProb4,  out1, out2 ,out3 , out4 ,temp4 )
begin
if rising_edge( clk) then

if( (expProb1 = expProb2) and ( temp4 = out1)) then
output <= "001";
elsif( (expProb1 = expProb2) and ( temp4 = out2)) then
output <= "010";

elsif( (expProb2 = expProb3) and ( temp4 = out2)) then
output <= "010";
elsif( (expProb2 = expProb3) and ( temp4 = out3)) then
output <= "011";

elsif( (expProb3 = expProb4) and ( temp4 = out3)) then
output <= "011";
elsif( (expProb3 = expProb4) and ( temp4 = out4)) then
output <= "100";




elsif( (expProb1 = expProb3) and ( temp4 = out1)) then
output <= "001";
elsif( (expProb1 = expProb3) and ( temp4 = out3)) then
output <= "011";

elsif( (expProb1 = expProb4) and ( temp4 = out1)) then
output <= "001";
elsif( (expProb1 = expProb4) and ( temp4 = out4)) then
output <= "100";

elsif( (expProb2 = expProb4) and ( temp4 = out2)) then
output <= "010";
elsif( (expProb2 = expProb4) and ( temp4 = out4)) then
output <= "100";

elsif( temp8 = out1) then
output <= "001";
elsif ( temp8 = out2) then
output <= "010";
elsif ( temp8 = out3) then
output <= "011";
elsif ( temp8 = out4) then
output <= "100";
end if;
end if;
end process;

end architecture; 


