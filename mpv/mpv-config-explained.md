# MPV 配置详解

本文档对 `portable_config/` 下所有配置文件进行逐项说明。

---

## 1. mpv.conf — 主配置文件

[mpv.conf](file:///home/alex/alexmak/dotfiles/mpv/portable_config/mpv.conf)

### 配置文件引入

```
include="~~/profiles.conf"
```
引入外部的 `profiles.conf`，将预设配置单独管理。

### 视频渲染

| 选项 | 值 | 说明 |
|---|---|---|
| `vo` | `gpu-next` | 使用 mpv 新一代 GPU 渲染后端，支持更多高级功能（HDR 色调映射等） |
| `gpu-api` | `d3d11` | 使用 Direct3D 11 图形 API（Windows 专用） |
| `vd-lavc-dr` | `yes` | 启用直接渲染，减少视频帧的内存拷贝，提升性能 |
| `gpu-context` | `auto` | 自动选择 GPU 上下文 |
| `hwdec-codecs` | `all` | 对所有编解码器启用硬件解码 |
| `hwdec` | `d3d11va-copy` | 使用 D3D11VA 硬件解码（copy-back 模式，兼容性更好） |
| `d3d11va-zero-copy` | `yes` | 允许零拷贝优化（减少 GPU→CPU 数据传输） |
| `d3d11-exclusive-fs` | `yes` | 全屏时使用 D3D11 独占全屏模式（降低延迟、减少撕裂） |
| `d3d11-adapter` | （空） | 不指定特定显卡适配器，使用默认 |

### 去色带 (Deband)

```
deband=no                  # 默认关闭去色带
deband-iterations=1        # 去色带迭代次数（数值越高效果越强，性能消耗越大）
deband-threshold=48        # 色带检测阈值
deband-range=16            # 色带检测范围（像素）
deband-grain=32            # 添加的随机噪点量，用于掩盖色带
```
默认关闭，但预设了参数以便通过快捷键 `Alt+D` 随时开启。

### 时间抖动

```
temporal-dither            # 启用时间性抖动，在帧间交替颜色以实现更平滑的色彩过渡
```

### 音频与字幕

**语言优先级：**
- 字幕语言 (`slang`)：英语优先
- 音频语言 (`alang`)：日语优先，英语其次（适合看日语原声动画/影视）

**字幕样式：**
使用 Nord 主题配色方案（`#eceff4` 浅灰白前景 + `#2e3440` 深蓝灰背景），字体为 **Clear Sans Bold**，缩放 0.7（较小），底部边距 60 像素，带轻微模糊和高斯效果。

**音频/字幕功能：**

| 选项 | 说明 |
|---|---|
| `sub-auto=all` | 自动加载同目录下所有匹配的字幕文件 |
| `volume-max=200` | 最大音量允许到 200%（2 倍增益） |
| `sub-fix-timing=yes` | 自动修复字幕时间轴 |
| `blend-subtitles=yes` | 将字幕混合渲染到视频帧中（对 HDR 内容更准确） |
| `sub-ass-override=yes` | 覆盖 ASS 字幕的内嵌样式 |
| `audio-file-auto=fuzzy` | 模糊匹配自动加载外部音轨 |
| `audio-pitch-correction=yes` | 变速播放时保持音调不变 |
| `audio-normalize-downmix=yes` | 下混音时归一化音量 |
| `audio-channels=7.1,5.1,stereo` | 声道优先级：7.1 > 5.1 > 立体声 |
| `demuxer-mkv-subtitle-preroll=yes` | MKV 字幕预加载（解决跳转后字幕不显示的问题） |
| `sub-file-paths=sub;subs;subtitles` | 字幕搜索目录 |

**音频滤镜（注释未启用）：**
文件中保留了多组音频归一化/动态压缩的滤镜配置供测试，包括 `dynaudnorm`、`loudnorm`、`speechnorm` 等。这些仅作备选方案记录。

### 功能设置

| 选项 | 说明 |
|---|---|
| `osc=no` | 关闭 mpv 内置 OSC（使用 uosc 替代） |
| `fs=yes` | 启动时全屏 |
| `snap-window` | 窗口拖动时吸附到屏幕边缘 |
| `keep-open=yes` | 播放结束不自动关闭，停留在最后一帧 |
| `save-position-on-quit=yes` | 退出时保存播放进度 |
| `watch-later-dir` | 播放进度缓存目录 |
| `gpu-shader-cache-dir` | GPU 着色器缓存目录（加速启动） |

### OSD 显示

| 选项 | 说明 |
|---|---|
| `no-border` | 隐藏窗口边框 |
| `osd-bar=no` | 关闭 OSD 进度条（由 uosc 接管） |
| `osd-bold=yes` | OSD 文字加粗 |
| `osd-font-size=37` | OSD 字号 |
| `osd-font=JetBrains Mono` | OSD 使用 JetBrains Mono 字体 |

---

## 2. input.conf — 按键绑定

[input.conf](file:///home/alex/alexmak/dotfiles/mpv/portable_config/input.conf)

### 鼠标与基本操作

| 按键 | 功能 |
|---|---|
| `鼠标左键 单击` | 暂停/继续，并闪烁暂停指示器 |
| `鼠标左键 长按` | 加速播放（evafast 脚本） |
| `鼠标左键 松开` | 恢复正常速度 |
| `鼠标右键` | 打开 uosc 右键菜单 |
| `TAB` | 切换 uosc UI 显示/隐藏 |

### 快捷键

| 按键 | 功能 |
|---|---|
| `;` | 上一个播放列表项 |
| `'` | 下一个播放列表项 |
| `Alt+D` | 切换去色带 |
| `Ctrl+D` | 自动反交错 |
| `Alt+B` | 自动下载字幕 |
| `Alt+A` | 打开"Open"子菜单 |
| `Alt+Z` | 打开"Audio"子菜单 |
| `Alt+X` | 打开"Subtitles"子菜单 |
| `Alt+S` | 打开"Shaders"子菜单 |
| `b` | 打开文件浏览器 |
| `h` | 最近播放历史（memo 脚本） |
| `g` | 切换运动插帧 |
| `Alt+V` | 切换去块效应滤镜 |
| `n` | 切换 NLMeans 降噪着色器 |
| `c` | 清除所有着色器 |
| `F1` | 切换对话增强音频滤镜（loudnorm） |
| `y` | 加载字幕文件 |
| `Y` | 选择字幕轨道 |
| `Alt+J / Alt+K` | 字幕放大/缩小 |
| `z / x` | 字幕延迟 -0.1s / +0.1s |
| `/` | 打开控制台 |
| `a` | 最小化窗口 |
| `q` | 保存进度并退出 |

### 着色器预设快捷键 (Ctrl+数字)

| 按键 | 预设 | 适用场景 |
|---|---|---|
| `Ctrl+1` | FSRCNNX | 高清真人影视 |
| `Ctrl+2` | FSRCNNX+ | 标清真人影视 |
| `Ctrl+3` | Ravu-Zoom | 通用场景 |
| `Ctrl+4` | Ani4K | 通用动画 |
| `Ctrl+5` | AniSD | 标清动画 |
| `Ctrl+6` | Anime4K | 通用动画 |
| `Ctrl+7` | NNEDI3 | 通用场景 |
| `Ctrl+8` | NNEDI3+ | 通用场景 |

### 右键菜单结构

通过 `#!` 注释语法定义了 uosc 右键菜单的层级结构：
- **Open** — 播放列表、章节、文件浏览、最近播放
- **Video** — 视频轨道、插帧、滤镜、着色器（降噪/锐化/超分辨率）、预设
- **Audio** — 对话增强、清除滤镜、音轨选择、归一化
- **Subtitles** — 加载/选择/大小调整/延迟
- **Tools** — 控制台、配置目录

---

## 3. profiles.conf — 着色器预设与条件配置

[profiles.conf](file:///home/alex/alexmak/dotfiles/mpv/portable_config/profiles.conf)

### 去色带预设

| 预设 | 迭代次数 | 阈值 | 范围 | 噪点 |
|---|---|---|---|---|
| **Deband-Medium** | 2 | 64 | 16 | 24 |
| **Deband-Strong** | 3 | 64 | 16 | 24 |

### 超分辨率/画质增强预设

| 预设 | 着色器组合 | 适用场景 |
|---|---|---|
| **NNEDI3** | nnedi3 (nns32) + AdaptiveSharpen | 通用 |
| **NNEDI3+** | nnedi3 (nns64) + AdaptiveSharpen | 通用（更高质量） |
| **Ravu-Zoom** | RAVU Zoom AR R3 + AdaptiveSharpen | 通用 |
| **FSRCNNX** | FSRCNNX 8 + AdaptiveSharpen | 高清真人影视 |
| **FSRCNNX+** | nnedi3 (nns32) + FSRCNNX 16 | 标清真人影视（二级放大） |
| **Ani4K** | Ani4Kv2 ArtCNN | 通用动画 |
| **AniSD** | AniSD ArtCNN | 标清动画 |
| **Anime4K** | KrigBilateral + A4K Restore + A4K Clamp Highlights | 通用动画 |

### 条件自动触发预设

**HDR 直通：**
- 触发条件：视频为 BT.2020 + PQ 色彩空间，且显示器分辨率为 2560×1440
- 行为：启用 PQ 色调映射、10-bit 抖动、目标峰值亮度 1156 nit、HDR 峰值计算、D3D11 PQ 输出、rgb10_a2 输出格式
- 这是为特定 HDR 显示器量身定制的配置

**SDR→HDR（注释未启用）：** 反向色调映射，将 SDR 内容转换为 HDR 输出。

**HDR→SDR（注释未启用）：** 针对 1920×1080 SDR 显示器的 HDR 内容色调映射。

**4K 降采样：**
- 触发条件：视频分辨率 ≥ 3840×2160
- 行为：清除其他着色器，使用 SSimSuperRes + SSimDownscaler 进行高质量降采样，关闭线性降采样

**5.1 声道下混：**
- 触发条件：音频声道数 ≥ 5 且 < 7
- 行为：对 LFE 低通滤波 120Hz，整体增益 1.6 倍，自定义矩阵混合为立体声（中置声道 50%、前置/后置 70.7%、LFE 50%）

**7.1 声道下混：**
- 触发条件：音频声道数 ≥ 7
- 行为：类似 5.1 但增加了侧环绕和前宽声道的混合矩阵

---

## 4. 脚本配置 (script-opts/)

### uosc.conf — 现代化 UI 界面

[uosc.conf](file:///home/alex/alexmak/dotfiles/mpv/portable_config/script-opts/uosc.conf)

**时间轴：** 条形显示风格，高度 25px，暂停时始终显示，步进 5 秒，启用缓存指示器和 YouTube 热力图。

**进度条：** 窗口模式下显示迷你进度条（2px 高、20px 线宽）。

**控制栏：** 高度 37px，包含菜单、打开文件、历史记录（仅空闲时）、统计信息、流品质、视频/音频/字幕轨道选择、章节、速度滑块、播放列表导航等控件。

**音量：** 右侧显示，高度 39px，步进 1。

**速度调节：** 步进 0.05，非乘法模式。

**菜单：** 行高 35px，最小宽度 290px，支持输入搜索。

**顶栏：** 无边框模式下显示，控制按钮在右侧，标题可在主标题和文件名之间点击切换。

**视觉风格：**
- 使用 **Nord 主题**配色（前景 `#eceff4`，背景 `#2e3440`，成功 `#a3be8c`，错误 `#bf616a`，匹配 `#88c0d0`）
- 圆角半径 2px，字体缩放 1.18，加粗字体
- 动画时长 100ms，闪烁时长 1000ms
- 多项透明度自定义（时间轴 0.8、菜单 0.84、幕布 0.2 等）

**章节范围标记：** 自动识别并着色显示片头/片尾、广告等章节段落。

**支持的文件类型：** 预定义了视频、音频、图片、字幕、播放列表的扩展名列表。

### memo.conf — 播放历史记录

[memo.conf](file:///home/alex/alexmak/dotfiles/mpv/portable_config/script-opts/memo.conf)

- 历史记录保存至 `memo-history.log` 文件
- 菜单显示最近 10 条记录
- 支持分页、去重、隐藏已删除文件
- 显示标题（截断至 60 字符）

### thumbfast.conf — 时间轴缩略图

[thumbfast.conf](file:///home/alex/alexmak/dotfiles/mpv/portable_config/script-opts/thumbfast.conf)

- 缩略图最大尺寸 200×200 像素
- 关闭色调映射和硬件解码（兼容性考虑）
- 文件加载时立即生成缩略图
- 支持网络播放，不支持纯音频
- Windows 下使用原生 API 写入管道

### evafast.conf — 长按加速播放

[evafast.conf](file:///home/alex/alexmak/dotfiles/mpv/portable_config/script-opts/evafast.conf)

- 按下时先跳转 5 秒，然后逐步加速
- 速度以 0.1 步长递增/递减，间隔 0.05 秒
- 最大加速 2 倍，有字幕时限制为 1.7 倍（避免看不清字幕）
- OSD 上显示当前速度

### console.conf — 内置控制台

[console.conf](file:///home/alex/alexmak/dotfiles/mpv/portable_config/script-opts/console.conf)

- 字体：JetBrains Mono，大小 15

---

## 5. fonts.conf — 字体配置

[fonts.conf](file:///home/alex/alexmak/dotfiles/mpv/portable_config/fonts.conf)

标准 fontconfig 配置文件，主要功能：
- 指定 Windows 系统字体目录和 XDG 字体目录
- 将 `mono`→`monospace`、`sans serif`→`sans-serif`、`sans`→`sans-serif`、`system ui`→`system-ui` 等旧名称映射为标准名称
- 字体缓存目录和 30 秒重新扫描间隔

---

## 6. 已安装脚本汇总

| 脚本 | 功能 |
|---|---|
| **uosc** | 替代 mpv 原生 OSC 的现代化界面（菜单、控制栏、时间轴等） |
| **thumbfast** | 时间轴缩略图预览 |
| **evafast** | 长按鼠标左键加速播放 |
| **memo** | 播放历史记录 |
| **autoload** | 自动加载同目录下的其他媒体文件到播放列表 |
| **autodeint** | 自动检测并反交错 |

---

## 总结

这是一套**面向 Windows 平台**的高度定制 mpv 配置，核心特点：

1. **画质优先**：配备大量超分辨率着色器（NNEDI3/FSRCNNX/RAVU/Anime4K/ArtCNN），通过 `Ctrl+数字` 快捷键一键切换
2. **HDR 支持**：针对 2560×1440 HDR 显示器的 PQ 直通配置
3. **动画优化**：日语音轨优先 + 多套动画专用着色器预设
4. **智能下混**：5.1/7.1 环绕声自动下混为立体声，带 LFE 低通和增益补偿
5. **Nord 主题**：全局统一的 Nord 配色方案（字幕样式、uosc UI）
6. **便捷操作**：长按加速、右键菜单、播放历史、自动加载等
