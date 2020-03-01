import bokeh.io
import bokeh.plotting
import bokeh.layouts
import bokeh.palettes
import bokeh.themes.theme
import itertools
import holoviews as hv
import skimage.io
import skimage.measure
import seaborn as sns
import numpy as np
import pandas as pd
import os
import matplotlib
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from scipy.signal import gaussian, convolve

def pub_style(return_colors=True):
    """
    Sets the style to the publication style

    Parameters
    ----------
    return_colors: Bool
        If True, this will also return a dictionary

    """
    rc = {'axes.facecolor': '#ffffff',
          'asxes.linewidth':0.75,
          'axes.axisbelow':True,
          'axes.edgecolor': 'black',
          'xtick.color': 'black',
          'ytick.color': 'black',
          'font.family': 'Times New Roman',
          'grid.linestyle': '-',
          'grid.linewidth': 0.5,
          'grid.alpha': 0.75,
          'grid.color': '#FFFFFF',
          'legend.frameon': True,
          'legend.facecolor': '#FFFFFF',
          'figure.dpi': 150}
    plt.rc('text.latex', preamble=r'\usepackage{sfmath}')
    plt.rc('mathtext', fontset='stixsans', sf='sans')
    sns.set_style('darkgrid', rc=rc)
    colors = ['#D56C55', '#738FC1', '#7AA974', '#D4C2D9', '#F1D4C9', '#C9D7EE',
              '#DCECCB']
    if return_colors:
        return colors
