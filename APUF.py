pip3 install pypuf
  
>>> from pypuf.simulation import XORArbiterPUF
>>> puf = XORArbiterPUF(n=64, k=8, seed=1, noisiness=.1)
>>> from pypuf.io import random_inputs
>>> puf.eval(random_inputs(n=64, N=3, seed=2))

import numpy as np


def prng(description: str) -> np.random.Generator:
   
    >>> from pypuf.random import prng
    >>> seed = 5
    >>> my_prng = prng(f'my favorite random numbers, seed {seed}')
    >>> my_prng.integers(2, 6, 3)
    array([4, 3, 2])

def seed(description: str) -> int:
    return prng(description).integers(0, 2**32 - 1)
