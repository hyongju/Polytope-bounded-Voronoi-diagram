function out = dota(a1,b1)


for i =1:size(a1,1)
    out(i,1) = dot(a1(i,:),b1(i,:));
end