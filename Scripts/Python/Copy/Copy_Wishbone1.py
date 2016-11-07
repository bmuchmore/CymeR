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
scdata = wishbone.wb.SCData.from_fcs("/home/developer/Data/Bendall/CUR/Wishbone/wishbone_input_Bendall.fcs", cofactor=5)
curdir = os.path.dirname("/home/developer/Data/Bendall/CUR/Wishbone/wishbone_input_Bendall.fcs")
scdata.run_diffusion_map()
writediffusion1 = curdir + "/" + "DiffusionEigenvalues.csv"
scdata.diffusion_eigenvalues.to_csv(writediffusion1)
writediffusion2 = curdir + "/" + "DiffusionEigenvectors.csv"
scdata.diffusion_eigenvectors.to_csv(writediffusion2)
savename = curdir + "/" + os.path.basename("/home/developer/Data/Bendall/CUR/Wishbone/wishbone_input_Bendall.fcs") + ".pickle"
scdata.save(savename)



