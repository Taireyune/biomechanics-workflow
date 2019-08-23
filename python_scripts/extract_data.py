#%%
import numpy as np

def extract_data(data, inclusion_parameters, exclusion_parameters = {}):
    # bread and butter data finder given exclusion and inclusion parameters
    indices = []
    extracted = []
    for i in range(len(data)):
        if include(data[i], inclusion_parameters) and exclude(data[i], exclusion_parameters):
            indices.append(i)
            extracted.append(data[i])
    return extracted, indices
               
def include(data_vector, parameters):
    for key in list(parameters):
        # False when not matching
        if parameters[key] != data_vector[key]: 
            return False     
    return True

def exclude(data_vector, parameters):
    for key in list(parameters):
        # False when it is matching
        if parameters[key] == data_vector[key]:
            return False     
    return True

def displayable_array(data, np_key = 'value'):
    # For debugging and data viewing in IDE. Put all data in one np.array.
    
    # get the array dimensions
    value_length = data[0][np_key].shape[0]
    column = len(data[0]) + value_length - 1 
    array = np.zeros((column, len(data)), dtype = '<U26')
    
    label_keys = list(data[0])
    label_keys.remove(np_key)
    for i in range(len(data)):
        for j, key in enumerate(label_keys): 
            array[j, i] = data[i][key]
        for k in range(value_length):
            array[len(data[0]) + k - 1, i] = data[i][np_key][k].astype('<U26') 
    return array
    
def dict_to_array(data, np_key = 'value'):
    # gather specified (np_key) dict into one numpy array for further manipulation
    column = data[0][np_key].shape[0]
    array = np.zeros((column, len(data)), dtype = np.float32)
    
    for i in range(len(data)):
        for j in range(column):
            array[j, i] = data[i][np_key]
    return array

def part_compute(data, constant_parameter, variable_func, **kwargs):
    '''
    Mainly for seperating data into specific groups for mean and std
    calculations. When constant_parameter is 'name', the function apply 
    variable_func to each unique 'name' in the data set.
    Can be used to group other parameters using constant_parameter.
    '''
    
    # gather unique parameter of the specified key
    constant_list = []
    for i in range(len(data)):
        if data[i][constant_parameter] not in constant_list:
            constant_list.append(data[i][constant_parameter])
    
    # apply variable_func computation on each set of grouping 
    # aka take the mean from each trial        
    output_array = np.zeros(len(constant_list), dtype = np.float32)        
    for idx, parameter in enumerate(constant_list):
        extract, _ = extract_data(data, {constant_parameter:parameter})
        array = dict_to_array(extract)
        output_array[idx] = variable_func(array, **kwargs)
    return constant_list, output_array
