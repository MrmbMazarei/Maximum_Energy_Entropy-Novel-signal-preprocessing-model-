function  pc=Spectral_Density_Function(f,Data_No,dt)
for n=-(Data_No-1):(Data_No-1)
    Landa(n)
    SumA=Landa(n)*(cos(2*pi*f*n*dt)+(sin(2*pi*f*n*dt))*i)
end

pc=exp(-1-Sum_A);

end