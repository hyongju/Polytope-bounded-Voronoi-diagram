   function sum3 = lloyd_cvt_fin_exp(vorvx,bnd_pnts,p2,pos,n1,adv,prob_int)
    for i = 1:size(pos,1)
        sum1 = [0 0];
        sum2 = 0;
        in1 = inhull(p2,vorvx{i},[],1e-15);
        cl = find(in1);
        q1 = p2(cl,:);
        p_int1 = prob_int(cl,:);
        for l = 1:size(q1,1)
            sum1 = sum1 + q1(l,:)*p_int1(l,:);  
            sum2 = sum2 + p_int1(l,:);  
        end
%         if ~ismember(i,adv)
            sum3(i,:) = sum1 ./sum2;
%         else
%             sum3(i,:) = pos(i,:);
%         end
    end