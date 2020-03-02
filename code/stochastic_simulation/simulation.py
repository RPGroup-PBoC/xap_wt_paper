# -*- coding: utf-8 -*-
"""
Created on Thu Feb 28 11:21:44 2019

@author: Kathrin Laxhuber

Theoretical investigation of a genetic switch for metabolic adaptation

Xap System Simulation (3D)
"""

# %% Imports

import numpy as np
import time
import csv
import matplotlib.pyplot as plt
import stochpy
import os 
import sys
from datetime import datetime


# %% Paths

dir_path = os.path.dirname(os.path.realpath(__file__))


# %% Function definitions

def initialize(simulation,params,initials):
    """
    Sets parameter values and initial species numbers.
    """
    for i in range(len(initials)):
        simulation.ChangeInitialSpeciesCopyNumber(initials[i][0],initials[i][1])
    
    for i in range(len(params)):
        simulation.ChangeParameter(params[i][0],params[i][1])     

def repeat(simulation,runs,endtime):
    """
    Perfoms multiple runs of the simulation.
    
    runs: number of runs to perform
    simulation: the simulation to run
    endtime: time until the simulation should run
    """    
    reslist = []  
    
    for i in range(runs):   
        simulation.DoStochSim(mode="time",end=endtime)
        res = simulation.data_stochsim.species[-1]
        
        reslist.append(res)
        
    reslist = np.array(reslist)
        
    return reslist
    
def species_to_index(species):
    if species == "mrna":
        index = 0
    if species == "protein":
        index = 1
    elif species == "xanthosine":
        index = 2
    else:
        sys.exit("Not a valid species.")
        
    return index

def find_plot_distribution(simulation,params,initials,species,runs,endtime):
    """
    Finds, exports and plots the probability distribution of a given species.
    
    params: simulation parameters 
    initials: initial values
    species: the species to plot
    runs: number of runs to perform for this
    simulation: the simulation
    endtime: time until the simulation should run
    """
    initialize(simulation,params,initials)
    
    index = species_to_index(species)
    data = repeat(simulation,runs,endtime)[:,index]
    
    param_export = [(' ' + params[i][0] + ': ' + str(params[i][1])) for i in range(len(params))]
    init_export = [(' ' + initials[i][0] + ': ' + str(initials[i][1])) for i in range(len(initials))]
    
    with open(dir_path + '\\Output\\All From Plots\\distribution' + str(datetime.now().strftime("%Y-%m-%d %H-%M-%S")) + '.csv', mode='w', newline='') as csv_file:
        data_writer = csv.writer(csv_file, delimiter=',')
        data_writer.writerow([species + " distribution from " + str(runs) + " runs"])
        data_writer.writerow(['parameter values: '])
        data_writer.writerows([param_export])
        data_writer.writerow(['initial values: '])
        data_writer.writerows([init_export])
        data_writer.writerow(["data: "])
        data_writer.writerows([[item] for item in data])

    plt.hist(data,bins=np.arange(min(data), max(data) + 1, 5))
    plt.title(species + " distribution from " + str(runs) + " runs of duration " + str(endtime))
    plt.xlabel("number of molecules")
    plt.ylabel("number of occurrences")
    plt.savefig(dir_path + '\\Output\\All From Plots\\distribution' + str(datetime.now().strftime("%Y-%m-%d %H-%M-%S")) + '.png',dpi=300)
    plt.show  
    
def find_distribution_data(simulation,params,initials,runs,endtime):
    """
    Finds and exports the probability distribution of all three species.
    
    params: simulation parameters 
    initials: initial values
    runs: number of runs to perform for this
    simulation: the simulation
    endtime: time until the simulation should run
    """
    initialize(simulation,params,initials)
    data = repeat(simulation,runs,endtime)
    
    param_export = [(' ' + params[i][0] + ': ' + str(params[i][1])) for i in range(len(params))]
    init_export = [(' ' + initials[i][0] + ': ' + str(initials[i][1])) for i in range(len(initials))]
    
    with open(dir_path + '\\Output\\All Full\\FullDistribution' + str(datetime.now().strftime("%Y-%m-%d %H-%M-%S")) + '.csv', mode='w', newline='') as csv_file:
        data_writer = csv.writer(csv_file, delimiter=',')
        data_writer.writerow(["Full distribution from " + str(runs) + " runs"])
        data_writer.writerow(['parameter values: '])
        data_writer.writerows([param_export])
        data_writer.writerow(['initial values: '])
        data_writer.writerows([init_export])
        data_writer.writerows([["mRNA data: ", "protein data: ", "xanthosine data: "]])
        data_writer.writerows([item for item in data])
        
