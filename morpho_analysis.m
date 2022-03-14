function  morpho_analysis(inputmaindir,outputmain)

files = dir(inputmaindir); dirFlags = [files.isdir]; subFolders = files(dirFlags);
  for i=3:length(subFolders)
      mkdir(strcat(outputmain,'\',subFolders(i).name));
      morpho_analysis([inputmaindir,'\',subFolders(i).name], [outputmain,'\',subFolders(i).name]);
  end

dat = dir(fullfile(inputmaindir,'*.tif'));  
pixe_x = 512;  % pixel number of the image
FOV = 300.0; % scale of the image, unit:um
pixel_di = FOV./pixe_x;

filenum = length( dat );
if (filenum~=0)
    fileID = fopen(strcat(outputmain,'\','mophorlogical statistics.txt'),'w');
    fprintf(fileID,'%15s\t %15s\t %20s\r\n','name','endpoints','ramification index');  

for m = 1 : length( dat )
loadpath = fullfile(inputmaindir, dat( m ).name);  
file_name = dat( m ).name(1: end - 4);
rawimg = imread(loadpath);
%% keep the mainbody of microglia and remove all the other part
L = bwlabeln(rawimg(:,:));
T = regionprops('table', L, 'centroid', 'area'); 
S = [];
S.voxN = T.Area;
S.voxS = T.Area * pixel_di.^2;
thrVolume =  max(T.Area(:));
S.smallCluster = T.Area < thrVolume;  
%--- remove small cluster
idxBig = find(S.smallCluster==0);
rawimg_spclr = ismember(L,idxBig);
%% skeletonize
[endpoint_number,rawimg_skel] = Skeletonize(rawimg_spclr);

%% calculate ramification index
[ramification_index] = calculate_ri(rawimg_spclr);
%% output
rawimg_spclr = 255.* rawimg_spclr./max(rawimg_spclr(:));
rawimg_skel = 255.* rawimg_skel./max(rawimg_skel(:));
savename1 = strcat(file_name,'_bw');
savename2 = strcat(file_name,'_skel');
savepath1 = strcat(outputmain,'\',savename1,'.tif');
savepath2 = strcat(outputmain,'\',savename2,'.tif');
imwrite(uint8(rawimg_spclr(:,:)),savepath1);
imwrite(uint8(rawimg_skel(:,:)),savepath2);
fprintf(fileID,'%15s\t %15.5f\t %20.5f\r\n', file_name, endpoint_number,ramification_index);

end
fclose(fileID);
end
end

