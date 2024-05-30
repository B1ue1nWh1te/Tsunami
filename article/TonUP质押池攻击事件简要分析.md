今天刷资讯看到[TonUP](https://tonup.io/)项目被黑了，最近正好在了解[TON](https://ton.org/)生态，于是考虑简单分析一波。

[相关资讯 1](https://jinse.cn/lives/398221.html)

![1](https://img.seaeye.cn/img/tonup-event/1.png)

[相关资讯 2](https://x.com/TonUP_io/status/1793953653956772315)

![2](https://img.seaeye.cn/img/tonup-event/2.png)

---

被攻击的一个主要质押池合约：[EQAxN5aREN_WF-He1uKeQsalDxobF3kz2u-5U69x_RAzK3sQ](https://tonviewer.com/EQAxN5aREN_WF-He1uKeQsalDxobF3kz2u-5U69x_RAzK3sQ)

![3](https://img.seaeye.cn/img/tonup-event/3.png)

攻击者：[UQCqfGGPYqDhFC2-6FcAldnWwkKHcs_Ez9RoXvJF_in3y_ll](https://tonviewer.com/EQCqfGGPYqDhFC2-6FcAldnWwkKHcs_Ez9RoXvJF_in3y6Sg)

白帽救援者：[notcoin-scam.ton](https://tonviewer.com/EQC7QQ4yZGuNr-qJYOcg-w8hP7EdF29rok-d84fXTKRuUq0-)

1.攻击者向[[TonUP 功能合约-EQDPNq_v_rCljQzrueWeIxACBVgWlJr0qtXwaZSipMRIj7pQ]](https://tonviewer.com/EQDPNq_v_rCljQzrueWeIxACBVgWlJr0qtXwaZSipMRIj7pQ)发送`"I accept the ToS of TonUP. SHA256:8a5b220..37b75ca."`消息进行注册，这是一个惯例操作，用于表示同意服务条款以便使用网站服务。

2.攻击者尝试以发送消息的形式调用[[UP 质押池合约-EQAxN5aREN_WF-He1uKeQsalDxobF3kz2u-5U69x_RAzK3sQ]](https://tonviewer.com/EQAxN5aREN_WF-He1uKeQsalDxobF3kz2u-5U69x_RAzK3sQ)的`claim`函数，结果意外地接收到了当时质押池中已由其他用户存入的所有[[UP 代币-EQCvaf0JMrv6BOvPpAgee08uQM_uRpUd__fhA7Nm8twzvbE_]](https://tonviewer.com/EQCvaf0JMrv6BOvPpAgee08uQM_uRpUd__fhA7Nm8twzvbE_)。

由于质押池相关的合约均未开源，基于结果来猜测应该是某些参数配置错误导致了用户在`claim`的时候会获得质押池合约中的所有`UP`代币。这似乎是一个不需要什么技术分析的简单漏洞，任何人都可以通过发送同样的消息来简单地利用。

![4](https://img.seaeye.cn/img/tonup-event/4.png)

3.攻击者成功执行的`claim`交易整理如下：

[Transaction · 0f2b…2e43](https://tonviewer.com/transaction/0f2bb81f68ae5fe60cef790d82576232b1755c1d6b00897df27bd0bac60f2e43)

[Transaction · 0f07…cb3b](https://tonviewer.com/transaction/0f07ffe28d53e78bb67530904706fc70cced90b1434200856d4f08a06af2cb3b)

[Transaction · 6d16…fcf7](https://tonviewer.com/transaction/6d16d84f5da80b0b20d3885c91a1cb73ce72d597969bf7d75ca3ea8be39efcf7)

[Transaction · cc39…281f](https://tonviewer.com/transaction/cc3951134737958ff4ff9b01e4e00d9a4bc39051ed376dbf6536cf6ca166281f)

[Transaction · fddb…caac](https://tonviewer.com/transaction/fddb0ef6bd0df09ea5b092cd8d118804f205e9ee996864ac354582f755e9caac)

[Transaction · 2234…cffd](https://tonviewer.com/transaction/2234fde166693338ed5320429501faa6743f696a1235218cce4b61417d82cffd)

[Transaction · c5e0…16a6](https://tonviewer.com/transaction/c5e0e4a5233dee7bef24cb08587c7a6dfa1a35eddec37e43af43e4081d2716a6)

[Transaction · 85f9…062d](https://tonviewer.com/transaction/85f98f53412ae1927949b9bf7b954bad967d574d98482845769ca2ba1623062d)

[Transaction · d35c…7cb3](https://tonviewer.com/transaction/d35cb74c3f8d77c75ee7fd58ab5ed35b071e260fe2224989f0b2f48ba33d7cb3)

[Transaction · d79d…2cd9](https://tonviewer.com/transaction/d79d3604cc439b830a850b074fcd4c65e214433d1d3bec12d3bf2d39524b2cd9)

窃取`UP`代币数量合计为：`11169.68+20852.57+14677.88+25637.36+6311.49+50280.04+19720.52+50650.86+21700.89+8946.51=229947.8`

4.后续白帽黑客`notcoin-scam.ton`发现了这一攻击行为并尝试救援出质押池合约中剩余的`UP`代币，并在约一天时间后向项目方`tonup.ton`发送链上消息进行汇报沟通。

[Transaction · 51d7…992e](https://tonviewer.com/transaction/51d74ce9eda99b1339b84b2adab3d1e172014aaa3344656792646cc23df5992e)

![5](https://img.seaeye.cn/img/tonup-event/5.png)

[Transaction · 3618…d60e](https://tonviewer.com/transaction/3618fb0c356c65ff9bfd62adf3ea10a2ffc90355b15491dabea926111c80d60e):"Hey, TonUp team, please DM me. I discovered a bug that was using by wallet UQCqfGGPYqDhFC2-6FcAldnWwkKHcs_Ez9RoXvJF_in3y_ll and tried to save at least some funds"

[Transaction · a3be…1cff](https://tonviewer.com/transaction/a3bedb8ea88fc3d979e6d7d1cbfb62e8621c94a6c1af196fa4e35c6025b41cff):"Hello, this is Leo from the TonUP team. Thank you for contacting us. Could you please guide us on how to proceed? We are pleased to offer rewards in appreciation of your support."

[Transaction · 283a…2158](https://tonviewer.com/transaction/283a76c0d34b82e5858b1829473c747916caca8fd5377628d2fd592e347c2158):"Hello Leo! I apologize for the long response. Yes, I am ready to return the UP received, but there is one point. As soon as I saw that one of the wallets had found a vulnerability with the TONG pool, I had to act quickly and I withdrew some of my UP of their liquidity pool to STONfi. I then sent these UPs to the TONG pool and was able to collect some of the tokens. But then, in order not to lose tokens due to impermanent losses, I deposited UP back into the liquidity pool. You can look at my transaction history to see what I'm talking about. Now I am ready to return 35553.53 UP, and after completing the staking of UP (36610.13), which I contributed in order to save your funds, I will be able to return the missing part."

5.在此之前一段时间项目方向攻击者也尝试发送链上消息进行沟通，表示愿意提供 20%的金额作为赏金让其退还剩余的`UP`代币，但 48 小时的期限过后黑客似乎仍未退还被盗资产。

[Transaction · 27d6…69cf](https://tonviewer.com/transaction/27d6ae5d275f8efedbfeb3d453eebff8cfce28144b0767c95794402b2e7069cf):"Hello! You exploited a vulnerability in one of our smart contracts and unlawfully obtained a total of 229,947.8 UP in 10 transactions. Those funds belong to the users of the TonUP platform. You have 48 hours to return at least 183,958 UP to tonup.ton. If you act in good faith, we're willing to give you the remaining 20% UP as a bug bounty. Otherwise we will file a police report and try to recover the funds through legal actions."

6.值得注意的一点是，[[黑客钱包-UQCqfGGPYqDhFC2-6FcAldnWwkKHcs_Ez9RoXvJF_in3y_ll]](https://tonviewer.com/EQCqfGGPYqDhFC2-6FcAldnWwkKHcs_Ez9RoXvJF_in3y6Sg)的初始资金来自于`OKX 2`，且窃取金额被全部转入`Kucoin 1`中，可以据此来查找到黑客的真实身份，以追回被盗资金。

[Transaction · 97d3…4850](https://tonviewer.com/transaction/97d3c2597eb09e038015d189a6a236695ce56c29180c0dd5b18bcbef98024850)

[Transaction · f7a5…aaf7](https://tonviewer.com/transaction/f7a5a3f33b4de0773886cca07cec8c70e022996b0ca21e0bce00b74661fcaaf7)

---

此后项目方也是非常快速地关闭了质押池的`claim`功能并找到了一家审计公司[TonBit](https://x.com/tonbit_)来审计他们的[Tact](https://tact-lang.org/)合约（合约仓库未开源），并且在两天时间内得出了一个[审计报告](https://tonbit.xyz/reports/TonUP-Smart-Contract-Final-Audit-Report.pdf)，此事件告一段落。
