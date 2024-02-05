import matplotlib.pyplot as plt
import numpy as np

# data for rublev
data1 = [0.056516724, 0.003460208, 0.025374856, 0.535178777, 0.051903114, 0.109573241, 0.018454441, 0.064590542, 0.031141869, 0.061130334, 0.006920415, 0.035755479]

# data for sinner
temp = sum([0.079229122, 0.012847966, 0.016059957, 0.154432548, 0.160599572, 0.168094218, 0.100642398, 0.02248394, 0.085653105, 0.003211991, 0.020342612, 0.03640257])
data2 =[]
list = [0.079229122, 0.012847966, 0.016059957, 0.154432548, 0.160599572, 0.168094218, 0.100642398, 0.02248394, 0.085653105, 0.003211991, 0.020342612, 0.03640257]
for i in list:
    data2.append(i/temp)

# data for alcaraz
data3 = [0.024590164, 0.06557377, 0.018442623, 0.485655738, 0.071721311, 0.079918033, 0.081967213, 0.043032787, 0.081967213, 0.020491803, 0.006147541, 0.020491803]

features = ['feature{}'.format(i) for i in range(1, len(data1) + 1)]
real_names = ['ace_', 'double_fault_', 'first_serve_', 'fast_win_', 'return_depth_', 'winner_', 'net_pt_won_', 'distance', 'unf_err_', 'rally_', 'break_point_diff', 'speed_mph']

# 设置子图的行数和列数
rows = 1
cols = 3

# 设置整体图形大小
fig, axes = plt.subplots(rows, cols, figsize=(15, 5))

# 循环遍历每个子图
for i, ax in enumerate(axes):
    # 选择不同的数据
    if i == 0:
        current_data = data1
        title = 'Rublev'
    elif i == 1:
        current_data = data2
        title = 'Sinner'
    elif i == 2:
        current_data = data3
        title = 'Alcaraz'

    # 将数据、特征和真实名字进行降序排列
    sorted_data, sorted_features, sorted_real_names = zip(*sorted(zip(current_data, features, real_names), key=lambda x: x[0], reverse=True))

    # 生成渐变色
    colors = plt.cm.Blues(np.linspace(0.5, 1, len(current_data)))

    # 创建横向条形图，并指定颜色
    bars = ax.barh(range(len(current_data)), sorted_data, color=colors)

    # 添加特征标签和标题
    ax.set_yticks(range(len(current_data)))
    ax.set_yticklabels(sorted_features)
    ax.set_xlabel('')
    ax.set_ylabel('')
    ax.set_title(title)

    # 在每个条形图右侧添加真实名字
    for bar, real_name in zip(bars, sorted_real_names):
        ax.text(bar.get_width(), bar.get_y() + bar.get_height() / 2, real_name, ha='left', va='center')

# 调整子图之间的距离
plt.tight_layout()

# 显示图形
plt.show()
