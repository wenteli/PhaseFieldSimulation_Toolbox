clear
clc

%%%% we choose the path start from grid ID 10 and go along x direciton. %%%% 
nx=40;
ny=40;
nz=8;


data = readtable('sol_40408.csv', 'HeaderLines',1);
data = table2array(data);
len = length(data);

strain = zeros(len,3);
strain(:,1) = data(:,16);   %exx
strain(:,2) = data(:,17);   %exy
strain(:,3) = data(:,18);   %exz
strain(:,4) = data(:,19);   %eyx
strain(:,5) = data(:,20);   %eyy
strain(:,6) = data(:,21);   %eyz
strain(:,7) = data(:,22);   %ezx
strain(:,8) = data(:,23);   %ezy
strain(:,9) = data(:,24);   %ezz



%%%% plot shear strain for all points %%%%
ave_exy=zeros(nx*ny*nz,1);
ave_exz=zeros(nx*ny*nz,1);
ave_eyz=zeros(nx*ny*nz,1);

ave_exy=ave_exy+mean(strain(:,2));
ave_exz=ave_exz+mean(strain(:,3));
ave_eyz=ave_eyz+mean(strain(:,6));

plot(strain(:,2),'LineWidth',2)
hold on
plot(strain(:,3),'LineWidth',2)
plot(strain(:,6),'LineWidth',2)
plot(ave_exy,'LineWidth',3)
plot(ave_eyz,'LineWidth',3)
plot(ave_exz,'LineWidth',3)
legend({'exy','exz','eyz','ave exy','ave exz','ave eyz'},'Location','southwest','FontSize',20)



%%%% calculate average along z direction, verify z direction is alost uniform %%%%
exx=zeros(nx,1);
std_exx=zeros(nx,1);
eyy=zeros(nx,1);
std_eyy=zeros(nx,1);
ezz=zeros(nx,1);
std_ezz=zeros(nx,1);
exy=zeros(nx,1);
std_exy=zeros(nx,1);


start_node=2;     %starting node ID of the path we choose
for i=1:nx
    for j=1:nz     %list all nodes ID along z direction
        nodes(j)=start_node+ny*nz*(i-1)+(j-1)*ny; 
    end
    exx(i)=mean(strain(nodes,1));
    std_exx(i)=std(strain(nodes,1));
    eyy(i)=mean(strain(nodes,5));
    std_eyy(i)=std(strain(nodes,5));
    ezz(i)=mean(strain(nodes,9));
    std_ezz(i)=std(strain(nodes,9));
    exy(i)=mean(strain(nodes,2));
    std_exy(i)=std(strain(nodes,2));

end

errorbar(exx,std_exx,'black','LineWidth',3);
hold on;
xticks(1:nx);
errorbar(eyy,std_eyy,'blue','LineWidth',3);
errorbar(ezz,std_ezz,'red','LineWidth',3);
errorbar(exy,std_exy,'green','LineWidth',3);

%ec=zeros(nx,1);
%ec=ec+1.8;
%plot(ec,'LineWidth',2)
%ea=zeros(nx,1);
%ea=ea-0.61;
%plot(ea,'LineWidth',2)
legend({'exx','eyy','ezz','exy'},'Location','west','FontSize',20)



%%%% calculate average average strain and std in a small group with specific tolerance %%%%
tol=0.15;        %strain tolerance
left=1;          %left and right are the boundary of domain. It is a movable cursor.
right=1;         %left and right are the boundary of domain. It is a movable cursor.

%for exx
exx_left_bound=[];   %array to store info of domain left boundary
exx_right_bound=[];  %array to store info of domain right boundary
for i=1:nx
    if i==1
          if abs(exx(i+1)-exx(i))<tol 
             left=i;
             exx_left_bound=[exx_left_bound left];
             fprintf('left=%d;   ', left);
          end
    elseif i==nx
          if abs(exx(i-1)-exx(i))<tol 
             right=i;
             exx_right_bound=[exx_right_bound right];
             fprintf('right=%d;\r\n', right);
          end
    else
          if abs(exx(i-1)-exx(i))>tol && abs(exx(i+1)-exx(i))<tol 
             left=i;
             exx_left_bound=[exx_left_bound left];
             fprintf('left=%d;   ', left);
          elseif abs(exx(i+1)-exx(i))>tol && abs(exx(i-1)-exx(i))<tol 
             right=i;
             exx_right_bound=[exx_right_bound right];
             fprintf('right=%d;\r\n', right);
          end
    end
end

