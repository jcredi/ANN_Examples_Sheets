function [ patterns, outputs ] = ReadData( dataFilePath )
%READDATA

fileID = fopen(dataFilePath);
data = textscan(fileID, '%f %f %f');
fclose(fileID);

patterns = [data{1}, data{2}];
outputs = data{3};

end

