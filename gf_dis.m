function ret = gf_dis(a, b)
% GF_DIS 计算 GF(2^m) 域中两个元素的汉明距离
% 输入:
%   a, b - gf对象 (必须来自相同的GF域)
% 输出:
%   ret - 汉明距离 (二进制位的不同数)

% 参数验证
if ~isequal(a.m, b.m)
    error('输入元素必须来自相同的GF域');
end

% 转换为二进制表示
a_temp = de2bi(double(a.x), a.m, 'left-msb');
b_temp = de2bi(double(b.x), a.m, 'left-msb');

% 计算汉明距离
ret = sum(a_temp ~= b_temp);

end