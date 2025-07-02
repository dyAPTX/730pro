clc;
clear;
%%zhushi
%% 参数设置
n = 7; % RS 码字长度
k = 3; % 信息长度
gf_domain = 3; % 有限域 GF(2^3)

% RS 生成矩阵
g = [1 0 0 3 2 1 3;
     0 1 0 5 5 1 4;
     0 0 1 7 6 1 6];
g = gf(g, gf_domain);

%% %辅助函数定义
% 生成所有可能的信息向量
function all_m = a_msg()
    all_m = zeros(512, 3); % 8^3=512种可能
    count = 1;
    for i = 0:7
        for j = 0:7
            for k = 0:7
                all_m(count, :) = [i, j, k];
                count = count + 1;
            end
        end
    end
end

% 将消息转换为GF域元素
function gf_msg = ef(msg, domain)
    gf_msg = gf(msg, domain);
end

% RS编码函数
function coded_msg = rs_rscode(msg, gen_matrix)
    if nargin < 2
        % 解码模式
        coded_msg = rs_decode(msg);
    else
        % 编码模式
        coded_msg = msg * gen_matrix;
    end
end

% RS解码函数
function decoded_msg = rs_decode(received_msg, all_code_words, all_msg)
    % 找到与接收码字距离最小的合法码字
    min_dist = Inf;
    best_match = 1;
    
    received = double(received_msg.x);
    
    for i = 1:size(all_code_words, 1)
        code_word = double(all_code_words(i,:).x);
        dist = sum(received ~= code_word);
        
        if dist < min_dist
            min_dist = dist;
            best_match = i;
        end
    end
    
    decoded_msg = all_msg(best_match, 1:k);
end

%% 所有可能的信号
all_msg = a_msg();
all_msg_gf = ef(all_msg, gf_domain);
all_code_msg = rs_rscode(all_msg_gf, g);

%% 生成随机信号并编码
msg = floor(rand(5, k) * 8);
MSG = ef(msg, gf_domain);
code = rs_rscode(MSG, g);

disp('随机生成的原始信号: ');
disp(msg);

disp('RS 编码后的码字: ');
disp(double(code.x));

%% 添加噪声
noise = [zeros(5, k), floor(rand(5, n - k) * 8)];
NOISE = ef(noise, gf_domain);
in_msg = code + NOISE;

disp('加噪声的信号: ');
disp(double(in_msg.x));

%% RS 译码
new_msg = zeros(5, k);
for i = 1:5
    new_msg(i, :) = rs_rscode(in_msg(i, :), all_code_msg, all_msg);
end

disp('译码后的信号: ');
disp(new_msg);

%% 计算正确率
num_same = sum(all(msg == new_msg, 2));
accuracy = num_same / 5;

disp(['译码正确率: ', num2str(accuracy * 100), '%']);