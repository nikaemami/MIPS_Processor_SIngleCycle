# MIPS_Processor_SIngleCycle
Design and implementation of MIPS processor with a single-cycle datapath and controller.


Different modules like adder, register, shift register, up counter, multiplexer and comparator were used in this project. Each of these modules is defined in the Modules.v file.

Both the controller and the datapath are seperately defined in the Controller.v and Datapath.v files.

The top level module of the final processor is inititated in MIPS.v, also a test bench was implemented to check the function of the precoessor, which is shown in the TB.v file.

The text file is the machine language instruction for a program to find the maximum number in a list of 20 numbers, and store both the number and its index in the memory.
