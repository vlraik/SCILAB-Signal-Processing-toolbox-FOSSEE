/*poly2lsf.sci
 *
 *Prediction polynomial to line spectral frequencies
 *
 *Converts the prediction polynomial specified by 'a'
 *into the corressponding line spectral frequencies, LSF.
 *Normalizes the prediction polynomial by a(1)
 *
 *Syntax:
 *lsf = poly2lsf(a)
 *Description:
 *lsf = poly2lsf(a) returns a vector, lsf, of line spectral frequencies from
 *a vector,'a', of prediction filter coefficient
 *
 *Example:
 *Given a vector, a, of prediction filter coefficient, generate the corressponding
 *line spectral frequencies
 *
 *Input:
 *a = [1.0000  0.6149  0.9899  0.0000  0.0031 -0.0082];
 *lsf = poly2lsf(a)
 *
 *Output:
 *lsf = 
 *    0.7842
 *    1.5605
 *    1.8776
 *    1.8984
 *    2.3593
 *
 *
 *Author: Vrishabh Lakhani
 *
 *References:
 *Deller, John R., John G. Proakis, and John H. L. Hansen. Discrete-Time Processing of Speech Signals. New York: Macmillan, 1993.
 *Rabiner, Lawrence R., and Ronald W. Schafer. Digital Processing of Speech Signals. Englewood Cliffs, NJ: Prentice-Hall, 1978.
 *
 */ 

function lsf = poly2lsf(a)
 	if a(1)<>1 then
 		a=a/a(1)
 	end
 	if max(abs(roots(a))) >= 1.0 then
 		error('The polynomial must have all the roots inside of the unit circle.')
 	end
 	p=length(a)-1
 	x=[0]
 	a1=cat(2,a,x)
 	a2=flipdim(a1,2,1)
 	P1 = a1 - a2
 	Q1 = a1 + a2

 	P2=P1(1)
 	Q2=P2(1)
 	z=poly(0,"z")
 	for i=2:length(P1)
 		P2=P2+P1(i)*z^(i)
 	end
 	for i=2:length(Q1)
 		Q2=Q2+Q1(i)*z^(i)
 	end
 	divisorOdd=-1*z^2+0*z^1+1
 	divisorEven1=-1*z^1+1
 	divisorEven2=1*z^1+1
 	disp(divisorEven1,divisorEven2,divisorOdd)
 	if modulo(p,2) then
 		[r,P]= pdiv(P2,divisorOdd)
 		Q=Q1
 	else
 		[r, P] = pdiv(P2, divisorEven1)
 		[r, Q] = pdiv(P2, divisorEven2)
 	end
 	P=coeff(P)
 	rP = roots(coeff(P))
 	rQ = roots(coeff(Q))


 	aP = atan(imag(rP), real(rP))
 	aQ = atan(imag(rQ), real(rQ))
 	lsf = gsort(cat(1,-aP, -aQ),'r','i')
 	lsf = lsf(find(lsf>0))
 	return lsf

 endfunction
