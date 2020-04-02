#!/usr/bin/env python
# coding: utf-8

# In[ ]:


file = open("/home/wente/Desktop/parallel-3D-stuff/nodes.txt",'w')


# In[ ]:


nx = 40;
ny = 40;
nz = 14;
h = 0.25;
file.write('   %i\r\n'%(nx*ny*nz));


# In[ ]:


for i in range (0,nx):
    for k in range (0,nz):
        for j in range (0,ny):
            file.write('%i\t'%(1+j+k*ny+i*(ny*nz)));
            file.write('%f\t'%((nx-i-1)*h));
            file.write('%f\t'%((ny-j-1)*h));
            file.write('%f\r\n'%((nz-k-1)*h));


# In[ ]:


file.close

