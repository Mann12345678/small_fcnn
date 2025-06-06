----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/30/2025 02:33:24 PM
-- Design Name: 
-- Module Name: FC_NNetwork - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.std_logic_1164.all;

entity FCNN is
port ( 
      clk : in std_logic;
      input : in std_logic_vector(16383 downto 0);
      output : out std_logic_vector(2 downto 0)
      );
      end entity ;

architecture structure of FCNN is
      
component layer1 is
port ( 
       clk : in std_logic;
       Layer1_input : in std_logic_vector(16383 downto 0); ------------128 neuron
       Layer1_output : out std_logic_vector(2047 downto 0)
       );
end component;      

component layer2 is
port ( 
       clk : in std_logic;
       Layer2_input : in std_logic_vector(2047 downto 0); -------------256 neuron
       Layer2_output : out std_logic_vector(4095 downto 0)
       );
end component;

component layer3 is
port ( 
       clk : in std_logic;
       Layer3_input : in std_logic_vector(4095 downto 0); -------------128 neuron
       Layer3_output : out std_logic_vector(2047 downto 0)
       );
end component;

component layer4 is
port ( 
       clk : in std_logic;
       Layer4_input : in std_logic_vector(2047 downto 0); -------------32 neuron
       Layer4_output : out std_logic_vector(511 downto 0)
       );
end component;

component layer5 is
port ( 
       clk : in std_logic;
       Layer5_input : in std_logic_vector(511 downto 0); --------------5 neuron
       Layer5_output : out std_logic_vector(2 downto 0)
       );
end component;

signal layer_1_output : std_logic_vector(2047 downto 0);
signal layer_2_output : std_logic_vector (4095 downto 0);
signal layer_3_output : std_logic_vector (2047 downto 0);
signal layer_4_output : std_logic_vector (511 downto 0);

begin

l1 : layer1 port map( clk => clk , Layer1_input => input , Layer1_output => layer_1_output );
l2 : layer2 port map( clk => clk , Layer2_input => layer_1_output , Layer2_output => layer_2_output );
l3 : layer3 port map( clk => clk , Layer3_input => layer_2_output , Layer3_output => layer_3_output );
l4 : layer4 port map( clk => clk , Layer4_input => layer_3_output , Layer4_output => layer_4_output );
l5 : layer5 port map( clk => clk , Layer5_input => layer_4_output  , Layer5_output => output );

end structure;