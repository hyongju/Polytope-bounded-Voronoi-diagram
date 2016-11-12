%% lloyd's algorithm
% function [p_sav,cst3] = main_lloyd_func2(pos,adv,stage,bnd_pnts,p2,type)

clear all;close all;clc

% n = size(pos,1);
% d = size(pos,2);
% clear all;close all;clc
n = 10;
% % m = 15;
d = 2;
eta = 1/2;
p1_0 = haltonset(d,'Skip',1e3,'Leap',1e2);
p1_1 = scramble(p1_0,'RR2');
pos = 1/4 *(net(p1_1,n) -0.5 * ones(n,d)) + 0.5 * ones(n,d);
figure,plot(pos(:,1),pos(:,2),'x');axis([0 1 0 1]);
% pos = rand(n,d);
% pos = [0.15 1-0.15;1-0.15 1-0.15;0.5 0.5;0.15 0.15;1-0.15 0.15];
% vmax = 0.1;
stage = 30;
m = 50;
p2_0 = net(p1_1,m);
bnd_idx = convhull(p2_0);
bnd_pnts = p2_0(bnd_idx,:);
% bnd_pnts = [0 1;1 1;1 0;0 0];

%% new codes: normal distribution multi-variate (uni-modal)
% mean = [0.75 0.75], covariance = 0.1*eye(2)



mu = [0.75 0.75]; 
SIGMA = 0.05*eye(2);
X_test = mvnrnd(mu,SIGMA,10000); 
p_test = mvnpdf(X_test,mu,SIGMA); 
k = 0;

[A_bnd,b_bnd] = vert2lcon(bnd_pnts);     
in_y = inhull(X_test,bnd_pnts,[],1e-15);

X_int = X_test(in_y,:);
p_int_unnorm = p_test(in_y,:);

% for i = 1:size(X_test,1)
%     if X_test(i,1) >=0 && X_test(i,2) <= 1 && X_test(i,1) <=1 && X_test(i,2) >= 0
%         k = k+1;
%         X_int(k,:) = X_test(i,:);
%         p_int_unnorm(k) = p_test(i);
%     end
% end
p_int = p_int_unnorm / sum(p_int_unnorm);
h_00 = figure('position',[100 100 600 600],'Color',[1 1 1]);
plot3(X_int(:,1),X_int(:,2),p_int(:),'Marker','.','MarkerSize',1,'LineStyle','none');
hold on;
bdp = convhull(bnd_pnts);
plot(bnd_pnts(bdp,1),bnd_pnts(bdp,2),'b-');
hold on;
plot(mu(1),mu(2),'Marker','o','MarkerSize',10,'Color','r','LineWidth',2);
axis('square')
axis([0 1 0 1 0 0.0003])
% axis('off')
set(gca,'xtick',[0 1]);
set(gca,'ytick',[0 1]);

% grid on;
% axis('equal');
xlabel('X');ylabel('Y');zlabel('Target distribution');
view(0,90)

%%
% n1 = 10000;
% p2  = net(p1_1,n1);
p_sav{1} = pos;
% n1 = size(p2,1);
% adv = [1 2 3 4 5];
adv = [1];
% adv = [];
type = 3;
coef = 100;

p2 = X_int;
n1 = size(X_int,1);
%% call function
for t = 1:stage
    t
    [~,vorvx{t},~,~] = polybnd_voronoi(pos,bnd_pnts);
    sum3{t} = lloyd_cvt_fin_exp(vorvx{t},bnd_pnts,p2,pos,n1,adv,p_int);
    [cst3(t),indx{t}]= lloyd_cost_fin_exp(vorvx{t},bnd_pnts,p2,pos,n1,coef,adv,type,p_int);
    if type == 2 || type == 3
        for i = 1:size(pos,1)
            if ~ismember(i,adv)
                pos(i,:) = sum3{t}(i,:);
            end
        end
    else
        pos = sum3{t};
    end
    p_sav{t+1} = pos;
end

p_ani{1} = p_sav{1};
p_ani{2} = p_sav{stage+1};


size(cst3)
k_p = 5;
res = 60;
M = animation_func9vor0_fin2(p_ani',res,n,0,bnd_pnts,k_p,adv);
h2 = figure('position',[100 100 600 600],'Color',[1 1 1]);
axis('square')
axis([0 1 0 1 0 1])
axis('off')
set(gca,'xtick',[]);
set(gca,'ytick',[]);
movie(h2,M,1,30);
% movie2avi(M, 'vid_exp_10_0_75_0_75_lloyd.avi', 'compression', 'None','quality',100,'fps',10);

figure,
plot(p_sav{stage+1}(:,1),p_sav{stage+1}(:,2),'o');axis([0 1 0 1]);
axis('equal')
axis([0 1 0 1]);
set(gca,'xtick',[]);
set(gca,'ytick',[]);
figure,plot(1:stage,cst3,'-s');set(gca,'FontSize',20);
xlabel('stage');ylabel('cost');
h0 = figure('position',[0 0 700 700],'Color',[1 1 1]);
k = 0;
t = stage;
% for i = 1:size(voronoi_rg{t},1)*size(voronoi_rg{t},2)
%     col(i,:)= rand(1,3);
% %     col(i,:) = [i/(size(voronoi_rg{t},1)*size(voronoi_rg{t},2)) 1 1];
% end
% col = distinguishable_colors(size(vorvx{t},2));
for i = 1:size(vorvx{t},2)
        if ~isempty(vorvx{t}{i})
            k = k+1;
            if ismember(i,adv)
                 patch(vorvx{t}{i}(:,1),vorvx{t}{i}(:,2),[0.9 0.9 0.9]);
                 hold on;
            end
            plot(vorvx{t}{i}(:,1),vorvx{t}{i}(:,2),'-','Color','b');
            hold on;

        end
end
bdp = convhull(bnd_pnts);
plot(bnd_pnts(bdp,1),bnd_pnts(bdp,2),'b-');
hold on;
plot(p_sav{t}(:,1),p_sav{t}(:,2),'Marker','o','MarkerSize',12,'MarkerFaceColor','w','Color','b','LineStyle','none'); hold on;
plot(p_sav{t}(adv,1),p_sav{t}(adv,2),'Marker','o','MarkerSize',12,'MarkerFaceColor','r','Color','b','LineStyle','none'); hold on;
% plot(p_sav{t}(adv,1),p_sav{t}(adv,2),'Marker','o','MarkerSize',6,'MarkerFaceColor','r','Color','k','LineStyle','none');
axis('equal')
axis([0 1 0 1]);
set(gca,'xtick',[]);
set(gca,'ytick',[]);  


h0 = figure('position',[0 0 800 700],'Color',[1 1 1]);
x = p2(:,1);
y = p2(:,2);
z = indx{stage};

h = scatter3(x,y,z,'Marker','o','MarkerFaceColor',[0 .75 .75], 'MarkerEdgeColor','k');
hChildren = get(h, 'Children');
set(hChildren, 'MarkerSize', 0.5)

% axis('equal')
% axis([0 1 0 1 0 1]);
set(gca,'xtick',[0 1]);
set(gca,'ytick',[0 1]);
set(gca,'ztick',[0 1]);
view(3)


% COST PLOT

h_cst = figure('position',[0 0 500 500],'Color',[1 1 1]);
plot(1:stage,cst_aug,'s-');legend('10','10(1)','10(2)','10(3)');xlabel('stage');ylabel('cost');
