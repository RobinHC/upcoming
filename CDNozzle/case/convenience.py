#!/usr/bin/python

import os

def isfloat(value):
  try:
    float(value)
    return True
  except ValueError:
    return False

def isint(value):
  try:
    int(value)
    return True
  except ValueError:
    return False

def isnumber(value):
  return isint(value) or isfloat(value)

def get_times(casedir='./'):
  """
  Gets the timestep folders greater than 0. 
  """
  times = []
  for item in os.listdir(casedir):
    if os.path.isdir(item):
      if isnumber(item) and not item == "0":
        times.append(item) 
  return times

def remove_solution(casedir='./'):
  for item in get_times(casedir):
    os.system('rm -r '+casedir+"/"+item)
  return

def clean(casedir="./"):
  remove_solution(casedir)
  os.system("rm -r "+casedir+"/constant/polyMesh")
  os.system("rm -r "+casedir+"/postProcessing")
  os.system("rm "+casedir+"/log")
  return

if __name__ == "__main__":
  clean()



