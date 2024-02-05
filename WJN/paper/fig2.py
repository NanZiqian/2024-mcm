import matplotlib.pyplot as plt
import numpy as np

data = [0.016483278,0.036621921,0.005728187,0.382429422,0.13833293,0.073740326,0.026257812,0.049499482,0.014267717,0.024669062,0.115134702,0.116835161]
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
