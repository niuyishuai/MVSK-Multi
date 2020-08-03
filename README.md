# MVSK-Multi
MVSK多目标资产组合优化建模和求解

## 安装
在MATLAB中执行脚本 `setup.m`或者把所有子目录加入MATLAB的PATH中。

## 案例
请参考tests目录下的两个案例 `drawcurve.m` 和 `drawdiffepsfig.m`

## 并行计算
`paretoopt`函数是帕累托优化求解器, 可以同时并行求解多个多目标资产组合规划问题，调用格式为:
```matlab-code
paretoopt(loop,idxN,muoverline,method,activateparal)
```
其中最后一个参数`activateparal`设置是否使用MATLAB并行计算。设置为true为使用并行计算, false为不适用并行计算。

