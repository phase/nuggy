module protocol.packet;
import nuggy;
import tcpclient;
import logger;
import std.stdio;
import std.file;
import std.base64;
import std.json;
import std.algorithm;
import std.string;
import std.conv;
import std.socket;
import core.stdc.stdlib;

TcpClient client;
InternetAddress address;

void connect(string host, ushort port) {
    address = new InternetAddress(host, port);
    client = new TcpClient(address);
    client.run((data){
        log("Data Recieved:");
        foreach(b;data) {
            write(to!string(b));
        }
    });
}