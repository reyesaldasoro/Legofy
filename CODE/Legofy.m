function dataOut = Legofy(dataIn,scaleOutput,displayResult)
% function dataOut = Legofy(dataIn)
%--------------------------------------------------------------------------
% Legofy converts an image into what it would look like if formed with the bricks of the
% very very very famous Danish block company
%
%       INPUT
%         dataIn:       A 2D or 3D (for RGB) matrix that corresponds to an image
%         
%
%       OUTPUT
%         dataOut:      A 2D or 3D (for RGB) matrix that corresponds to the same
%                       image but with brick-texture
%
%--------------------------------------------------------------------------
%
%
%     Legofy is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, version 3 of the License.
%
%     The Legofy package is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%
%     A copy of the GNU General Public License is available here
%     <http://www.gnu.org/licenses/>.
%
%--------------------------------------------------------------------------
%
%
%--------------------------------------------------------------------------
%
% The authors shall not be liable for any errors or responsibility for the 
% accuracy, completeness, or usefulness of any information, or method in the content, or for any 
% actions taken in reliance thereon.
%
%--------------------------------------------------------------------------


% parse the dataIn, it may be an image or a location

if isa(dataIn,'char') 
    location = dataIn;
    dataIn = imread(dataIn);
else
    location ='';
end 

% First, pixelise, decide the size
if ~exist('scaleOutput','var')
    scaleOutput         = 0.1;
end

% First, pixelise, decide the size
if ~exist('displayResult','var')
    displayResult         = 0;
end
% Input Dimensions
[rows,cols,levs]        = size (dataIn);

sizeRows                = round(rows*scaleOutput);
sizeCols                = round(cols*scaleOutput);
% increase the contrast
clear data_*
data_contrast           = imadjust(dataIn,[0.1*[1 1 1];0.9*[1 1 1]]);
data_pixelised          = imresize(data_contrast,[sizeRows sizeCols]);
%imagesc(data_pixelised)

