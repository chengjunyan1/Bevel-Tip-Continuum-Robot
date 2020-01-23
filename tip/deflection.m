function [theta_next]=deflection(iin,theta_now)

%% FK(v u ~ theta) theta start from 0
syms K
Q=CONFIG('Q');
L=CONFIG('L'); n=CONFIG('n'); l=L/n;
E=CONFIG('E'); I=CONFIG('I');
k0=CONFIG('k0'); k1=CONFIG('k1');
K_v=E*I*n/L;
THETA0=0; STHETA=0; CTHETA=0; 
for i=1:iin
    eval(['syms theta' num2str(i)]) % define theta
    eval(['THETA' num2str(i) '=THETA' num2str(i-1) '+theta' num2str(i) ';']) % define THETA
end
for j=1:iin
    i=iin+1-j;
    eval(['STHETA=STHETA+sin(THETA' num2str(i) ');'])
    eval(['CTHETA=CTHETA+cos(THETA' num2str(i) ');'])
    eval(['G' num2str(j) '=[-l*STHETA,l*CTHETA];'])
end
eval(['Fu=Q*sin(THETA' num2str(iin) ');'])
eval(['Fv=-Q*cos(THETA' num2str(iin) ');'])
F=[Fu;Fv];
v0=0; u0=0; theta=[];
for i=1:iin
    eval(['tau' num2str(i) '=G' num2str(i) '*F;']) 
    eval(['theta=[theta theta' num2str(i) '];'])
    eval(['v' num2str(i) '=v' num2str(i-1) '+l*sin(THETA' num2str(i) ');'])
    eval(['u' num2str(i) '=u' num2str(i-1) '+l*cos(THETA' num2str(i) ');'])
end

%% tissue (rou ~ v u ~ Q theta)
theta_v=[];
for i=1:iin
    eval(['T' num2str(i) '=k0*(l*(n-i+1)^k1);'])
    eval(['K' num2str(i) '=T' num2str(i) '+K_v;'])
    eval(['theta_v=[theta_v (G' num2str(i) '/K' num2str(i) ')*F];'])
end
theta_next=eval(subs(theta_v,theta,theta_now));

%% curvature
% for i=1:iin
%     eval(['v' num2str(i) '=subs(v' num2str(i) ',theta,theta_v);'])
%     eval(['u' num2str(i) '=subs(u' num2str(i) ',theta,theta_v);'])
% end
% for i=1:n-1
%     eval(['rou' num2str(i) '=(1+((v' num2str(i) '-v' num2str(i-1) ')/(u'...
%         num2str(i) '-u' num2str(i-1) '))^2)^(3/2)/((v' num2str(i+1) '-2*v'...
%         num2str(i) '+v' num2str(i-1) ')/(u' num2str(i) '-u' num2str(i-1) ')^2);'])
% end

end
