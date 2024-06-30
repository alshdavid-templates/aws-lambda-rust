set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR="$SCRIPT_DIR/../.."

cd $ROOT_DIR

TARGET=aarch64-unknown-linux-musl
export CC=aarch64-linux-gnu-gcc

# TARGET=x86_64-unknown-linux-musl

cargo build --target $TARGET --release

rm -rf dist
mkdir dist
mv $ROOT_DIR/target/$TARGET/release/aws-lambda-rust $ROOT_DIR/dist/bootstrap
