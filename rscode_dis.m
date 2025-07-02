function dis = rscode_dis(code1, code2)
% RSCODE_DIS 计算两个RS码字之间的汉明距离
% 输入:
%   code1, code2 - 待比较的码字(GF对象向量)
% 输出:
%   dis - 汉明距离(不同符号的数量)

% 参数校验
if length(code1) ~= length(code2)
    error('码字长度必须相同');
end

if ~isa(code1, 'gf') || ~isa(code2, 'gf')
    error('输入必须是GF域对象');
end

% 初始化距离
dis = 0;

% 逐符号比较
for i = 1:length(code1)
    if code1(i) ~= code2(i)  % GF对象的直接比较
        dis = dis + 1;
    end
end

end