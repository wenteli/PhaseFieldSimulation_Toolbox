phase=zeros(nx,ny);
BTO_phase=zeros(nx*ny*nz,1);

for jjj=1:ny



       exx=zeros(nx,1);
       std_exx=zeros(nx,1);
       eyy=zeros(nx,1);
       std_eyy=zeros(nx,1);
       ezz=zeros(nx,1);
       std_ezz=zeros(nx,1);
       exy=zeros(nx,1);
       std_exy=zeros(nx,1);
       
       
       start_node=jjj;     %starting node ID of the path we choose
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
       
       
       
       
       %%%% calculate average average strain and std in a small group with specific tolerance %%%%
       tol=0.1;        %strain tolerance
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
       
       %for exy
       left=1;          %left and right are the boundary of domain. It is a movable cursor.
       right=1;         %left and right are the boundary of domain. It is a movable cursor.
       tol_exy=0.05;
       exy_left_bound=[];   %array to store info of domain left boundary
       exy_right_bound=[];  %array to store info of domain right boundary
       for i=1:nx
           if i==1
                 if abs(exy(i+1)-exy(i))<tol_exy
                    left=i;
                    exy_left_bound=[exy_left_bound left];
                    fprintf('left=%d;   ', left);
                 end
           elseif i==nx
                 if abs(exy(i-1)-exy(i))<tol_exy
                    right=i;
                    exy_right_bound=[exy_right_bound right];
                    fprintf('right=%d;\r\n', right);
                 end
           else
                 if abs(exy(i-1)-exy(i))>tol_exy && abs(exy(i+1)-exy(i))<tol_exy
                    left=i;
                    exy_left_bound=[exy_left_bound left];
                    fprintf('left=%d;   ', left);
                 elseif abs(exy(i+1)-exy(i))>tol_exy && abs(exy(i-1)-exy(i))<tol_exy
                    right=i;
                    exy_right_bound=[exy_right_bound right];
                    fprintf('right=%d;\r\n', right);
                 end
           end
       end

      
       tolerance=0.1;
       for iii=1:numel(exx_left_bound)
	       if mean(exy(exx_left_bound(iii):exx_right_bound(iii)))-8*std(exy(exx_left_bound(iii):exx_right_bound(iii)))<0 && mean(exy(exx_left_bound(iii):exx_right_bound(iii)))+8*std(exy(exx_left_bound(iii):exx_right_bound(iii)))>0 && mean(eyy(exx_left_bound(iii):exx_right_bound(iii)))<0 && ( abs(mean(ezz(exx_left_bound(iii):exx_right_bound(iii)))-mean(eyy(exx_left_bound(iii):exx_right_bound(iii))))/abs(mean(eyy(exx_left_bound(iii):exx_right_bound(iii))))<tolerance || abs(mean(ezz(exx_left_bound(iii):exx_right_bound(iii)))-mean(eyy(exx_left_bound(iii):exx_right_bound(iii))))/abs(mean(ezz(exx_left_bound(iii):exx_right_bound(iii))))<tolerance )
                   phase(exx_left_bound(iii):exx_right_bound(iii),jjj)=2;
               elseif mean(exy(exx_left_bound(iii):exx_right_bound(iii)))-8*std(exy(exx_left_bound(iii):exx_right_bound(iii)))<0 && mean(exy(exx_left_bound(iii):exx_right_bound(iii)))+8*std(exy(exx_left_bound(iii):exx_right_bound(iii)))>0 && mean(exx(exx_left_bound(iii):exx_right_bound(iii)))<0 && ( abs(mean(ezz(exx_left_bound(iii):exx_right_bound(iii)))-mean(exx(exx_left_bound(iii):exx_right_bound(iii))))/abs(mean(exx(exx_left_bound(iii):exx_right_bound(iii))))<tolerance || abs(mean(ezz(exx_left_bound(iii):exx_right_bound(iii)))-mean(exx(exx_left_bound(iii):exx_right_bound(iii))))/abs(mean(ezz(exx_left_bound(iii):exx_right_bound(iii))))<tolerance )
                   phase(exx_left_bound(iii):exx_right_bound(iii),jjj)=1;
               end
       end

       for i=1:nx
           for j=1:ny
               for k=1:nz
                   BTO_phase(j+(i-1)*ny*nz+(k-1)*ny)=phase(i,j);
               end
           end
       end




end



fileID = fopen('sol.vtk','a');
fprintf(fileID,'SCALARS Phase float 1\n');
fprintf(fileID,'LOOKUP_TABLE default\n');
for i=1:nx*ny*nz
    fprintf(fileID,'%d\n',BTO_phase(i));
end
