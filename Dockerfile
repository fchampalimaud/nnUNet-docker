FROM nvcr.io/nvidia/pytorch:22.08-py3

# install git
RUN apt-get update && apt-get install -y git

RUN pip install --upgrade pip
RUN pip install nnunet

# TODO: for when we map the nnunet folder
# RUN cd /nnUNet \
#  && pip install --no-cache-dir -e . 


# optional... how to load this depending on a varible?
RUN pip install --upgrade git+https://github.com/FabianIsensee/hiddenlayer.git@more_plotted_details#egg=hiddenlayer


WORKDIR /my_data