function F = eightpoint_norm(pts1, pts2, normalization_constant)

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
[~,~,V] = svd(A, 0); 
F = reshape(V(:,9), 3, 3)';

[U, S, V,] = svd(F, 0);
F=U*diag([S(1,1) S(2,2) 0])*V';
F = T'*F*T;

end



