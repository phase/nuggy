module nuggy;
import logger;
import std.stdio;
import std.file;
import std.base64;
import std.json;
import std.algorithm;
import std.string;
import std.conv;

string VERSION = "1.8-0.0.1"; ///Version of Nuggy
string HOSTNAME = "localhost";
ushort PORT = 25565;

void parseArguments(char[][] args) {
    foreach(w; args) {
        if(w == "--debug" || w == "-d") {
            setDebug(true);
        }
        else if(w.startsWith("-h=")){
            HOSTNAME = (to!string(w).split("-h="))[1];
        }
        else if(w.startsWith("-p=")){
            PORT = to!ushort((to!string(w).split("-p="))[1]);
        }
    }
    log("Parsed arguments");
}

int main(char[][] args) {
    writeln("\n Nuggy v" ~ VERSION ~ " initializing...\n");
    parseArguments(args);
    return 0;
}