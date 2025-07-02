function new_msg = rs_irscode(in_msg, all_code_msg, all_msg)
% RS_IRSCODE RS(7,3) 译码函数
% 输入:
%   in_msg - 接收到的码字 (gf对象)
%   all_code_msg - 所有合法码字 (gf对象数组)
%   all_msg - 对应的原始信息矩阵
% 输出:
%   new_msg - 译码后的原始信息

% 参数验证
if ~isa(in_msg, 'gf')
    error('输入消息必须是GF对象');
end

if size(all_code_msg, 2) ~= length(in_msg)
    error('码字长度不匹配');
end

% 调用解释器进行译码
new_msg = rs_interpret(in_msg, all_code_msg, all_msg);

end