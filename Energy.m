clear
clc



%%%%%%%%%%%%%%%%%%%Try to switch back to nomralized value%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




a1 = -2.062e+7;
a11 = -2.097e+8;
a12 = 7.974e+8;
a111 = 1.294e+9;
a112 = -1.95e+9;
a123 = -2.5009e+9;
a1111 = 3.863e+10;
a1112 = 2.529e+10;
a1122 = 1.637e+10;
a1123 = 1.367e+10;

Q11 = 0.1;
Q12 = -0.034;
Q44 = 0.029;
C11 = 1.78e+11;
C12 = 0.964e+11;
C44 = 1.22e+11;

k0 = 8.854e-12;

P0 = 0.18;
elec0 = 3.21e+5;
strain = 3.28e-3;

G0 = 51.0e-11;
mesh = 1;
l0 = 0.35*sqrt(G0*P0/elec0);

%%%% we choose the path start from grid ID 10 and go along x direciton. %%%% 
nx=20;
ny=20;
nz=4;


data = readtable('sol20.csv', 'HeaderLines',1);
data = table2array(data);
len = length(data);


exx = data(:,16);   %exx
exy = data(:,17);   %exy
exz = data(:,18);   %exz
eyx = data(:,19);   %eyx
eyy = data(:,20);   %eyy
eyz = data(:,21);   %eyz
ezx = data(:,22);   %ezx
ezy = data(:,23);   %ezy
ezz = data(:,24);   %ezz

px = data(:,1);   %Px
py = data(:,2);   %Py
pz = data(:,3);   %Pz


delecx = data(:,12);   %Dx
delecy = data(:,13);   %Dy
delecz = data(:,14);   %Dz

exx0 = 10*Q11*px.^2+10*Q12*(py.^2+pz.^2);
eyy0 = 10*Q11*py.^2+10*Q12*(px.^2+pz.^2);
ezz0 = 10*Q11*pz.^2+10*Q12*(py.^2+px.^2);
exy0 = 5*Q44*px.*py;
eyx0 = exy0;
exz0 = 5*Q44*px.*pz;
ezx0 = exz0;
eyz0 = 5*Q44*py.*pz;
ezy0 = eyz0;

%%%%%%%%   gradient P start  %%%%%%%%%%%%%%%%%
ppx = zeros(nx,ny,nz);
ppy = zeros(nx,ny,nz);
ppz = zeros(nx,ny,nz);

for i=1:nx
    for j=1:ny
        for k=1:nz
            ppx(i,j,k) = px((nx-i)*ny*nz+(ny-j)+(nz-k)*ny+1);
            ppy(i,j,k) = py((nx-i)*ny*nz+(ny-j)+(nz-k)*ny+1);
            ppz(i,j,k) = pz((nx-i)*ny*nz+(ny-j)+(nz-k)*ny+1);
        end
    end
end

gppxx = zeros(nx,ny,nz);
gppyy = zeros(nx,ny,nz);
gppzz = zeros(nx,ny,nz);
gppxy = zeros(nx,ny,nz);
gppyx = zeros(nx,ny,nz);
gppxz = zeros(nx,ny,nz);
gppzx = zeros(nx,ny,nz);
gppyz = zeros(nx,ny,nz);
gppzy = zeros(nx,ny,nz);

gpxx = zeros(len,1);
gpyy = zeros(len,1);
gpzz = zeros(len,1);
gpxy = zeros(len,1);
gpyx = zeros(len,1);
gpxz = zeros(len,1);
gpzx = zeros(len,1);
gpyz = zeros(len,1);
gpzy = zeros(len,1);


for i=1:nx
    for j=1:ny
        for k=1:nz


            if i==1
               gppxx(i,j,k) = (ppx(i+1,j,k)-ppx(nx,j,k))*0.5/mesh;
            elseif i==nx
               gppxx(i,j,k) = (ppx(1,j,k)-ppx(i-1,j,k))*0.5/mesh;
            else
               gppxx(i,j,k) = (ppx(i+1,j,k)-ppx(i-1,j,k))*0.5/mesh;
            end
            if j==1
               gppyy(i,j,k) = (ppy(i,j+1,k)-ppy(i,ny,k))*0.5/mesh;
            elseif j==ny
               gppyy(i,j,k) = (ppy(i,1,k)-ppy(i,j-1,k))*0.5/mesh;
            else
               gppyy(i,j,k) = (ppy(i,j+1,k)-ppy(i,j-1,k))*0.5/mesh;
            end
            if k==1
               gppzz(i,j,k) = (ppz(i,j,k+1)-ppz(i,j,nz))*0.5/mesh;
            elseif k==nz
               gppzz(i,j,k) = (ppz(i,j,1)-ppz(i,j,k-1))*0.5/mesh;
            else
               gppzz(i,j,k) = (ppz(i,j,k+1)-ppz(i,j,k-1))*0.5/mesh;
            end
            if j==1
               gppxy(i,j,k) = (ppx(i,j+1,k)-ppx(i,ny,k))*0.5/mesh;
            elseif j==ny
               gppxy(i,j,k) = (ppx(i,1,k)-ppx(i,j-1,k))*0.5/mesh;
            else
               gppxy(i,j,k) = (ppx(i,j+1,k)-ppx(i,j-1,k))*0.5/mesh;
            end
            if i==1
               gppyx(i,j,k) = (ppy(i+1,j,k)-ppy(nx,j,k))*0.5/mesh;
            elseif i==nx
               gppyx(i,j,k) = (ppy(1,j,k)-ppy(i-1,j,k))*0.5/mesh;
            else
               gppyx(i,j,k) = (ppy(i+1,j,k)-ppy(i-1,j,k))*0.5/mesh;
            end
            if k==1
               gppxz(i,j,k) = (ppx(i,j,k+1)-ppx(i,j,nz))*0.5/mesh;
            elseif k==nz
               gppxz(i,j,k) = (ppx(i,j,1)-ppx(i,j,k-1))*0.5/mesh;
            else
               gppxz(i,j,k) = (ppx(i,j,k+1)-ppx(i,j,k-1))*0.5/mesh;
            end
            if i==1
               gppzx(i,j,k) = (ppz(i+1,j,k)-ppz(nx,j,k))*0.5/mesh;
            elseif i==nx
               gppzx(i,j,k) = (ppz(1,j,k)-ppz(i-1,j,k))*0.5/mesh;
            else
               gppzx(i,j,k) = (ppz(i+1,j,k)-ppz(i-1,j,k))*0.5/mesh;
            end
            if k==1
               gppyz(i,j,k) = (ppy(i,j,k+1)-ppy(i,j,nz))*0.5/mesh;
            elseif k==nz
               gppyz(i,j,k) = (ppy(i,j,1)-ppy(i,j,k-1))*0.5/mesh;
            else
               gppyz(i,j,k) = (ppy(i,j,k+1)-ppy(i,j,k-1))*0.5/mesh;
            end
            if j==1
               gppzy(i,j,k) = (ppz(i,j+1,k)-ppz(i,ny,k))*0.5/mesh;
            elseif j==ny
               gppzy(i,j,k) = (ppz(i,1,k)-ppz(i,j-1,k))*0.5/mesh;
            else
               gppzy(i,j,k) = (ppz(i,j+1,k)-ppz(i,j-1,k))*0.5/mesh;
            end


        end
    end
