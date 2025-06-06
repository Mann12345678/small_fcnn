 ------fixed point muliplier---------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Normalizer is
    Port (
        mantissa_in  : in  STD_LOGIC_VECTOR(21 downto 0);
        exponent_in  : in  STD_LOGIC_VECTOR(5 downto 0);
        mantissa_out : out STD_LOGIC_VECTOR(9 downto 0);
        exponent_out : out STD_LOGIC_VECTOR(5 downto 0)
    );
end Normalizer;

ARCHITECTURE structural OF Normalizer IS

    SIGNAL mantissa_mux_out_temp1, mantissa_mux_out_temp2 , mantissa_mux_out : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL exponent_add_out  : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL add_input1  :  STD_LOGIC_VECTOR(5 DOWNTO 0);
    signal add_input2  :  STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL select_signal1 ,select_signal2 , temp1    : STD_LOGIC;
    
    
   component N_Bit_Adder is
        generic ( N : integer := 5 );  -- 3-bit adder for exponent addition
        port(
            A, B : in std_logic_vector(N-1 downto 0);
            Cin  : in std_logic;  -- Initial carry-in
            Sum  : out std_logic_vector(N-1 downto 0);
            Cout : out std_logic  -- Carry-out (not used)
        );
    end component;

BEGIN
    -- Select signal is mantissa_in(9)
    select_signal1 <= mantissa_in(21);

    mantissa_mux_out_temp1 <= mantissa_in(20 DOWNTO 11) WHEN select_signal1 = '1' ELSE 
                        mantissa_in(19 DOWNTO 10);
                        
    process(mantissa_in ,select_signal1)
    begin 
    if((mantissa_in(10)= '1') and (select_signal1 ='1')) then                  
    select_signal2 <= '1';
    elsif( (mantissa_in(9)= '1') and (select_signal1 = '0')) then
    select_signal2 <= '1';
    else
     select_signal2 <= '0';
     end if;
     end process;
                            
    -- 5-bit Adder for Exponent
  
   
    add_input1 <= "000001" WHEN select_signal1 = '1'  ELSE "000000";

    -- Instantiate 5-bit Adder
    adder_inst : N_bit_Adder 
        GENERIC MAP (N => 6)
        PORT MAP (
            A   => exponent_in,
            B   => add_input1,
            Cin  => '0',  -- No carry-in at this stage
            Sum => exponent_add_out,
            Cout => temp1  -- Not used
        );
          
     add_input2 <= "0000000001" WHEN select_signal2 = '1'  ELSE "0000000000";

    -- Instantiate 10-bit Adder
    adder_inst1 : N_bit_Adder 
        GENERIC MAP (N => 10)
        PORT MAP (
            A   => mantissa_mux_out_temp1,
            B   => add_input2,
            Cin  => '0',  -- No carry-in at this stage
            Sum => mantissa_mux_out_temp2,
            Cout => temp1  -- Not used
        );  
      
    mantissa_mux_out <=  mantissa_mux_out_temp1  when select_signal2 = '0' else mantissa_mux_out_temp2;
    -- Assign outputs
    mantissa_out <= mantissa_mux_out;
    exponent_out <= exponent_add_out;
    
END structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OverflowDetector is
    Port (
        exponent  : in  STD_LOGIC_VECTOR(4 downto 0);
        overflow  : out STD_LOGIC;
        underflow : out STD_LOGIC
    );
end OverflowDetector;

architecture Structural of OverflowDetector is
begin
    process (exponent)
    begin
        if exponent > "11111" then
            overflow  <= '1';
            underflow <= '0';
        elsif exponent < "00000" then
            overflow  <= '0';
            underflow <= '1';
        else
            overflow  <= '0';
            underflow <= '0';
        end if;
    end process;
end Structural;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity q4_4_multiplier is
    Port (
    
        A, B : in  STD_LOGIC_VECTOR(15 downto 0); 
        P    : out STD_LOGIC_VECTOR(15 downto 0)  
    );
end q4_4_multiplier;

