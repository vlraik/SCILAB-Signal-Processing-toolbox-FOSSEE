# -*- coding: utf-8 -*-
"""
Created on Tue Feb 09 14:17:24 2016

@author: Vrishabh
"""


import numpy
import scipy
import scipy.signal
a = [1.0000,  0.6149,  0.9899,  0.0000,  0.0031, -0.0082];
def poly2lsf(a):
    """Prediction polynomial to line spectral frequencies.

    converts the prediction polynomial specified by A,
    into the corresponding line spectral frequencies, LSF. 
    normalizes the prediction polynomial by A(1).

    .. doctest::

        >>> a = [1.0000  ,  0.6149   , 0.9899   , 0.0000 ,   0.0031,   -0.0082
        >>> lsf = poly2lsf(a)
        >>> lsf =  array([  0.7842,    1.5605 ,   1.8776 ,   1.8984,    2.3593])

    .. seealso:: lsf2poly, poly2rc, poly2qc, rc2is
    """

    #Line spectral frequencies are not defined for complex polynomials.

    # Normalize the polynomial

    a = numpy.array(a)
    if a[0] != 1:
        a/=a[0]

    if max(numpy.abs(numpy.roots(a))) >= 1.0:
        print("hello world")

    # Form the sum and differnce filters

    p  = len(a)-1   # The leading one in the polynomial is not used
    a1 = numpy.concatenate((a, numpy.array([0])))        
    a2 = a1[-1::-1]
    P1 = a1 - a2        # Difference filter
    Q1 = a1 + a2        # Sum Filter 
    divisorOdd = [1,0,-1]
    divisorEven1 = [1,-1]
    divisorEven2 = [1,1]

    # If order is even, remove the known root at z = 1 for P1 and z = -1 for Q1
    # If odd, remove both the roots from P1

    if p%2: # Odd order
        P, r = scipy.signal.deconvolve(P1,divisorOdd)
        Q = Q1
    else:          # Even order 
        P, r = numpy.polydiv(P1, divisorEven1)
        Q, r = numpy.polydiv(Q1, divisorEven2)
    
    rP  = numpy.roots(P)
    rQ  = numpy.roots(Q)

    aP  = numpy.angle(rP[1::2])
    aQ  = numpy.angle(rQ[1::2])

    lsf = sorted(numpy.concatenate((-aP,-aQ)))
    print("a",a)
    print("p",p)
    print("a1",a1)
    print("a2",a2)
    print("P1",P1)
    print("Q1",Q1)
    print("r",r)
    print("P",P)
    print("Q",Q)
    print("rP",rP)
    print("rQ",rQ)
    print("aP",aP)
    print("aQ",aQ)

    return lsf
print(poly2lsf(a))