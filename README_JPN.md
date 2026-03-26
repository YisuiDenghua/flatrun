# flatrun

[English 🇬🇧](README.md)

[简体中文 🇨🇳](README_CHN.md)

[Español 🌎](README_SPN.md)

[日本語 💔](README_JPN.md)

完全な App ID を知らなくても Flatpak アプリを実行できるスクリプト

心が砕けた悲しみを紛らわせ、時間を潰すために作成した非常にシンプルなスクリプトです。Flatpak アプリをラップすることで、ユーザーは完全な ID を入力することなく、アプリ名を直接入力するだけで実行できるようになります。


## 使い方
```shell
使い方: flatrun [オプション] アプリケーション名 [ -- ]
名前またはIDを一致させてFlatpakアプリケーションを実行します。

オプション:
  -c    厳密な一致（大文字小文字を区別し、スマートフィルタリングを無効化）。
  -v    このツールのバージョンを表示。
  -h    このヘルプ情報を表示。

例:
  flatrun steam              # スマートマッチでSteamを起動。
  flatrun -c Steam           # 厳密な一致、選択メニューが表示される場合があります。
  flatrun vlc -- --version   # --versionサブコマンドをvlcに渡す。

```

## インストール

### Nix Flake:

`nix run` を使用して直接このツールを実行できます:

```bash
nix run github:yisuidenghua/flatrun
```

システム設定ファイルに追加することも可能です:

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

このパッケージは `inputs.flatrun.packages.${pkgs.stdenv.hostPlatform.system}.default` として提供されており、`environment.systemPackages` 、`users.users.<ユーザー名>.packages` 、Home Manager を使用する場合は `home.packages` 、または devshell に追加できます。


### その他の方法:

*近日公開予定 s∞n...*




##### ちょっとしたつぶやき><...

菩提を離れ、一念のままに阿修罗へ堕ちた。

昔は優しかったのに、今は自らを責めるばかり
