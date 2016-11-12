%%% animation code 
%%% input p: cell array of position set
%%% stage x 1
%%% example: p{1} = [0.1 0.2;0.3 0.4;0.5 0.5]; read as at stage 1, agent 1
%%% is at (0.1, 0.2), agent 2 is at (0.3 0.4), and agent 3 is at (0.5 0.5)
%%% resolution - how many steps between each move e.g. 30
%%% adv_idx - the heterogeneous agents' index. e.g. given p{1} above, if
%%% agent 1, and 3 is the hetero-agents, adv_idx is a row vector [1 3]
% clear all;close all;clc
function M = animation_func9vor0_fin2(p,resolution,n,f,bnd_pnts,k_p,adv)
% load('psav_test1.mat');
% resolution = 120;
% n = size(p_sav{1},1);
% p = p_sav';
% k_p = 5;
th{1}{1}=2*pi*rand(size(p{1},1),1);
% f=0;
% pos_init = [23.5425   25.9122];
% pos_init2 = repmat(pos_init,size(p{1},1),1);
% color_code = jet(100);
% adv_idx = 1;
N = size(p,1);
% N = 5;
% N = 5;
adv_idx = n-f+1:n;
% n_adv = f;
vmax = -0.03;
n_adv = size(adv_idx,2);
n_cop = size(p{1},1) - n_adv;
cop_idx= setdiff(1:size(p{1},1),adv_idx);
for u1 = 1:N
    pos_int{u1} = mean(p{u1}(cop_idx,:),1);
end
delta_p = cell(N,1);
p_appended = cell(N,1);

for i = 1:N-1
    i
%    delta_p{i} = p{i+1} - p{i};
   if i >= 2
       th{i}{1} = th{i-1}{resolution};
   end
   for j = 1:resolution
     if j >= 2
         delta_p1{i}{j} = p_appended{i}{j-1} - p{i+1};
         v{i}{j} = -k_p* dota([cos(th{i}{j-1}) sin(th{i}{j-1})],delta_p1{i}{j});
         w{i}{j} = 2*k_p * arcta(th{i}{j-1},delta_p1{i}{j});
         p_appended{i}{j} = p_appended{i}{j-1} + [v{i}{j} .* cos(th{i}{j-1}) v{i}{j} .*sin(th{i}{j-1})] / resolution;
         th{i}{j} = th{i}{j-1} + 1/resolution * w{i}{j};
     else
         p_appended{i}{j} = p{i};
     end
%      p_appended{i}{j} = p{i} + delta_p{i} /resolution * j;
     [~,voronoi_rg{i}{j}] = polybnd_voronoi(p_appended{i}{j},bnd_pnts);
%      voronoi_rg{i}{j}
   end
end

h = figure('position',[50 50 600 600],'Color',[1 1 1]);
k = 0; k2 = 0;
for i = 1:N-1
    for j = 1:resolution
        for m1 = 1:size(p_appended{i}{j},1)
            color_code = jet(size(p_appended{i}{j},1));
            if ~ismember(m1,adv)
            plot(p_appended{i}{j}(m1,1),p_appended{i}{j}(m1,2),...,
                'MarkerSize',6,'Marker','o',...,
                'Color',[0 0 1],...,
                'MarkerFaceColor','b','LineWidth',1,'LineStyle','none');
            else
            plot(p_appended{i}{j}(m1,1),p_appended{i}{j}(m1,2),...,
                'MarkerSize',6,'Marker','o',...,
                'Color',[0 0 1],...,
                'MarkerFaceColor','r','LineWidth',1,'LineStyle','none');                
            end
            hold on; 
            if j >= 2
            line([p_appended{i}{j}(m1,1) p_appended{i}{j}(m1,1)+vmax* cos(th{i}{j-1}(m1))],...,
                [p_appended{i}{j}(m1,2) p_appended{i}{j}(m1,2)+vmax* sin(th{i}{j-1}(m1))]);
%            [p_appended{i}{j}(m1,1) p_appended{i}{j}(m1,1)+vmax*cos(th{i}{j}(m1))]
%            
%            [p_appended{i}{j}(m1,2) p_appended{i}{j}(m1,2)+vmax*sin(th{i}{j}(m1))]
            hold on;
            elseif j == 1 && i >=2
             line([p_appended{i}{j}(m1,1) p_appended{i}{j}(m1,1)+vmax* cos(th{i-1}{resolution}(m1))],...,
                [p_appended{i}{j}(m1,2) p_appended{i}{j}(m1,2)+vmax* sin(th{i-1}{resolution}(m1))]);               
            end
        end
        for i1 = 1:size(voronoi_rg{i}{j},2)
%             for j1 = 1:size(voronoi_rg{i}{j},2)
                if ~isempty(voronoi_rg{i}{j}{i1})
                    if ismember(i1,adv)
                        patch(voronoi_rg{i}{j}{i1}(:,1),voronoi_rg{i}{j}{i1}(:,2),[0.5 0.5 0.5],'FaceAlpha',0.3);
                        hold on;
                    end                    
                    plot(voronoi_rg{i}{j}{i1}(:,1),voronoi_rg{i}{j}{i1}(:,2),'-','Color','b');
                    hold on;
                end
%             end
        end
        k2 = k2 + 1;
        k3 = k2 * n_adv - (n_adv-1);
        k4 = k2 * n_cop - (n_cop-1);
        histo(k3:k3 + n_adv - 1,:) = p_appended{i}{j}(adv_idx,:);
        histo2(k4:k4 + n_cop - 1,:) = p_appended{i}{j}(cop_idx,:);
        hold off;
        axis([-0.05 50.05 -0.05 50.05]/50);
        axis('off');
        k = k + 1;
        set(gca,'xtick',[]);
        set(gca,'ytick',[]);
        xlabel([]);
        ylabel([]);
        M(k) = getframe(h);
    end
end
h2 = figure('position',[100 100 600 600],'Color',[1 1 1]);
axis('square')
axis([0 1 0 1 0 1])
axis('off')
set(gca,'xtick',[]);
set(gca,'ytick',[]);
movie(h2,M,1,30);