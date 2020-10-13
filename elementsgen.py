#!/usr/bin/env python
# coding: utf-8

# In[1]:


file = open("/home/wente/Desktop/parallel-3D-stuff/elements.txt",'w')


# In[2]:


nx = 60;
ny = 20;
nz = 8;


file.write('   %i\r\n'%((nx-1)*(ny-1)*(nz-1)));


# In[ ]:


for i in range (0,nx-1):
    for k in range (0,nz-1):
        for j in range (0,ny-1):
            file.write('   %i   '%(1+j+k*(ny-1)+i*((ny-1)*(nz-1))));
            startnode = ny*nz*(i+1)+k*ny+j+1;
            file.write('%i   %i   %i   %i   ' %(startnode, (startnode+1), (startnode+ny+1), (startnode+ny)));
            file.write('%i   %i   %i   %i\r\n' %((startnode-ny*nz), (startnode-ny*nz+1), (startnode-ny*nz+ny+1), (startnode-ny*nz+ny)));


# In[ ]:


file.close

