function [R] = calculate_ri(rawimg_spclr)
% Calculate the circularity index
    pe = bwperim(rawimg_spclr,8); %imshow(peri)
    peri = sum(pe(:)); 
    area = bwarea(rawimg_spclr);
    R = (peri./area)./(2.*(pi./area).^0.5);
end

