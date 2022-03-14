function [endpoint_number,rawimg_skel] = Skeletonize(rawimg_spclr)
%   skeletonize the microglia 
%   calulate the number of endpints after skeletonized

rawimg_skel = bwskel(rawimg_spclr);
endpoints = bwmorph(rawimg_skel,'endpoints');
endpoint_number = size(find(endpoints), 1);   %% calculate endpoints

end

