#%%
from compile_data import compile_data, save_data, load_data
from extract_data import extract_data, displayable_array, part_compute, include
from excel_tools import excel_tools 
from plotting_tools import plot_comparisons
import os, sys, cohens_d
import numpy as np
from scipy.stats import ttest_ind, ttest_rel

#%%
# Compile all txt data into one file
folder_dir = 'C:\\Users\\Taire\\Desktop\\TylerPapers\\data_workspace\\run_data_190724\\value_data'
data_1 = compile_data(folder_dir, 5)

folder_dir = 'C:\\Users\\Taire\\Desktop\\TylerPapers\\data_workspace\\run_data_190724\\array_data'
data_2 = compile_data(folder_dir, 5)

data = data_1 + data_2

#%%

# delete futianyu N-R1
delation_parameter = {'name': 'futianyu', 'gait': 'normal', 'foot': 'right', 'trail': 1}
new_data = []
for value in data:
    if not include(value, delation_parameter):
        new_data.append(value)

#%%
# delete futianyu N-R1
delation_parameter = {'name': 'nichengbo', 'foot': 'left'}
data = []
for value in new_data:
    if not include(value, delation_parameter):
        data.append(value)
        

save_dir = 'C:\\Users\\Taire\\Desktop\\TylerPapers\\data_workspace\\compiled_190731.pickle'
save_data(data, save_dir)

#%%

# load compiled data if needed
load_dir = 'C:\\Users\\Taire\\Desktop\\TylerPapers\\data_workspace\\compiled_190731.pickle'

data = load_data(load_dir)

