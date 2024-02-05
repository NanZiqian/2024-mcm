import matplotlib.pyplot as plt
import numpy as np

# data for rublev
data1 = [0.056516724, 0.003460208, 0.025374856, 0.535178777, 0.051903114, 0.109573241, 0.018454441, 0.064590542, 0.031141869, 0.061130334, 0.006920415, 0.035755479]

# data for sinner
temp = sum([0.079229122, 0.012847966, 0.016059957, 0.154432548, 0.160599572, 0.168094218, 0.100642398, 0.02248394, 0.085653105, 0.003211991, 0.020342612, 0.03640257])
data2 = [i / temp for i in [0.079229122, 0.012847966, 0.016059957, 0.154432548, 0.160599572, 0.168094218, 0.100642398, 0.02248394, 0.085653105, 0.003211991, 0.020342612, 0.03640257]]

# data for alcaraz
data3 = [0.024590164, 0.06557377, 0.018442623, 0.485655738, 0.071721311, 0.079918033, 0.081967213, 0.043032787, 0.081967213, 0.020491803, 0.006147541, 0.020491803]

# 数据标签
labels = ['ace_', 'double_fault_', 'first_serve_', 'fast_win_', 'return_depth_', 'winner_', 'net_pt_won_', 'distance', 'unf_err_', 'rally_', 'break_point_diff', 'speed_mph']

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

    # 创建饼状图
    ax.pie(current_data, labels=None, autopct='', startangle=90, colors=plt.cm.Blues(np.linspace(0, 1, len(current_data))))

    # 添加标题
    ax.set_title(title)

# 添加整体图标题
plt.suptitle('Player Feature Analysis', fontsize=16)

# 添加图例
plt.legend(labels, loc='center left', bbox_to_anchor=(1, 0.5))

# 调整子图之间的距离
plt.tight_layout()

# 显示图形
plt.show()
