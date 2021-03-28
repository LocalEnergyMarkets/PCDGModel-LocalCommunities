clc
clear
%%
dem = xlsread('dataset25housesninemonths.xlsx',2,'B2:Z49');
Pg = xlsread('dataset25housesninemonths.xlsx',3,'B2:B49');
Solar = xlsread('dataset25housesninemonths.xlsx',5,'B2:Z49');
Wind = xlsread('dataset25housesninemonths.xlsx',4,'B2:Z49');
res=Wind+Solar;
alpha = xlsread('dataset25housesninemonths.xlsx',6,'B4');
beta = xlsread('dataset25housesninemonths.xlsx',6,'B5');
Sl = xlsread('dataset25housesninemonths.xlsx',6,'B3');
Su = xlsread('dataset25housesninemonths.xlsx',6,'B2');
eta_ch = xlsread('dataset25housesninemonths.xlsx',6,'B6');
eta_dis = xlsread('dataset25housesninemonths.xlsx',6,'B7');
Nt=length(dem(:,1));
Nh=length(dem(1,:));
psip2p=1-0.076;
BatteryPlace=[0 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0];  % Battery location
Sp0=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];    % Initial battery state
Spp0=BatteryPlace.*Sp0;
S0=Spp0(1,BatteryPlace==1);
%%
[linsol,fval]=p2p(dem,Pg,alpha,beta,Sl,Su,eta_ch,eta_dis,Nt,res,BatteryPlace,S0,psip2p)


