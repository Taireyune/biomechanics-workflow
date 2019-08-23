import numpy as np

def between_group(A, B):
    '''
    s = root( (n-1)*s^2 + (n-1)*s^2 / n + n - 2)
    d = (x_1 - x_2)/s   
    '''    
    s = (A.shape[0] - 1) * (np.std(A, ddof = 1) ** 2) + (B.shape[0] - 1) * (np.std(B, ddof = 1) ** 2)
    s /= A.shape[0] + B.shape[0] - 2
    s = s ** 0.5    
    return abs(np.mean(A) - np.mean(B)) / s
    
def within_group(A, B):
    '''
    d = delta(x) / (n x s)
    '''
    delta = A - B
    return abs(np.sum(delta)) / (delta.shape[0] * np.std(delta, ddof = 1))