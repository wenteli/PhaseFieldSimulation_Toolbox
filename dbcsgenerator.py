#!/usr/bin/env python
# coding: utf-8

import numpy as np
file = open("/home/wente/Desktop/parallel-3D-stuff/dbcs.txt",'w')





# how many nodes along x, y and z 
nx = 40;
ny = 40;
nz = 14;
length = 0.25;
epsilonxx = +2.5;
epsilonyy = +2.5;
epsilonxy = -0;
disx = epsilonxx*(nx-1)*length;
disy = epsilonyy*(ny-1)*length;
disxy = epsilonxy*(ny-1)*length;
flag = np.zeros([nx*ny*nz,8],int);



# specify the index of 8 corner nodes
Cornernode = [1, ny, 1+ny*(nz-1), 1+ny*(nz-1)+ny-1, 1+ny*nz*(nx-1), 1+ny*nz*(nx-1)+ny-1, 1+ny*(nz-1)+ny*nz*(nx-1), 1+ny*(nz-1)+ny*nz*(nx-1)+ny-1];



# top and bottom z plane electrostatic potential, displacement, etc. Bottom is zero
for i in range (0,nx):
    for j in range (0,ny):
        topnodeindex = i*nz*ny+1+j;
        bottomnodeindex = topnodeindex+(nz-1)*ny;
        if flag[bottomnodeindex-1][3] == 0:
            file.write('%i'%bottomnodeindex);
            file.write('\t 4 \t 0.00\r\n');
            flag[bottomnodeindex-1][3] = 1;
#        if flag[bottomnodeindex-nx-1][3] == 0:
#            file.write('%i'%(bottomnodeindex-nx));
#            file.write('\t 4 \t 1.0\r\n');
#            flag[bottomnodeindex-nx-1][3] = 1;
#        if flag[topnodeindex-1][3] == 0:
#            file.write('%i'%topnodeindex);
#            file.write('\t 4 \t 0.00\r\n');
#            flag[topnodeindex-1][3] = 1;

for i in range (0,nx):
    for j in range (0,ny):
        topnodeindex = i*nz*ny+1+j;
        bottomnodeindex = topnodeindex+(nz-1)*ny;
        x = nx-1-int((bottomnodeindex-1)/(ny*nz));
        y = ny-(bottomnodeindex-(nx-1-x)*ny*nz-(nz-1)*ny);
        if flag[bottomnodeindex-1][2] == 0:
            file.write('%i'%bottomnodeindex);
            file.write('\t 3 \t 0.00\r\n');
            flag[bottomnodeindex-1][2] = 1;
        if flag[bottomnodeindex-1][0] == 0:
            file.write('%i'%bottomnodeindex);
            ux = epsilonxx*x*length+epsilonxy*y*length;
            file.write('\t 1 \t');
            file.write(str(ux));
            file.write('\r\n')
            flag[bottomnodeindex-1][0] = 1;
        if flag[bottomnodeindex-1][1] == 0:
            file.write('%i'%bottomnodeindex);
            uy = epsilonyy*y*length+epsilonxy*x*length;
            file.write('\t 2 \t');
            file.write(str(uy));
            file.write('\r\n');
            flag[bottomnodeindex-1][1] = 1;


'''
# left and right y plane potential, displacement, etc. Left is zero.
for i in range (0,nx):
    for j in range (0,nz):
        rightnodeindex = i*ny*nz+1+j*ny;
        leftnodeindex = rightnodeindex+ny-1;
        if flag[leftnodeindex-1][3] == 0:
            file.write('%i'%leftnodeindex);
            file.write('\t 4 \t 0.00\r\n');
            flag[leftnodeindex-1][3] = 1;
        if flag[rightnodeindex-1][3] == 0:
            file.write('%i'%rightnodeindex);
            file.write('\t 4 \t 0.00\r\n');
            flag[rightnodeindex-1][3] = 1;

for i in range (0,nx):
    for j in range (0,nz):
        rightnodeindex = i*ny*nz+1+j*ny;
        leftnodeindex = rightnodeindex+ny-1;
        if flag[leftnodeindex-1][1] == 0:
            file.write('%i'%leftnodeindex);
            file.write('\t 2 \t 0.00\r\n');
            flag[leftnodeindex-1][1] = 1;
'''