architecture Structural of q4_4_multiplier is
    -- Internal signals
    signal sign_A, sign_B, sign_P : STD_LOGIC;
    signal exp_A, exp_B, adjusted_exp,  temp3: STD_LOGIC_VECTOR(4 downto 0);
    signal exp_sum ,adjusted_exp1,adjusted_exp2 :STD_LOGIC_VECTOR(5 downto 0); 
    signal mant_A, mant_B         : STD_LOGIC_VECTOR(9 downto 0);
    signal mant_A_prep, mant_B_prep : STD_LOGIC_VECTOR(10 downto 0);
    signal mant_P                 : STD_LOGIC_VECTOR(21 downto 0);
    signal normalized_mant        : STD_LOGIC_VECTOR(9 downto 0);
    signal overflow, underflow ,temp4,temp2   : STD_LOGIC;
    signal P_temp   : STD_LOGIC_VECTOR(15 downto 0);  

    -- Component: 4x4 Bit Multiplier
    component Multiplier_11X11 is 
        Port (
            X : in  STD_LOGIC_VECTOR(10 downto 0);
            Y : in  STD_LOGIC_VECTOR(10 downto 0);
            P : out STD_LOGIC_VECTOR(21 downto 0)
        );
    end component;

    -- Component: 3-bit Adder for Exponent Addition
   component N_Bit_Adder is
        generic ( N : integer := 5 );  -- 3-bit adder for exponent addition
        port(
            A, B : in std_logic_vector(N-1 downto 0);
            Cin  : in std_logic;  -- Initial carry-in
            Sum  : out std_logic_vector(N-1 downto 0);
            Cout : out std_logic  -- Carry-out (not used)
        );
    end component;

    -- Component: Subtractor for Bias Removal
   component n_bit_subtractor is
        generic ( N : integer := 5 );  -- 3-bit subtractor for bias correction
        port(
            A, B  : in std_logic_vector(N-1 downto 0);
            Bin   : in std_logic;
            D     : out std_logic_vector(N-1 downto 0);
            Bout  : out std_logic
        );
    end component;

    -- Component: Normalization Logic
    component Normalizer is
        Port (
            mantissa_in  : in  STD_LOGIC_VECTOR(21 downto 0);
            exponent_in  : in  STD_LOGIC_VECTOR(5 downto 0);
            mantissa_out : out STD_LOGIC_VECTOR(9 downto 0);
            exponent_out : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;

    -- Component: Overflow/Underflow Detector
    component OverflowDetector is
        Port (
            exponent : in  STD_LOGIC_VECTOR(4 downto 0);
            overflow : out STD_LOGIC;
            underflow : out STD_LOGIC
        );
    end component;

begin
    -- Extract sign, exponent, and mantissa
    sign_A <= A(15);
    sign_B <= B(15);
    exp_B  <= B(14 downto 10);
    mant_A <= A(9 downto 0);
    mant_B <= B(9 downto 0);

    -- Compute result sign
    sign_P <= sign_A XOR sign_B;
      
        
    exp_adder: N_Bit_Adder 
        generic map (N => 5) 
        port map (
            A    => exp_A ,
            B    => exp_B ,
            Cin  => '0',  -- No carry-in at this stage
            Sum  => temp3,
            Cout =>  temp4  -- Not used
        );
        
        
        process(temp3 , temp4)
        begin
        if(( temp3 < "01111") and (temp4 ='0')) then
         exp_sum <= "001111";
         elsif( (temp3 < "01111") and (temp4 = '1')) then
         exp_sum <= temp4 & temp3;
         else 
         exp_sum <= '0' & temp3;
        end if;
        end process; 
        
        -- Handle overflow & underflow
   
        
   -- **Step 2: Subtract Bias (3 i.e., "011")**
      bias_subtractor_A: N_Bit_Subtractor
        generic map (N => 6)
        port map (
            A    => exp_sum,
            B    => "001111",  -- Bias
            Bin  => '0',
            D    => adjusted_exp1 ,
            Bout => temp2
        );
        
  
    mant_A_prep <= '1' & mant_A;
    mant_B_prep <= '1' & mant_B;

    -- Multiply mantissas (5-bit * 5-bit)
    M1: Multiplier_11X11 port map (X => mant_A_prep, Y => mant_B_prep, P => mant_P);
   
    -- Normalize mantissa (shift if needed)
    NORM: Normalizer port map ( mantissa_in=>mant_P, exponent_in=>adjusted_exp1,  mantissa_out=>normalized_mant,  exponent_out =>adjusted_exp2);
    
         process(temp3,adjusted_exp2 ,temp4)
       begin
       if(( temp3 < "01111") and (temp4 ='0'))then
       adjusted_exp <= "00000";
       else
       adjusted_exp <= adjusted_exp2(4 downto 0);
       end if;
       end process;
    
    -- Handle overflow & underflow
    OVERFLOW_CHECK2: OverflowDetector port map (exponent => adjusted_exp, overflow=> overflow, underflow=>underflow);
       
    process( A ,B , sign_P ,adjusted_exp , normalized_mant , overflow, underflow)
    begin
    if( A = "0000000000000000" or B = "0000000000000000" ) or (overflow = '1' and underflow = '1') then
    P_temp <= "0000000000000000";
    else 
    P_temp(15) <= sign_P ;
    P_temp(14) <= adjusted_exp(4); 
    P_temp(13) <= adjusted_exp(3); 
    P_temp(12) <= adjusted_exp(2); 
    P_temp(11) <= adjusted_exp(1);
    P_temp(10) <= adjusted_exp(0);
    P_temp(9) <= normalized_mant(9);
    P_temp(8) <= normalized_mant(8); 
    P_temp(7) <= normalized_mant(7); 
    P_temp(6) <= normalized_mant(6); 
    P_temp(5) <= normalized_mant(5); 
    P_temp(4) <= normalized_mant(4); 
    P_temp(3) <= normalized_mant(3); 
    P_temp(2) <= normalized_mant(2); 
    P_temp(1) <= normalized_mant(1); 
    P_temp(0) <=normalized_mant(0); 
    
  
    end if;
    end process;
    
    P <= P_temp;
end Structural;
