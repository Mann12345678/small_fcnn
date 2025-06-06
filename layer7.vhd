library ieee;
use ieee.std_logic_1164.all;

entity layer7 is
port ( 
       clk : in std_logic;
       Layer7_input : in std_logic_vector(255 downto 0);
       Layer7_output : out std_logic_vector(2 downto 0)
       );
end entity;
    
architecture structure of layer7 is 

component Neu_Ron is 
generic( N : integer := 4);
port ( clk : in std_logic; 
       inputs : in std_logic_vector( ((N*16)-1) downto 0);
       weights : in std_logic_vector( ((N*16)-1) downto 0);
       Bias : in std_logic_vector(15 downto 0);
       weighted_sum : out std_logic_vector(15 downto 0);
       neuron_output :out  std_logic_vector(15 downto 0)
      );
end component;

component Approximate_softmax_function is 
    generic (N : integer := 4 ); -- Number of inputs
    port (
        clk : in std_logic;
        input : in  std_logic_vector(63 downto 0); 
        output  : out std_logic_vector( 2 downto 0)
    );
end component;


type weight_array is array (0 to 3) of std_logic_vector(255 downto 0);
signal weight : weight_array := (
("0011011110001101101011110110100000110111100001001011011010000110001100000001011000111000001000010011011110110110001101011010100010110011010001111011000110111010001101010010011000110101100101100010111101110010101101100100101000110000110100011011011001111010"),
("0010101111010010101101010111001100111000000110000011000001010001101100101111100010100110001010100011010011011101001011001011111100110101110001001010110101011100101110000010101100110010011011101011011111100101001101010011010110101101110010111011100100111010"),
("0011010001100000001100001110110110110101110001010011100011001010101010111011110100111000001010011010110110011001001011011111000100110010110110100011100000000110101101101000011010110101101000101011000110011000101001000110010100110100101000100011011101001001"),
("0010110110011101101100111101011110110110010010001011011010110011001101110011100110110101010001101011100100000000101010100101000010101110011001110011010101000101001100100011111110101100100011001011011100100111001110000000111000101000101000101011001001110001")
                                );
 TYPE fixed_point_array IS ARRAY (natural RANGE <>) OF std_logic_vector(15 downto 0);                                  
 constant bias_array : fixed_point_array(0 to 3):=  ("0001101001100110","1010000001000110","1001010100111110","0001101110100100");

 signal   reg_Layer7out : fixed_point_array(0 to 3);
 signal weighted_sum_array : fixed_point_array(0 to 3);
 signal Layer7_output_temp : std_logic_vector(63 downto 0);
 
 
 
begin

  gen_neurons: for i in 0 to 3 generate
    N: Neu_Ron generic map (N => 16) 
    port map(
      clk => clk,
      inputs => layer7_input, 
      weights => weight(i), 
      Bias => bias_array(i), 
      weighted_sum => weighted_sum_array(i), 
      neuron_output => reg_Layer7out(i)
    );
  end generate;

  -- Update output
  process(clk)
  begin
    if rising_edge(clk) then
      Layer7_output_temp <= weighted_sum_array(0) & weighted_sum_array(1) & weighted_sum_array(2) & weighted_sum_array(3) ;    
     end if;
  end process;
 
 S1 : Approximate_softmax_function  generic map (N => 4 )
     port map (
        clk => clk,
        input => Layer7_output_temp , 
        output => Layer7_output
    );

end architecture  structure ;