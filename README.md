# nvim-config
My C#/C++ NVIM Workflow

It works on MacOS probably on Linux too for Windows there is few path related configs to port

### How To Setup Unity

1) Download omnisharp-roslyn from https://github.com/OmniSharp/omnisharp-roslyn/releases
2) Replace OmniSharp path from config.lua inside OmnisharpLspCfg class to freshly downloaded package
3) Add environment variable `export FrameworkPathOverride=/Library/Frameworks/Mono.framework/Versions/Current`
4) Open Unity -> Preferences -> External Tools and select VsCode as text editor then tick all boxes below project file generation
5) Press regenerate project files voila! 

### How To Setup Debugger For Unity
1) Download VsCode then install Debugger For Unity extension
2) Check if extension is installed correctly by looking `~/.vscode/extensions/unity.unity-debug-x.x.x`
3) Done!
