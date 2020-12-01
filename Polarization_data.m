clear
clc

%%%% we choose the path start from grid ID 10 and go along x direciton. %%%% 
nx=40;
ny=40;
nz=8;


data = readtable('sol_40408.csv', 'HeaderLines',1);
data = table2array(data);
len = length(data);

polarization = zeros(len,3);
polarization(:,1) = data(:,1);   %Px
polarization(:,2) = data(:,2);   %Py
polarization(:,3) = data(:,3);   %Pz


%%%% calculate average along z direction, verify z direction is alost uniform %%%%
px=zeros(nx,1);
std_px=zeros(nx,1);
py=zeros(nx,1);
std_py=zeros(nx,1);
pz=zeros(nx,1);
std_pz=zeros(nx,1);



start_node=2;     %starting node ID of the path we choose
for i=1:nx
    for j=1:nz     %list all nodes ID along z direction
        nodes(j)=start_node+ny*nz*(i-1)+(j-1)*ny; 
    end
    px(i)=mean(polarization(nodes,1));
    std_px(i)=std(polarization(nodes,1));
    py(i)=mean(polarization(nodes,2));
    std_py(i)=std(polarization(nodes,2));
    pz(i)=mean(polarization(nodes,3));
    std_pz(i)=std(polarization(nodes,3));
end

errorbar(px,std_px,'black','LineWidth',3);
hold on;
xticks(1:nx);
errorbar(py,std_py,'blue','LineWidth',3);
errorbar(pz,std_pz,'red','LineWidth',3);



legend({'px','py','pz'},'Location','west','FontSize',20)



%%%% calculate average average strain and std in a small group with specific tolerance %%%%
tol=0.15;        %strain tolerance
left=1;          %left and right are the boundary of domain. It is a movable cursor.
right=1;         %left and right are the boundary of domain. It is a movable cursor.

%for px
px_left_bound=[];   %array to store info of domain left boundary
px_right_bound=[];  %array to store info of domain right boundary
for i=1:nx
    if i==1
          if abs(px(i+1)-px(i))<tol 
             left=i;
             px_left_bound=[px_left_bound left];
             fprintf('left=%d;   ', left);
          end
    elseif i==nx
          if abs(px(i-1)-px(i))<tol 
             right=i;
             px_right_bound=[px_right_bound right];
             fprintf('right=%d;\r\n', right);
          end
    else
          if abs(px(i-1)-px(i))>tol && abs(px(i+1)-px(i))<tol 
             left=i;
             px_left_bound=[px_left_bound left];
             fprintf('left=%d;   ', left);
          elseif abs(px(i+1)-px(i))>tol && abs(px(i-1)-px(i))<tol 
             right=i;
             px_right_bound=[px_right_bound right];
             fprintf('right=%d;\r\n', right);
          end
    end
end

for i=1:numel(px_left_bound)
    rectangle('Position',[px_left_bound(i) mean(px(px_left_bound(i):px_right_bound(i)))-std(px(px_left_bound(i):px_right_bound(i))) px_right_bound(i)-px_left_bound(i) 2*std(px(px_left_bound(i):px_right_bound(i)))],'EdgeColor','black', 'LineWidth',2);
end



%for py
left=1;          %left and right are the boundary of domain. It is a movable cursor.
right=1;         %left and right are the boundary of domain. It is a movable cursor.
py_left_bound=[];   %array to store info of domain left boundary
py_right_bound=[];  %array to store info of domain right boundary
for i=1:nx
    if i==1
          if abs(py(i+1)-py(i))<tol 
             left=i;
             py_left_bound=[py_left_bound left];
             fprintf('left=%d;   ', left);
          end
    elseif i==nx
          if abs(py(i-1)-py(i))<tol 
             right=i;
             py_right_bound=[py_right_bound right];
             fprintf('right=%d;\r\n', right);
          end
    else
          if abs(py(i-1)-py(i))>tol && abs(py(i+1)-py(i))<tol 
             left=i;
             py_left_bound=[py_left_bound left];
             fprintf('left=%d;   ', left);
          elseif abs(py(i+1)-py(i))>tol && abs(py(i-1)-py(i))<tol 
             right=i;
             py_right_bound=[py_right_bound right];
             fprintf('right=%d;\r\n', right);
          end
    end
end
for i=1:numel(py_left_bound)
    rectangle('Position',[py_left_bound(i) mean(py(py_left_bound(i):py_right_bound(i)))-std(py(py_left_bound(i):py_right_bound(i))) py_right_bound(i)-py_left_bound(i) 2*std(py(py_left_bound(i):py_right_bound(i)))],'EdgeColor','blue', 'LineWidth',2);
end

%for pz
left=1;          %left and right are the boundary of domain. It is a movable cursor.
right=1;         %left and right are the boundary of domain. It is a movable cursor.
tol_pz=0.05;
pz_left_bound=[];   %array to store info of domain left boundary
pz_right_bound=[];  %array to store info of domain right boundary
for i=1:nx
    if i==1
          if abs(pz(i+1)-pz(i))<tol_pz
             left=i;
             pz_left_bound=[pz_left_bound left];
             fprintf('left=%d;   ', left);
          end
    elseif i==nx
          if abs(pz(i-1)-pz(i))<tol_pz 
             right=i;
             pz_right_bound=[pz_right_bound right];
             fprintf('right=%d;\r\n', right);
          end
    else
          if abs(pz(i-1)-pz(i))>tol_pz && abs(pz(i+1)-pz(i))<tol_pz 
             left=i;
             pz_left_bound=[pz_left_bound left];
             fprintf('left=%d;   ', left);
          elseif abs(pz(i+1)-pz(i))>tol_pz && abs(pz(i-1)-pz(i))<tol_pz
             right=i;
             pz_right_bound=[pz_right_bound right];
             fprintf('right=%d;\r\n', right);
          end
    end
end
for i=1:numel(pz_left_bound)
    rectangle('Position',[pz_left_bound(i) mean(pz(pz_left_bound(i):pz_right_bound(i)))-std(pz(pz_left_bound(i):pz_right_bound(i))) pz_right_bound(i)-pz_left_bound(i) 2*std(pz(pz_left_bound(i):pz_right_bound(i)))],'EdgeColor','red', 'LineWidth',2);
end
