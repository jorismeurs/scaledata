function scaledData = scaledata(data,varargin)
% scaledata.m allows scaling of data for multivariate analysis. Several
% scaling options are supported 
% 
% Supported scaling: auto, pareto, vast, level and range [1]
% 
% Syntax
% scaledData = scaledata(data,'type',TypeValue)
% - data: matrix (N X M)containing N samples and M variables
% - TypeValue: 'auto', 'pareto', 'vast', 'level' or 'range'

% Error when no data is provided
if nargin < 1
   error('No data input'); 
end

% Default is no scaling
scaleType = [];

% Valid options for scaling
options = {'auto','pareto','vast','level','range'};

% Check input type
for j = 1:length(varargin)
    if isequal(varargin{j},'type')
       for n = 1:length(options)
           if isequal(varargin{j+1},options{n})
              scaleType = n; 
           end
       end
    end
end

if isempty(scaleType)
   error('Invalid or no scale type input'); 
end

% Handle scale type
if scaleType == 1 % auto scaling
    scaledData = zscore(data);
elseif scaleType == 2 % pareto scaling
    for j = 1:size(data,2)
       scaledData(:,j) = (data(:,j)-mean(data(:,j)))./sqrt(std(data(:,j))); 
    end
elseif scaleType == 3 % level scaling
    for j = 1:size(data,2)
       scaledData(:,j) = (data(:,j)-mean(data(:,j)))./mean(data(:,j)); 
    end
elseif scaleType == 4 % vast scaling
    for j = 1:size(data,2)
       scaledData(:,j) = ((data(:,j)-mean(data(:,j)))./std(data(:,j))).*(mean(data(:,j))./std(data(:,j))); 
    end
elseif scaleType == 5 % range scaling
    for j = 1:size(data,2)
       scaledData(:,j) = (data(:,j)-mean(data(:,j)))./(max(data(:,j))-min(data(:,j))); 
    end
end
