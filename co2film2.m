clear
clc

%constant

D=1.91e-9;
k=0.037;
v=.009;
a=0.005053;
del=1e-4;
nx=50;
nt=50;
c0=0;
ci=420e-6;
tol=0.005;
dx=del/nx;
ca=zeros(nx,nt+1);
x=linspace(0,del,nx+1);
x(1)=dx;
t=linspace(0,1,nt+1);
dt=mean(diff(t));
ca(1,:)=ci;
ca(:,1)=c0;
caf=zeros(nx+1,nt+1);
A=zeros(nx,nx);
u=zeros(nx,1)*ci;


    for j=1:nt
         for i=1:nx
           if i==nx
            A(i,i)=1+(2*D*dt/dx^2)+(k*dt);
            A(i,i-1)=-D*dt/dx^2;
            u(i)=ci-v*a*dt+ci*D*dt/dx^2;
            
           elseif i==1
               A(i,i)=-3;
               A(i,i+1)=+4;
               A(i,i+2)=-1;
               u(i)=0;
           else
               A(i,i)=1+(2*D*dt/dx^2)+(k*dt);
               A(i,i+1)=-D*dt/dx^2;
               A(i,i-1)=-D*dt/dx^2;
               u(i)=ca(i,j)-v*a*dt;
           end
         end
         
         Y=A\u;
         ca(:,j+1)=Y;
    end
    

caf(1:nx,:)=ca;
caf(nx+1,:)=ci;

%plot(x,caf(:,2),x,caf(:,end),'--','linewidth',2)
%legend('ca(x,0)','ca(x,del)')
%xlabel('x')
%ylabel('u')            
[xx,tt]=meshgrid(x,t);
surf(xx,tt,caf')
xlabel('X')
ylabel('t')
zlabel('C')    
    %plot(x,caf) 