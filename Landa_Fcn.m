function landa=Landa_Fcn(n)
 if n==0 
    landa=-1-Cepstrum(n);
 else 
    landa=Cepstrum(n);
 end
end