'''
# front and back x plane potential, displacement, etc. Back is zero.
for j in range (0,nz):
    for i in range (0,ny):
        frontnodeindex = ny*j+1+i;
        backnodeindex = frontnodeindex+ny*nz*(nx-1);
        if flag[backnodeindex-1][3] == 0:
            file.write('%i'%backnodeindex);
            file.write('\t 4 \t 0.00\r\n');
            flag[backnodeindex-1][3] = 1;
        if flag[frontnodeindex-1][3] == 0:
            file.write('%i'%frontnodeindex);
            file.write('\t 4 \t 0.00\r\n');
            flag[frontnodeindex-1][3] = 1;

for j in range (0,nz):
    for i in range (0,ny):
        frontnodeindex = ny*j+1+i;
        backnodeindex = frontnodeindex+ny*nz*(nx-1);
        if flag[backnodeindex-1][0] == 0:
            file.write('%i'%backnodeindex);
            file.write('\t 1 \t 0.00\r\n');
            flag[backnodeindex-1][0] = 1;
'''
            
 
            
# temperature fixed for all nodes
for i in range (0,nx*ny*nz):
    file.write('%i'%(i+1));
    file.write('\t 8 \t 2.32 \r\n');
    flag[i][7] = 1;


    
# specify the value (displacement, potential) of corner nodes. To fix rigid body motion, rotation and set ground potential.
'''
if flag[Cornernode[7]-1][0] == 0:
    file.write('%i'%(Cornernode[7]));
    file.write('\t 1 \t 0.00\r\n');
    flag[Cornernode[7]-1][0] = 1;    
if flag[Cornernode[7]-1][1] == 0:
    file.write('%i'%(Cornernode[7]));
    file.write('\t 2 \t 0.00\r\n');
    flag[Cornernode[7]-1][1] = 1;   
if flag[Cornernode[7]-1][2] == 0:
    file.write('%i'%(Cornernode[7]));
    file.write('\t 3 \t 0.00\r\n');
    flag[Cornernode[7]-1][2] = 1; 
'''
'''
if flag[Cornernode[7]-1][3] == 0:
    file.write('%i'%(Cornernode[7]));
    file.write('\t 4 \t 0.00\r\n');
    flag[Cornernode[7]-1][3] = 1;  
    
if flag[Cornernode[6]-1][3] == 0:
    file.write('%i'%(Cornernode[6]));
    file.write('\t 4 \t 0.00\r\n');
    flag[Cornernode[6]-1][3] = 1;  
    
if flag[Cornernode[2]-1][3] == 0:
    file.write('%i'%(Cornernode[2]));
    file.write('\t 4 \t 0.00\r\n');
    flag[Cornernode[2]-1][3] = 1;  
    
if flag[Cornernode[3]-1][3] == 0:
    file.write('%i'%(Cornernode[3]));
    file.write('\t 4 \t 0.00\r\n');
    flag[Cornernode[3]-1][3] = 1;  
    
if flag[Cornernode[0]-1][3] == 0:
    file.write('%i'%(Cornernode[0]));
    file.write('\t 4 \t 0.00\r\n');
    flag[Cornernode[0]-1][3] = 1;  
    
if flag[Cornernode[5]-1][3] == 0:
    file.write('%i'%(Cornernode[5]));
    file.write('\t 4 \t 0.00\r\n');
    flag[Cornernode[5]-1][3] = 1;  
'''
'''
if flag[Cornernode[0]-1][0] == 0:
    file.write('%i'%(Cornernode[0]));
    file.write('\t 1 \t 0.00\r\n');
    flag[Cornernode[0]-1][0] = 1;    
if flag[Cornernode[0]-1][1] == 0:
    file.write('%i'%(Cornernode[0]));
    file.write('\t 2 \t 0.00\r\n');
    flag[Cornernode[0]-1][1] = 1;   
if flag[Cornernode[0]-1][2] == 0:
    file.write('%i'%(Cornernode[0]));
    file.write('\t 3 \t 0.00\r\n');
    flag[Cornernode[0]-1][2] = 1;  
if flag[Cornernode[0]-1][3] == 0:
    file.write('%i'%(Cornernode[0]));
    file.write('\t 4 \t 0.00\r\n');
    flag[Cornernode[0]-1][3] = 1;

if flag[Cornernode[1]-1][0] == 0:
    file.write('%i'%(Cornernode[1]));
    file.write('\t 1 \t 0.00\r\n');
    flag[Cornernode[1]-1][0] = 1;    
if flag[Cornernode[1]-1][1] == 0:
    file.write('%i'%(Cornernode[1]));
    file.write('\t 2 \t 0.00\r\n');
    flag[Cornernode[1]-1][1] = 1;   
if flag[Cornernode[1]-1][2] == 0:
    file.write('%i'%(Cornernode[1]));
    file.write('\t 3 \t 0.00\r\n');
    flag[Cornernode[1]-1][2] = 1;  
    
if flag[Cornernode[2]-1][0] == 0:
    file.write('%i'%(Cornernode[2]));
    file.write('\t 1 \t 0.00\r\n');
    flag[Cornernode[2]-1][0] = 1;    
if flag[Cornernode[2]-1][1] == 0:
    file.write('%i'%(Cornernode[2]));
    file.write('\t 2 \t 0.00\r\n');
    flag[Cornernode[2]-1][1] = 1;   
if flag[Cornernode[2]-1][2] == 0:
    file.write('%i'%(Cornernode[2]));
    file.write('\t 3 \t 0.00\r\n');
    flag[Cornernode[2]-1][2] = 1;  

if flag[Cornernode[3]-1][0] == 0:
    file.write('%i'%(Cornernode[3]));
    file.write('\t 1 \t 0.00\r\n');
    flag[Cornernode[3]-1][0] = 1;    
if flag[Cornernode[3]-1][1] == 0:
    file.write('%i'%(Cornernode[3]));
    file.write('\t 2 \t 0.00\r\n');
    flag[Cornernode[3]-1][1] = 1;   
if flag[Cornernode[3]-1][2] == 0:
    file.write('%i'%(Cornernode[3]));
    file.write('\t 3 \t 0.00\r\n');
    flag[Cornernode[3]-1][2] = 1;  

if flag[Cornernode[4]-1][0] == 0:
    file.write('%i'%(Cornernode[4]));
    file.write('\t 1 \t 0.00\r\n');
    flag[Cornernode[4]-1][0] = 1;    
if flag[Cornernode[4]-1][1] == 0:
    file.write('%i'%(Cornernode[4]));
    file.write('\t 2 \t 0.00\r\n');
    flag[Cornernode[4]-1][1] = 1;   
if flag[Cornernode[4]-1][2] == 0:
    file.write('%i'%(Cornernode[4]));
    file.write('\t 3 \t 0.00\r\n');
    flag[Cornernode[4]-1][2] = 1;  
'''
if flag[Cornernode[5]-1][0] == 0:
    file.write('%i'%(Cornernode[5]));
    file.write('\t 1 \t 0.00\r\n');
    flag[Cornernode[5]-1][0] = 1;  
    
