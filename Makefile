# luamylib - some funcs in Lua
# (c) 2009-10 Alacner zhang <alacner@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHOR OR COPYRIGHT HOLDER BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# If you use this package in a product, an acknowledgment in the product
# documentation would be greatly appreciated (but it is not required).

#CC = gcc
#RM = rm

DRIVER_LIBS= -I/usr/local/openssl/include/ -L/usr/local/openssl/lib -fPIC -I/usr/local/percona/include -L/usr/local/percona/lib -lperconaserverclient -lpthread -lm -lrt -lssl -lcrypto -ldl -lz
DRIVER_INCS= -I/usr/local/percona/include

# Name of .pc file. "lua5.1" on Debian/Ubuntu
LUAPKG = lua5.1

WARN= -Wall -Wmissing-prototypes -Wmissing-declarations
#CFLAGS = `pkg-config $(LUAPKG) --cflags` -O3 $(WARN) $(DRIVER_INCS)
#INSTALL_PATH = `pkg-config $(LUAPKG) --variable=INSTALL_CMOD`
#LIBS = `pkg-config $(LUAPKG) --libs`

## If your system doesn't have pkg-config, comment out the previous lines and
## uncomment and change the following ones according to your building
## enviroment.

CFLAGS = -I/usr/local/include/luajit-2.0/ -L/usr/local/lib -O3 -Wall
LIBS = -lluajit-5.1
INSTALL_PATH = /usr/lib/lua/5.1


mysql.so: luamysql.c
	$(CC) -o mysql.so -shared $(LIBS) $(CFLAGS) luamysql.c $(DRIVER_LIBS)

install: mysql.so
	make test
	install -s mysql.so $(INSTALL_PATH)

clean:
	$(RM) mysql.so

test: mysql.so test.lua
	lua test.lua

all: mysql.so
