# 基于QuartusII 13的多功能电子钟项目设计

 基于QuartusII 13的多功能电子钟 | 江苏大学《数字逻辑电路设计》2024秋课程设计


##  **课程设计内容**

1、**基础计时功能：**

能进行正常的时、分、秒计时，分别用6个七段数码管动态扫描显示时、分、秒。

2、**快速调时功能：**

利用开关快速调整时间：时、分。

3、**闹钟功能：**

通过开关设定闹铃时间，到了设定时间发出闹铃提示音，提示音长度为1分钟。

4、**倒计时功能：**

通过按键开关设定倒计时的时间，通过开关启动/暂停倒计时，倒计时为0时发出提示音。

5、**整点报时功能：**

在59分50、52、54、56、58秒时按500Hz频率报时，在59分50、52、54、56、58秒时按500Hz频率报时。

##  **实验方案分析与设计**

对于系统的实现，首先需要从整体的角度完成方案设计。为此，我先将系统划分为三个层次，分别为输入层、处理层以及输出层。其中，输入层用以识别用户的输入信号并向处理层输入不同的指令；处理层根据接收到的输入指令，执行相应的处理命令，并将其转化为可输出信号传递给输出层；输出层最终获取可输出信号，向用户输出信息，完成预期的任务。据此，需要在输出层中进行进一步设计，以完成预定的目标功能，并且要在各层之间做好数据的转换，以实现不同类型信号的信息传递。最终先设计出总体框图，如图1所示。

![](https://github.com/Hamilton-Liu/A-VHDL-Digital-Clock/blob/main/IMAGE/%E9%A1%B6%E5%B1%82%E8%AE%BE%E8%AE%A1.drawio.png)

图1 多功能电子钟的总体框图

根据总体框图，进行进一步的细化设计，完成每一步的具体实现，在此基础上得到顶层设计原理图，如图2所示。

![](https://github.com/Hamilton-Liu/A-VHDL-Digital-Clock/blob/main/IMAGE/%E5%9B%BE%E7%89%872.png)

图2 多功能电子钟的顶层原理图

##  **具体实现过程描述**

**模块1：标准计时模块**

通过串联2个双向60进制计数器（cnt60s）和一个双向24进制计数器（cnt24s）可以实现标准计数功能。1Hz标准时钟信号由1kHz脉冲信号经1/1kHz分频器（divier11k）处理给出。下面给出源代码。


**模块** **2**  **：** **快速校时模块**

通过在秒分、分时计数器之间串联途中加入2选1选择器（mux21），来控制接受的时钟信号。默认情况下，接收到的信号为上一级计数器传来的进位信号，即秒计数器接收标准时钟信号的系统；如果处理层收到校时信号，则停止接受标准信号，并根据相应的调时/调分信号，向对应计数器的时钟信号源输入5Hz的快速校准信号。这一信号处理过程可以利用一个校时控制器（time_set）来完成，并通过一个1/200Hz分频器（divider1200）来获得5Hz快速校准信号。下面给出源代码。

**模块** **3**  **：** **闹钟模块**

可以给闹钟模块单设一个类似标准计时模块的计时器模块，以此隔离两个计时系统，分别行使各自功能。不同的是，闹钟模块不接受标准时钟信号，只接受5Hz快速校准信号，以此来进行时间的设定。为此，同样需要一个校时控制器。至此，闹钟设定功能基本已经完善，接下来要实现的是闹钟到时间的判断功能。可以利用一个闹钟判断器（alarm）通过获取闹钟计时和标准计时模块的时、分输出信号，并进行比对，来实现闹钟的到时判断，并输出蜂鸣信号。蜂鸣器可以通过在一个二选一选择器的一段接0，另一端接1kHz时钟信号来调用，把闹钟判断器输出的蜂鸣信号作为选择器的选择端输入。此外，给判断器的蜂鸣信号前加上一个与门，可以实现闹钟启/停用的功能。的下面给出源代码。


**模块** **4**  **：** **倒计时模块**

综合考量多个因素，我决定将倒计时模块和闹钟模块设于同一个计时模块中。一是为了提高元件复用率，提升系统效率；二是因为闹钟只有调时间的信号输入，而倒计时只在此基础上添加了一个开始/暂停倒计时的功能，两者存在相当高的重合度，方便进行拓展。根据上文，可以直接接受开始倒计时信号输入，而无需与闹钟的信号输入隔绝开。因此，可以参照标准计时模块，利用2选1选择器来对闹钟/倒计时计时模块的时钟信号输入进行控制。当控制端接收信号为1，将time_set校时控制器的信号输入通路转换为1Hz标准时钟信号，并且给三个双向计数器的反向计数设定端置入高电平信号，则开始倒计时。通过一个倒计时检测模块（anticnt）来判断是否倒数到0，并输出蜂鸣信号。为了倒计时永久循环，为倒计时检测模块增加一个isCnt的输出端，当闹钟/倒计时计时模块时间为0时输出0，并通过一个与门与倒计时开关连接，保证必须在倒计时未结束且开关开启状态才会开始倒计时。下面给出源代码。


**模块** **5**  **：** **整点报时模块**

通过设计一个整点报时检测器（baoshi）来实现对整点的监控，当接收到为二进制59的时信号，并且秒信号为50~58中的偶数时，激活speak500输出，选通500Hz高频信号，让蜂鸣器发声；当秒信号为60，激活speak1000，选通1000Hz高频信号，让蜂鸣器发声。其中涉及的分频器原理大致与上文相同，故省略展示。下面给出源代码。



**模块** **6**  **：** **显示模块**

最终需要两个动态扫描器（dtsm）分别对标准计时模块和闹钟/倒计时计时模块的二进制信号进行译码，并以高频扫描的方式显示到8位7段数码管上去。这两个动态扫描器可以视作输出信号的直接来源。通过一个7路2选1选择器（mux21_7）来控制显示器最后接受的动态扫描信号源，可以使显示内容在标准计时和闹钟/倒计时之间互相切换，且不破坏到内部逻辑。下面给出源代码。

##  **实现效果**

通过将以上具体涉及的模块按照总体框图进行设计，最终可以按照预期实现所有设定的目标功能，包括标准计时、快速校时、闹钟、倒计时、整点报时。且各功能模块之间冲突较少，系统仍具有良好的可拓展性，可以留待增加新的功能。系统也存在一些设计缺陷，由于课设时间有限，不能一一完善，在这里给出修改设计方案：
1. 开关控制的快速校时存在较大抖动，开启或关闭瞬间都可能产生不正常的脉冲，导致调时的不稳定。为此，拟引入防抖模块来消除或减轻开关硬件自身带来的竞争或险象；
2. 倒计时功能启动时仍可开启校时开关，操作校时模块，导致闹钟/倒计时模块的时钟信号发生竞争。为此，拟将倒计时控制器上移一个优先级，在倒计时过程中禁止校时，以避免竞争；
3. 顶层原理图连接混乱，由于在最初设计时缺少规划，几乎是想到什么连接什么，顶层设计图较为混乱，可读性较低。为此，拟根据总体框图重新连接相关元件，构成相应模块，增强其可读性和清晰性。

##  **项目参考**
[1] 鲍可进、赵念强、赵不贿.数字逻辑电路设计（第4版）.北京：清华大学出版社，2022.\
[2] CNBlog 作者 漫舞八月（Mount256）https://www.cnblogs.com/Mount256/p/15628625.html#52-心得体会 \
[3] Github项目 VHDL_digital_clock
作者Luxiyu https://github.com/Luxiyu/VHDL_digital_clock
