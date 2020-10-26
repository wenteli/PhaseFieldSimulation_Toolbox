#!/usr/bin/env python
# coding: utf-8

# In[1]:
#Instead of plane capacitor charge control model, this code can generate more realistic electrode model on top surface.

import numpy as np
file = open("/home/wente/Desktop/parallel-3D-stuff/dbcs.txt",'w')





# how many nodes along x, y and z 
nx = 60;
ny = 20;
nz = 8;
length = 0.1;
epsilonxx = +0.4;
epsilonyy = +0.4;
epsilonxy = 0.0;
disx = epsilonxx*(nx-1)*length;
disy = epsilonyy*(ny-1)*length;
disxy = epsilonxy*(ny-1)*length;
flag = np.zeros([nx*ny*nz,8],int);


# In[2]:


Cornernode = [1, ny, 1+ny*(nz-1), 1+ny*(nz-1)+ny-1, 1+ny*nz*(nx-1), 1+ny*nz*(nx-1)+ny-1, 1+ny*(nz-1)+ny*nz*(nx-1), 1+ny*(nz-1)+ny*nz*(nx-1)+ny-1];



# Electrode generator begin
Electrode_num = 80;
Electrode_1 = [];
Electrode_2 = [];
for i in range(0,ny):
    for j in range(0,int(Electrode_num/ny)):
        Electrode_1.append(i+Cornernode[0]+ny*nz*j);
        Electrode_2.append(i+Cornernode[4]-ny*nz*j);
# Electrode generator end




# In[3]:


if flag[Cornernode[5]-1][0] == 0:
    file.write('%i'%(Cornernode[5]));
    file.write('\t 1 \t 0.00\r\n');
    flag[Cornernode[5]-1][0] = 1;  
    
if flag[Cornernode[5]-1][1] == 0:
    file.write('%i'%(Cornernode[5]));
    file.write('\t 2 \t 0.00\r\n');
    flag[Cornernode[5]-1][1] = 1;   
    
if flag[Cornernode[2]-1][2] == 0:
    file.write('%i'%(Cornernode[2]));
    file.write('\t 3 \t 0.00\r\n');
    flag[Cornernode[2]-1][2] = 1;   
    
if flag[Cornernode[7]-1][2] == 0:
    file.write('%i'%(Cornernode[7]));
    file.write('\t 3 \t 0.00\r\n');
    flag[Cornernode[7]-1][2] = 1;   


# In[4]:


for i in range (0,Electrode_num):
    if flag[Electrode_1[i]-1][3] == 0:
        file.write('%i'%(Electrode_1[i]));
        file.write('\t 4 \t 0.00\r\n');
        flag[Electrode_1[i]-1][3] = 1;



# In[5]:


# temperature fixed for all nodes
for i in range (0,nx*ny*nz):
    file.write('%i'%(i+1));
    file.write('\t 8 \t 0.85 \r\n');
    flag[i][7] = 1;


# In[6]:


file.write('begin multi-point constraints\r\n');


# In[7]:


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


# In[8]:

center_node = int(Cornernode[4]-ny*nz*Electrode_num*0.5/ny+ny/2);
flag[center_node-1][3] = 1;
for i in range (0,Electrode_num):
    if flag[Electrode_2[i]-1][3] == 0:
        file.write('1');
        file.write('\t %i'%Electrode_2[i]);
        file.write('\t 4\r\n');
        file.write('%i'%(center_node));
        file.write('\t 4 \t 1.00 \t 0.00\r\n');
        flag[Electrode_2[i]-1][3] = 1;

# In[9]:


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
#        if flag[frontnodeindex-1][3] == 0:
#            file.write('1');
#            file.write('\t %i'%frontnodeindex);
#            file.write('\t 4\r\n');
#            file.write('%i'%backnodeindex);
#            file.write('\t 4 \t 1.00 \t 0.00\r\n');
#            flag[frontnodeindex-1][3] = 1;
#            flag[backnodeindex-1][3] = 1;

'''
center_node = 226;
flag[center_node-1][3] = 1;
for j in range (0,nz):
    for i in range (0,ny):
        frontnodeindex = ny*j+1+i;
        if flag[frontnodeindex-1][3] == 0:
            file.write('1');
            file.write('\t %i'%frontnodeindex);
            file.write('\t 4\r\n');
            file.write('%i'%(center_node));
            file.write('\t 4 \t 1.00 \t 0.00\r\n');
            flag[rightnodeindex-1][3] = 1;
'''

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
        if flag[topnodeindex-1][3] == 0:
            file.write('1');
            file.write('\t %i'%topnodeindex);
            file.write('\t 4\r\n');
            file.write('%i'%bottomnodeindex);
            file.write('\t 4 \t 1.00 \t 0.00\r\n');
            flag[topnodeindex-1][3] = 1;
            flag[bottomnodeindex-1][3] = 1;
'''


# In[10]:


file.close


# In[ ]:





# In[ ]:




