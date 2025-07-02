

function x = a_msg()
% A_MSG 生成GF(2^3)域上所有可能的3位信息组合
% 输出:
%   x - 512×3矩阵(8^3=512种组合)，每行代表一个信息组合

x = zeros(512, 3); % 预分配数组(提高性能)
count = 1;

% 三重循环生成所有组合
for i = 0:7       % 第一位
    for j = 0:7   % 第二位
        for k = 0:7  % 第三位
            x(count, :) = [i, j, k];
            count = count + 1;
        end
    end
end

end