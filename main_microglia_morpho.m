clear all; clc; close all;
inputmaindir = uigetdir( 'choose input dir' ); %save the binary images of microglial cells in subfolders in the input directory prior analysis
outputmain =uigetdir( 'choose input dir' ); %choose the output directory for the results output
morpho_analysis(inputmaindir,outputmain);
fprintf('sucessfully processed!');
close all;






      








