
clear,clc
%p1_points means points won after this round
%p1_score means score before this round
data = readmatrix("useful_data.csv");
point_no = data(:,1);
p1_points_won = data(:,2);
p2_points_won = data(:,3);
p1_p2points = p1_points_won - p2_points_won;
p1_score = data(:,4);
p2_score = data(:,5);
game_victor = data(:,6);
p1_games = data(:,7);
p2_games = data(:,8);

%% index of first game in sets
set_index = find(point_no==1);% ith set begin at set_index[i]
set_number = length(set_index);% number of set in data
set_index = [set_index;length(point_no)+1];
set_cap = zeros(set_number,1);% capacity of ith set, total 31 sets
for i = 1:set_number
    set_cap(i) = set_index(i+1)-set_index(i);
end
%% find runs of success,RoS,连续得分
runs = 5;%number of runs considered as RoS
%for p1,p1连续得分分数=p2得分不变的次数
p1_RoS_num = zeros(set_number,1);%number of RoS in ith set
p1_RoS_time = zeros(set_number,floor(max(set_cap)/runs));%index of RoS in each set
for i = 1:set_number
    %RoS in ith set
    RoS_count = 0;%number of RoS in a set
    continual_count = 0;
    value = -1;
    for j = set_index(i):set_index(i+1)-1
        %judge p2_points_won(j)
        if p2_points_won(j)~=value
            %encounter new point
            value = p2_points_won(j);
            if continual_count>=5
                % valid RoS
                RoS_count = RoS_count + 1;
                p1_RoS_time(i,RoS_count) = j-runs;
                continual_count = 1;
                continue
            else
                % invalid RoS
                continual_count = 1;
                continue
            end
        else
            %same point
            continual_count = continual_count + 1;
        end
    end
    p1_RoS_num(i) = RoS_count;
end
% %print first 5runs in each set
% for i = 1:set_number
%     fprintf('set No.%d: ',i);
%     for j = 1:5
%         fprintf('%d ',p1_points_won(p1_RoS_time(i,1)+j-1));
%     end
%     fprintf('\n');
% end

%for p2,p2连续得分分数=p1得分不变的次数
p2_RoS_num = zeros(set_number,1);%number of RoS in ith set
p2_RoS_time = zeros(set_number,floor(max(set_cap)/runs));%index of RoS in each set
for i = 1:set_number
    %RoS in ith set
    RoS_count = 0;%number of RoS in a set
    continual_count = 0;
    value = -1;
    for j = set_index(i):set_index(i+1)-1
        %judge p2_points_won(j)
        if p1_points_won(j)~=value
            %encounter new point
            value = p1_points_won(j);
            if continual_count>=5
                % valid RoS
                RoS_count = RoS_count + 1;
                p2_RoS_time(i,RoS_count) = j-runs;
                continual_count = 1;
                continue
            else
                % invalid RoS
                continual_count = 1;
                continue
            end
        else
            %same point
            continual_count = continual_count + 1;
        end
    end
    p2_RoS_num(i) = RoS_count;
end
% %print first 5runs in each set
% for i = 1:set_number
%     fprintf('set No.%d: ',i);
%     for j = 1:5
%         fprintf('%d ',p2_points_won(p2_RoS_time(i,1)+j-1));
%     end
%     fprintf('\n');
% end

%% output ith set image
% output first 8 sets
for i = 1:8
    subplot(4,2,i);
    x = 1:set_cap(i);
    plot(x,p1_p2points(set_index(i):set_index(i+1)-1));
end