% Use this pallete to match
Brick_RGB = [250,250,250;158,162,162;251,216,114;229,106,84;211,188,141;162,228,184;246,141,46;236,179,203;171,202,233;213,120,0;255,130,0;236,232,26;229,158,109;219,138,6;239,51,64;226,119,205;0,61,165;255,205,0;105,63,35;39,37,31;81,83,74;0,132,61;128,224,167;254,203,139;0,150,57;184,97,37;203,211,235;198,218,231;255,179,171;255,134,116;108,172,228;178,180,178;155,38,182;255,163,0;255,130,0;0,134,117;110,76,30;30,34,170;72,92,199;206,220,0;0,178,169;156,219,217;181,189,0;194,225,137;255,181,73;255,103,31;175,22,133;255,185,144;184,97,37;255,103,31;197,232,108;91,127,149;161,146,178;255,127,50;155,148,95;0,56,101;44,82,52;93,121,117;120,159,144;156,97,105;155,39,67;204,138,0;255,215,0;255,163,0;122,62,58;207,69,32;162,170,173;0,71,187;0,51,160;152,29,151;91,103,112;193,198,200;172,132,0;74,119,41;44,213,196;105,179,231;48,127,226;150,56,33;96,61,32;184,132,203;104,91,199;159,174,229;233,60,172;241,167,220;252,155,179;217,200,158;253,190,135;251,219,101;5,195,222;51,0,114;66,152,181;252,200,155;49,38,29;113,197,232;185,220,210;160,94,181;202,162,221;212,235,142;115,123,76;238,218,234];
% Definintion of the block
% button = [...
%     1    1    1    1    1    1    1    1    1    1    1    1    1    1    1;...
%     1    1    1    1    1    1    1    1    1    1    1    1    1    1    1;...
%     1    1    1    1    1    1    1    1    1    1    1    1    1    1    1;...
%     1    1    1    1    1.1  1.2  1.2  1.2  1.2  1.2  1    1    1    1    1;...
%     1    1    1    1.1  1.2  1    1    1    1    1    0.8  0.7  1    1    1;...
%     1    1    1.1  1.2  1.1  1    1    1    1    1    1    0.8  0.7  1    1;...
%     1    1    1.1  1.2  1.1  1    1    1    1    1    1    0.8  0.7  1    1;...
%     1    1.1  1.2  1.1  1    1    1    1    1    1    1    1    0.8  0.7  1;...
%     1    1    1.1  1.2  1.1  1    1    1    1    1    1    1    0.8  0.7  1;...
%     1    1    1.1  1.2  1.1  1    1    1    1    1    1    0.8  0.7  1    1;...
%     1    1    1    1.1  1.2  1.1  1    1    1    1    0.8  0.7  1    1    1;...
%     1    1    1    1    1    1.2  1.2  1.2  0.8  0.8  0.7  1    1    1    1;...
%     1    1    1    1    1    1    1    1    1    1    1    1    1    1    1;...
%     1    1    1    1    1    1    1    1    1    1    1    1    1    1    1;...
%     1    1    1    1    1    1    1    1    1    1    1    1    1    1    1];
% 
% 
% button(:,1) = 1.1;
% button(:,end) = 0.9;
% button(1,:) = 1.1;
% button(end,:) = 0.9;
button=[...
    7    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    7;...
    9   10    9    9    9    9    9    9    9    9    9    9    9    9    9    9    9    9    9    9    9    9    9    9    9    9    9    9    9    8;...
    8    9    9    9    9    9    9    9    9    9    9    9    9    9    8    8    8    9    9    9    9    9    9    9    9    9    9    9    9    8;...
    8    9    9    9    9    9    9    9    9    9    9    9   10   10   11   11   10   10    9    9    9    9    9    9    9    9    9    9    9    8;...
    8   10    9    9    9    9    9    9    9    9   11   12   13   12   12   12   13   13   12   10    9    9    9    9    9    9    9    9    9    8;...
    8    9    9    9    9    9    9    9   10   12   12   11   10    9    9    9    9   10   12   13   12    9    9    9    9    9    9    9    9    8;...
    8    9    9    9    9    9    9   10   12   11    9    8    9    9    9    9    9    9    9   10   12   12    9    9    9    9    9    9    9    8;...
    8    9    9    9    9    9   10   12   10    8    9    9    9    9    9    9    9    9    9    8    9   11   11    9    9    9    9    9    9    8;...
    8    9    9    9    9    9   11   10    8    9    9    9    9    8    8    8    9    8    8    9    8    8   11   10    8    9    9    9    9    8;...
    8   10    9    9    9    9   10    9    9    9    9    9    9    9    9    9    8    9    9    9    9    9    9   11    9    8    9    9    9    8;...
    8   10    9    9    8    9    9    9   10   10    8    8    9   11   11    9    8   11   11    8    9   11   10   10    9    8    9    9    9    8;...
    8   10    9    8    8    9    9    8    8    9    9    8    8    8    7    8    9    7    9    9    8    7    9   10    9    7    8    9    9    8;...
    8   10    9    8    8    9    9    8    8    9    9    8    8    8    8    8    9    7    7    8    9    7    8    9    9    7    8    9    9    8;...
    8    9    9    7    8    9    9    8    9    8    8    8   10   10    8    8    9    9    8    8    9    8    9    9    9    7    7    9    9    8;...
    8    9    9    7    8   10    9    8    9    8    8    8   10   10    7    8    9   11    9    8    8    8    9    9    9    7    7    8    9    8;...
    8    9    8    7    8   10    8    9    9    9    8    9    7    8    8    9    7    8    8    9    8    8    9    9    9    6    7    8    9    8;...
    8    9    8    6    7   10    8    8    8    8    8    8    8    8    8    9    7    9    9    9    7    9    8    9    8    6    7    8    9    8;...
    8    9    8    7    6    9    8   10   11   10    8   10   11   10    7   11   11    8    7   11   11    8    8    9    8    5    7    8    9    8;...
    8    9    9    7    5    8    9    8   10    9    7    8    9    9    7    7    9    8    7    8    9    8    9    9    6    5    7    8    9    8;...
    8    9    9    8    5    6    9    8    6    8    8    7    6    8    9    7    7    8    9    7    7    9    9    8    5    6    8    8    9    8;...
    8    9    9    8    6    5    7   10    9    9    9    9    9    9    8    9    9    9    9    9    9    9    9    6    4    7    8    8    9    8;...
    8    9    9    8    7    5    4    8    9    8    8    9    9    9    9    9    9    9    9    9    9    9    7    4    5    7    8    8    9    8;...
    8    9    9    8    7    6    4    4    7    9    9    9    9    9    9    9    9    9    9    9   10    7    4    4    6    7    8    8    9    8;...
    8    9    9    9    8    7    5    4    3    6    8    9    9    9    9    9    9    9    9    9    7    3    3    5    7    8    8    8    9    8;...
    8    9    9    9    8    8    6    5    4    3    4    6    8    8    9    9    8    8    6    4    3    3    5    6    8    8    8    8    9    8;...
    8    9    9    9    9    8    7    6    5    4    3    3    4    4    5    5    4    4    3    2    4    5    6    7    8    8    8    8    9    8;...
    8    9    9    9    9    9    8    7    6    5    4    3    3    3    3    3    3    3    3    4    5    6    7    8    8    8    8    9    9    8;...
    8    9    9    9    9    9    9    8    8    7    6    4    4    4    3    3    3    4    5    6    7    8    8    8    8    8    8    9    9    8;...
    9   10    9    9    9    9    9    9    9    9    8    7    7    6    6    6    6    7    7    8    9    9    9    9    9    9    9    9   10    8;...
    7    8    8    8    8    8    8    8    8    8    8    8    7    7    7    7    7    7    7    8    8    8    8    8    8    8    8    8    8    7];