for i=1:numel(exx_left_bound)
    rectangle('Position',[exx_left_bound(i) mean(exx(exx_left_bound(i):exx_right_bound(i)))-std(exx(exx_left_bound(i):exx_right_bound(i))) exx_right_bound(i)-exx_left_bound(i) 2*std(exx(exx_left_bound(i):exx_right_bound(i)))],'EdgeColor','black', 'LineWidth',2);
end



%for eyy
left=1;          %left and right are the boundary of domain. It is a movable cursor.
right=1;         %left and right are the boundary of domain. It is a movable cursor.
eyy_left_bound=[];   %array to store info of domain left boundary
eyy_right_bound=[];  %array to store info of domain right boundary
for i=1:nx
    if i==1
          if abs(eyy(i+1)-eyy(i))<tol 
             left=i;
             eyy_left_bound=[eyy_left_bound left];
             fprintf('left=%d;   ', left);
          end
    elseif i==nx
          if abs(eyy(i-1)-eyy(i))<tol 
             right=i;
             eyy_right_bound=[eyy_right_bound right];
             fprintf('right=%d;\r\n', right);
          end
    else
          if abs(eyy(i-1)-eyy(i))>tol && abs(eyy(i+1)-eyy(i))<tol 
             left=i;
             eyy_left_bound=[eyy_left_bound left];
             fprintf('left=%d;   ', left);
          elseif abs(eyy(i+1)-eyy(i))>tol && abs(eyy(i-1)-eyy(i))<tol 
             right=i;
             eyy_right_bound=[eyy_right_bound right];
             fprintf('right=%d;\r\n', right);
          end
    end
end
for i=1:numel(eyy_left_bound)
    rectangle('Position',[eyy_left_bound(i) mean(eyy(eyy_left_bound(i):eyy_right_bound(i)))-std(eyy(eyy_left_bound(i):eyy_right_bound(i))) eyy_right_bound(i)-eyy_left_bound(i) 2*std(eyy(eyy_left_bound(i):eyy_right_bound(i)))],'EdgeColor','blue', 'LineWidth',2);
end

%for ezz
left=1;          %left and right are the boundary of domain. It is a movable cursor.
right=1;         %left and right are the boundary of domain. It is a movable cursor.
tol_ezz=0.05;
ezz_left_bound=[];   %array to store info of domain left boundary
ezz_right_bound=[];  %array to store info of domain right boundary
for i=1:nx
    if i==1
          if abs(ezz(i+1)-ezz(i))<tol_ezz
             left=i;
             ezz_left_bound=[ezz_left_bound left];
             fprintf('left=%d;   ', left);
          end
    elseif i==nx
          if abs(ezz(i-1)-ezz(i))<tol_ezz 
             right=i;
             ezz_right_bound=[ezz_right_bound right];
             fprintf('right=%d;\r\n', right);
          end
    else
          if abs(ezz(i-1)-ezz(i))>tol_ezz && abs(ezz(i+1)-ezz(i))<tol_ezz 
             left=i;
             ezz_left_bound=[ezz_left_bound left];
             fprintf('left=%d;   ', left);
          elseif abs(ezz(i+1)-ezz(i))>tol_ezz && abs(ezz(i-1)-ezz(i))<tol_ezz
             right=i;
             ezz_right_bound=[ezz_right_bound right];
             fprintf('right=%d;\r\n', right);
          end
    end
end
for i=1:numel(ezz_left_bound)
    rectangle('Position',[ezz_left_bound(i) mean(ezz(ezz_left_bound(i):ezz_right_bound(i)))-std(ezz(ezz_left_bound(i):ezz_right_bound(i))) ezz_right_bound(i)-ezz_left_bound(i) 2*std(ezz(ezz_left_bound(i):ezz_right_bound(i)))],'EdgeColor','red', 'LineWidth',2);
end

%for exy
left=1;          %left and right are the boundary of domain. It is a movable cursor.
right=1;         %left and right are the boundary of domain. It is a movable cursor.
tol_exy=0.05;
exy_left_bound=exx_left_bound;   %array to store info of domain left boundary
exy_right_bound=exx_right_bound;  %array to store info of domain right boundary
for i=1:numel(exy_left_bound)
    rectangle('Position',[exy_left_bound(i) mean(exy(exy_left_bound(i):exy_right_bound(i)))-std(exy(exy_left_bound(i):exy_right_bound(i))) exy_right_bound(i)-exy_left_bound(i) 2*std(exy(exy_left_bound(i):exy_right_bound(i)))],'EdgeColor','green', 'LineWidth',2);
end
