% This DEMO calculates a Voronoi diagram with arbitrary points in arbitrary
% polytope in 2D/3D
clear all;close all;clc
%% generate random samples
n = 200;        % number of points
m = 20;         % number of boundary point-candidates
d = 3;          % dimension of the space
pos0 = rand(n,d);       % generate random points
bnd0 = rand(m,d);       % generate boundary point-candidates
K = convhull(bnd0);
bnd_pnts = bnd0(K,:);   % take boundary points from vertices of convex polytope formed with the boundary point-candidates
%% take points that are in the boundary convex polytope
in = inhull(pos0,bnd0); 
% inhull.m is written by John D'Errico that efficiently check if points are
% inside a convex hull in n dimensions
% We use the function to choose points that are inside the defined boundary
u1 = 0;
for i = 1:size(pos0,1)
    if in(i) ==1
        u1 = u1 + 1;
        pos(u1,:) = pos0(i,:);
    end
end
%% 
% =========================================================================
% INPUTS:
% pos       points that are in the boundary      n x d matrix (n: number of points d: dimension) 
% bnd_pnts  points that defines the boundary     m x d matrix (m: number of vertices for the convex polytope
% boundary d: dimension)
% -------------------------------------------------------------------------
% OUTPUTS:
% vornb     Voronoi neighbors for each generator point:     n x 1 cells
% vorvx     Voronoi vertices for each generator point:      n x 1 cells
% =========================================================================

[vornb,vorvx] = poly_bnd_voronoi(pos,bnd_pnts);

%% PLOT

for i = 1:size(vorvx,2)
    col(i,:)= rand(1,3);
end

switch d
    case 2
        figure,
        for i = 1:size(pos,1)
        plot(vorvx{i}(:,1),vorvx{i}(:,2),'-r')
        hold on;
        end
        plot(bnd_pnts(:,1),bnd_pnts(:,2),'-');
        hold on;
        plot(pos(:,1),pos(:,2),'go');
        axis('equal')
        axis([0 1 0 1]);
        set(gca,'xtick',[0 1]);
        set(gca,'ytick',[0 1]);        
    case 3
        figure,
        for i = 1:size(pos,1)
        K = convhulln(vorvx{i});
        trisurf(K,vorvx{i}(:,1),vorvx{i}(:,2),vorvx{i}(:,3),'FaceColor',col(i,:),'FaceAlpha',1,'EdgeAlpha',1)
        hold on;
        end
        plot3(bnd_pnts(:,1),bnd_pnts(:,2),bnd_pnts(:,3),'*-');
        hold on;
        plot3(pos(:,1),pos(:,2),pos(:,3),'go');
        axis('equal')
        axis([0 1 0 1 0 1]);
        set(gca,'xtick',[0 1]);
        set(gca,'ytick',[0 1]);
        set(gca,'ztick',[0 1]);
        
end
