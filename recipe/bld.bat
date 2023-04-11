:: NOTE: mostly derived from
:: https://github.com/conda-forge/py-spy-feedstock/blob/master/recipe/bld.bat

:: build
cargo install --locked --root "%PREFIX%" --path texlab || goto :error

:: move to scripts
md %SCRIPTS% || echo "%SCRIPTS% already exists"
move %PREFIX%\bin\texlab.exe  %SCRIPTS%

:: dump licenses
cargo-bundle-licenses ^
    --format yaml ^
    --output %SRC_DIR%\THIRDPARTY.yml ^
    || goto :error

:: remove extra build files
del /F /Q "%PREFIX%\.crates2.json"
del /F /Q "%PREFIX%\.crates.toml"

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
