LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY full_subtractor IS
    PORT (
        A, B, Bin : IN std_logic;
        D, Bout   : OUT std_logic
    );
END full_subtractor;

ARCHITECTURE behavior OF full_subtractor IS
BEGIN
    D <= A XOR B XOR Bin;
    Bout <= (NOT A AND B) OR (B AND Bin) OR (NOT A AND Bin);
END behavior;

-- N-bit Subtractor using Full Subtractors

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY n_bit_subtractor IS
    GENERIC (N : INTEGER := 4);
    PORT (
        A, B     : IN std_logic_vector(N-1 DOWNTO 0);
        Bin      : IN std_logic;
        D        : OUT std_logic_vector(N-1 DOWNTO 0);
        Bout     : OUT std_logic
    );
END n_bit_subtractor;

ARCHITECTURE structural OF n_bit_subtractor IS
    SIGNAL borrow : std_logic_vector(N DOWNTO 0);
    
   component full_subtractor IS
    PORT (
        A, B, Bin : IN std_logic;
        D, Bout   : OUT std_logic
    );
END component;
    
BEGIN
    borrow(0) <= Bin;
    
    FS: FOR i IN 0 TO N-1 GENERATE
        FS_inst: full_subtractor
            PORT MAP (
                A    => A(i),
                B    => B(i),
                Bin  => borrow(i),
                D    => D(i),
                Bout => borrow(i+1)
            );
    END GENERATE;
    
    Bout <= borrow(N);
END structural;
