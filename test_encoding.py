# -*- coding: utf-8 -*-                                                          
""" This module gives a shit about encoding. """                                 

from __future__ import print_function                                            
import sys

if __name__ == '__main__':                                                       
    print('---------------------------')                                         
    print('| Unicode Analysis Script |')                                         
    print('---------------------------')                                         
    print('system default encoding  : %s' % sys.getdefaultencoding())            
    print('standard output encoding : %s' % sys.stdout.encoding)                 
    print('filesystem encoding      : %s' % sys.getfilesystemencoding())         
    print('')                                                                    
    unikot = u'Ã¤Âµ'.encode('utf-8')                                               
    print('native unicode string    : \'%s\'' % unikot)                          
    ascii = u'Ã¤Âµ'.encode('ascii',errors='replace')                               
    print('translated to ascii      : \'%s\'' % ascii)                           
    at_euro = u'Ã¤Âµ'.encode('iso-8859-15')                                        
    print('translated to iso-8859-15: \'%s\'' % at_euro)                         
