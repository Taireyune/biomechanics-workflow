import numpy as np
import os, pickle

def compile_data(folder_dir, value_index):
    # main function
    dir_list = list_full_dir(folder_dir)
    array = concatenate_txt(dir_list)
    data = create_data_object(array, value_index)
    data = get_group(data)
    return data

def list_full_dir(folder_dir):
    name_list = os.listdir(folder_dir)
    dir_list = []
    for name in name_list:
        file_dir = os.path.join(folder_dir, name)
        dir_list.append(file_dir)
    return dir_list
    
def concatenate_txt(dir_list):
    # stack all the txt data together
    full_array = [] 
    for file_dir in dir_list: 
        data = np.loadtxt(file_dir, dtype = str, delimiter = '\t')
        full_array.append(data[:,1:])
    return np.hstack(full_array)

def parse_file_name(file_name):
    # obtain trial information from file name
    
    # delete head and tail
    file_name = file_name.replace('Trimmed_', '')
    file_name = file_name.replace('.c3d', '')
    
    # trial number
    trial_num = int(file_name[-1])
    file_name = file_name[:-1]
    
    # left or right leg
    if '-L' in file_name[-4:] or '-l' in file_name[-4:]:
        foot = 'left'
    else:
        foot = 'right'
    
    # running gait
    if 'N' in file_name[-4:] or 'n' in file_name[-4:]:
        gait = 'normal'
    elif 'B' in file_name[-4:] or 'b' in file_name[-4:]:
        gait = 'toe-out'
    else:
        gait = 'toe-in'
    
    # name of participant
    name = file_name[:file_name.find('-')]
    return name, gait, foot, trial_num
    
def value_label(label_vector):
    # create dictionary that describe the value. 
    # Test foot and parameter directions
 
    name, gait, foot, trial_num = parse_file_name(label_vector[0])
    
    value = {}    
    value['name'] = name
    value['group'] = None
    value['gait'] = gait
    value['foot'] = foot
    value['trail'] = trial_num
    value['parameter'] = str(label_vector[1])
    value['axis'] = str(label_vector[4])
    value['value'] = None
  
    if 'R_' in value['parameter']:
        if value['foot'] == 'left':
            return False  
        else:
            value['parameter'] = value['parameter'].replace('R_', '')
    if 'L_' in value['parameter']:
        if value['foot'] == 'right':
            return False  
        else:
            value['parameter'] = value['parameter'].replace('L_', '')       
    return value

def create_data_object(array, value_index):
    # Final data structure.
    # Delete data of the swing-phase leg
    
    data = []
    for i in range(array.shape[1]):
        value = value_label(array[:value_index, i])       
        if not value:
            continue
        
        value['value'] = array[value_index:, i].astype(np.float32)
        data.append(value)
    return data
        
def get_group(data):
    # the group that did toe-in modification is the wide FPA group
    # the group that did toe-out modification is the narrow FPA group
    
    wide = []
    narrow = []
    for i in range(len(data)):
        if data[i]['gait'] == 'toe-in' and data[i]['name'] not in wide:
            wide.append(data[i]['name'])
            continue
        
        if data[i]['gait'] == 'toe-out' and data[i]['name'] not in narrow:
            narrow.append(data[i]['name'])
            
    overlap = set(wide).intersection(narrow) 

    if bool(overlap):
        print("overlap groups {}, check data".format(overlap))
        return False
    
    for i in range(len(data)):
        if data[i]['name'] in wide:
            data[i]['group'] = 'wide'
        else:
            data[i]['group'] = 'narrow'
    return data

def load_data(file_dir):
    # load pickled files as a variable
    with open(file_dir, 'rb') as file:
        data = pickle.load(file)
    return data

def save_data(data, save_dir):
    # save a variable to hard disk
    with open(save_dir, 'wb') as out_file:
        pickle.dump(data, out_file)            


