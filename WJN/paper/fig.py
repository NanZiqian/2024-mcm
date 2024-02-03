import matplotlib.pyplot as plt
from matplotlib.lines import Line2D

# 第一组数据
data1 = {
    'ace': 0.0198991509121888,
    'net_win_rate': 0.0187773323271644,
    'fast_win': 0.0771698779277567,
    'first_serve': 0.0461077886989741,
    'score_diff': 0.378306878306878,
    'scored_last_point': 0.0756613756613757,
    'winner': 0.0435435246185526,
    'double_fault': 0.0198991509121888,
    'unforced_error': 0.0801587301587302,
    'distance': 0.240476190476191
}

# 第二组数据
data2 = {
    'net_win_rate': 0.0179308614091223,
    'score_diff': 0.5,
    'scored_last_point': 0.1,
    'winner': 0.0606687997992346,
    'receiving': 0.121400338791643,
    'unforced_error': 0.05,
    'distance': 0.15
}

# 提取数据和标签
labels1 = list(data1.keys())
values1 = list(data1.values())

labels2 = list(data2.keys())
values2 = list(data2.values())

# 颜色列表，蓝色系和黄色系
colors_blue = ['steelblue', 'mediumblue', 'dodgerblue', 'deepskyblue', 'skyblue', 'lightsteelblue', 'powderblue', 'lightskyblue', 'aliceblue', 'azure']
colors_orange = ['darkorange', 'orange', 'gold', 'darkgoldenrod', 'tan', 'navajowhite', 'wheat']

# 创建画布并调整间距
fig, axes = plt.subplots(nrows=1, ncols=2, figsize=(14, 6))  # 调整画布宽度
plt.subplots_adjust(wspace=0.4)  # 调整子图间距

# 绘制第一个饼状图（蓝色系）
wedges1, texts1, autotexts1 = axes[0].pie(values1, labels=None, autopct='%.2f%%', startangle=140, colors=colors_blue, wedgeprops=dict(width=0.3))
axes[0].set_title('Group 1')

# 绘制第二个饼状图（黄色系）
wedges2, texts2, autotexts2 = axes[1].pie(values2, labels=None, autopct='%.2f%%', startangle=140, colors=colors_orange, wedgeprops=dict(width=0.3))
axes[1].set_title('Group 2')

# 添加图例
legend_labels1 = labels1
legend_labels2 = labels2
legend_handles1 = [Line2D([0], [0], marker='o', color='w', markerfacecolor=color, markersize=10) for color in colors_blue]
legend_handles2 = [Line2D([0], [0], marker='o', color='w', markerfacecolor=color, markersize=10) for color in colors_orange]

# 合并图例
combined_legend_labels = legend_labels1 + legend_labels2
combined_legend_handles = legend_handles1 + legend_handles2

# 添加图例到左边的图
legend1 = axes[0].legend(combined_legend_handles, combined_legend_labels, title="Items", loc="center left", bbox_to_anchor=(1, 0.5))

# 添加图例到右边的图
legend2 = axes[1].legend([], [], title="Items", loc="center left", bbox_to_anchor=(1.02, 0.5), borderaxespad=0.)  # 不显示右边的图例

# 调整图例大小
for lh in legend1.legendHandles:
    lh._sizes = [10]

# 添加整体标题
plt.suptitle('Comparison of Two Groups')

# 显示图形
plt.show()
