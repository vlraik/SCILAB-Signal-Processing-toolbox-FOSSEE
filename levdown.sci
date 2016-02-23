function [acur,ecur] =  levdown(anxt, varargin)
	[lhs,rhs]=argn()
    if rhs==2 then

    if anxt(1)<>1 then
        error('At least one of the reflection coefficients is equal to one.')
    end

    anxt = anxt(2:length(a)) //  Drop the leading 1, it is not needed 
                             //  in the step down

    // Extract the k+1'th reflection coefficient
    knxt = anxt($)

    if knxt == 1.0 then
        error('At least one of the reflection coefficients is equal to one.')
    end    
    // A Matrix formulation from Stoica is used to avoid looping 
    anxtflip=flipdim(anxt,2,1)
    anxtflip=anxtflip(2:$)
    anxtflip=flipdim(anxtflip,2,1)

    z=knxt*conj(anxtflip)
    z=flipdim(z,2,1)
   
    acur = (anxt(1:$-1)-z)
    //acurdiv = (1.-abs(knxt)**2)
    //acur = acur/acurdiv
    acur = [1 acur]


    enxt = varargin
    
    knxtconj=conj(knxt)
    knxtconj=knxtconj'
    ecur = enxt/(1.-(knxtconj.*knxt))
    

    elseif rhs==1 then
    	
    if anxt(1)<>1 then
        error('At least one of the reflection coefficients is equal to one.')
    end
    anxt = anxt(2:length(a)) //  Drop the leading 1, it is not needed 
                             //  in the step down
    // Extract the k+1'th reflection coefficient
    knxt = anxt($)
    if knxt == 1.0 then
        error('At least one of the reflection coefficients is equal to one.')
    end
    // A Matrix formulation from Stoica is used to avoid looping 
    anxtflip=flipdim(anxt,2,1)
    anxtflip=anxtflip(2:$)
    anxtflip=flipdim(anxtflip,2,1)
    z=knxt*conj(anxtflip)
    z=flipdim(z,2,1)
   
    acur = (anxt(1:$-1)-z)
    //acurdiv = (1.-abs(knxt)**2)
    //acur = acur/acurdiv
    acur = [1 acur]

    ecur=[]
    end
    return acur,ecur
endfunction