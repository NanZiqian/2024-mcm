import pandas as pd  
  
# 用于存储所有 Excel 文件的数据帧的列表  
all_data_frames = []  
  
# 替换下面的文件名列表为您的实际文件名  
excel_files = ['file1.xlsx', 'file2.xlsx', 'file3.xlsx']  
  
# 读取每个 Excel 文件并将其添加到数据帧列表中  
for file in excel_files:  
    data = pd.read_excel(file)  
    all_data_frames.append(data)  
  
# 将所有数据帧合并为一个数据帧  
merged_data = pd.concat(all_data_frames, ignore_index=True)  
  
# 将合并的数据帧保存到新的 Excel 文件中  
merged_data.to_excel('merged_file.xlsx', index=False)  