#%%
def run_statistics(file_name, graph_name, parameter, axis):
    # excel initialize
    e = excel_tools()
    file_dir = 'C:\\Users\\Taire\\Desktop\\TylerPapers\\data_workspace\\{}_statistics.xls'.format(file_name)
    
    # mean and std vectors for each group and run
    exclusion_parameters = {}
    
    # wide group normal
    inclusion_parameters = {'group': 'wide', 'gait': 'normal', 'axis': axis, 'parameter': parameter}
    extracted, idx = extract_data(data, inclusion_parameters, exclusion_parameters)
    constant_list, wide_normal = part_compute(extracted, 'name', np.mean)
    _, wide_normal_std = part_compute(extracted, 'name', np.std, ddof = 1)
    
    # write excel
    e.write_column(e.mean_std, 'participant', constant_list)
    e.write_column(e.mean_std, 'wide_normal_means', wide_normal)
    e.write_column(e.mean_std, 'wide_normal_std', wide_normal_std)
    
    # wide group toe-in
    inclusion_parameters = {'group': 'wide', 'gait': 'toe-in', 'axis': axis, 'parameter': parameter}
    extracted, idx = extract_data(data, inclusion_parameters, exclusion_parameters)
    _, wide_in = part_compute(extracted, 'name', np.mean)
    _, wide_in_std = part_compute(extracted, 'name', np.std, ddof = 1)
    
    # write excel
    e.write_column(e.mean_std, '', [''])
    e.write_column(e.mean_std, 'wide_in_means', wide_in)
    e.write_column(e.mean_std, 'wide_in_std', wide_in_std)
    
    # narrow group normal
    inclusion_parameters = {'group': 'narrow', 'gait': 'normal', 'axis': axis, 'parameter': parameter}
    extracted, idx = extract_data(data, inclusion_parameters, exclusion_parameters)
    constant_list, narrow_normal = part_compute(extracted, 'name', np.mean)
    _, narrow_normal_std = part_compute(extracted, 'name', np.std, ddof = 1)
    
    # write excel
    e.write_column(e.mean_std, '', [''])
    e.write_column(e.mean_std, 'participant', constant_list)
    e.write_column(e.mean_std, 'narrow_normal_means', narrow_normal)
    e.write_column(e.mean_std, 'narrow_normal_std', narrow_normal_std)
    
    # wide group toe-in
    inclusion_parameters = {'group': 'narrow', 'gait': 'toe-out', 'axis': axis, 'parameter': parameter}
    extracted, idx = extract_data(data, inclusion_parameters, exclusion_parameters)
    _, narrow_out = part_compute(extracted, 'name', np.mean)
    _, narrow_out_std = part_compute(extracted, 'name', np.std, ddof = 1)
    
    # write excel
    e.write_column(e.mean_std, '', [''])
    e.write_column(e.mean_std, 'narrow_out_means', narrow_out)
    e.write_column(e.mean_std, 'narrow_out_std', narrow_out_std)
    
    
    # determine amount of rounding
    if parameter in ['KNEE_IMPULSE', 'KNEE_MIN_Y']:
        round_dec = 4
    else:
        round_dec = 1
    
    # statistical analysis wide comparison
    _, wide_p = ttest_rel(wide_normal, wide_in)
    wide_d = cohens_d.within_group(wide_normal, wide_in)
    
    wide_normal_mean = str(np.round(np.mean(wide_normal), decimals = round_dec))
    wide_normal_std = str(np.round(np.std(wide_normal, ddof = 1), decimals = round_dec))
    wide_in_mean = str(np.round(np.mean(wide_in), decimals = round_dec))
    wide_in_std = str(np.round(np.std(wide_in, ddof = 1), decimals = round_dec))    
    
    wide_stat = [wide_normal_mean + ' ± ' + wide_normal_std, 
                 wide_in_mean + ' ± ' + wide_in_std, 
                 str(np.round(wide_p, decimals = 3)),
                 str(np.round(wide_d, decimals = 3))]
     
    # write excel
    e.write_row(e.statistics, '', ['habitual', 'toe-in', 'P', 'd'])
    e.write_row(e.statistics, 'wide_stat', wide_stat)
    e.write_row(e.statistics, '', [''])
    
    # graph data
    graph_dir = 'C:\\Users\\Taire\\Desktop\\TylerPapers\\data_workspace\\{}'.format(file_name+'_wide') 
    title = 'P = {}, d = {}'.format(wide_stat[-2], wide_stat[-1])
    plot_comparisons(title, graph_name, 
                     'Habitual \n FPA', 'Toe-in \n FPA',
                     np.mean(wide_normal), np.std(wide_normal, ddof = 1),
                     np.mean(wide_in), np.std(wide_in, ddof = 1),
                     graph_dir, file_type = 'png')
    
    # statistical analysis narrow comparison
    _, narrow_p = ttest_rel(narrow_normal, narrow_out)
    narrow_d = cohens_d.within_group(narrow_normal, narrow_out)
    
    narrow_normal_mean = str(np.round(np.mean(narrow_normal), decimals = round_dec))
    narrow_normal_std = str(np.round(np.std(narrow_normal, ddof = 1), decimals = round_dec))
    narrow_out_mean = str(np.round(np.mean(narrow_out), decimals = round_dec))
    narrow_out_std = str(np.round(np.std(narrow_out, ddof = 1), decimals = round_dec))    
    
    narrow_stat = [narrow_normal_mean + ' ± ' + narrow_normal_std, 
                   narrow_out_mean + ' ± ' + narrow_out_std, 
                   str(np.round(narrow_p, decimals = 3)),
                   str(np.round(narrow_d, decimals = 3))]
         
    # write excel
    e.write_row(e.statistics, '', ['habitual', 'toe-out', 'P', 'd'])
    e.write_row(e.statistics, 'narrow_stat', narrow_stat)
    e.write_row(e.statistics, '', [''])
    
    # graph data
    graph_dir = 'C:\\Users\\Taire\\Desktop\\TylerPapers\\data_workspace\\{}'.format(file_name+'_narrow') 
    title = 'P = {}, d = {}'.format(narrow_stat[-2], narrow_stat[-1])
    plot_comparisons(title, graph_name, 
                     'Habitual \n FPA', 'Toe-out \n FPA',
                     np.mean(narrow_normal), np.std(narrow_normal, ddof = 1),
                     np.mean(narrow_out), np.std(narrow_out, ddof = 1),
                     graph_dir, file_type = 'png')
    
    # statistical analysis habitual comparison
    _, habitual_p = ttest_ind(wide_normal, narrow_normal)
    habitual_d = cohens_d.between_group(wide_normal, narrow_normal)

    narrow_normal_mean = str(np.round(np.mean(narrow_normal), decimals = round_dec))
    narrow_normal_std = str(np.round(np.std(narrow_normal, ddof = 1), decimals = round_dec))
    wide_normal_mean = str(np.round(np.mean(wide_normal), decimals = round_dec))
    wide_normal_std = str(np.round(np.std(wide_normal, ddof = 1), decimals = round_dec))    
    
    habitual_stat = [narrow_normal_mean + ' ± ' + narrow_normal_std, 
                     wide_normal_mean + ' ± ' + wide_normal_std, 
                     str(np.round(habitual_p, decimals = 3)),
                     str(np.round(habitual_d, decimals = 3))]    
    # write excel
    e.write_row(e.statistics, '', ['narrow', 'wide', 'P', 'd'])
    e.write_row(e.statistics, 'habitual_stat', habitual_stat)
    e.write_row(e.statistics, '', [''])

    # graph data
    graph_dir = 'C:\\Users\\Taire\\Desktop\\TylerPapers\\data_workspace\\{}'.format(file_name+'_inter') 
    title = 'P = {}, d = {}'.format(habitual_stat[-2], habitual_stat[-1])
    plot_comparisons(title, graph_name, 
                     'Narrow \n FPA group', 'Wide \n FPA group',
                     np.mean(narrow_normal), np.std(narrow_normal, ddof = 1),
                     np.mean(wide_normal), np.std(wide_normal, ddof = 1),
                     graph_dir, file_type = 'png')  
    
    # save results
    e.workbook.save(file_dir)

