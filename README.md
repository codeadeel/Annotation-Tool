# Annotation Tool

* [**Introduction**](#introduction)
* [**MongoDB Setup**](#mongo_setup)  
  * [**Experimental Data**](#mongo_experimental_data)
* [**Building Annotation Tool**](#annotation_tool_build)
* [**Using Annotation Tool**](#annotation_tool_usage)
  * [**Connect Tab**](#connect_tab)
  * [**Stream Classification & Brand Recognition ***(SCBR)*** Tab**](#scbr_tab)
  * [**Face Detection Tab**](#face_tab)
  * [**Ticker Detection Tab**](#ticker_tab)
* [**Annotation Tool Development**](#annotation_develop)
* [**Annotation Tool Deployment**](#annotation_deploy)

## <a name="introduction">Introduction

The subject code is responsibe for handling Qt5 based annotation tool for following modules:

- Stream Classification & Brand Recognition
- Face Detection & Recognition
- Ticker Detection & Recognition

Subject annotation tool can be used to perform basic and quick annotation of new data. Data handling in annotation tool is based on ***MongoDB***. Dummy files are provided in [***Dummy_Files***][dummy files folder] folder in repository.

## <a name="mongo_setup">MongoDB Setup

MongoDB can be pulled from [**Docker Hub**][dockerhub weblink]. It is recommended to use following command to pull ***MongoDB*** image from [**Docker Hub**][dockerhub weblink]:

```bash
docker pull mongo@sha256:6743836d42756b2ae50549b2eb4585c688fce81a243cedd152b56266c2fb3d17
```

After downloading ***MongoDB*** image from [**Docker Hub**][dockerhub weblink], ***MongoDB*** can be started using the following command:

```bash
docker run -d -p 27017:27017 --name mongodb mongo@sha256:6743836d42756b2ae50549b2eb4585c688fce81a243cedd152b56266c2fb3d17
```

### <a name="mongo_experimental_data">Experimental Data

After ***MongoDB*** is up and running, [***Dummy_Files***][dummy files folder] can be added to ***some single database, as individual collection*** in ***MongoDB*** for experimentation with subject annotation tool. Links to respective files for each module is provided following:

- [Stream Classification & Brand Recognition][scbr dummy file]
- [Face Detection & Recognition][face dummy file]
- [Ticker Detection & Recognition][ticker dummy file]

Database name needs to be hardcoded in [***annotation.py***][annotation file], as following:

<a name="hardcoded_db">

[***annotation.py***][annotation file] > Ui_Dialog > connect_pressed >
```python
load_db_name = 'brs' # Target Database on MongoDB
```

## <a name="annotation_tool_build">Building Annotation Tool

Annotation tool can be build by [***Dockerfile***][dockerfile link]. The build image contains all necessary libraries to develop, test and deploy annotation tool. By running the following command in current [***Dockerfile***][dockerfile link] directory, we can easily build image:

```bash
docker build -t annotation_tool:basic .
```

After successful build, we can start annotation tool by running follwoing command in terminal:

```bash
xhost + # Only one time run
docker run --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --name annotation_instance annotation_tool:basic
```

## <a name="annotation_tool_usage">Using Annotation Tool

Subject annotation tool has four tabs, named as following:

- Connect
- SCBR
- Face Detection
- Ticker Detection

The above tabs are disscussed briefly as following:

### <a name="connect_tab">Connect Tab

This tab is responsible for connecting annotation tool to database. In this tab, first we need IP address of database to connect to. Then we connect with database which was [hardcoded](#hardcoded_db) in annotation bool [build process](#annotation_tool_build). After successful connection, we can select collection to connect to and also respective channel to perform annotation for. An image as example is attached following:

![Annotation Tool Connect Tab][first tab link]

In above given example, user would enter ***172.17.0.3:27017*** as IP address of the database to connect. Target collection and channel to annotate for is ***inference*** and ***HUM*** respectively. After starting annotation, user can proceed to respective annotation tool tab.

### <a name="scbr_tab">Stream Classification & Brand Recognition ***(SCBR)*** Tab

This tab is responsible for performing annotation for SCBR. In this tab, we are presented with image, and we are required to annotate it. ***Backend code for system feedback of brand recognition should be developed according to system architecture designed***. Other than that, it can perform stream classification annotation and identify brands. An image as example is attached following:

![Annotation Tool SCBR Tab][second tab link]

In above given example, user would annotate on the basis of per frame or iteratively using respective buttons. After done with annotation, data can be directly saved to database.

### <a name="face_tab">Face Detection Tab

This tab is responsible for performing annotation for Face Detection & Recognition. In this tab, we are presented with image, and we are required to draw boxes and annotate them respectively and iteratively. In other words, it can annotate face detection and respective annotation. An example image is attached following:

![Annotation Tool Face Detection Tab][third tab link]

In above given example, user would annotate on the basis of per frame or iteratively using respective buttons. After done with annotation, data can be directly saved to database.

### <a name="ticker_tab">Ticker Detection Tab

This tab is responsible for performing annotation for Ticker Detection & Recognition. In this tab, we are presented with image, and we are required to draw boxes and annotate them respectively and iteratively. In other words, it can annotate ticker detection and respective annotation. An example image is attached following:

![Annotation Tool Ticker Detection Tab][fourth tab link]

In above given example, user would annotate on the basis of per frame or iteratively using respective buttons. After done with annotation, data can be directly saved to database.

## <a name="annotation_develop">Annotation Tool Development

Annotation tool can be further developed using ***Qt Designer***. It is a part of build process in [annotation tool build](#annotation_tool_build). ***Qt Designer*** can be accessed by running follwoing command in terminal:

```bash
xhost + # Only one time run
docker run --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --name annotation_instance annotation_tool:basic qtchooser -run-tool=designer -qt=5
```
By running the above command, you will be presented with following screen:

![Qt Designer Main Screen][main qt designer]

After that, we need to open `annotation_tool.ui` file, available in `/home` directory in ***Qt Designer***. An example image is attached following:

![Qt Designer Example File][example qt designer]

Just like above example, you can further develop annotation tool and can export boilerplate code to python by running following command in `/home` or respective directory:

```bash
pyuic5 ./annotation_tool.ui -o annotation_new.py
```

After generating new code, you can integrate your own backend code.

## <a name="annotation_deploy">Annotation Tool Deployment

Subject annotation can be deployed on following platforms:

- Virtual Machines
- Containers
- Native Host Machine Installation

Whatever the deployment method is, it is required for database to be accessable over network.

[dockerfile link]: ./Dockerfile
[dummy files folder]: ./Dummy_Files
[dockerhub weblink]: https://hub.docker.com/
[scbr dummy file]: ./Dummy_Files/brs
[face dummy file]: ./Dummy_Files/frs
[ticker dummy file]: ./Dummy_Files/trs
[annotation file]: ./annotation.py
[first tab link]: ./MarkDown-Data/one.png
[second tab link]: ./MarkDown-Data/two.png
[third tab link]: ./MarkDown-Data/three.png
[fourth tab link]: ./MarkDown-Data/four.png
[main qt designer]: ./MarkDown-Data/five.png
[example qt designer]: ./MarkDown-Data/six.png