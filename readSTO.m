function [result] = readSTO(filename)

table = readtable(filename, 'FileType', 'text');
column_names = table.Properties.VariableNames;
data = table2array(table);

result = {data, column_names};

end