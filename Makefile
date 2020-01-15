server_sources = src/server.cpp src/endpoints_multiuser.cpp
server_objects = $(subst .cpp,.o,$(server_sources))
server_cppflags = -I3rdparty/
server_cxxflags = -std=c++17
server_libs = -pthread -lboost_program_options -lboost_system -largon2 -lfmt

all: rtmp-authserver

$(server_objects): %.o: %.cpp
	g++ -c $+ $(CPPFLAGS) $(server_cppflags) $(server_cxxflags) $(CXXFLAGS) $(CFLAGS) -o $@

rtmp-authserver: $(server_objects)
	g++ $+ $(LDFLAGS) $(server_libs) -o $@

PREFIX = /usr/local

install:
	systemctl stop rtmp-authserver
	cp rtmp-authserver $(DESTDIR)$(PREFIX)/bin
	systemctl start rtmp-authserver
