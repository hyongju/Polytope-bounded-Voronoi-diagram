   function sum3 = lloyd_cvt_fin(vorvx,bnd_pnts,p2,pos,n1,adv)
    for i = 1:size(pos,1)
        sum1 = [0 0];
        sum2 = 0;
        in1 = inhull(p2,vorvx{i},[],1.e-13*mean(abs(bnd_pnts(:))));
        q1 = p2(find(in1),:);
        for l = 1:size(q1,1)
            sum1 = sum1 + q1(l,:)./n1;  
            sum2 = sum2 + 1/n1;  
        end
%         if ~ismember(i,adv)
            sum3(i,:) = sum1 ./sum2;
%         else
%             sum3(i,:) = pos(i,:);
%         end
    end