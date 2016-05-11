function [wordMap]=getVisualWords(I,filterBank,dictionary)

  
   wordMap = zeros(size(I, 1)* size(I, 2),1);
   filterResponses = extractFilterResponses(I, filterBank);
  
   for i = 1:size(filterResponses, 1);
       l = pdist2(filterResponses(i,:), dictionary);
       [unused, index] = min(l);
        wordMap(i, 1) = index;
   end
         
   wordMap = reshape(wordMap, size(I, 1), size(I, 2));  
    
end

