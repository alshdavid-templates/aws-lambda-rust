set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR="$SCRIPT_DIR/../.."

cd $ROOT_DIR

cargo build --target x86_64-unknown-linux-musl --release

rm -rf dist
mkdir dist
mv $ROOT_DIR/target/x86_64-unknown-linux-musl/release/aws-lambda-rust $ROOT_DIR/dist/bootstrap