button = button/10;
% map to the blocks pallete 
[rowsB,colsB]=size(button);
data_mapped1(sizeRows ,sizeCols,1:3)=[0 0 0];
data_mapped2(sizeRows *rowsB,sizeCols*colsB,1:3)=[0 0 0];
% Display the results sequentially
if displayResult==1
    h0=get(0);
    scrsz = h0.ScreenSize;
    figure
    set(gcf,'position',[200 300 scrsz(3)-300 scrsz(4)-300])
    subplot(121)
    imagesc([dataIn ])
    title(strcat('Original ',32,32,32,location),'interpreter','none')
    subplot(122)
    h122 = imagesc(data_mapped2);
    title(strcat('At scale = ',num2str(scaleOutput)))
end
%imagesc([ dataOut])
for row=1:sizeRows
    for col=1:sizeCols
        currentpixel            = squeeze(double(data_pixelised(row,col,:)));
        difference              = sum(  (Brick_RGB - repmat(currentpixel',[100 1])).^2,2);
        [val,match]             = min(difference);
         data_mapped1(row,col,:) = Brick_RGB(match,:);
         data_mapped2(1+(row-1)*rowsB:row*rowsB,1+(col-1)*colsB:col*colsB,1) = button*Brick_RGB(match,1);
         data_mapped2(1+(row-1)*rowsB:row*rowsB,1+(col-1)*colsB:col*colsB,2) = button*Brick_RGB(match,2);
         data_mapped2(1+(row-1)*rowsB:row*rowsB,1+(col-1)*colsB:col*colsB,3) = button*Brick_RGB(match,3);
         
    end
    if displayResult==1
        h122.CData = uint8(data_mapped2);
        pause(0.001)
        drawnow
    end
end
dataOut             = uint8(data_mapped2);



