# flatrun

[English 🇬🇧](README.md)

[简体中文 🇨🇳](README_CHN.md)

[Español 🌎](README_SPN.md)

[日本語 💔](README_JPN.md)

不需要知道完整 App ID 就能运行 Flatpak 应用的脚本

一个在我心碎时为缓解悲伤，消磨时间而做出的脚本，极其简易，它用来包装 flatpak 应用，让用户直接输入应用名称即可运行，不需要输入完整的 id。


## 用法
```shell
用法: flatrun [选项] 应用程序名称 [ -- ]
通过匹配名称或 ID 来运行 Flatpak 应用程序。

选项:
  -c    精准匹配（区分大小写且禁用智能过滤）。
  -v    显示此工具版本。
  -h    显示此帮助信息。
例子:
  flatrun steam              # 通过智能匹配启动 Steam。
  flatrun -c Steam           # 精准匹配，可能出现选单。
  flatrun vlc -- --version   # 将 --version 子命令传递至 vlc。

```

## 安装

### Nix Flake:

你可以直接使用 `nix run` 运行此工具:

```bash
nix run github:yisuidenghua/flatrun
```

也可以将其加入系统配置文件:

```
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flatrun = {
      url = "github:yisuidenghua/flatrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
```

软件的名字可以写成 `inputs.flatrun.packages.${pkgs.stdenv.hostPlatform.system}.default` ，你可以将它添加到 `environment.systemPackages`，也可以在 Home Manager 中以 `users.users.<username>.packages`, 或 `home.packages` 的形式添加，也可以添加到 devshell 中.



### 其他方式:

***Comming s∞n...***





##### 一点碎碎念><...

偏离了菩提正道，一念之间堕入修罗。

从前那般温柔，如今却只剩自我折磨。
