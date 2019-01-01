% **************************************************************************%
% filename  	: filtering.m               								%
% Description 	: filtering images using GLCM properties					%
% Owner			: Rinaldi Ardiansyah (nalrinaldiardiansyah@gmail.com; ra93)	%
% **************************************************************************%

%Insert '1' in prompt
prompt = 'n-direktori = ';
x = input(prompt);

citra = {}; temp = {}; namafile={};
y=1;

for i=1:x
	%Browse image
    folder{i} = uigetdir();
	imdir{i} = [folder{i} '\'];
	dataset{i} = [dir([folder{i} '\*.jpg']);];
    
    for j=1:numel(dataset{i})
		%Store image in variable
        citra = [citra, rgb2gray(imread([imdir{i},dataset{i}(j).name]))];
        [filepath,name,ext] = fileparts([imdir{i},dataset{i}(j).name]);
        namafile = [namafile, name];
        
		%GLCM extraction
        temp = graycomatrix(citra{y},'GrayLimits',[0,255],'Offset',[0 1],'Symmetric',true);
        props = graycoprops(temp);
        f1 = ones(2,2)*props.Homogeneity;
		
		%Disable Comments to use these features' filters
		% f1 = ones(2,2)*props.Contrast;			
		% f2 = ones(2,2)*props.Energy;
		% f3 = ones(2,2)*props.Correlation;
		
        img_filt = imfilter(citra{y},f1);
		% img_filt1 = imfilter(citra{y},f1);
		% img_filt2 = imfilter(citra{y},f2);
		% img_filt3 = imfilter(citra{y},f3);
		% img_filt4 = imfilter(citra{y},f4);
        
        dirs = 'D:\Temporaries\Skripsi\Program\MATLAB\dataset_wayang\dataset_wayang_glcm_homogeneity\';
        savefiles = [dirs,namafile{y},'.jpg'];
        imwrite(img_filt,savefiles);
        
        y=y+1;
    end
		
		%Disable these comments to view the results
		% subplot(2,2,1);imshow(img_filt1);
		% subplot(2,2,2);imshow(img_filt2);
		% subplot(2,2,3);imshow(img_filt3);
		% subplot(2,2,4);imshow(img_filt4);

end