%function cepstrum=Cepstrum_Fcn(l,m,correlation_coeficiont,cepstrum_pre)
%for k=1:m-1
    %cepstrum=cepstrum+k/m*cepstrum_pre(l,k)*correlation_coeficiont(l,m-k);
%end    
%cepstrum=2*(correlation_coeficiont(m)-cepstrum);
%end