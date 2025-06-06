library Ieee;
use Ieee.std_logic_1164.all;

entity RelU is
 port(
     Data_in : in std_logic_vector (15 downto 0);
     Data_out: out std_logic_vector(15 downto 0)
  );
  end entity;
  
architecture structural of RelU is
begin
process(Data_in)
  begin
  if(Data_in(15) = '1')then
  Data_out <= "0000000000000000";
  else
  Data_out <= Data_in;
  end if;
  end process;
end structural;

------------------sub-particle--------------------

library Ieee;
use Ieee.std_logic_1164.all;

entity subparticle is
port ( 
     input : in std_logic_vector( 15 downto 0);
     weight : in std_logic_vector(15 downto 0);
     output : out std_logic_vector ( 15 downto 0)
     );
 end entity;    
architecture structure of subparticle is
component q4_4_multiplier is
    Port (
        A, B : in  STD_LOGIC_VECTOR(15 downto 0); 
        P    : out STD_LOGIC_VECTOR(15 downto 0) 
    );
end component;
begin

m1 : q4_4_multiplier port map(A => input , B => weight , P => output);

end structure;

--------------neuron-----------------

library Ieee;
use Ieee.std_logic_1164.all;

entity Neu_Ron is 
generic( N : integer := 4);
port ( 
       clk : in std_logic; 
       inputs : in std_logic_vector( ((N*16)-1) downto 0);
       weights : in std_logic_vector( ((N*16)-1) downto 0);
       Bias : in std_logic_vector(15 downto 0);
       weighted_sum : out std_logic_vector(15 downto 0);
       neuron_output :out  std_logic_vector(15 downto 0)
      );
end entity;

architecture structure of Neu_Ron is  
  
TYPE fixed_point_array IS ARRAY (natural RANGE <>) OF std_logic_vector(15 downto 0);
signal temp_inputs : fixed_point_array(0 to N-1);
signal temp_weights : fixed_point_array(0 to N-1);
signal temp_product : fixed_point_array(0 to N-1);
signal temp_sum :  fixed_point_array(0 to N-1);
signal sum_accum , biased , activated : std_logic_vector(15 downto 0);

component  FP_Adder_Fixed is
  port ( 
        clk : in std_logic;
        A, B : IN std_logic_vector(15 DOWNTO 0);     
        Sum  : OUT std_logic_vector(15 DOWNTO 0)
  );
end component;

component subparticle is
port ( 
     input : in std_logic_vector( 15 downto 0);
     weight : in std_logic_vector(15 downto 0);
     output : out std_logic_vector ( 15 downto 0)
     );
 end component;    

component RelU is
 port(
     Data_in : in std_logic_vector (15 downto 0);
     Data_out: out std_logic_vector(15 downto 0)
  );
  end component;
begin

    g1 : for i in 0 to N-1 generate
    temp_inputs(i) <= inputs(((i+1)*16)-1 downto i*16);
    temp_weights(i) <= weights(((i+1)*16)-1 downto i*16);
    end generate;
    
    g2 : for i in 0 to N-1 generate 
    m1 : subparticle port map ( input => temp_inputs(i) , weight => temp_weights(i), output => temp_product(i));
    end generate;  
  
                g3: for i in  0 to N-2 generate
                signal a_in , b_in : std_logic_vector(15 downto 0);
                begin
                    a_in <= temp_product(0) when i= 0 else temp_sum(i-1);
                    b_in <= temp_product(i+1);
                
                    F1:FP_Adder_Fixed port map (clk =>clk,A => a_in ,B => b_in, Sum => temp_sum(i));
                     
                end generate;
                
                sum_accum<= temp_sum(N-2);
                temp_sum(N-1) <= "0000000000000000";
                     
                F2 :FP_Adder_Fixed port map (clk => clk ,A => sum_accum ,B=> Bias ,  Sum => Biased);
                weighted_sum <= Biased;
                
                A : RelU port map( Data_in => Biased , Data_out => activated);
                
                neuron_output <= activated;
                
 end structure;              
                