:: NOTE: mostly derived from
:: https://github.com/conda-forge/py-spy-feedstock/blob/master/recipe/bld.bat

:: build
cargo install --locked --root "%PREFIX%" --path crates/texlab || exit 1

:: move to scripts
md "%SCRIPTS%" || echo "%SCRIPTS% already exists"
move "%PREFIX%\bin\texlab.exe" "%SCRIPTS%"

:: dump licenses
cargo-bundle-licenses ^
    --format yaml ^
    --output "%SRC_DIR%\THIRDPARTY.yml" ^
    || exit 1

:: remove extra build files
del /F /Q "%PREFIX%\.crates2.json" "%PREFIX%\.crates.toml"
