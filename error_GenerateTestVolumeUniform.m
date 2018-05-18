
%% load data
clear
imposed = load('imposed_disp_series.mat');
% measured = load('results_qDVC_ss16_inc.mat');
measured = load('resultsFIDVC.mat');

a = 25;
dm = 8;
%% map imposed and measured data onto same mesh

% grid = permute(measured.m,[213]);
[gridPoints_m{1},gridPoints_m{2},gridPoints_m{3}] = meshgrid(measured.m{1},...
    measured.m{2},measured.m{3});
[gridPoints{1},gridPoints{2},gridPoints{3}] = ndgrid(measured.m{1},...
    measured.m{2},measured.m{3});

for ii= 1:length(measured.u)
   
    for jj = 1:3
        imposed.u_grid{ii}{jj} = griddata(imposed.x0{1}(:,1),imposed.x0{1}(:,2), ...
            imposed.x0{1}(:,3),-imposed.u{ii}(:,jj),...
            gridPoints_m{1},gridPoints_m{2},gridPoints_m{3});
        
        nan_mask{ii}{jj} = measured.u{ii}{jj}./measured.u{ii}{jj};
%         nan_mask{ii}{jj}(round(size(measured.u{ii}{jj},1)/2-a/dm):round(size(measured.u{ii}{jj},1)/2+a/dm),...
%             round(size(measured.u{ii}{jj},2)/2-a/dm):round(size(measured.u{ii}{jj},2)/2+a/dm),...
%             round(size(measured.u{ii}{jj},3)/2-a/dm):round(size(measured.u{ii}{jj},3)/2+a/dm)) = nan;
        
    end
    
    imposed.u_grid{ii}{4} = sqrt(imposed.u_grid{ii}{1}.^2 + ...
        imposed.u_grid{ii}{2}.^2 + imposed.u_grid{ii}{3}.^2);
    
end

% imposed.u_grid = inc2cum(imposed.u_grid,measured.dm,gridPoints,'spline');
measured.u_c = inc2cum(measured.u,measured.dm,gridPoints,'spline');
1
%% plotting

comp = 2;
img = 1;

fig
% subplot(1,2,1)
imagesc3d(nan_mask{img}{comp}.*imposed.u_grid{img}{comp})
% subplot(1,2,2)
fig
imagesc3d(nan_mask{img}{comp}.*measured.u_c{img}{comp})

fig
imagesc3d(2*nan_mask{img}{comp}.*measured.u_c{img}{comp} - nan_mask{img}{comp}.*imposed.u_grid{img}{comp})

2

