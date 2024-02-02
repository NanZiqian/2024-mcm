
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
set_number = length(set_index);
set_index = [set_index;length(point_no)+1];
set_cap = zeros(set_number,1);% capacity of ith set, total 31 sets
for i = 1:set_number
    set_cap(i) = set_index(i+1)-set_index(i);
end
%% output ith set image
% output first 8 sets
for i = 1:8
    subplot(2,4,i);
    x = 1:set_cap(i);
    plot(x,p1_p2points(set_index(i):set_index(i+1)-1));
end