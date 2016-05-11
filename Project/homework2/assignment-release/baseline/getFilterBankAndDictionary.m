function [filterBank,dictionary] = getFilterBankAndDictionary(trainFiles)

alpha = 50;
K = 200; %the size of dictionary
filterBank = createFilterBank();
l = length(trainFiles);
total_response = zeros(alpha*l, length(filterBank)*3);
for i = 1:l
    im = imread(trainFiles{i});
    response = extractFilterResponses(im, filterBank);
    n = size(im, 1)*size(im,2);
    pixels = randperm(n);
    for j = 1:alpha
        total_response((i-1)*alpha+j,:) = response(pixels(j),:);
    end
end

[unused, dictionary] = kmeans(total_response, K, 'EmptyAction', 'drop');


end
