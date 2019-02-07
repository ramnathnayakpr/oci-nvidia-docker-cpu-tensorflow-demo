FROM tensorflow/tensorflow:latest-devel-py3
EXPOSE 80
RUN apt-get update && apt-get install -y npm vim bash wget
RUN git clone https://github.com/tensorflow/models
RUN mkdir /tmp/imagenet
WORKDIR /tmp/imagenet
RUN wget http://download.tensorflow.org/models/image/imagenet/inception-2015-12-05.tgz
RUN tar xvfz inception-2015-12-05.tgz
WORKDIR /root/models/tutorials/image/imagenet
RUN npm init -f
RUN npm install n -g && n stable
RUN npm install --save express express-fileupload ansi-to-html
COPY callpy.js /root/models/tutorials/image/imagenet
COPY background.jpg /root/models/tutorials/image/imagenet
CMD node callpy.js
