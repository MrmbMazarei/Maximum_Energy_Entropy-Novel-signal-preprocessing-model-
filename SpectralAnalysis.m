% This program is written for Spectral Alanysis by using
% Maximum Entropy Algorithm.
% Input data has Excel format. this program is written for monthly data 
% All month of year shuld be in one row and next year lie in the next row.
% The other Input time series shoud be lied next to the previous time serie
% in right side.



%%start of program
clc
clear
close all

%%dataloading----------------------------------------------------------
% Input the data with Excel format
% TimeSeries_No: number of input time series
% Year_No: the nomber of years that wehava data
% Data_No: Alltime steps that we have data
% Min_f: Minimum frequency that we want to search for dominant frequency
% Max_f: Maximum frequency that we want to search for dominant frequency
% X: Organized data matrix with TimeSeries_No rows and Year_No*12 column


Data=xlsread('Data.xlsx'); 
Landa_nomber=490;
TimeSeries_No=13;
Year_No=41;
Data_No=41*12;
Min_f=0;
Max_f=2;
Frequency_div=0.0001;
dt=1;
Number_Of_Output_Waves=50;
Output_Waves=zeros(TimeSeries_No,Data_No,Number_Of_Output_Waves);
X=zeros(TimeSeries_No,Data_No);
Correlation_coeficiont=ones(TimeSeries_No,Data_No-1);
Landa=zeros(TimeSeries_No,Landa_nomber);
A=zeros(Data_No,Number_Of_Output_Waves);
for i=1:TimeSeries_No 
    for j=1:Year_No
        for k=1:12 
            X(i,(j-1)*12+k)=Data(j,(i-1)*12+k); 
        end
    end
end

%%normalization----------------------------------------------------
% Data before use in this program have been normalized.
MinX=min(X'); %matrix for finding the maximum of input time series
MaxX=max(X'); %matrix for finding the minimum of input time series

XN=X; %matrix for normalized input data

%in this section we normalize the input time series
for i=1:TimeSeries_No
    XN(i,:)=Normalize_Fcn(X(i,:),MinX(i),MaxX(i));
end

for l=1:TimeSeries_No
for m=1:(Data_No-2)
    Correlation_coeficiont(l,m+1)=Corr_Fcn(l,m,Data_No,XN);
end
end

for l=1:TimeSeries_No
    Cepstrum(l,:)=cceps(XN(l,:));
end

for l=1:TimeSeries_No
    for i=1:Landa_nomber
        if i==1
           Landa(l,i)=-3;
        else
           Landa(l,i)=-Cepstrum(l,i-1);
        end
    end
end

for l=1:TimeSeries_No
    Counter=0;
    for f=Min_f:Frequency_div:Max_f
        Counter=Counter+1;
        SumA=0;
        for i=1:Landa_nomber
            SumA=SumA+Landa(l,i)*cos(2*pi*f*(i-1)*dt);
        end
        F(Counter)=f;
        P(l,Counter)=exp(-1-SumA);
    end
end

figure(1)
plot(F(:),log10(P(1,:)),'r')
title('P-Bostan abad power density function');
xlabel('Frequency(Hz)');
ylabel('Log-Power(W/Hz)');

figure(2)
plot(F(:),log10(P(2,:)),'g')
title('P-Esbaghran power density function');
xlabel('Frequency(Hz)');
ylabel('Log-Power(W/Hz)');

figure(3)
plot(F(:),log10(P(3,:)),'b')
title('P-Ghoshchi power density function');
xlabel('Frequency(Hz)');
ylabel('Log-Power(W/Hz)');

figure(4)
plot(F(:),log10(P(4,:)),'c')
title('P-Ghourigol power density function');
xlabel('Frequency(Hz)');
ylabel('Log-Power(W/Hz)');

figure(5)
plot(F(:),log10(P(5,:)),'m')
title('P-Nahand power density function');
xlabel('Frequency(Hz)');
ylabel('Log-Power(W/Hz)');

figure(6)
plot(F(:),log10(P(6,:)),'y')
title('P-SaeadAbad power density function');
xlabel('Frequency(Hz)');
ylabel('Log-Power(W/Hz)');

figure(7)
plot(F(:),log10(P(7,:)),'k')
title('P-Sarab power density function');
xlabel('Frequency(Hz)');
ylabel('Log-Power(W/Hz)');

figure(8)
plot(F(:),log10(P(8,:)),'r')
title('P-Sohzab power density function');
xlabel('Frequency(Hz)');
ylabel('Log-Power(W/Hz)');

figure(9)
plot(F(:),log10(P(9,:)),'g')
title('P-Vaniar power density function');
xlabel('Frequency(Hz)');
ylabel('Log-Power(W/Hz)');

figure(10)
plot(F(:),log10(P(10,:)),'b')
title('T-Ghourigol power density function');
xlabel('Frequency(Hz)');
ylabel('Log-Power(W/Hz)');

figure(11)
plot(F(:),log10(P(11,:)),'c')
title('T-Mirkoh power density function');
xlabel('Frequency(Hz)');
ylabel('Log-Power(W/Hz)');

figure(12)
plot(F(:),log10(P(12,:)),'y')
title('T-Srab power density function');
xlabel('Frequency(Hz)');
ylabel('Log-Power(W/Hz)');

figure(13)
plot(F(:),log10(P(13,:)),'y')
title('R-Vaniar power density function');
xlabel('Frequency(Hz)');
ylabel('Log-Power(W/Hz)');

for l=1:TimeSeries_No
    [sort_p(l,:),I(l,:)]=sort(P(l,:),'descend');
end

for l=1:TimeSeries_No
    count=0;
    for i=1:Data_No
        if i==1
           count=count+1;
           max_p(l,count)=sort_p(l,i);
           max_I(l,count)=I(l,i);
           max_F(l,count)=F(I(l,i));
        elseif max_p(l,count)>sort_p(l,i);
           count=count+1;
           max_p(l,count)=sort_p(l,i);
           max_I(l,count)=I(l,i);
           max_F(l,count)=F(I(l,i));
        end
        if count==Number_Of_Output_Waves
           break;
        end
    end
end

for l=1:TimeSeries_No
    for i=1:Number_Of_Output_Waves
        for j=1:Data_No
            Output_Waves(l,j,i)=cos(2*pi*F(max_I(l,i))*j);
        end
    end
end
