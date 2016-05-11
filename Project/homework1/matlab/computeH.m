% Wang luting
% Q 4.1
% 2015

function H2to1 = computeH(p1, p2)


N = size(p1, 2); % the number of points
A = zeros(2*N, 9); % set A to the required size

for i = 1 : N
    A(2*i-1, :) = [p2(1, i), p2(2, i), 1, 0, 0, 0, -p1(1, i)*p2(1, i), -p1(1, i)* p2(2, i),  -p1(1, i)];
    A(2*i, :) = [0, 0, 0, p2(1, i), p2(2, i), 1, -p1(2, i)*p2(1, i), -p1(2, i)* p2(2, i),  -p1(2, i)];
end

B = A'*A;
[V D] = eig(B);

H = V(:, 1);

H2to1 = reshape(H,3,3)';