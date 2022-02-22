clear 
clc

[x, y, z] = ellipsoid(0,0,0,30,30,30);
s=surf(x,y,z);
p=surf2patch(s);

%Extract faces and vertices from structure p
pf=p.faces;
pv=p.vertices;
tr=triangulation(pf,pv);
[F,P] = freeBoundary(tr);
trNew = triangulation(F,P);
stlwrite(trNew, "ellipsoid10.stl");