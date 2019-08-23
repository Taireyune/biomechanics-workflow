#%%
from matplotlib import pyplot as plt

def plot_comparisons(title, y_label, 
                     x_label_1, x_label_2, 
                     y_1, yerr_1, y_2, yerr_2,
                     file_dir, file_type = 'png'):
    
    graph_file = file_dir + '.' + file_type  # building directory string
    
    # size parameters
    font_size = 25
    label_size = 20
    line_width = 4
    marker_size = 25
    
    # font parameters
    font = {'family': 'arial',
            'color':  'black',
            'weight': 'normal',
            'size': font_size}
        
    x_label = ''
        
    fig = plt.figure(figsize=(7, 8))
    ax = fig.add_subplot(111)
    for axis in ['top','bottom','left','right']:
        ax.spines[axis].set_linewidth(line_width)
    ax.tick_params(length = 2 * line_width, width = line_width)
    
    # shift graph relative to window
    plt.subplots_adjust(top = 0.925, right = 0.95, left = 0.325, bottom = 0.125)   
    
    # text labels
    plt.title(title, fontdict = font)    
    plt.xticks([0, 1], [x_label_1, x_label_2], fontsize = font_size)
    plt.yticks(fontsize = label_size)
    
    plt.errorbar(0, y_1, yerr = yerr_1,
                 ecolor = 'black', elinewidth = line_width, capsize = 0.4 * marker_size, capthick = line_width,
                 marker = 'o', markersize = marker_size, 
                 markeredgecolor = 'black', markeredgewidth = line_width, markerfacecolor = 'white')
    plt.errorbar(1, y_2, yerr = yerr_2,
                 ecolor = 'black', elinewidth = line_width, capsize = 0.4 * marker_size, capthick = line_width,
                 marker = 'D', markersize = marker_size, 
                 markeredgecolor = 'black', markeredgewidth = line_width, markerfacecolor = 'white')
    
    plt.xlabel(x_label, fontdict = font)
    plt.ylabel(y_label, fontdict = font)
    
    plt.xlim([-0.5, 1.5])  # leave room left and right of the points
    
    plt.show()
    plt.savefig(graph_file) #'foo.png' can use 'foo.pdf'


# Example
#y_1 = 5.7
#yerr_1 = 2.7
#y_2 = -1.3
#yerr_2 = 3.3
#p_value = 0.001
#cohen = 3.333
#name = 'inter_FPA'   
#
#y_label = 'Foot Progression Angle (deg)'
#
#x_label_1 = 'Narrow \n FPA group'
#x_label_2 = 'Wide \n FPA group'
#
#file_dir = 'C:\\Users\\Taire\\Desktop\\TylerPapers\\data_workspace\\{}'.format(name) 
#title = 'P = {}, d = {}'.format(p_value, cohen)
#plot_comparisons(title, y_label, 
#                 x_label_1, x_label_2, 
#                 y_1, yerr_1, y_2, yerr_2,
#                 file_dir, file_type = 'png')
