# nvim-config
My C#/C++ NVIM Workflow

It works on MacOS probably on Linux too for Windows there is few path related configs to port

### How To Setup Unity and .Net Core LSP

1) Download omnisharp-roslyn from https://github.com/OmniSharp/omnisharp-roslyn/releases
2) Replace OmniSharp path from config.lua inside OmnisharpLspCfg class to freshly downloaded package
3) Add environment variable `export FrameworkPathOverride=/Library/Frameworks/Mono.framework/Versions/Current`
4) Open Unity -> Preferences -> External Tools and select VsCode as text editor then tick all boxes below project file generation
5) Press regenerate project files voila! 

### How To Setup Debugger For Unity
1) Download VsCode then install Debugger For Unity extension
2) Check if extension is installed correctly by looking `~/.vscode/extensions/unity.unity-debug-x.x.x`
3) Done!


### Dependencies 
1) [MonoMDK](https://formulae.brew.sh/cask/mono-mdk)
2) [.NET Core 6](https://dotnet.microsoft.com/en-us/download/dotnet/6.0) - for OmniSharp
3) [OmniSharp](https://github.com/OmniSharp/omnisharp-roslyn) - mentioned in first step of setting up unity
4) [Packer](https://github.com/wbthomason/packer.nvim)
5) Opt: [Ripgrep](https://github.com/BurntSushi/ripgrep) - for file/text search
6) Opt: [Bat](https://github.com/sharkdp/bat) - for colorfull output in Ripgrep
7) Opt: [Fzf](https://github.com/junegunn/fzf) -  for formatting Ripgrep since it's usually installed automatically I write it down in case of missing install
8) Opt: [netcoredbg](https://github.com/Samsung/netcoredbg] - for .NET Core debugging

### Things to consider

1 - Since dotnet and mono have to use different debuggers you only have debugger on unity side I didn't address the issue but it's pretty trivial to some scripting

2 - Code completion should work with .NET Core and Unity seemlessly
