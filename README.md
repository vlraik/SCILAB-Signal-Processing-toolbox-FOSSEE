# SCILAB-Signal-Processing-toolbox-FOSSEE

##Synopsis
There are two functions for the for the SCILAB signal processing toolbox, rc2poly and poly2lsf

#rc2poly.sci
This function is used to convert reflection coefficient to prediction filter polynomial
a = rc2poly(k) converts the reflection coefficients k corresponding to the lattice structure to the prediction filter polynomial a, with a(1) = 1. The output a is row vector of length length(k) + 1.

[a,efinal] = rc2poly(k,r0) returns the final prediction error efinal based on the zero-lag autocorrelation, r0.

Example,
k = [0.3090 0.9800 0.0031 0.0082 -0.0082];
Input syntax:
a = rc2poly(k)
Output:
a =

    1.0000    0.6148    0.9899    0.0000    0.0032   -0.0082
The Algorithm works in the following way using the Lenvinson's recursion:
[1] Sets the output vector a to the first element of k

[2]Loop through the remaining elements of k, such that,
   for each iteration i,a = [a + a(i-1: -1 :1)*k(i) k(i)]
   
   
[3] Implements a =[1 a]





#Poly2lsf.sci
This function is used to convert prediction filter polynomial to linear spectral frequencies.
lsf = poly2lsf(a) returns a vector, lsf, of line spectral frequencies from a vector, a, of prediction filter coefficients.

Given a vector, a, of prediction filter coefficients, generate the corresponding line spectral frequencies.
Input syntax:
a = [1.0000  0.6149  0.9899  0.0000  0.0031 -0.0082];
lsf = poly2lsf(a)

Output:
lsf =

    0.7842
    1.5605
    1.8776
    1.8984
    2.3593

The Algorithm works in the following way:
[1] First it checks whether the polynomials should be normalised or not because
    linear spectral frequencies are not defined for complex polynomials
    
[2]Then checks whether the roots are inside of the unit circle

[3]Creates the suma and the difference filters

[4]The leading one is not used for the calculation, and the order is decided

[5]If order is even, we have to remove the known roots at z=1 for P1(difference filter) and z=-1 for Q1(sum filter)

[6]If odd, remove both the roots from P1

[7]deconvolution of P1 and Q1 respectively

[8]Find the roots of the Quotient of P1 and Q1

[9]Find the phase between the real and the imaginary part of the roots of the quotient of P1 and Q1

[10]Sort the phase and return the output





##Contributors
Vrishabh Lakhani

##Reference
Rc2poly.sci: 
[1]  Kay, Steven M. Modern Spectral Estimation. Englewood Cliffs, NJ: Prentice-Hall, 1988.


Poly2lsf.sci:
[1] Deller, John R., John G. Proakis, and John H. L. Hansen. Discrete-Time Processing of Speech Signals. New York: Macmillan, 1993.
[2] Rabiner, Lawrence R., and Ronald W. Schafer. Digital Processing of Speech Signals. Englewood Cliffs, NJ: Prentice-Hall, 1978.


