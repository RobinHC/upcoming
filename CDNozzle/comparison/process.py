#!/usr/bin/python

import os

def mach(datadir, destdir):
  """
  Generates Mach number data from velocity files.
  """
  a = 149.4 # speed of sound for this case.
  upattern = "U.xy"
  for item in os.listdir(datadir):
    if upattern in item:
      mfile = item.replace('U', 'M')
      with open(destdir+"/"+mfile, 'w') as mf:
        with open(datadir+"/"+item, 'r') as uf:
          for line in uf:
            entries = line.split()
            if len(entries) > 0:
              mf.write( entries[0]+"\t" ) # x
              mf.write( str( float(entries[1]) / a ) ) # Mach
              mf.write( '\n' )
  return
def pressure(datadir, destdir):
  """
  Generates pressure number data from velocity files.
  """
  pa2psi = 0.000145038 # speed of sound for this case.
  upattern = "p.xy"
  for item in os.listdir(datadir):
    if upattern in item:
      mfile = item.replace('p.xy', 'P.xy')
      with open(destdir+"/"+mfile, 'w') as mf:
        with open(datadir+"/"+item, 'r') as uf:
          for line in uf:
            entries = line.split()
            if len(entries) > 0:
              mf.write( entries[0]+"\t" ) # x
              mf.write( str( float(entries[1]) * pa2psi ) ) # Mach
              mf.write( '\n' )
  return

def inches(datadir, destdir):
  """
  Converts position from m to inches in all files in datadir.
  """
  itm = 0.0254 # in to m
  for item in os.listdir(datadir):
    if os.path.isfile(datadir+"/"+item):
      with open(destdir+"/"+item, 'w') as new:
        with open(datadir+"/"+item, 'r') as f:
          for line in f:
            entries = line.split()
            if len(entries) > 0:
              entries[0] = str( float(entries[0])/itm )
              new.write( '\t'.join(entries) + "\n" )
  return

if __name__ == "__main__":
  os.system("rm processed/*")
  inches( "present", "processed" )
  mach( "processed", "processed" )
  pressure( "processed", "processed" )


