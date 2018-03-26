FROM microsoft/dotnet:2.0-sdk

RUN Invoke-WebRequest 'https://github.com/git-for-windows/git/releases/download/v2.16.3.windows.1/MinGit-2.16.3-64-bit.zip' -OutFile MinGit.zip

RUN Expand-Archive c:\MinGit.zip -DestinationPath c:\MinGit; \
$env:PATH = $env:PATH + ';C:\MinGit\cmd\;C:\MinGit\cmd'; \
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path -Value $env:PATH

WORKDIR /benchmarks

ENV DOTNET_SKIP_FIRST_TIME_EXPERIENCE true

COPY . .

WORKDIR /benchmarks/src/BenchmarksServer

RUN dotnet publish -c Release -o /benchmarks/src/BenchmarksServer/published