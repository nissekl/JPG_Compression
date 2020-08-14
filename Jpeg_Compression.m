%%ECE Optional HW-Image Compression
%Hung-Hsiu Yen(yen.142)

%Input img and covert to grayscale and make it double
I = rgb2gray(imread('S2.PNG'));
I = im2double(I);
imshow(I)

%Do the dct transformation
T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[8 8],dct,'PadPartialBlocks',true);

%Setting Mask add 1 from top left to bottom right (depends on ratio)
mask = [1   1   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];
    
%Doing block process with mask you set    
B2 = blockproc(B,[8 8],@(block_struct) mask .* block_struct.data);

%Invert dcy process and show the compressed img
invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B2,[8 8],invdct);
figure
imshow(I2)