if flag[Cornernode[5]-1][1] == 0:
    file.write('%i'%(Cornernode[5]));
    file.write('\t 2 \t 0.00\r\n');
    flag[Cornernode[5]-1][1] = 1;   
    
#if flag[Cornernode[5]-1][2] == 0:
#    file.write('%i'%(Cornernode[5]));
#    file.write('\t 3 \t 0.00\r\n');
#    flag[Cornernode[5]-1][2] = 1;  
'''
if flag[Cornernode[6]-1][0] == 0:
    file.write('%i'%(Cornernode[6]));
    file.write('\t 1 \t 0.00\r\n');
    flag[Cornernode[6]-1][0] = 1;    
if flag[Cornernode[6]-1][1] == 0:
    file.write('%i'%(Cornernode[6]));
    file.write('\t 2 \t 0.00\r\n');
    flag[Cornernode[6]-1][1] = 1;   
if flag[Cornernode[6]-1][2] == 0:
    file.write('%i'%(Cornernode[6]));
    file.write('\t 3 \t 0.00\r\n');
    flag[Cornernode[6]-1][2] = 1;   
'''    
    

file.write('begin multi-point constraints\r\n');
    
   
# periodic boundary condition of top and bottom multipoint constraint. Bottom is master and top is slave. 
'''
for i in range (0,nx):
    for j in range (0,ny):
        topnodeindex = i*nz*ny+1+j;
        bottomnodeindex = topnodeindex+(nz-1)*ny;
        if flag[topnodeindex-1][4] == 0:
            file.write('1');
            file.write('\t %i'%topnodeindex);
            file.write('\t 5\r\n');
            file.write('%i'%bottomnodeindex);
            file.write('\t 5 \t 1.00 \t 0.00\r\n');
            flag[topnodeindex-1][4] = 1;
            flag[bottomnodeindex-1][4] = 1;
        if flag[topnodeindex-1][5] == 0:
            file.write('1');
            file.write('\t %i'%topnodeindex);
            file.write('\t 6\r\n');
            file.write('%i'%bottomnodeindex);
            file.write('\t 6 \t 1.00 \t 0.00\r\n');
            flag[topnodeindex-1][5] = 1;
            flag[bottomnodeindex-1][5] = 1;
        if flag[topnodeindex-1][6] == 0:
            file.write('1');
            file.write('\t %i'%topnodeindex);
            file.write('\t 7\r\n');
            file.write('%i'%bottomnodeindex);
            file.write('\t 7 \t 1.00 \t 0.00\r\n');
            flag[topnodeindex-1][6] = 1;
            flag[bottomnodeindex-1][6] = 1;
        if flag[topnodeindex-1][0] == 0:
            file.write('1');
            file.write('\t %i'%topnodeindex);
            file.write('\t 1\r\n');
            file.write('%i'%bottomnodeindex);
            file.write('\t 1 \t 1.00 \t 0.00\r\n');
            flag[topnodeindex-1][0] = 1;
            flag[bottomnodeindex-1][0] = 1;
        if flag[topnodeindex-1][1] == 0:
            file.write('1');
            file.write('\t %i'%topnodeindex);
            file.write('\t 2\r\n');
            file.write('%i'%bottomnodeindex);
            file.write('\t 2 \t 1.00 \t 0.00\r\n');
            flag[topnodeindex-1][1] = 1;
            flag[bottomnodeindex-1][1] = 1;
        if flag[topnodeindex-1][2] == 0:
            file.write('1');
            file.write('\t %i'%topnodeindex);
            file.write('\t 3\r\n');
            file.write('%i'%bottomnodeindex);
            file.write('\t 3 \t 1.00 \t 0.00\r\n');
            flag[topnodeindex-1][2] = 1;
            flag[bottomnodeindex-1][2] = 1;

 '''  


