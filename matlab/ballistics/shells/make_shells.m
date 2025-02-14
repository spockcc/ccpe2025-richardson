function flag=make_shells(method)

% MAKE_SHELLS  Build drag functions for standard shells

% Defines the drag coefficient functions for standard shells
%
% CALL SEQUENCE:
%   
%   flag=make_shells(method)
% 
% INPUT: 
%   method    string, describes the algorithm used
%               'spline'  uses MATLAB's spline function
%               'smooth'  generates a C-infinity interpolant
% OUTPUT:
%   flag      standard flag
%               flag=0  if the method is unknown
%               flag=1  if the method is accepted
% 
% The raw data has been downloaded from this address
% https://jbmballistics.com/ballistics/downloads/downloads.shtml
% 
% The original source of this data is the late Robert L. McCoy
% of US Army's Ballistics Research Laboratory
%
% The abbreviation McG refers to McCoy and the
% Gâvre Commission who defined the standard shells

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%   201X-YY-ZZ Initial programming and testing
%   2024-03-04 Reformatted during yearly review
%   2024-12-05 Extended to allow for C-infinity interpolation

% Assume failure
flag=0;

% Logical check
switch lower(method)
    case {"spline","smooth","linear"}

        % Define data files
        names=["mcg1.txt", "mcg2.txt", "mcg5.txt", "mcg6.txt", "mcg7.txt", "mcg8.txt"];

        % Define empty cell array
        f=cell(1,6);

        % Loop over the data files
        for i=1:6
            % Load the ascii file
            A=importdata(names(i));
            % Generate the interpolating function
            f{i}=interpolant(A(:,1),A(:,2),method);
        end

        % Name the functions using the old names
        mcg1=f{1};
        mcg2=f{2};
        mcg5=f{3};
        mcg6=f{4};
        mcg7=f{5};
        mcg8=f{6};

        % Save the spline functions
        % This searches the MATLAB path for a file called 'shells.mat'
        fp=which('shells.mat');
        if isempty(fp)==true
            % The file will be saved in the current folder
            fp='shells.mat';
            % This is not ideal, but what can we do?
        end
        save(fp,'mcg1','mcg2','mcg5','mcg6','mcg7','mcg8');
        
        % Set flag
        flag=1;

    otherwise
        disp("Unknown method");
end