import std.stdio;
import serial.device;
import std.string;

SerialPort s_port;
string PortName;
immutable ubyte[] select_cp866 = [0x1b,0x74,0x06];
immutable ubyte[] clear_disp = [0x0c];
string s, choiser,textdata;
//char choiser;

void main()

{
	auto ports = SerialPort.ports;
	writeln("You have ", ports.length, " available com ports: ", ports);
	writeln("Enter port name");
	PortName = chomp(readln());
	if ((s_port is null)||(s_port.closed))
	{
		s_port = new SerialPort(PortName);
	}

	while (choiser != "q")
	{
	writeln("1. Select cp866 codepage.");
	writeln("2. Clear display");
	writeln("3. Enter text");
	writeln("q. Exit");
		choiser = chomp(readln());
		switch (choiser)			
		{
			case "1":s_port.write(select_cp866);
				 writeln("cp866 codepage selected."); 
				 break; 
			case "2":s_port.write(clear_disp);
				 writeln("Display cleared");
				 break;
			case "3":writeln("Enter text:");
				 textdata = chomp(readln());
				 //writeln(textdata);
				 s_port.write(textdata);
				 break;
			case "q","Q":s_port.close;
				 break;
			default:
				 writeln("Wrong number.");
				 break;
		}
	}

}
