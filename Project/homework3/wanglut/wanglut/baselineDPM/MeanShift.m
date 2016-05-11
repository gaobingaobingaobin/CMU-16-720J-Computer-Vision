% Created by 15213796 on 2015-10-17.

function [CCenters,CMemberships] = MeanShift(data,bandwidth,stopThresh)

[numOfPoints, numOfDimPlusOne] = size(data);
numOfDim = numOfDimPlusOne -1;
numOfCluster = 0;          %the cluster number M
initPointsInd = 1:numOfPoints;   % the initial points
CCenters = [];        % center of each cluster
visited = zeros(1, numOfPoints);  %record the points which have been clusered
numOfInitPoints = numOfPoints;       % the initial point number to be clustered
CMemberships = zeros(1, numOfPoints);  %cluster membership
clusterVotes = zeros(1, numOfPoints);


while numOfInitPoints
    seedPoint = ceil((numOfInitPoints-1e-6)*rand);                  % pick up a rand point as seed point
    startPoint = initPointsInd(seedPoint);                      % use this point as start of mean
    myMean = data(startPoint, 1:numOfDim);                             %initial the mean to this point
    myMembers = [];     % the member of each cluster
    thisClusterVotes = zeros(1, numOfPoints);
   
    while 1              %utill convergence
        squareDistanceToAll = sum((repmat(myMean, numOfPoints, 1) - data(:, 1:numOfDim)).^2, 2);
        selectedInds = find(squareDistanceToAll < bandwidth^2);
        thisClusterVotes(selectedInds) = thisClusterVotes(selectedInds)+1;           % add vote to all the points belonging to this cluster
        myOldMean = myMean;  %save the old mean
        myMean = sum(data(selectedInds, 1:numOfDim).*(repmat(data(selectedInds, numOfDimPlusOne),1, numOfDim)))./sum(data(selectedInds, numOfDimPlusOne));
        myMembers = [myMembers, selectedInds'];
        visited(myMembers) = 1;
        
        % stop this cluster
        if norm(myMean-myOldMean) < stopThresh
           %check for merge possibility
            mergeWith = 0;
            for i = 1:numOfCluster
                distanceToOther = norm(myMean - CCenters(i, :));
                if distanceToOther < bandwidth/2
                    mergeWith = i;
                    break;
                end                   
            end
            
            if mergeWith > 0
                CCenters(mergeWith, :) = 0.5*(myMean+ CCenters(mergeWith, :)); 
                clusterVotes(mergeWith, :) = clusterVotes(mergeWith, :) + thisClusterVotes;
            else
                numOfCluster = numOfCluster+1;
                CCenters(numOfCluster, :) = myMean;
                clusterVotes(numOfCluster, :) = thisClusterVotes;
            end        
            break;
        end          
    end
initPointsInd = find(visited == 0); 
numOfInitPoints = length(initPointsInd);    
end

[~,CMemberships] = max(clusterVotes,[],1);  % a point belong to a cluster with the most votes
CMemberships = CMemberships';
end





