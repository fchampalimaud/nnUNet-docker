# nnUNet-docker

## Folder structure

nnUNet ([Official repository](https://github.com/MIC-DKFZ/nnUNet)) expects that certain folders are created in the system as described in the [Setting Up Paths](https://github.com/MIC-DKFZ/nnUNet/blob/master/documentation/setting_up_paths.md#:~:text=nnUNet_raw_data_base%3A%20This%20is%20where%20nnU-Net%20finds%20the%20raw,in%20turn%20contains%20one%20subfolder%20for%20each%20Task) official page.

Additional notes from the nnUNet-docker project can be found in the [Step 1: prepare data set for training](https://github.com/PkrMask/nnUNet-docker#step-1-prepare-data-set-for-training) section.

## Requirements

- [Docker](https://docs.docker.com/get-docker/) and [docker-compose](https://docs.docker.com/compose/) installed
- On a Windows machine, WSL2 is highly recommended. You can follow the instructions [here](https://docs.microsoft.com/en-us/windows/wsl/install) to install it.
- NVIDIA Container Runtime for Docker. Follow the instructions [here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker) to install it.
- NVIDIA driver 515 or later. You can check your driver version with `nvidia-smi` or `nvidia-settings`.

## Recommendations

- Use a SSD drive for the data folder. The training process is very I/O intensive, so the faster the drive, the better.
- If using WSL2, make sure that the data resides in the WSL2 file system for improved performance. Mileage may vary depending on the Windows version and the WSL2 distribution used. Please test both situations and choose the one that works best for you.


## Start and run commands inside container

The Dockerfile is currently based on `nvcr.io/nvidia/pytorch:22.12-py3` image (available [here](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/pytorch)), which has:

- CUDA 11.8 (**requires NVIDIA driver 520 or later**)
- PyTorch 1.14.0
- nnUNet 1.7.1
- nnUNetv2 2.0
- Python 3.8.10.

> [!IMPORTANT]  
> for more information on the container image used, please refer to the [official compatibility support matrix documentation](https://docs.nvidia.com/deeplearning/frameworks/support-matrix/index.html#framework-matrix-2022).

### Prepare a .env file with the data path

Copy the .env.example file to .env and change the path to the parent data folder, which should include the `nnUNet_raw`, `nnUNet_preprocessed` and `nnUNet_results` folders.

These are mapped to the container as volumes, so the data will be available to the container and in the host system.

Inside the container, the parent data folder is mapped to `/my_data`.

### Run docker-compose

On the first run, the container will be built and the nnUNet package will be installed.

```bash
docker-compose run --rm nnunet
```

Running the previous command will open a shell inside the container. From there, you can run the nnUNet commands as normal.

### Troubleshoting

If receiving the following error:

```bash
The 'sklearn' PyPI package is deprecated, use 'scikit-learn' rather than 'sklearn' for pip commands.
```

Please run the following command and try again:

```bash
SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL=True docker-compose run --rm nnunet
```
**Note**: This should only be required when building (e.g., for the first run) and until nnUNet is updated to use the latest version of scikit-learn.

## TODO

- [ ] Add support for mapping the nnunet repository from the host system to the container, and install it from there so that changes to the code can be tested without having to rebuild the container.
- [ ] more to come...

## For development (should not be needed)

## Build docker container with current Dockerfile

```bash
docker build -t nnunet-docker -f Dockerfile .
```

## Run interactive shell on previously built container

```bash
docker run -it \
 -v=<HOST PATH TO BASE FOLDER>:/my_data \
 -e "nnUNet_raw='/my_data/nnUNet_raw'" \
 -e "nnUNet_preprocessed='/my_data/nnUNet_preprocessed'" \
 -e "nnUNet_results='/my_data/nnUNet_results'" \
 --gpus=all \
 --rm \
 --name=<TASK NAME> \
 --network=host \
 --ipc=host\
 <NAME OF CONTAINER BUILT>

```

## Running

Start by following the tutorial example [here](https://github.com/MIC-DKFZ/nnUNet/blob/master/documentation/training_example_Hippocampus.md)
