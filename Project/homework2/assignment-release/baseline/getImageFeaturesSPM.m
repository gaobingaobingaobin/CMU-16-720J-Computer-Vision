function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)

   %cut the image to suitable size
   x = floor(size(wordMap, 1)/4);
   y = floor(size(wordMap, 2)/4);
   x = 4*x;
   y = 4*y;
   wordMap=wordMap(1:x, 1:y);
       
   
    k=dictionarySize;
    L=layerNum-1;
    h = zeros(k*(power(4, L+1)-1)/3, 1);

    l = L;
    numofcellperline = power(2,l);
    numofcells = numofcellperline * numofcellperline;
    sizeofcellsx = size(wordMap, 1)/numofcellperline;
    sizeofcellsy = size(wordMap, 2)/numofcellperline;
    mx = sizeofcellsx*ones(1, numofcellperline);
    my = sizeofcellsy*ones(1, numofcellperline);
    n = mat2cell(wordMap, mx, my);
    c = cell(numofcellperline, numofcellperline);
    d = cell(2, 2);

    for i = 1:numofcellperline
        for j = 1:numofcellperline
           c{i,j} = getImageFeatures(n{i,j},dictionarySize);
           h((((i-1)*4+j-1)*k + 1):(((i-1)*4+j)*k),1) = c{i,j}*power(2, l-L-1)/numofcells;
        end
    end    
    
    d{1, 1} = (c{1,1} + c{1,2} +c{2, 1} +c{2,2})/4;
    d{1, 2} = (c{1,3} + c{1,4} +c{2, 3} +c{2,4})/4;
    d{2, 1} = (c{3,1} + c{3,2} +c{4, 1} +c{4,2})/4;
    d{2, 2} = (c{3,3} + c{3,4} +c{4, 3} +c{4,3})/4;  
    
    h((16*k+1:17*k), 1) = d{1, 1}*power(2, -L)/4;
    h((17*k+1:18*k), 1) = d{1, 2}*power(2, -L)/4;
    h((18*k+1:19*k), 1) = d{2, 1}*power(2, -L)/4;
    h((19*k+1:20*k), 1) = d{2, 2}*power(2, -L)/4;
    
    h((20*k+1:21*k), 1) = ((d{1, 1} +  d{1, 2} +  d{2, 1} +  d{2, 2})/4)*power(2, -L);
    
end
