%% Target
% a series of points in 3D to present the heart.
% First you need to align the heart samples points (many series)
% Then you need to apply PCA
% Later change the parameter (i.e. the value of y) to record the meaning of the
% beginning three components. (with relative biggest lambda 1,2,3)
% Finally as for one series, record use different number of components
% (i.e. the numbers of y) to reconstruct the heart and what's the shape?

%% Align the 3d data

% read all the files first
file_path =  './LV_data/'; 
file_mask =  '*.txt';

file_path_list = dir(strcat(file_path, file_mask)); 
file_num = length(file_path_list);  
file_list = cell(file_num, 1);
if file_num > 0 
    for j = 1:file_num 
        file_name = file_path_list(j).name;
        file_list{j} = [file_path, file_name];
    end
end

if file_num > 0
    align_vertices = load(file_list{1});
    [m, n] = size(align_vertices);
    align_samples = zeros(m*n,file_num);
    align_infos = cell(1,file_num);
    for j = 1:file_num 
        
        info = ['Now Filenum ', num2str(j), ' from ' ,file_list{j}];
        disp(info);
        
        be_align_vertices = load(file_list{j});
        % align the 3D data to the first file
        [be_align_vertices,tform] = ASM_align_data3D(be_align_vertices, align_vertices);
%         Show(be_align_vertices);
        align_samples(:,j) = reshape(be_align_vertices, [m*n, 1]);
        align_infos{1,j} = tform;
    end
end

%% Apply PCA to these series
% align_samples is a M*N matrix with M is the parameters of one samples and
% N is the size number of all the samples

% PCA with definition
% the column of Evectors is the correspondent eigen vector so we don't need
% to use Evectors' when we rebuild
% [Evalues, Evectors, x_mean] = defPCA(align_samples);

% PCA with SVD
[Evalues, Evectors, x_mean] = svdPCA(align_samples);

%% change the parameter (i.e. the value of y) to record the meaning of the
% beginning three components. (with relative biggest lambda 1,2,3)
% use show please.

% Notice use defPCA with bigger components in the back of the evalues
% But just the opposite in svdPCA function
% Only use one single components with top 3 values to rebuild
% and notice they are the same!!!!
for i = 1:3
%     notive not Evectors' for the eigen vectors are stored in the form of
%     columns not rows!!
%     use different scale with 0.5/1/1.5 to find the mean of each
%     components
    for j = 1:3
        Evalues_single = zeros(size(Evalues));
        Evalues_single(i,1) = Evalues_single(i,1) + 0.5*j*Evalues(i,1);
        vertices_rebuild = Evectors * Evalues_single + x_mean;
        vertices_rebuild = reshape(vertices_rebuild, [m,n]);
        disp(['Component ', num2str(i), ' with scale of ', num2str(0.5*j), '. Continue with any key input']);
        Show(vertices_rebuild);
    end
end

%% Using different scales of components to rebuild file 1

Y = Evectors'*(align_samples(:,1) - x_mean);
disp('Now Source Mesh. Continue with any key input');
Show(reshape(align_samples(:,1), [m,n]));
rebuild_scale = [1, 5, 10, 20, 40, 80, 140];
for i = 1:size(rebuild_scale,2)
    Evalues_rebuild = zeros(size(Y));
    Evalues_rebuild(1:rebuild_scale(i),1) = Evalues_rebuild(1:rebuild_scale(i),1) + Y(1:rebuild_scale(i),1);
    vertices_rebuild = Evectors * Evalues_rebuild + x_mean;
    vertices_rebuild = reshape(vertices_rebuild, [m,n]);
    disp(['Rebuild with ', num2str(rebuild_scale(i)), ' Components. Continue with any key input']);
    Show(vertices_rebuild);
end