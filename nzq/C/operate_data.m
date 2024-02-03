
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
server = data(:,9);

matches_momentum = readmatrix("matches_momentum/output.csv");
matches_momentum = matches_momentum(:,2:end);
% index of first match in match
match_index = find(point_no==1);% ith match begin at match_index[i]
match_number = length(match_index);% number of match in data
match_index = [match_index;length(point_no)+1];
match_cap = zeros(match_number,1);% capacity of ith match, total 31 matchs
for i = 1:match_number
    match_cap(i) = match_index(i+1)-match_index(i);
end
%% Calculte points difference in future multiple points at each time
%p1_p2_5points
runs = 1;%points difference in future 'runs' points
p1_p2_5points = zeros(match_number,floor(max(match_cap)-runs+1));
for i = 1:match_number
    p1_p2_5points(i,1) = p1_p2points(match_index(i)+runs-1);
    for j = 2:match_cap(i)-runs+1
        p1_p2_5points(i,j) = p1_p2points(match_index(i)+j+runs-2)-p1_p2points(match_index(i)+j-2);
    end
end
%corrcoef between momentum and point gain of matches

for i=1:match_number;
    R_1 = corrcoef( p1_p2_5points(i,1:match_cap(i)-runs+1) , ...
        matches_momentum(match_index(i):match_index(i)+match_cap(i)-runs,1)-matches_momentum(match_index(i):match_index(i)+match_cap(i)-runs,2));
    R(i) = R_1(1,2);
end
plot(1:match_number,R);
% numerator = sum(p1_p2_5points(i,match_cap(i)-runs+1)>0 & ...
%     match1_momentum(1:match_cap(i)-runs+1,1) - match1_momentum(1:match_cap(i)-runs+1,2)>0.5)
% + sum(p1_p2_5points(i,match_cap(i)-runs+1)<0 & ...
%     match1_momentum(1:match_cap(i)-runs+1,1) - match1_momentum(1:match_cap(i)-runs+1,2)<-0.5);
% numerator/(match_cap(i)-runs+1-sum(abs(match1_momentum(1:match_cap(i)-runs+1,1) - match1_momentum(1:match_cap(i)-runs+1,2))<0.5))
%plot p1_p2_5points


%% find runs of success,RoS,连续得分
%p1_RoS_num
%p1_RoS_time
%p2_RoS_num
%p2_RoS_time
runs = 5;%number of runs considered as RoS
%for p1,p1连续得分分数=p2得分不变的次数
p1_RoS_num = zeros(match_number,1);%number of RoS in ith match
p1_RoS_time = zeros(match_number,floor(max(match_cap)/runs));%index of RoS in each match
for i = 1:match_number
    %RoS in ith match
    RoS_count = 0;%number of RoS in a match
    continual_count = 0;
    value = -1;
    for j = match_index(i):match_index(i+1)-1
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
% %print first 5runs in each match
% for i = 1:match_number
%     fprintf('match No.%d: ',i);
%     for j = 1:5
%         fprintf('%d ',p1_points_won(p1_RoS_time(i,1)+j-1));
%     end
%     fprintf('\n');
% end

%for p2,p2连续得分分数=p1得分不变的次数
p2_RoS_num = zeros(match_number,1);%number of RoS in ith match
p2_RoS_time = zeros(match_number,floor(max(match_cap)/runs));%index of RoS in each match
for i = 1:match_number
    %RoS in ith match
    RoS_count = 0;%number of RoS in a match
    continual_count = 0;
    value = -1;
    for j = match_index(i):match_index(i+1)-1
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
% %print first 5runs in each match
% for i = 1:match_number
%     fprintf('match No.%d: ',i);
%     for j = 1:5
%         fprintf('%d ',p2_points_won(p2_RoS_time(i,1)+j-1));
%     end
%     fprintf('\n');
% end

%% output ith match image
% output first 8 matchs
for i = 1:8
    subplot(4,2,i);
    x = 1:match_cap(i);
    plot(x,p1_p2points(match_index(i):match_index(i+1)-1));
end