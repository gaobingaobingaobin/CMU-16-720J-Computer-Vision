function F = sevenpoint_norm(pts1, pts2, normalization_constant)

N = size(pts1, 2);
T = eye(3)/normalization_constant;
T(3,3)=1;
pts1 = [pts1', ones(N, 1)]*T;
pts2 = [pts2', ones(N, 1)]*T;
x1 = pts1(:, 1);
y1 = pts1(:, 2);
x2 = pts2(:, 1);
y2 = pts2(:, 2);

A = [x1.*x2, y1.*x2, x2, x1.*y2, y1.*y2, y2, x1, y1, ones(N, 1)];
[~,~,V] = svd(A); 
f1 = reshape(V(:,8), 3, 3)';
f2 = reshape(V(:,9), 3, 3)';

syms lamda;
F0 = det(lamda*f1 + (1-lamda)*f2);
coef = sym2poly(F0);
lamda = roots(coef);

real_index = lamda == real(lamda);
lamda = lamda(real_index);
numOfF = length(lamda);
if(numOfF == 1)
    F{1} = lamda*f1 + (1-lamda)*f2;
    F{1} = T'*F{1}*T;
else
    for j = 1:3
        F{j} = lamda(j)*f1 + (1-lamda(j))*f2;
        F{j} = T'*F{j}*T;
    end
end

end
