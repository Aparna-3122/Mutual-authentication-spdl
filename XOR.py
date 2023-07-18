>>> from pypuf.simulation import XORArbiterPUF
>>> puf = XORArbiterPUF(n=64, k=8, seed=1, noisiness=.1)
>>> from pypuf.io import random_inputs
>>> puf.eval(random_inputs(n=64, N=3, seed=2))
array([-1, -1,  1], dtype=int8)