# periodic boundary condition of left and right multipoint constraint. Left is master and right is slave.
for i in range (0,nx):
    for j in range (0,nz):
        rightnodeindex = i*ny*nz+1+j*ny;
        leftnodeindex = rightnodeindex+ny-1;
        if flag[rightnodeindex-1][4] == 0:
            file.write('1');
            file.write('\t %i'%rightnodeindex);
            file.write('\t 5\r\n');
            file.write('%i'%leftnodeindex);
            file.write('\t 5 \t 1.00 \t 0.00\r\n');
            flag[rightnodeindex-1][4] = 1;
            flag[leftnodeindex-1][4] = 1;
        if flag[rightnodeindex-1][5] == 0:
            file.write('1');
            file.write('\t %i'%rightnodeindex);
            file.write('\t 6\r\n');
            file.write('%i'%leftnodeindex);
            file.write('\t 6 \t 1.00 \t 0.00\r\n');
            flag[rightnodeindex-1][5] = 1;
            flag[leftnodeindex-1][5] = 1;
        if flag[rightnodeindex-1][6] == 0:
            file.write('1');
            file.write('\t %i'%rightnodeindex);
            file.write('\t 7\r\n');
            file.write('%i'%leftnodeindex);
            file.write('\t 7 \t 1.00 \t 0.00\r\n');
            flag[rightnodeindex-1][6] = 1;
            flag[leftnodeindex-1][6] = 1;
        if flag[rightnodeindex-1][0] == 0:
            file.write('1');
            file.write('\t %i'%rightnodeindex);
            file.write('\t 1\r\n');
            file.write('%i'%leftnodeindex);
            file.write('\t 1 \t 1.00 \t');
            file.write(str(disxy));
            file.write('\r\n');
            flag[rightnodeindex-1][0] = 1;
            flag[leftnodeindex-1][0] = 1;
        if flag[rightnodeindex-1][1] == 0:
            file.write('1');
            file.write('\t %i'%rightnodeindex);
            file.write('\t 2\r\n');
            file.write('%i'%leftnodeindex);
            file.write('\t 2 \t 1.00 \t');
            file.write(str(disy));
            file.write('\r\n');
            flag[rightnodeindex-1][1] = 1;
            flag[leftnodeindex-1][1] = 1;
        if flag[rightnodeindex-1][2] == 0:
            file.write('1');
            file.write('\t %i'%rightnodeindex);
            file.write('\t 3\r\n');
            file.write('%i'%leftnodeindex);
            file.write('\t 3 \t 1.00 \t 0.00\r\n');
            flag[rightnodeindex-1][2] = 1;
            flag[leftnodeindex-1][2] = 1;
        if flag[rightnodeindex-1][3] == 0:
            file.write('1');
            file.write('\t %i'%rightnodeindex);
            file.write('\t 4\r\n');
            file.write('%i'%leftnodeindex);
            file.write('\t 4 \t 1.00 \t 0.00\r\n');
            flag[rightnodeindex-1][3] = 1;
            flag[leftnodeindex-1][3] = 1;            

            

