-------------11 X 11 muiplier-----------    

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplier_11x11 is 
    port(
        X: in std_logic_vector(10 downto 0); 
        Y: in std_logic_vector(10 downto 0);
        P: out std_logic_vector(21 downto 0)
    );
end Multiplier_11x11;

architecture Behavioral of Multiplier_11x11 is 

   type array11x11 is array (0 to 10) of std_logic_vector (10 downto 0);
    signal PC   : array11x11;  -- Partial products
    signal PCS  : array11x11;  -- Carry-save sum
    signal PCC  : array11x11;  -- Carry-save carry
    signal RAS, RAC : std_logic_vector (10 downto 0);
    signal P_var : std_logic_vector(21 downto 0) := "0000000000000000000000";


begin

    -- Generate partial products
    gen_pp: for i in 0 to 10 generate
        gen_pp_inner: for j in 0 to 10 generate
            PC(i)(j) <= X(j) and Y(i);
        end generate;
    end generate;
    
 -- First row: copy partial products and zero carry
    first_row: for j in 0 to 10 generate
        PCS(0)(j) <= PC(0)(j);
        PCC(0)(j) <= '0';
    end generate;
    
-- Carry-save addition: rows 1 to 10
    csa_rows: for i in 1 to 10 generate
        csa_inner: for j in 0 to 9 generate
            PCS(i)(j) <= PC(i)(j) xor PCS(i-1)(j+1) xor PCC(i-1)(j);
            PCC(i)(j) <= (PC(i)(j) and PCS(i-1)(j+1)) or
                         (PCS(i-1)(j+1) and PCC(i-1)(j)) or
                         (PC(i)(j) and PCC(i-1)(j));
        end generate;
        PCS(i)(10) <= PC(i)(10);
    end generate;
  
-- Final stage addition
    RAC(0) <= '0';
    final_add: for i in 0 to 9 generate
        RAS(i) <= PCS(10)(i+1) xor PCC(10)(i) xor RAC(i);
        RAC(i+1) <= (PCS(10)(i+1) and PCC(10)(i)) or
                    (PCC(10)(i) and RAC(i)) or
                    (PCS(10)(i+1) and RAC(i));
    end generate;

    -- Final output product
    assign_output: for i in 0 to 10 generate
        P_var(i) <= PCS(i)(0);
    end generate;

    P_var(11) <= RAS(0);
    P_var(12) <= RAS(1);
    P_var(13) <= RAS(2);
    P_var(14) <= RAS(3);
    P_var(15) <= RAS(4);
    P_var(16) <= RAS(5);
    P_var(17) <= RAS(6);
    P_var(18) <= RAS(7);
    P_var(19) <= RAS(8);
    P_var(20) <= RAS(9);
    P_var(21) <= RAC(10);

    -- Output assignment
    P <= P_var;

end Behavioral;
