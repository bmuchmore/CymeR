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
writediffusion1 = curdir + "/" + "DiffusionEigenvalues.csv"
scdata.diffusion_eigenvalues.to_csv(writediffusion1)
writediffusion2 = curdir + "/" + "DiffusionEigenvectors.csv"
scdata.diffusion_eigenvectors.to_csv(writediffusion2)
savename = curdir + "/" + os.path.basename("xxChooseFilexx") + ".pickle"
scdata.save(savename)



