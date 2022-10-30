clear
clc

%constant

D=1.91e-9;
k=52.54;
del=1e-4;
nr=60;
nt=40;
c0=0;
ci=0.804E-6;
tol=0.005;
dr=del/nr;
ca=zeros(nr,nt+1);
r=linspace(0,del,nr+1);
r(1)=dr;
t=linspace(0,555,nt+1);
dt=mean(diff(t));
ca(1,:)=ci;
ca(:,1)=c0;
caf=zeros(nr+1,nt+1);
A=zeros(nr,nr);
u=ones(1,nr)*c0;


    for j=1:nt
         for i=1:nr
           if i==nr
            A(i,i)=1+2*D*dt/(dr^2)+k*dt;
            A(i,i-1)=-D*dt/dr^2+D*dt/r(i)/dr;
            u(i)=ci+(((D/dr^2)+(D/r(i)*dr)))*dt*ci;
            
           elseif i==1
               A(i,i+2)=-3;
               A(i,i+1)=4;
               A(i,i)=-1;
               u(i)=0;
           else
               A(i,i)=1+2*D*dt/(dr^2)+k*dt;
               A(i,i+1)=-D*dt/dr^2-D*dt/r(i)/dr;
               A(i,i-1)=-D*dt/dr^2+D*dt/r(i)/dr;
               u(i)=ca(i,j);
           end
         end
         
         Y=A\u';
         ca(:,j+1)=Y;
    end
    
    

caf(1:nr,:)=ca;
caf(end,:)=ci;


%plot(x,caf(:,2),x,caf(:,end),'--','linewidth',2)
%legend('ca(x,0)','ca(x,del)')
%xlabel('x')
%ylabel('u')            
[rr,tt]=meshgrid(r,t);
surf(rr,tt,caf')
xlabel('R')
ylabel('time')
zlabel('C')    
    