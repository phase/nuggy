module protocol.packet;
import nuggy;
import std.stdio;
import std.file;
import std.base64;
import std.json;
import std.algorithm;
import std.string;
import std.conv;
import std.socket;
import core.stdc.stdlib;

Socket socket;

void connect(string host, ushort port) {
    socket = new Socket(AddressFamily.INET,  SocketType.STREAM);
    char[1024] buffer;
    socket.connect(new InternetAddress(host, port));
    auto received = socket.receive(buffer);
    writeln("Server said: ", buffer[0 .. received]);
    foreach(line; stdin.byLine) {
       socket.send(line);
       writeln("Server said: ", buffer[0 .. socket.receive(buffer)]);
    }
}