function out = arcta(th,delta)

for i = 1:size(th,1)
    num = dot([-sin(th(i)) cos(th(i))],delta(i,:));
    den = dot([cos(th(i)) sin(th(i))],delta(i,:));
    out(i,:) = atan2(num,den);
end