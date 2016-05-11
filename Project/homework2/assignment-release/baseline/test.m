
for i = 1:20
    disp(C{i});
    fprintf('when k is%d, the accuracy is %d\n', i, accuracy(i));
end