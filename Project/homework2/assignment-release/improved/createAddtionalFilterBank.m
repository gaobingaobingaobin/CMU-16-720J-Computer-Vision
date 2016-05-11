function [filterBank1] = createAddtionalFilterBank()


    filterBank1 = cell(4, 1);  
    filterBank1{1} = fspecial('average',3);
    
    filterBank1{2} = fspecial('unsharp',0.2);
    
    filterBank1{3} = fspecial('unsharp',0.2);
    
    filterBank1{4} = fspecial('unsharp',0.2);

    