end

for i=1:nx
    for j=1:ny
        for k=1:nz
            gpxx((nx-i)*ny*nz+(ny-j)+(nz-k)*ny+1) = gppxx(i,j,k);
            gpyy((nx-i)*ny*nz+(ny-j)+(nz-k)*ny+1) = gppyy(i,j,k);
            gpzz((nx-i)*ny*nz+(ny-j)+(nz-k)*ny+1) = gppzz(i,j,k);
            gpxy((nx-i)*ny*nz+(ny-j)+(nz-k)*ny+1) = gppxy(i,j,k);
            gpyx((nx-i)*ny*nz+(ny-j)+(nz-k)*ny+1) = gppyx(i,j,k);
            gpxz((nx-i)*ny*nz+(ny-j)+(nz-k)*ny+1) = gppxz(i,j,k);
            gpzx((nx-i)*ny*nz+(ny-j)+(nz-k)*ny+1) = gppxz(i,j,k);
            gpyz((nx-i)*ny*nz+(ny-j)+(nz-k)*ny+1) = gppyz(i,j,k);
            gpzy((nx-i)*ny*nz+(ny-j)+(nz-k)*ny+1) = gppzy(i,j,k); 
        end
    end
end
%%%%%%%%   gradient P end  %%%%%%%%%%%%%%%%%%%




%%%%%%%%   total energy start  %%%%%%%%%%%%%%%%%%%
helec = ((delecx-px).^2+(delecy-py).^2+(delecz-pz).^2)/(2*k0);
helec = helec*P0^2;

helas = 0.5*C11*((exx-exx0).^2+(eyy-eyy0).^2+(ezz-ezz0).^2)+C12*((exx-exx0).*(eyy-eyy0)+(exx-exx0).*(ezz-ezz0)+(ezz-ezz0).*(eyy-eyy0))+0.5*C44*((exy-exy0).^2+(eyx-eyx0).^2+2*(exy-exy0).*(eyx-eyx0)+(exz-exz0).^2+(ezx-ezx0).^2+2*(exz-exz0).*(ezx-ezx0)+(ezy-ezy0).^2+(eyz-eyz0).^2+2*(ezy-ezy0).*(eyz-eyz0));
helas = helas*strain^2;

hbulk2 = a1*(px.^2+py.^2+pz.^2);
hbulk2= hbulk2*P0^2;

hbulk4 = a11*(px.^4+py.^4+pz.^4)+a12*((px.^2).*(py.^2)+(px.^2).*(pz.^2)+(pz.^2).*(py.^2));
hbulk4 = hbulk4*P0^4;
 
hbulk6 = a111*(px.^6+py.^6+pz.^6)+a112*((px.^2).*(py.^4+pz.^4)+(py.^2).*(px.^4+pz.^4)+(pz.^2).*(py.^4+px.^4))+a123*(px.*py.*pz).^2;
hbulk6 = hbulk6*P0^6;
 
hbulk8 = a1111*(px.^8+py.^8+pz.^8)+a1112*((px.^6).*(py.^2+pz.^2)+(py.^6).*(px.^2+pz.^2)+(pz.^6).*(py.^2+px.^2))+a1122*((px.^4).*(py.^4)+(px.^4).*(pz.^4)+(pz.^4).*(py.^4))+a1123*((px.^4).*(py.^2).*(pz.^2)+(px.^2).*(py.^4).*(pz.^2)+(px.^2).*(py.^2).*(pz.^4));
hbulk8 = hbulk8*P0^8;

hwall = 0.5*G0*(gpxx.^2+gpyy.^2+gpzz.^2+gpxy.^2+gpyx.^2+gpxz.^2+gpzx.^2+gpyz.^2+gpzy.^2);
hwall = hwall*P0^2/l0^2;
%%%%%%%%   total energy end  %%%%%%%%%%%%%%%%%%%%%

h = helec+helas+hbulk2+hbulk4+hbulk6+hbulk8+hwall;
energy = sum(h)
