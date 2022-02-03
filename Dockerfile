FROM ubuntu@sha256:626ffe58f6e7566e00254b638eb7e0f3b11d4da9675088f4781a50ae288f3322
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y libgl1-mesa-dev
RUN apt-get install -y libglib2.0-0
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y python3-pyqt5
RUN apt-get install -y qttools5-dev-tools
RUN pip3 install pandas
RUN pip3 install PyQt5
RUN pip3 install pymongo
RUN pip3 install pyqt5-tools
WORKDIR /home
COPY ./annotation_tool.ui ./annotation_tool.ui
COPY ./logo.png ./logo.png
COPY ./annotation.py ./annotation.py
RUN chmod 777 ./annotation.py
CMD ["./annotation.py"]