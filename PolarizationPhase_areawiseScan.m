%%%%%   Areawise phase scan   %%%%%%%%%
phase=zeros(nx,ny);
BTOpola_phase=zeros(nx*ny*nz,1);


for jjj=1:ny



          %%%% calculate average along z direction, verify z direction is alost uniform %%%%
          px=zeros(nx,1);
          std_px=zeros(nx,1);
          py=zeros(nx,1);
          std_py=zeros(nx,1);
          pz=zeros(nx,1);
          std_pz=zeros(nx,1);
          
          
          
          start_node=jjj;     %starting node ID of the path we choose
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
          
          
          
          %%%% calculate average average strain and std in a small group with specific tolerance %%%%
          tol=0.1;        %strain tolerance
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

       tolerance=0.2;
       for iii=1:numel(py_left_bound)
	       if mean(py(py_left_bound(iii):py_right_bound(iii)))<-1 && abs(mean(px(py_left_bound(iii):py_right_bound(iii))))/abs(mean(py(py_left_bound(iii):py_right_bound(iii))))<tolerance
                   phase(py_left_bound(iii):py_right_bound(iii),jjj)=1;
 	       elseif mean(py(py_left_bound(iii):py_right_bound(iii)))>1 && abs(mean(px(py_left_bound(iii):py_right_bound(iii))))/abs(mean(py(py_left_bound(iii):py_right_bound(iii))))<tolerance
                   phase(py_left_bound(iii):py_right_bound(iii),jjj)=2;
	       elseif mean(px(py_left_bound(iii):py_right_bound(iii)))<-1 && abs(mean(py(py_left_bound(iii):py_right_bound(iii))))/abs(mean(px(py_left_bound(iii):py_right_bound(iii))))<tolerance
                   phase(py_left_bound(iii):py_right_bound(iii),jjj)=3;
 	       elseif mean(px(py_left_bound(iii):py_right_bound(iii)))>1 && abs(mean(py(py_left_bound(iii):py_right_bound(iii))))/abs(mean(px(py_left_bound(iii):py_right_bound(iii))))<tolerance
                   phase(py_left_bound(iii):py_right_bound(iii),jjj)=4;
               end
       end



       for i=1:nx
           for j=1:ny
               for k=1:nz
                   BTOpola_phase(j+(i-1)*ny*nz+(k-1)*ny)=phase(i,j);
               end
           end
       end





end


fileID = fopen('sol.vtk','a');
fprintf(fileID,'SCALARS PolaPhase float 1\n');
fprintf(fileID,'LOOKUP_TABLE default\n');
for i=1:nx*ny*nz
    fprintf(fileID,'%d\n',BTOpola_phase(i));
end
