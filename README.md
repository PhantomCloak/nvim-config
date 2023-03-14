# nvim-config
My C#/C++ NVIM Workflow

### How To Setup Unity

1) Download omnisharp-roslyn from https://github.com/OmniSharp/omnisharp-roslyn/releases
2) Replace OmniSharp path from config.lua inside OmnisharpLspCfg class to freshly downloaded package
3) Add environment variable `export FrameworkPathOverride=/Library/Frameworks/Mono.framework/Versions/Current`
4) Open Unity -> Preferences -> External Tools and select visual studio code as text editor then tick all boxes below project file generation
5) Press regenerate project files voila! 
