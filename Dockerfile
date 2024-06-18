FROM nvcr.io/nvidia/pytorch:22.12-py3

# install git
RUN apt-get update && apt-get install -y git graphviz

# add graphviz to path
ENV PATH="/usr/bin/dot:${PATH}"

RUN pip install --upgrade pip
# both nnunet and nnunetv2 can coexist and be installed in the same environment
RUN pip install nnunet nnunetv2

# TODO: for when we map the nnunet folder
# RUN cd /nnUNet \
#  && pip install --no-cache-dir -e . 


# optional... how to load this depending on a varible?
RUN pip install --upgrade git+https://github.com/FabianIsensee/hiddenlayer.git


WORKDIR /my_data