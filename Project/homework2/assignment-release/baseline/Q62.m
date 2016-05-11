
h = getImageFeatures(wordMap,dictionarySize);
[~, pos] = sort(h, 'descend');
index = pos(1:10)';
patch = total_patch(index);
imdisp(patch, 'size', [2 5]);
export_fig(gcf ,'myfig','width',6 ,'format','kitchen2');


