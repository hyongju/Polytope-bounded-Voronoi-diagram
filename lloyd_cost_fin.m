   function [sum1,indx] = lloyd_cost_fin(vorvx,bnd_pnts,p2,pos,n1,eta,adv,type,prob_int)
   sum1 = 0;
   indx = 0;
    for i = 1:size(pos,1)
%         sum1 = [0 0];
%         sum2 = 0;
        in1 = inhull(p2,vorvx{i},[],1e-15);
        cl = find(in1);
        q1 = p2(cl,:);
        p_int1 = prob_int(cl,:);
        if type == 1 || type == 3
            if ~ismember(i,adv)
                for l = 1:size(q1,1)
                    sum1 = sum1 + eta*(norm(q1(l,:)-pos(i,:))^2)*p_int1(l,:);
                    indx(cl(l)) =  eta*(norm(q1(l,:)-pos(i,:))^2)*p_int1(l,:);
                end
    %         sum3(i,:) = sum1 ./sum2;
            else
                for l = 1:size(q1,1)
                    sum1 = sum1 + p_int1(l,:);  
                    indx(cl(l)) =  p_int1(l,:);
                end            
            end
        else
            for l = 1:size(q1,1)
                sum1 = sum1 + eta*(norm(q1(l,:)-pos(i,:))^2) *p_int1(l,:);
                indx(cl(l)) =  eta*(norm(q1(l,:)-pos(i,:))^2) *p_int1(l,:);
            end
        end
    end