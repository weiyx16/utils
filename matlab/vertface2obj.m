function vertface2obj(fv,file_name)
% name is the filename to save the obj file.

%% The standard form
% v 0.939212 2.111016 1.027426 0.043661 0.059910 0.040452 loc+rgb
% vn -0.759511 -0.180611 0.624918
% after all is the f(face) 

%% a fv in bodynet
% vertices: [17398×3 double]
% faces: [34792×3 double]
% FaceColor: 'interp'
% LineStyle: 'none'
% FaceLighting: 'gouraud'
% DiffuseStrength: 0.5000
% FaceVertexCData: [17398×3 uint8]

name = strcat(file_name, '_plain.obj');
fid = fopen(name,'w');

[n,~] = size(fv.vertices);
for i=1:n %14772
    fprintf(fid,'v %f %f %f\n',fv.vertices(i,1),fv.vertices(i,2),fv.vertices(i,3));
end

fprintf(fid,'g foo\n');

[m,~] = size(fv.faces);
for i=1:m %29536
    fprintf(fid,'f %d %d %d\n',fv.faces(i,1),fv.faces(i,2),fv.faces(i,3));
end

fprintf(fid,'g\n');

fclose(fid);
