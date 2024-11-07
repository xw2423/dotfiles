mklink /D %HOMEDRIVE%%HOMEPATH%\.vim %~dp0

for %%i in (vimrc screenrc gitconfig bash_profile wgetrc curlrc) do (
	mklink %HOMEDRIVE%%HOMEPATH%\.%%i %~dp0%%i
)

pause

