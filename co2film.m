clear
clc

%constant

D=1.91e-9;
k=0.037;
del=1e-6;
nx=50;
ny=10;
v=9;
c0=0;
ci=420e-6;
tol=0.005;
dx=del/nx;
ca=zeros(nx,ny+1);
x=linspace(0,del,nx+1);
x(1)=dx;
y=linspace(0,5000,ny+1);
dy=mean(diff(y));
ca(1,:)=ci;
ca(:,1)=c0;
caf=zeros(nx+1,ny+1);
A=zeros(nx,nx);
u=zeros(nx,1)*ci;

   for j=1:ny
         for i=1:nx
           if i==1
            A(i,i)=1+(2*D*dy/v/dx^2)+k*dy/v;
            A(i,i+1)=-D*dy/v/dx^2;
            u(i)=ci+D*dy/v/dx^2*ci;
            
           elseif i==nx
               A(i,i)=3;
               A(i,i-1)=-4;
               A(i,i-2)=1;
               u(i)=0;
           else
               A(i,i)=1+(2*D*dy/v/dx^2)+k*dy/v;
               A(i,i+1)=-D*dy/v/dx^2;
               A(i,i-1)=-D*dy/v/dx^2;
               u(i)=ca(i,j);
           end
         end
         
         Y=A\u;
         ca(:,j+1)=Y;
    end
    
    

%caf(nx+1,:)=ci;
caf(1:nx,:)=ca;

%plot(x,caf(:,2),x,caf(:,end),'--','linewidth',2)
%legend('ca(x,0)','ca(x,del)')
%xlabel('x')
%ylabel('u')            
%[yy,xx]=meshgrid(y,x);
%surf(yy,xx,caf)
xlabel('y')
ylabel('x')
zlabel('C')  
plot(y,caf)
xlabel('y')
ylabel('C')