library IEEE;
use IEEE.std_logic_1164.all;

entity FCNN is
port ( 
      clk : in std_logic;
      input : in std_logic_vector(4095 downto 0);
      output : out std_logic_vector(2 downto 0)
      );
      end entity ;

architecture structure of FCNN is
      
component layer_1 is
port ( 
       clk : in std_logic;
       Layer1_input : in std_logic_vector(4095 downto 0); ------------16 neuron
       Layer1_output : out std_logic_vector(255 downto 0)
       );
end component;      

component layer_2 is
port ( 
       clk : in std_logic;
       Layer2_input : in std_logic_vector(255 downto 0); -------------32 neuron
       Layer2_output : out std_logic_vector(511 downto 0)
       );
end component;

component layer3 is
port ( 
       clk : in std_logic;
       Layer3_input : in std_logic_vector(511 downto 0); -------------32 neuron
       Layer3_output : out std_logic_vector(511 downto 0)
       );
end component;

component layer4 is
port ( 
       clk : in std_logic;
       Layer4_input : in std_logic_vector(511 downto 0); -------------16 neuron
       Layer4_output : out std_logic_vector(255 downto 0)
       );
end component;

component layer5 is
port ( 
       clk : in std_logic;
       Layer5_input : in std_logic_vector(255 downto 0); -------------32 neuron
       Layer5_output : out std_logic_vector(511 downto 0)
       );
end component;

component layer6 is
port ( 
       clk : in std_logic;
       Layer6_input : in std_logic_vector(511 downto 0); -------------16 neuron
       Layer6_output : out std_logic_vector(255 downto 0)
       );
end component;

component layer7 is
port ( 
       clk : in std_logic;
       Layer7_input : in std_logic_vector(255 downto 0); --------------5 neuron
       Layer7_output : out std_logic_vector(2 downto 0)
       );
end component;

signal layer_1_output : std_logic_vector(255 downto 0);
signal layer_2_output : std_logic_vector (511 downto 0);
signal layer_3_output : std_logic_vector (511 downto 0);
signal layer_4_output : std_logic_vector (255 downto 0);
signal layer_5_output : std_logic_vector (511 downto 0);
signal layer_6_output : std_logic_vector (255 downto 0);


begin

l1 : layer_1 port map( clk => clk , Layer1_input => input , Layer1_output => layer_1_output );
l2 : layer_2 port map( clk => clk , Layer2_input => layer_1_output , Layer2_output => layer_2_output );
l3 : layer3 port map( clk => clk , Layer3_input => layer_2_output , Layer3_output => layer_3_output );
l4 : layer4 port map( clk => clk , Layer4_input => layer_3_output , Layer4_output => layer_4_output );
l5 : layer5 port map( clk => clk , Layer5_input => layer_4_output  , Layer5_output => layer_5_output );
l6 : layer6 port map( clk => clk , Layer6_input => layer_5_output  , Layer6_output =>  layer_6_output  );
l7 : layer7 port map( clk => clk , Layer7_input => layer_6_output  , Layer7_output => output );


end structure;
