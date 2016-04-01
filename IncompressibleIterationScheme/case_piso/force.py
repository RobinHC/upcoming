#!/usr/bin/python

import os
import sys

def extract_raw_data(scale=1/0.01, patch='wing', case_dir='./', time_folder='0', metric='force'):
  """
  Returns a list of 3-tuples (time, scaled x force, scaled y force) from the raw standard OpenFOAM postProcessing output.
  case_dir: directory to find 'postProcessing'.
  patch: name of the patch/boundary to investigate forces.
  time: the time folder within the patch folder to plot.
  metric: 'force' or 'moment'.
  scale: the scale factor to apply (multiply) the raw data.
  """
  history = []
  base_dir = case_dir+"/postProcessing/"+patch+"/"+time_folder+"/"
  raw_data = base_dir+metric+".dat"
  with open(raw_data, 'r') as rf:
    for line in rf:
      if '#' in line:
        continue
      line = line.replace('(','')
      line = line.replace(')','')
      line = line.split()
      history.append( ( float(line[0]), float(line[1])*scale, float(line[2])*scale ) )
  return history

def write_history(history, outputs=['cd.dat', 'cl.dat'], truncation_factor=0.2):
  """
  Creates gnuplot-plottable data files from history tuple list.
  history: a list of tuples (time, scaled x force, scaled y force, ...)
  output: the names of the 2-column data files that gnuplot can use.
  truncation_factor: truncates the first part of the history to get rid of transients.
  """
  for k in range(len(outputs)):
    with open(outputs[k], 'w') as wf:
      start = int( truncation_factor * len(history) )
      for h in history[start:]:
        wf.write( str(h[0])+"\t"+str(h[k+1])+"\n" )
  return

if __name__ == "__main__":
  # Let's plot CL and CD.
  dp = 0.5*1.18*11.176*11.176 
  a = 0.01*0.5
  history = extract_raw_data(scale=1/dp/a, time_folder='0')
  write_history(history,truncation_factor=0.2)

