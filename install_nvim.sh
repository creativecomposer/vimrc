#!/usr/bin/env bash

CUSTOM_NVIM_DIR=/usr/local/bin
CUSTOM_NVIM_FILE=${CUSTOM_NVIM_DIR}/nvim.appimage

echo "NeoVim file is ${CUSTOM_NVIM_FILE}"

pushd ${CUSTOM_NVIM_DIR}
sudo curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod +x nvim.appimage
popd

set -u
# sudo update-alternatives --install /usr/bin/ex ex "${CUSTOM_NVIM_FILE}" 110
sudo update-alternatives --install /usr/bin/vi vi "${CUSTOM_NVIM_FILE}" 110
# sudo update-alternatives --install /usr/bin/view view "${CUSTOM_NVIM_FILE}" 110
sudo update-alternatives --install /usr/bin/vim vim "${CUSTOM_NVIM_FILE}" 110
sudo update-alternatives --install /usr/bin/vimdiff vimdiff "${CUSTOM_NVIM_FILE}" 110
