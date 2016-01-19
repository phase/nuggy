module tcpclient;
import logger;
import std.conv;
import std.socket;
import std.concurrency;
import core.time;

class TcpListener {
     TcpSocket socket;
    
    this(InternetAddress ia) {
        socket = new TcpSocket();
        assert(socket.isAlive);
        socket.setOption(SocketOptionLevel.SOCKET, SocketOption.REUSEADDR, 1);
    }
    
    this(string hostname, ushort port) {
        this(new InternetAddress(hostname, port));
    }
    
    this(ushort port) {
        this(new InternetAddress(port));
    }
    
    ~this() {
        close();
    }
    
    void listen(int backlog) {
        (cast()socket).listen(backlog);
    }
    
    void close() nothrow @nogc @property {
        if(socket !is null) {
            (cast()socket).close;
        }
    }
}

class TcpClient {
    TcpListener listener;
    
    this(InternetAddress ia) {
        listener = new TcpListener(ia);
    }
    
    this(string hostname, ushort port) {
        listener = new TcpListener(hostname, port);
    }
    
    this(ushort port) {
        listener = new TcpListener(port);
    }
    
    ~this() {
        listener.close();
    }
    
    void run(void function(ubyte[]) handler) {
        spawn(cast(void delegate() shared) () {
            for(;;) {
                ubyte[1024] buffer;
                listener.socket.receive(buffer);
                handler(buffer);
            }
        });
    }
}