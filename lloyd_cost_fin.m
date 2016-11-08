   function [sum1,indx] = lloyd_cost_fin(vorvx,bnd_pnts,p2,pos,n1,eta,adv,type)
   sum1 = 0;
   indx = 0;
    for i = 1:size(pos,1)
%         sum1 = [0 0];
%         sum2 = 0;
        in1 = inhull(p2,vorvx{i},[],1.e-13*mean(abs(bnd_pnts(:))));
        cl = find(in1);
        q1 = p2(cl,:);
        if type == 1 || type == 3
            if ~ismember(i,adv)
                for l = 1:size(q1,1)
                    sum1 = sum1 + eta*(norm(q1(l,:)-pos(i,:))^2) /n1;
                    indx(cl(l)) =  eta*(norm(q1(l,:)-pos(i,:))^2) /n1;
                end
    %         sum3(i,:) = sum1 ./sum2;
            else
                for l = 1:size(q1,1)
                    sum1 = sum1 + 1 /n1;  
                    indx(cl(l)) =  1 /n1;
                end            
            end
        else
            for l = 1:size(q1,1)
                sum1 = sum1 + eta*(norm(q1(l,:)-pos(i,:))^2) /n1;
                indx(cl(l)) =  eta*(norm(q1(l,:)-pos(i,:))^2) /n1;
            end
        end
    end