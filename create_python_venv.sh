#!/bin/bash
#source create_python_venv
# set venv目錄
venv_dir="myvenv1"
venv_path=$(pwd)/$venv_dir

# check虛擬環境是否存在
if [ -d "$venv_path" ]; then
    echo "$venv_dir 已存在."
else
    read -p "Type which version you want: " version
    echo "在$venv_dir建立虛擬環境文件夾 ..."
    python$version -m venv $venv_dir
    echo "Done!."
fi

# run虛擬環境的函數
source $venv_path/bin/activate
echo "虛擬環境: $(which python)"
