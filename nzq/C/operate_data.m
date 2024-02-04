
clear,clc
%p1_points means points won after this round
%p1_score means score before this round
data = readmatrix("useful_data.csv");
point_no = data(:,1);
p1_points_won = data(:,2);
p2_points_won = data(:,3);
p1_p2points = p1_points_won - p2_points_won;
% p1_score = data(:,4);
% p2_score = data(:,5);
% game_victor = data(:,6);
% p1_games = data(:,7);
% p2_games = data(:,8);
% server = data(:,9);

matches_momentum = readmatrix("momentum.csv");
matches_momentum = matches_momentum(:,2:end);
% index of first match in match
match_index = find(point_no==1);% ith match begin at match_index[i]
match_number = length(match_index);% number of match in data
match_index = [match_index;length(point_no)+1];
match_cap = zeros(match_number,1);% capacity of ith match, total 31 matchs
for i = 1:match_number
    match_cap(i) = match_index(i+1)-match_index(i);
end
% % output first 8 matchs
% for i = 1:8
%     subplot(4,2,i);
%     x = 1:match_cap(i);
%     plot(x,p1_p2points(match_index(i):match_index(i+1)-1));
% end
%% Check momentum autocorrelation
for i = 1:3
    time_series = matches_momentum(match_index(i):match_index(i)+match_cap(i)-1,1)-matches_momentum(match_index(i):match_index(i)+match_cap(i)-1,2);
    % Calculate and plot autocorrelation function (ACF)
    max_lag = floor(match_cap(i)/2);  % Consider lags up to half of the length of the time series
    autocorrelation = zeros(1, max_lag);
    
    for shift = 1:max_lag
        correlation = corrcoef(time_series(1:end-shift), time_series(shift+1:end));
        autocorrelation(shift) = correlation(1,2);
    end
    
    % Plotting with enhanced aesthetics
    figure;
    stem(1:max_lag, autocorrelation, 'filled', 'MarkerSize', 5, 'Color', [0.2, 0.4, 0.6]);
    title('Autocorrelation Function', 'FontSize', 16, 'FontWeight', 'bold');
    xlabel('Lag', 'FontSize', 14);
    ylabel('Autocorrelation', 'FontSize', 14);
    grid on;
end
%% output momentum condition of future 5 points
runs = 5;
matches_momentum_diffed = matches_momentum(:,1)-matches_momentum(:,2);
% momentum_5condition(time,j)存储time+j-1到time+j的变化
% = 1,2,3,4, meaning
% stay positive, up to positive, stay negative, drop to negative
momentum_5condition = zeros(length(matches_momentum(:,1)),runs);
for i = 1:match_number
    for j = match_index(i):match_index(i)+match_cap(i)-runs-1
        for ii = 1:runs
            %j+ii-1 to j+ii momentum shift
            stay_positive = matches_momentum_diffed(j+ii-1)>0 && matches_momentum_diffed(j+ii)>0;
            up_to_positive = matches_momentum_diffed(j+ii-1)<0 && matches_momentum_diffed(j+ii)>0;
            stay_negative = matches_momentum_diffed(j+ii-1)<0 && matches_momentum_diffed(j+ii)<0;
            drop_to_negative = matches_momentum_diffed(j+ii-1)>0 && matches_momentum_diffed(j+ii)<0;
            momentum_5condition(j,ii) = stay_positive+2*up_to_positive+4*stay_negative+8*drop_to_negative;
            momentum_5condition(j,ii) = log2(momentum_5condition(j,ii))+1;
        end
    end
end
% for ith match, row match_index(i):match_index(i)+match_cap(i)-runs-1 is meaningful
% to check ith match at j+l time momentum shift,j = 1,...,match_cap(i)-runs-1
% l = 0,1,2,3,4, use momentum_5condition(match_index(i)+j-1,l+1)

momentum_5condition_20 = zeros(length(matches_momentum(:,1)),4*runs);
for i = 1:length(matches_momentum(:,1))
    for j = 1:runs
        if momentum_5condition(i,j)~=0
            momentum_5condition_20(i,4*(j-1)+momentum_5condition(i,j)) = 1;
        end
    end
end
% to check ith match at j+l time kth momentum condition is true or not,j = 1,...,match_cap(i)-runs-1
% l = 0,1,2,3,4,k = 1,2,3,4 use momentum_5condition_20(match_index(i)+j-1,4*l+k)
writematrix(momentum_5condition,'momentum_condition.csv');
writematrix(match_index,'match_index.csv')
%% Calculte points difference in future multiple points at each time
%p1_p2_5points
R = zeros(5,match_number);
for runs = 1:5%points difference in future 'runs' points
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
        R(runs,i) = R_1(1,2);
    end
    %plot corrcoef of all matches
    % runs = 1;
    % figure()
    % plot(1:match_number,R(runs,:));
    % title(['future rounds in consideration: ',num2str(runs)]);
    % xlabel('match number');
    % ylabel('correlation coefficient');
end
max_R = max(R,[],2)';
min_R = min(R,[],2)';
%plot p1_p2_5points
% for i = 1:3
%     figure()
%     plot(1:match_cap(i)-runs+1,p1_p2_5points(i,1:match_cap(i)-runs+1))
%     %,'o', 'filled'
%     hold on
%     plot(1:match_cap(i)-runs+1,matches_momentum(match_index(i):match_index(i)+match_cap(i)-runs,1)- ...
%         matches_momentum(match_index(i):match_index(i)+match_cap(i)-runs,2))
%     legend('gain difference','momentum difference')
% end

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
%replace p1 with p2 and p2 with p1 in above code