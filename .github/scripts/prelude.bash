#!/bin/bash
STARTING_PWD="$PWD"

mkdir -p $HOME/.local

## Install Rust
mkdir $HOME/.local/rust
cd $HOME/.local/rust

export RUSTUP_HOME="${HOME}/.local/rust/rustup"
export CARGO_HOME="${HOME}/.local/rust/cargo"

echo "RUSTUP_HOME=${HOME}/.local/rust/rustup" >> $GITHUB_ENV
echo "CARGO_HOME=${HOME}/.local/rust/cargo" >> $GITHUB_ENV

export PATH="${HOME}/.local/rust/cargo/bin:$PATH"
echo "${HOME}/.local/rust/cargo/bin" >> $GITHUB_PATH

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
rustup target add x86_64-unknown-linux-musl

## Install AWS CLI
mkdir $HOME/.local/aws
cd $HOME/.local/aws

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"  
unzip -qq awscliv2.zip
./aws/install --bin-dir $HOME/.local/aws/bin --install-dir $HOME/.local/aws/cli --update

export PATH="${HOME}/.local/aws/bin:${PATH}"
echo "${HOME}/.local/aws/bin" >> $GITHUB_PATH

## Install Terraform
mkdir $HOME/.local/terraform
cd $HOME/.local/terraform

curl "https://releases.hashicorp.com/terraform/1.9.0/terraform_1.9.0_linux_amd64.zip" -o "terraform.zip"  
unzip -qq terraform.zip

export PATH="${HOME}/.local/terraform:${PATH}"
echo "${HOME}/.local/terraform" >> $GITHUB_PATH

## Done
which cargo
which aws
which terraform

cd $STARTING_PWD