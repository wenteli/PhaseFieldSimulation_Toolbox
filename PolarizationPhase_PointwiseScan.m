%%%% This is pointwise plotting of each phase. Compared with crystallographic phase scan, that is areawise scan     %%%%%%

BTOpola_phase=zeros(nx*ny*nz,1);


tolerance = 0.2;
for jjj=1:nx*ny*nz
    if polarization(jjj,1)>1 && abs(polarization(jjj,2))/abs(polarization(jjj,1))<tolerance 
         BTOpola_phase(jjj)=1;  
    elseif polarization(jjj,1)<-1 && abs(polarization(jjj,2))/abs(polarization(jjj,1))<tolerance 
         BTOpola_phase(jjj)=2;
    elseif polarization(jjj,2)>1 && abs(polarization(jjj,1))/abs(polarization(jjj,2))<tolerance 
         BTOpola_phase(jjj)=3;  
    elseif polarization(jjj,2)<-1 && abs(polarization(jjj,1))/abs(polarization(jjj,2))<tolerance 
         BTOpola_phase(jjj)=4;  
    end
end


fileID = fopen('sol.vtk','a');
fprintf(fileID,'SCALARS PolaPhase float 1\n');
fprintf(fileID,'LOOKUP_TABLE default\n');
for i=1:nx*ny*nz
    fprintf(fileID,'%d\n',BTOpola_phase(i));
end
