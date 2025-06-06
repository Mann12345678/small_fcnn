library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder is
    port(
        A, B, Cin: in std_logic;
        Sum, Cout: out std_logic
    );
end Full_Adder;

architecture Structural of Full_Adder is
begin
    Sum  <= A XOR B XOR Cin;
    Cout <= (A AND B) OR (B AND Cin) OR (A AND Cin);
end Structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity N_Bit_Adder is
    generic ( N : integer := 4 );  -- Default is 4-bit adder
    port(
        A, B: in std_logic_vector(N-1 downto 0);
        Cin: in std_logic;  -- Initial carry-in (usually 0)
        Sum: out std_logic_vector(N-1 downto 0);
        Cout: out std_logic  -- Final carry-out
    );
end N_Bit_Adder;

architecture Structural of N_Bit_Adder is
    -- Component declaration for Full Adder
    component Full_Adder
        port(
            A, B, Cin: in std_logic;
            Sum, Cout: out std_logic
        );
    end component;

    -- Signals for carry connections
    signal Carry: std_logic_vector(N downto 0);  

begin
    Carry(0) <= Cin; -- Initial carry-in

    -- Generate N full adders
    FA_Gen: for i in 0 to N-1 generate
        FA_Instance: Full_Adder
        port map(
            A    => A(i),
            B    => B(i),
            Cin  => Carry(i),
            Sum  => Sum(i),
            Cout => Carry(i+1)
        );
    end generate;

    Cout <= Carry(N);  -- Final carry-out

end Structural;

