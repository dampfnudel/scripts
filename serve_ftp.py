#! /usr/bin/env python

from sys                   import argv,exit
from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers    import FTPHandler
from pyftpdlib.servers     import FTPServer

if len(argv) != 2:
  print "usage:", argv[0], "PORT"
  print
  exit(1)
  
authorizer = DummyAuthorizer()
authorizer.add_user("writer", "WRITER", ".", perm="elradfmw")
authorizer.add_anonymous(".")
handler = FTPHandler
handler.authorizer = authorizer
handler.passive_ports = range(60000, 60001)
address = ("0.0.0.0", argv[1])
ftpd = FTPServer(address, handler)
ftpd.serve_forever()
