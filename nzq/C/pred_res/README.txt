match 1: point 10-237 in train set (for TWO times, one for each player), point 238-294 in test set (for TWO times, one for each player).
match 2: point 10-158 in train set (for TWO times, one for each player), point 159-195 in test set (for TWO times, one for each player).
match 3: point 10-104 in train set (for TWO times, one for each player), point 105-128 in test set (for TWO times, one for each player).
match 4: point 10-267 in train set (for TWO times, one for each player), point 268-331 in test set (for TWO times, one for each player).
match 5: point 10-194 in train set (for TWO times, one for each player), point 195-240 in test set (for TWO times, one for each player).
match 6: point 10-263 in train set (for TWO times, one for each player), point 264-326 in test set (for TWO times, one for each player).
match 7: point 10-183 in train set (for TWO times, one for each player), point 184-226 in test set (for TWO times, one for each player).
match 8: point 10-149 in train set (for TWO times, one for each player), point 150-184 in test set (for TWO times, one for each player).
match 9: point 10-167 in train set (for TWO times, one for each player), point 168-207 in test set (for TWO times, one for each player).
match 10: point 10-251 in train set (for TWO times, one for each player), point 252-312 in test set (for TWO times, one for each player).
match 11: point 10-133 in train set (for TWO times, one for each player), point 134-164 in test set (for TWO times, one for each player).
match 12: point 10-217 in train set (for TWO times, one for each player), point 218-269 in test set (for TWO times, one for each player).
match 13: point 10-229 in train set (for TWO times, one for each player), point 230-284 in test set (for TWO times, one for each player).
match 14: point 10-145 in train set (for TWO times, one for each player), point 146-179 in test set (for TWO times, one for each player).
match 15: point 10-155 in train set (for TWO times, one for each player), point 156-192 in test set (for TWO times, one for each player).
match 16: point 10-131 in train set (for TWO times, one for each player), point 132-161 in test set (for TWO times, one for each player).
match 17: point 10-177 in train set (for TWO times, one for each player), point 178-219 in test set (for TWO times, one for each player).
match 18: point 10-216 in train set (for TWO times, one for each player), point 217-268 in test set (for TWO times, one for each player).
match 19: point 10-95 in train set (for TWO times, one for each player), point 96-116 in test set (for TWO times, one for each player).
match 20: point 10-226 in train set (for TWO times, one for each player), point 227-280 in test set (for TWO times, one for each player).
match 21: point 10-169 in train set (for TWO times, one for each player), point 170-209 in test set (for TWO times, one for each player).
match 22: point 10-153 in train set (for TWO times, one for each player), point 154-189 in test set (for TWO times, one for each player).
match 23: point 10-262 in train set (for TWO times, one for each player), point 263-325 in test set (for TWO times, one for each player).
match 24: point 10-214 in train set (for TWO times, one for each player), point 215-265 in test set (for TWO times, one for each player).
match 25: point 10-148 in train set (for TWO times, one for each player), point 149-183 in test set (for TWO times, one for each player).
match 26: point 10-223 in train set (for TWO times, one for each player), point 224-277 in test set (for TWO times, one for each player).
match 27: point 10-151 in train set (for TWO times, one for each player), point 152-187 in test set (for TWO times, one for each player).
match 28: point 10-171 in train set (for TWO times, one for each player), point 172-211 in test set (for TWO times, one for each player).
match 29: point 10-124 in train set (for TWO times, one for each player), point 125-153 in test set (for TWO times, one for each player).
match 30: point 10-159 in train set (for TWO times, one for each player), point 160-196 in test set (for TWO times, one for each player).
match 31: point 10-264 in train set (for TWO times, one for each player), point 265-328 in test set (for TWO times, one for each player).

in MATLAB,
ith match
time j=a:b
player p=1,2
momentum_5condition(match_index(i)-1+j,p)

to read csv in MATLAB
csv_cap(i) = 237-10+1,158-10+1,...
% index of train set
csv_match_index(i,1) = 1,2*csv_cap(i-1)+csv_match_index(i-1),...
% index of test set
csv_match_index(i,2) = csv_match_index(end,1)+2*csv_cap(end,1) , 

ith match
time j=a:b, for example=11:238
player p=1,2

train pred
pred_mom_con(csv_match_index(i)+(p-1)*csv_cap(i,1),:) is time at 11
pred_mom_con(csv_match_index(i)+csv_cap(i)-1+(p-1)*csv_cap(i,1),:) is time at 11+csv_cap(i,1)-1
pred_mom_con(csv_match_index(i)+j-11+(p-1)*csv_cap(i,1),:)

test pred
pred_mom_con(csv_match_index(i,2)+(p-1)*csv_cap(i,2),days) is time at 11+csv_cap(i,1)
pred_mom_con(csv_match_index(i,2)+csv_cap(i,2)-1+(p-1)*csv_cap(i,2),days) is time at 11+csv_cap(i,1)+csv_cap(i,2)-1
pred_mom_con(csv_match_index(i,2)+j-11-csv_cap(i,1)+(p-1)*csv_cap(i,2),days)