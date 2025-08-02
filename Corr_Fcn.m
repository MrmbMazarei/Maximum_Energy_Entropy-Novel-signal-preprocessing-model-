function correlation=Corr_Fcn(l,m,N,xN)
correlation=corr2(xN(l,1:N-m),xN(l,1+m:N));
end