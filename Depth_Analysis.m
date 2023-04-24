%Depth_Analysis 

%% user needs to specify

%import Cell_data and Pia files via interface, store data in cFos and pia
cFos = CellstdTRectangleNick; %change to variable name that holds file
pia = PiaNick; %change to variable name that holds file

%specify location to save
save_dir = '/Volumes/Shares/Suma/HK_LIFU/';

%specify region of analysis
region = 'Rectangle'; %'Ctx' or 'dLGN' or 'HC' or 'Rectangle' or 'V1'
nick = 'Nick_tdT'; %'Nick' or 'noNick'

%% depth calculation 
cellDepth = table('Size', [0,1], 'VariableTypes', ["double"], 'VariableNames', "Depth");
for n=1 : height(cFos)
    depth = 10000;
    for i=1 : height(pia)
        if norm([cFos.X(n) cFos.Y(n)] - [pia.X(i) pia.Y(i)]) < depth
            depth = norm([cFos.X(n) cFos.Y(n)] - [pia.X(i) pia.Y(i)]);
        end
    end
    cellDepth(end+1, 1) = array2table(depth);
end
cFos = addvars(cFos, cellDepth);
cFos.cellDepth = table2array(cellDepth);

file = [save_dir sprintf('Cell_depth_%s_%s.csv', region, nick)];
writetable(cFos, file);

%writetable(cFos, '/Users/sumakotha/Documents/Hopkins!!/Research/Lee Lab/Cell_depth_Ctx_Nick.csv')

% addpath('/Users/sumakotha/Documents/Hopkins!!/Research/Lee Lab/ANALYSIS_cFosTRAP2-Ai14/LIFU_LTD2A_CFOSTRAP2_#6-left_analysis')
% cFos = importdata('Cell_data_Ctx_Nick.csv');
% pia = importdata('Pia_Ctx_Nick.csv');