def find_switch_time(simulation,runs,endtime,high):
    """
    Runs the simulation several times and returns the switching time for each run.
    
    simulation: the simulation to run
    runs: number of runs to do
    endtime: the time until it should run
    high: the expectation value for the high state
    """
    t = []
    
    for run in range(runs):
        simulation.DoStochSim(mode="time",end=endtime)
        res = np.array(smod.data_stochsim.getSpecies()[:,0:3:2])
        
        t_run = 0
        
        if res[-1,1] > 0.5*high:
            for i in range(res.shape[0]):        
                if res[i,1] > 0.9*high:
                    t_run = res[i,0]
                    break
                
        if t_run == 0:
            print("ATTENTION: Run time to short")
                
        t.append(t_run)
    
    t = np.array(t)
    
    return t


# %% Main function

if __name__ == "__main__":
                                                                                                                
    smod = stochpy.SSA()   
    smod.Model("Xap_System_3d.psc",dir_path)
    smod.Method("Tauleap")
    #smod.SetSeeding(10)
  
    params = [['rho_m',25 * 1.0e-9 * 1.0e-3 * 1.0e9],['gamma_m ',5 * 1.0e-3],['r_p ',5.0e-4 * 1.0e2],
                   ['gamma_p', 5.0e-4],['XapR_R', 1],['ka ',5.0e-4 * 1.0e2],
                   ['kbi', 5.0e-4 * 5.0e4],['kbe', 5.0e-4 * 1.0e3],['kn', 5.0e-4 * 5.0e-1],
                   ['c', 5.0e-5 * 25 * 1.0e9],
                   ['chi',0.8],
                   ['Ka', 5.0e-5 * 1.0e9],['Kbi', 5.0e-5 * 1.0e1 * 1.0e9],['Kbe', 5.0e-5 * 1.0e2 * 1.0e9],['KxA', 5.0e-5 * 1.0e2 * 1.0e9],
                   ['KxI', 5.0e-5 * 1.0e4 * 1.0e9],['expEx',148.4],['expEc',148.5]] 
    initials = [['mRNA',0],['protein',0],['xanth', 0]]  
    
#    start = time.time()
#    find_plot_distribution(smod,params,initials,"protein",10,1.0e6)
#    end = time.time()
#    print(end - start)
    
#    print(switch_time_data(smod,params,initials,[5.0e-5 * 25 * 1.0e9],2,[5.0e5],[400]))
##    
    initialize(smod,params,initials)
#    
#    smod.DoStochSim(mode="time",end=5.0e5)
#    smod.PlotSpeciesTimeSeries(species2plot="xanth")
#    smod.PlotSpeciesTimeSeries(species2plot="protein")
#    smod.PlotSpeciesTimeSeries(species2plot="mrna") #error=0.1,size=10000)
#    
#    writingdata = smod.data_stochsim.getSpecies()[:,0:3:2]
#    with open(dir_path + '\\Output\\All From Plots\\distribution' + str(datetime.now().strftime("%Y-%m-%d %H-%M-%S")) + '.csv', mode='w', newline='') as csv_file:
#        data_writer = csv.writer(csv_file, delimiter=',')
#        data_writer.writerows([[item[0],item[1]] for item in writingdata])
    
    #print(smod.data_stochsim.species_means)
    
#    print(find_switch_time(smod,10,5.0e5,452))
    
    start = time.time()
    runs=510
    param_export = [(' ' + params[i][0] + ': ' + str(params[i][1])) for i in range(len(params))]
    init_export = [(' ' + initials[i][0] + ': ' + str(initials[i][1])) for i in range(len(initials))]
    writingdata = find_switch_time(smod,runs,8.0e5,452)
    with open(dir_path + '\\Output\\TimeDistribution\\' + str(datetime.now().strftime("%Y-%m-%d %H-%M-%S")) + '.csv', mode='w', newline='') as csv_file:
        data_writer = csv.writer(csv_file, delimiter=',')
        data_writer.writerow(["Adaptation time distribution from " + str(runs) + " runs (no bursts)"])
        data_writer.writerow(['parameter values: '])
        data_writer.writerows([param_export])
        data_writer.writerow(['initial values: '])
        data_writer.writerows([init_export])
        data_writer.writerows([["adaptation time:"]])
        data_writer.writerows([[item] for item in writingdata])
    end = time.time()
    print(end - start)
    
    