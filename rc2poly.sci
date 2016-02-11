/*
 *rc2poly
 *Convert reflection coefficient to prediction filter polynomial
 *Syntax:
 *a = rc2poly(k)
 *[a, efinal] = rc2poly(k, r0) 
 *
 *
 *Desciption:
 *a = rc2poly(k) converts the reflection coefficients k corresponding to the lattice structure to the
 *prediction filter polynomial a, with a(1) = 1. The output a is row vector of length length(k) + 1.
 *
 *[a,efinal] = rc2poly(k,r0) returns the final prediction error efinal based on
 * the zero-lag autocorrelation, r0.
 *
 * EXAMPLE:
 * Consider a lattice IIR filter given by a set of reflection coefficients.
 * Find its equivalent prediction filter representation.
 *
 *
 * k = [0.3090 0.9800 0.0031 0.0082 -0.0082];
 * a = rc2poly(k)
 *
 *OUTPUT:
 *a = 1.0000    0.6148    0.9899    0.0000    0.0032   -0.0082
 *
 *
 *
 *AUTHOR: Vrishabh Lakhani
 *Sources: Kay, Steven M. Modern Spectral Estimation. Englewood Cliffs, NJ: Prentice-Hall, 1988.
 */
function [a,efinal] = rc2poly( k,varargin)
[lhs,rhs]=argn(0)
if rhs==1 then
	a = k(1); //sets the output vector a to the first element of k
	for i = 2:length(k) //loop through the remaining elements of k
		a = [ a+conj(a(i-1:-1:1))*k(i)  k(i) ]; //levinson's recursion
	end  
	a = [1 a]; 
	return a
elseif rhs>1 then //to find efinal
	a = k(1); 
	for i = 2:length(k) 
		a = [ a+conj(a(i-1:-1:1))*k(i)  k(i) ]; //levinson's recursion
	end  
	a = [1 a]; 
	return a,a($) //return the prediction polynomial
end
endfunction