# periodic boundary condition of front and back multipoint constraint. Back is master and front is slave.
for j in range (0,nz):
    for i in range (0,ny):
        frontnodeindex = ny*j+1+i;
        backnodeindex = frontnodeindex+ny*nz*(nx-1);
        if flag[frontnodeindex-1][4] == 0:
            file.write('1');
            file.write('\t %i'%frontnodeindex);
            file.write('\t 5\r\n');
            file.write('%i'%backnodeindex);
            file.write('\t 5 \t 1.00 \t 0.00\r\n');
            flag[frontnodeindex-1][4] = 1;
            flag[backnodeindex-1][4] = 1;
        if flag[frontnodeindex-1][5] == 0:
            file.write('1');
            file.write('\t %i'%frontnodeindex);
            file.write('\t 6\r\n');
            file.write('%i'%backnodeindex);
            file.write('\t 6 \t 1.00 \t 0.00\r\n');
            flag[frontnodeindex-1][5] = 1;
            flag[backnodeindex-1][5] = 1;
        if flag[frontnodeindex-1][6] == 0:
            file.write('1');
            file.write('\t %i'%frontnodeindex);
            file.write('\t 7\r\n');
            file.write('%i'%backnodeindex);
            file.write('\t 7 \t 1.00 \t 0.00\r\n');
            flag[frontnodeindex-1][6] = 1;
            flag[backnodeindex-1][6] = 1;
        if flag[frontnodeindex-1][0] == 0:
            file.write('1');
            file.write('\t %i'%frontnodeindex);
            file.write('\t 1\r\n');
            file.write('%i'%backnodeindex);
            file.write('\t 1 \t 1.00 \t');
            file.write(str(disx));
            file.write('\r\n');
            flag[frontnodeindex-1][0] = 1;
            flag[backnodeindex-1][0] = 1;
        if flag[frontnodeindex-1][1] == 0:
            file.write('1');
            file.write('\t %i'%frontnodeindex);
            file.write('\t 2\r\n');
            file.write('%i'%backnodeindex);
            file.write('\t 2 \t 1.00 \t');
            file.write(str(disxy));
            file.write('\r\n');
            flag[frontnodeindex-1][1] = 1;
            flag[backnodeindex-1][1] = 1;
        if flag[frontnodeindex-1][2] == 0:
            file.write('1');
            file.write('\t %i'%frontnodeindex);
            file.write('\t 3\r\n');
            file.write('%i'%backnodeindex);
            file.write('\t 3 \t 1.00 \t 0.00\r\n');
            flag[frontnodeindex-1][2] = 1;
            flag[backnodeindex-1][2] = 1;
        if flag[frontnodeindex-1][3] == 0:
            file.write('1');
            file.write('\t %i'%frontnodeindex);
            file.write('\t 4\r\n');
            file.write('%i'%backnodeindex);
            file.write('\t 4 \t 1.00 \t 0.00\r\n');
            flag[frontnodeindex-1][3] = 1;
            flag[backnodeindex-1][3] = 1;
   
     
            
file.close
