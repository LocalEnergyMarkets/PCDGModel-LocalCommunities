function [linsol,fval]=p2p(dem,Pg,alpha,beta,Sl,Su,eta_ch,eta_dis,Nt,res,BatteryPlace,S0,psip2p)
Nh=length(dem(1,:));
%% defining variables
aa=size(dem);
G=optimvar('G',aa(1),aa(2),'LowerBound',0);
D=optimvar('D',Nt,sum(BatteryPlace),'LowerBound',0,'UpperBound',beta);
C=optimvar('C',Nt,sum(BatteryPlace),'LowerBound',0,'UpperBound',alpha);
S=optimvar('S',Nt,sum(BatteryPlace),'LowerBound',Sl,'UpperBound',Su);
Ip2p=optimvar('Ip2p',Nt,Nh,Nh-1,'LowerBound',0);
Xp2p=optimvar('Xp2p',Nt,Nh,Nh-1,'LowerBound',0);
%% Objective function
linprob = optimproblem('Objective',Pg'*(sum(G,2)));
%% Constraints
linprob.Constraints.SOC = S(1,:)==S0+eta_ch*C(1,:)-(1/eta_dis)*D(1,:);
for i=2:Nt
linprob.Constraints.SOC = [linprob.Constraints.SOC; S(i,:)==S(i-1,:)+eta_ch*C(i,:)-(1/eta_dis)*D(i,:)];
end

for i=1:Nh
    for j=1:Nt
    I(j,i)=sum(Ip2p(j,i,:));
    X(j,i)=sum(Xp2p(j,i,:));
    end
end

linprob.Constraints.eq1 = [];
k=0;
for i=1:Nh
    if BatteryPlace(i)==1
        k=k+1;
        linprob.Constraints.eq1=[linprob.Constraints.eq1,res(:,i)+G(:,i)+I(:,i)+D(:,k)>=dem(:,i)+X(:,i)+C(:,k)];
    else
        linprob.Constraints.eq1=[linprob.Constraints.eq1,res(:,i)+G(:,i)+I(:,i)>=dem(:,i)+X(:,i)];
    end
end

IXpind=zeros(Nh-1,Nh);
for i=1:length(IXpind(1,:))
    for j=1:length(IXpind(:,1))
        if i<=j
            IXpind(j,i)=j+1;
        else
            IXpind(j,i)=j;
        end
    end
end

linprob.Constraints.eq3 = [];
for i=1:Nh
    for j=1:Nh-1
        in=IXpind(j,i);
        jn=IXpind(:,in)==i;
        linprob.Constraints.eq3 = [linprob.Constraints.eq3; Ip2p(:,i,j)==psip2p*Xp2p(:,in,jn)];
    end
end

linprob.Constraints.eq5 = psip2p*sum(X,2)==sum(I,2);
%% Evaluation
[linsol,fval] = solve(linprob);
end