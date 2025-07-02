function interpret_msg = rs_interpret(in_msg, all_code_msg, all_msg)
% RS_INTERPRET 对接收到的RS编码消息进行解释(解码)
% 输入:
%   in_msg - 接收到的消息(GF格式)
%   all_code_msg - 所有合法的RS码字(GF格式)
%   all_msg - 对应的原始信息
% 输出:
%   interpret_msg - 解释后的原始信息

% 找到接收到的信号中与合法码字之间码距最短的那个码字
num_msgs = size(all_code_msg, 1); % 合法码字的数量
rs_dis = zeros(1, num_msgs); % 预分配距离数组

% 计算与每个合法码字的距离
for i = 1:num_msgs
    rs_dis(i) = rscode_dis(in_msg, all_code_msg(i,:)); % 计算距离
end

% 找到最小距离
rs_dis_min = min(rs_dis); 

% 处理可能存在的多个等距离情况(取第一个)
index = find(rs_dis == rs_dis_min, 1); 

% 返回对应的原始信号
interpret_msg = all_msg(index, :); 

end

% 辅助函数: 计算两个RS码字的距离
function d = rscode_dis(msg1, msg2)
% 计算两个GF域码字之间的距离
d = sum(double(msg1.x) ~= double(msg2.x));
end