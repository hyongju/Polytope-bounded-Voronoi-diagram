function f_val = f_exp(q,p,coef)

f_val = exp(-coef*norm(q -p)^2);