#%%
file_names = ['FPA', 'HIP_ADDUCTION', 'HIP_INTERNAL', 'HIP_ROTATION', 
              'KNEE_IMPULSE', 'KNEE_INTERNAL', 'KNEE_MOMENT', 'KNEE_ROTATION', 
              'KNEE_VARUS']

# y axis label for the graph
graph_names = ['Foot Progression Angle (deg)', 
              'Hip adduction (+)/abduction (-) angle (deg)', 
              'Hip internal (+)/external (-) rotation (deg)', 
              'Hip external (+)/internal (-) rotation (deg)', 
              'Knee varus (+)/valgus (-)  angular impulse \n (BH.BW.S)', 
              'Knee internal (+)/external (-) rotation (deg)', 
              'Minimum internal knee varus (+)/valgus (-) \n moment (BH.BW)', 
              'Knee external (+)/internal (-) rotation (deg)', 
              'Knee varus (+)/valgus (-) angle (deg)']
      
parameters = ['FPA_MEAN', 'HIP_ANGLE_MEAN', 'HIP_ANGLE_MEAN', 'HIP_ROTATION_MEAN', 
              'KNEE_IMPULSE', 'KNEE_ANGLE_MEAN', 'KNEE_MIN_Y', 'KNEE_ROTATION_MEAN',
              'KNEE_ANGLE_MEAN']
        
axes = ['X', 'Y', 'Z', 'X', 'Y', 'Z', 'X', 'X', 'Y']
        

for file_name, graph_name, parameter, axis in zip(file_names, graph_names, parameters, axes):
    run_statistics(file_name, graph_name, parameter, axis)

#%%
file_names = ['KNEE_IMPULSE', 'KNEE_MOMENT']
        
parameters = ['KNEE_IMPULSE', 'KNEE_MIN_Y']
        
axes = ['Y', 'X']
        

for file_name, parameter, axis in zip(file_names, parameters, axes):
    run_statistics(file_name, parameter, axis)

#%%
from plotting_tools import plot_comparisons

y_lists = [[8.7, 3.6, 14.7, 6.3, '0.024', '1.246'],
           [8.7, 3.6, 32.4, 8.3, '0.001', '2.992'],
           [5.7, 2.7, -1.3, 3.3, '0.001', '3.333'],
           [-5.6, 5.9, -3.1, 5.8, '0.001', '1.806'],
           [14.7, 6.3, 6.7, 5.1, '0.001', '2.250'],
           [-1.5, 2.6, -2.4, 3.0, '0.001', '1.244']]
labels = [['inter_FPA', 'Foot Progression Angle (deg)', 'Narrow \n FPA group', 'Wide \n FPA group'],
          ['narrow_FPA', 'Foot Progression Angle (deg)', 'Habitual \n FPA', 'Toe-out \n FPA'],
          ['narrow_hip', 'Hip adduction (+)/abduction (-) angle (deg)', 'Habitual \n FPA', 'Toe-out \n FPA'],
          ['narrow_knee', 'Knee varus (+)/valgus (-) angle (deg)', 'Habitual \n FPA', 'Toe-out \n FPA'], 
          ['wide_FPA', 'Foot Progression Angle (deg)', 'Habitual \n FPA', 'Toe-in \n FPA'], 
          ['wide_knee', 'Knee varus (+)/valgus (-) angle (deg)', 'Habitual \n FPA', 'Toe-in \n FPA']]

for y_list, label in zip(y_lists, labels):       
    file_dir = 'C:\\Users\\Taire\\Desktop\\TylerPapers\\data_workspace\\{}'.format(label[0]) 
    title = 'P = {}, d = {}'.format(y_list[-2], y_list[-1])
    plot_comparisons(title, label[1], 
                     label[2], label[3], 
                     y_list[0], y_list[1], y_list[2], y_list[3],
                     file_dir, file_type = 'png')























