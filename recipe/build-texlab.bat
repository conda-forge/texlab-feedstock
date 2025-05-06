@echo on

set CARGO_PROFILE_RELEASE_STRIP=symbols

:: build
cargo install ^
    --locked ^
    --no-track ^
    --profile release ^
    --root "%PREFIX%" ^
    --path crates/texlab ^
    || exit 1

:: move to scripts
md "%SCRIPTS%" ^
    || echo "%SCRIPTS% already exists"
move "%PREFIX%\bin\texlab.exe" "%SCRIPTS%"

:: dump licenses
cargo-bundle-licenses ^
    --format yaml ^
    --output "%SRC_DIR%\THIRDPARTY.yml" ^
    || exit 2
