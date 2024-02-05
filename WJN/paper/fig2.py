import matplotlib.pyplot as plt
import numpy as np

# temp = sum([0.021650982,0.004823531,0.034888239,0.203960026,0.027150315,0.07847742,0.075250469,0.012113737,0.116415212,0.035885046,0.055120039,0.044264982])
# data = []
# list = [0.021650982,0.004823531,0.034888239,0.203960026,0.027150315,0.07847742,0.075250469,0.012113737,0.116415212,0.035885046,0.055120039,0.044264982]
# for i in list:
#     data.append(i/temp)

#total data
data = [0.000257568,0.010045136,0.022064956,0.702031104,0.021598881,0.073455821,0.010682922,0.053770299,0.021071481,0.030527891,0.024199087,0.030294854]

#data for rublev
data1 = [0.056516724,0.003460208,0.025374856,0.535178777,0.051903114,0.109573241,0.018454441,0.064590542,0.031141869,0.061130334,0.006920415,0.035755479]

#data for sinner
data2 = [0.079229122,0.012847966,0.016059957,0.294432548,0.160599572,0.168094218,0.100642398,0.02248394,0.085653105,0.003211991,0.020342612,0.03640257]

#data for alcaraz
data3 = [0.024590164,0.06557377	,0.018442623,0.485655738,0.071721311,0.079918033,0.081967213,0.043032787,0.081967213,0.020491803,0.006147541,0.020491803]

features = ['feature{}'.format(i) for i in range(1, len(data) + 1)]
real_names = ['ace_', 'double_fault_', 'first_serve_', 'fast_win_', 'return_depth_', 'winner_', 'net_pt_won_', 'distance', 'unf_err_', 'rally_', 'break_point_diff', 'speed_mph']

# 将数据、特征和真实名字进行降序排列
sorted_data, sorted_features, sorted_real_names = zip(*sorted(zip(data, features, real_names), key=lambda x: x[0], reverse=True))

# 生成渐变色
colors = plt.cm.Blues(np.linspace(0.5, 1, len(data)))

# 设置图形大小
plt.figure(figsize=(10, 6))

# 创建横向条形图，并指定颜色
bars = plt.barh(range(len(data)), sorted_data, color=colors)

# 添加特征标签和标题
plt.yticks(range(len(data)), sorted_features)
plt.xlabel('')
plt.ylabel('')
plt.title('')

# 在每个条形图右侧添加真实名字
for bar, real_name in zip(bars, sorted_real_names):
    plt.text(bar.get_width(), bar.get_y() + bar.get_height() / 2, real_name, ha='left', va='center')

# 显示图形
plt.show()
