import wishbone
import os
import pandas as pd
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import seaborn as sns
import random
import pickle
import csv
scdata = wishbone.wb.SCData.from_fcs("xxChooseFilexx", cofactor=xxCofactorxx)
curdir = os.path.dirname("xxChooseFilexx")
scdata.run_diffusion_map()
start_cell = xxStartCellxx
waypoints = xxNumWaypointsxx
wb = wishbone.wb.Wishbone(scdata)
wb.run_wishbone(start_cell, components_list=[xxComponetsListxx], num_waypoints=waypoints)
branch = pd.Series.to_frame(wb.branch)
writebranch = curdir + "/branch.csv"
writebranch_colors = curdir + "/branch_colors.csv"
writetrajectory = curdir + "/trajectory.csv"
writewaypoints = curdir + "/waypoints.csv"
branch.to_csv(writebranch)
with open(writebranch_colors, 'w') as f:
	w = csv.DictWriter(f,wb.branch_colors.keys())
	w.writeheader()
	w.writerow(wb.branch_colors)
	f.close()
trajectory = pd.Series.to_frame(wb.trajectory)
trajectory.to_csv(writetrajectory)
a = np.asarray(wb.waypoints)
np.savetxt(writewaypoints, a, delimiter=",")







