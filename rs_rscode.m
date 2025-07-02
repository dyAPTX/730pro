function code = rs_rscode(msg, g)
% RS_RSCODE 使用生成矩阵进行RS编码
% 输入:
%   msg - 输入消息矩阵(GF对象)，每行代表一个消息向量
%   g   - 生成矩阵(GF对象)
% 输出:
%   code - 编码后的码字(GF对象)

% 参数校验
if ~isa(msg, 'gf') || ~isa(g, 'gf')
    error('输入参数必须是GF域对象');
end

if size(msg, 2) ~= size(g, 1)
    error('消息长度与生成矩阵行数不匹配');
end

% 执行编码 (矩阵乘法)
code = msg * g;  % 每行结果是一个编码码字

end