FROM ubuntu:14.04
MAINTAINER Brian Muchmore "brian.muchmore@genyo.es"
##Build with: docker build -t bmuchmore/cymer /Path/to/Dockerfile


ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

##Install x11 server so that programs that require a display compile correctly
RUN apt-get update -y && \
    apt-get install software-properties-common build-essential python-software-properties wget -y && \
    apt-get install xorg-dev xvfb -y

#Install all the needed fonts for x11
RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ precise universe multiverse" && \
    add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ precise-updates universe multiverse" && \
    apt-get -y update && \
    apt-get install -y -q xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic && \
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections && \
    apt-get install -y -q x-ttcidfont-conf cabextract ttf-mscorefonts-installer && \
    dpkg-reconfigure --default-priority x-ttcidfont-conf && \
    mkfontdir /usr/share/fonts/truetype/msttcorefonts && \
    cp -rs /usr/share/fonts/truetype/msttcorefonts/* /var/lib/defoma/x-ttcidfont-conf.d/dirs/TrueType

#Setup x11 as a service
ADD xvfb_init /etc/init.d/xvfb
RUN chmod a+x /etc/init.d/xvfb
ADD xvfb_daemon_run /usr/bin/xvfb-daemon-run
RUN chmod a+x /usr/bin/xvfb-daemon-run
ENV DISPLAY :99

##Install many downstream dependencies
RUN apt-get update -y
RUN apt-get install unzip libreadline6 libreadline6-dev libcairo2-dev tk8.5 autoconf openssl -y
RUN apt-get install gfortran tk tk-dev tcl tcl-dev libjpeg8 libxml2-dev liblz-dev libicu-dev libtool libssl-dev -y
RUN apt-get install libtiff4-dev libtiff-tools libtiff-opengl libgtk2.0-dev bzip2 libbz2-dev vim -y
RUN apt-get install libgd2-xpm-dev libpcre++-dev libhdf5-serial-dev libssh2-1 libcurl4-gnutls-dev git-core -y

##Install libcurl from source for R-devel
RUN  mkdir -p /home/developer && \
     wget https://github.com/bagder/curl/archive/master.zip -O /tmp/curl.zip -q && \
     echo 'Installing curl' && \
     unzip -o /tmp/curl.zip -d /home/developer && \
     cd /home/developer/curl-master && \
     ./buildconf && \
     ./configure && \
     make && \
     make install && \
     rm -rf /tmp/curl.zip

##Install zlib from source for R-devel
RUN wget http://www.zlib.net/zlib-1.2.8.tar.gz -O /tmp/zlib.tar.gz -q && \
    echo 'Installing zlib' && \
    tar -xvzf /tmp/zlib.tar.gz -C /home/developer && \
    rm /tmp/zlib.tar.gz -rf && \
    cd /home/developer/zlib-1.2.8 && \
    ./configure && \
    make && \
    make install

##Install HDF5 from source for Bioconductor package ncdfflow
RUN wget ftp://ftp.hdfgroup.org/HDF5/prev-releases/hdf5-1.8.16/src/hdf5-1.8.16.tar.gz -O /home/developer/hdf5-1.8.16.tar.gz -q && \
    cd /home/developer && tar -zxvf /home/developer/hdf5-1.8.16.tar.gz && \
    rm -rf /home/developer/hdf5-1.8.16.tar.gz && \
    cd /home/developer/hdf5-1.8.16 && ./configure && make && make check && make install && make check-install

##Install LinearTimeNeRV
RUN apt-get install libncurses5-dev libncursesw5-dev -y && \
    wget http://research.cs.aalto.fi/pml/software/LinearTimeNeRV/linearnerv-0.9.0.tar.gz -O /tmp/lineartimenerv.tar.gz -q && \
    echo 'Installing lineartimenerv' && \
    tar -xf /tmp/lineartimenerv.tar.gz -C /home/developer && \
    rm /tmp/lineartimenerv.tar.gz -rf && \
    cd /home/developer/lineartimenerv && \
    make linearnerv

##Install Java8
RUN add-apt-repository ppa:webupd8team/java && \
    apt-get update -y && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    xvfb-run -a apt-get install oracle-java8-installer libxext-dev libxrender-dev libxtst-dev -y && \
    xvfb-run -a apt-get install liblzma-dev -y && \
    xvfb-run -a apt-get install libglu1-mesa-dev -y

##Get Python working with KNIME. This installs R, so it must be run before the R version you want installed systemwide.
RUN apt-get install python-numpy python-pandas python-protobuf -y

##Install R with Atlas (OpenBLAS doesn't seem to play nice with library(parallel))
RUN echo 'deb http://lib.stat.cmu.edu/R/CRAN/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list && \ 
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 && \ 
    xvfb-run -a apt-get update -y && \
    xvfb-run -a apt-get install r-base -y && \
    xvfb-run -a apt-get install r-base-dev -y && \
    xvfb-run -a apt-get install libatlas3gf-base liblapack3gf xclip xsel -y

##Download KNIME
RUN echo 'Installing knime' && \
    wget http://download.knime.org/analytics-platform/linux/knime_3.2.0.linux.gtk.x86_64.tar.gz -O /tmp/knime.tar.gz -q && \
    tar -xf /tmp/knime.tar.gz -C /home/developer && \
    rm /tmp/knime.tar.gz && \
    apt-get install libwebkitgtk-3.0-0 -y

##Install needed KNIME extensions
RUN cd /home/developer/knime_3.2.0 && \
    ./knime -clean -purgeHistory -application org.eclipse.equinox.p2.director -noSplash -repository http://update.knime.org/store/3.2 -repository http://seleniumnodes.com/download/3.1 -repository http://update.knime.org/analytics-platform/3.2 -repository http://update.knime.org/community-contributions/trunk -repository http://update.knime.org/community-contributions/trusted/3.2 -repository http://update.knime.org/community-contributions/3.2 -installIUs org.pasteur.pf2.ngs -installIUs com.mind_era.knime_rapidminer.knime.feature.feature.group -installIUs org.knime.features.dbdrivers.feature.group -installIUs org.knime.features.ext.birt.feature.group -installIUs org.knime.ext.jfreechart -installIUs org.knime.python.nodes -installIUs org.knime.features.js.views.feature.group -installIUs com.knime.features.reporting.designer.feature.group -installIUs org.knime.features.r.feature.group -installIUs org.erlwood.features.core.base.feature.group -installIUs org.knime.features.arima.feature.group -installIUs org.knime.features.activelearning.feature.group -installIUs org.knime.features.stats2.feature.group -installIUs org.knime.features.virtual.feature.group -installIUs org.knime.features.distmatrix.feature.group -installIUs org.knime.features.ext.itemset.feature.group -installIUs org.knime.features.exttool.feature.group -installIUs org.knime.features.base.filehandling.feature.group -installIUs org.lhasalimited.knime.public.feature.feature.group -installIUs org.knime.features.ext.dl4j.feature.group -installIUs org.knime.features.base.widedata.feature.group -installIUs org.knime.features.core.streaming.feature.group -installIUs org.knime.features.rest.feature.group -installIUs es.unican.knime.stark.feature.feature.group -vmargs -Declipse.p2.mirrors=true -Djava.net.preferIPv4Stack=true
##Repository: http://update.knime.org/community-contributions/trunk
##Repository: http://update.knime.org/community-contributions/trusted/3.2
##Repository: http://update.knime.org/community-contributions/3.2
##Repository: http://update.knime.org/analytics-platform/3.2
##Repository: http://seleniumnodes.com/download/3.1
##Repository: http://update.knime.org/store/3.2
##Deep learning: org.knime.features.ext.dl4j.feature.group
##Wide data: org.knime.features.base.widedata.feature.group
##RESTful: org.knime.features.rest.feature.group
##Javascript: org.knime.features.js.views.feature.group
##JfreeCharts: org.knime.ext.jfreechart
##Python: org.knime.python.nodes
##Table Writers: org.knime.features.ext.birt.feature.group
##Reporting: com.knime.features.reporting.designer.feature.group
##R and flow variables: org.knime.features.r.feature.group
##Bash: org.pasteur.pf2.ngs
##RapidMiner: com.mind_era.knime_rapidminer.knime.feature.feature.group
##Database Drivers: org.knime.features.dbdrivers.feature.group
##ARIMA: org.knime.features.arima.feature.group
##Active learning: org.knime.features.activelearning.feature.group
##Extra stats: org.knime.features.stats2.feature.group 
##Parallelizing branches of a workflow: org.knime.features.virtual.feature.group
##Distance matrices: org.knime.features.distmatrix.feature.group
##Apriori: org.knime.features.ext.itemset.feature.group
##External tools: org.knime.features.exttool.feature.group
##File handling: org.knime.features.base.filehandling.feature.group
##Dumb joiner etc: org.lhasalimited.knime.public.feature.feature.group
##Self-Tuning Association Rules: es.unican.knime.stark.feature.feature.group
##KNIME Streaming Execution (Beta):  org.knime.features.core.streaming.feature.group
##Repository added but not currently installed - Selenium nodes: ws.palladian.nodes.selenium.feature.feature.group

##Get the correct verion of R working with KNIME and put KNIME in expert mode
##RUN R CMD javareconf && \
RUN echo '/usr/local/lib/R/lib/' > /etc/ld.so.conf.d/libR.conf && \
    echo '/usr/lib/jvm/java-8-oracle/jre/lib/amd64' > /etc/ld.so.conf.d/java.conf && \
    echo '/usr/lib/jvm/java-8-oracle/jre/lib/amd64/server' >> /etc/ld.so.conf.d/java.conf && \
    ldconfig && \
    echo '-Djava.library.path=/usr/local/lib/R/library/jri/' >> /home/developer/knime_3.2.0/knime.ini && \
    echo '-Dknime.expert.mode=true' >> /home/developer/knime_3.2.0/knime.ini
  
##We install Impute from Bioconductor first because samr depends on it, and citrus depends on samr.
##We install preprocessCore, GO.db, and AnnotationDbi from Bioconductor first because WGCNA depends on it.
RUN echo 'source("http://bioconductor.org/biocLite.R")' > /home/developer/prepackages.R && \
    echo 'biocLite("impute")' >> /home/developer/prepackages.R && \
    echo 'biocLite("preprocessCore")' >> /home/developer/prepackages.R && \
    echo 'biocLite("GO.db")' >> /home/developer/prepackages.R && \
    echo 'biocLite("AnnotationDbi")' >> /home/developer/prepackages.R && \
    echo 'install.packages("checkpoint", repos="http://mran.revolutionanalytics.com/snapshot/2016-05-01")' >> /home/developer/prepackages.R && \
    echo 'install.packages("WGCNA", repos="http://mran.revolutionanalytics.com/snapshot/2016-05-01")' >> /home/developer/prepackages.R && \
    echo 'install.packages("samr", repos="http://mran.revolutionanalytics.com/snapshot/2016-05-01")' >> /home/developer/prepackages.R && \
    xvfb-run -a Rscript /home/developer/prepackages.R

##Install R packages. The snapshot is set as YYYY-MM-DD
RUN echo 'install.packages("rJava", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' > /home/developer/packages.R && \
    echo 'install.packages("checkpoint", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("RGtk2", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("RGtk2Extras", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("tcltk2", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("BH", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("rCUR", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("foreach", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("doParallel", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("glmnet", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("pamr", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("shiny", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("brew", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("devtools", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("tabplot", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("googleVis", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("matrixStats", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("Rtsne", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("FeaLect", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("apcluster", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("doMC", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("loe", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \  
    echo 'install.packages("KODAMA", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("tpe", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("ROCR", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("RFOC", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("linkcomm", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("SNFtool", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("densityClust", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("Rserve", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("rChoiceDialogs", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("png", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("jpeg", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("tm", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("rtiff", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("gWidgets", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("gWidgets2RGtk2", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("propagate", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("caret", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("corrplot", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("psych", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    echo 'install.packages("fpc", repos="http://mran.revolutionanalytics.com/snapshot/2016-07-01")' >> /home/developer/packages.R && \
    xvfb-run -a Rscript /home/developer/packages.R
	
##Install packages for ncdfFlow
RUN echo 'source("http://bioconductor.org/biocLite.R")' > /home/developer/4ncdfFlow.R && \
    echo 'biocLite("Biobase")' >> /home/developer/4ncdfFlow.R && \
    echo 'biocLite("flowCore")' >> /home/developer/4ncdfFlow.R && \
    echo 'biocLite("flowViz")' >> /home/developer/4ncdfFlow.R && \
    echo 'biocLite("zlibbioc")' >> /home/developer/4ncdfFlow.R && \
    echo 'install.packages("RcppArmadillo", repos="http://mran.revolutionanalytics.com/snapshot/2016-05-01")' >> /home/developer/4ncdfFlow.R && \
    xvfb-run -a Rscript /home/developer/4ncdfFlow.R
	
##Install R package ncdfFlow from source in order to properly set the hdf5 library. This command may need to be continually updated with the correct link to the ncdfFlow package.
RUN wget https://www.bioconductor.org/packages/release/bioc/src/contrib/ncdfFlow_2.18.0.tar.gz -O /home/developer/ncdfFlow_2.18.0.tar.gz -q && \
    cd /home/developer && R CMD INSTALL ncdfFlow_2.18.0.tar.gz --configure-args="--with-hdf5='/home/developer/hdf5-1.8.16'"
	
##Install Bioconductor R packages
RUN echo 'source("http://bioconductor.org/biocLite.R")' > /home/developer/packagesBio.R && \
    echo 'biocLite("FlowRepositoryR")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("openCyto")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("FlowSOM")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("flowClean")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("QUALIFIER")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("flowBeads")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("cytofkit")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("flowCL")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("marray")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("limma")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("flowVS")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("RchyOptimyx")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("flowUtils")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("iClusterPlus")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("ConsensusClusterPlus")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("destiny")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("flowAI")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("ggcyto")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("kimod")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("flowDensity")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("ClusterSignificance")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("genefilter")' >> /home/developer/packagesBio.R && \
    echo 'biocLite("CytoML")' >> /home/developer/packagesBio.R && \
    xvfb-run -a Rscript /home/developer/packagesBio.R

##Install Github R packages
##flowWorkspace and openCyto are installed this way for CytoML. See: https://github.com/RGLab/CytoML
RUN echo 'options(unzip = "internal")' > /home/developer/packagesGit.R && \
    echo 'devtools::install_github("nolanlab/citrus")' >> /home/developer/packagesGit.R && \
    echo 'devtools::install_github("nolanlab/cytofCore")' >> /home/developer/packagesGit.R && \
    echo 'devtools::install_github("nolanlab/MouseImmuneReference")' >> /home/developer/packagesGit.R && \
    echo 'devtools::install_github("nolanlab/scaffold")' >> /home/developer/packagesGit.R && \
    echo 'devtools::install_github("nolanlab/Rclusterpp")' >> /home/developer/packagesGit.R && \
    echo 'devtools::install_github("nolanlab/spade")' >> /home/developer/packagesGit.R && \
    echo 'devtools::install_github("nbafrank/ggflow")' >> /home/developer/packagesGit.R && \
    echo 'devtools::install_github("analyxcompany/ForceAtlas2")' >> /home/developer/packagesGit.R && \
    echo 'devtools::install_github("analyxcompany/resolution")' >> /home/developer/packagesGit.R && \
    xvfb-run -a Rscript /home/developer/packagesGit.R

##Install R package NetPreProc from source
RUN wget https://cran.r-project.org/src/contrib/Archive/NetPreProc/NetPreProc_1.0.tar.gz -O /tmp/NetPreProc_1.0.tar.gz -q && \
    echo 'install.packages("/tmp/NetPreProc_1.0.tar.gz", repos = NULL, type = "source")' > /home/developer/packagesSource.R && \
    xvfb-run -a Rscript /home/developer/packagesSource.R && \
    rm /tmp/NetPreProc_1.0.tar.gz

##Install Python 3.5
RUN wget https://www.python.org/ftp/python/3.5.1/Python-3.5.1.tar.xz -O /home/developer/Python-3.5.1.tar.xz -q && \
    cd /home/developer && tar xJf /home/developer/Python-3.5.1.tar.xz && \
    rm -rf /home/developer/Python-3.5.1.tar.xz && \
    cd /home/developer/Python-3.5.1 && \
    ./configure --prefix=/opt/python3.5 && \ 
    make && \
    make install && \
    apt-get install python3-dev -y

##Install some Python 3.5 libraries
RUN apt-get install libblas-dev liblapack-dev -y && \
    export BLAS=/usr/lib/libblas.so && \
    export LAPACK=/usr/lib/liblapack.so && \
    export ATLAS=/usr/lib/libatlas.so.3 && \
    /opt/python3.5/bin/pip3 install --upgrade pip && \
    /opt/python3.5/bin/pip3 install numpy && \
    /opt/python3.5/bin/pip3 install scipy && \
    /opt/python3.5/bin/pip3 install scikit-learn && \
    /opt/python3.5/bin/pip3 install pyzmq && \
    /opt/python3.5/bin/pip3 install networkx && \
    /opt/python3.5/bin/pip3 install matplotlib && \
    /opt/python3.5/bin/pip3 install seaborn && \
    /opt/python3.5/bin/pip3 install sklearn && \
    /opt/python3.5/bin/pip3 install fcsparser && \
    /opt/python3.5/bin/pip3 install statsmodels && \
    /opt/python3.5/bin/pip3 install cython && \
    /opt/python3.5/bin/pip3 install pandas

##Followed the following advice to install tsne, which is needed for wishbone:
##http://stackoverflow.com/questions/25065113/blas-lapack-not-installed-how-to-install-it
##Installing tSNE 1.3 instead of latest version according to https://github.com/ManuSetty/wishbone/issues/6
RUN apt-get --purge remove libatlas3gf-base -y && \
    apt-get install libatlas-base-dev -y && \
    wget https://github.com/danielfrg/tsne/archive/v0.1.3.zip -O /home/developer/tsne.zip -q && \
    unzip -o /home/developer/tsne.zip -d /opt/python3.5/lib/python3.5/site-packages && \
    rm -rf /home/developer/tsne.zip && \
    cd /opt/python3.5/lib/python3.5/site-packages/tsne-0.1.3 && \
    /opt/python3.5/bin/python3 setup.py install

##Install PhenoGraph (dependent upon Python 3.x and some libraries)
RUN wget https://github.com/jacoblevine/PhenoGraph/archive/master.zip -O /home/developer/PhenoGraph.zip -q && \
    unzip -o /home/developer/PhenoGraph.zip -d /opt/python3.5/lib/python3.5/site-packages && \
    rm -rf /home/developer/PhenoGraph.zip && \
    cd /opt/python3.5/lib/python3.5/site-packages/PhenoGraph-master && \
    /opt/python3.5/bin/python3 setup.py install

##Install Wishbone (dependent upon Python 3.X and some libraries)
##The sed command below changes the setup.py script to point correctly to pip3
RUN cd /opt/python3.5/lib/python3.5/site-packages && \
    git clone git://github.com/manusetty/wishbone.git && \
    sed -i -e 's@pip3@/opt/python3.5/bin/pip3@g' /opt/python3.5/lib/python3.5/site-packages/wishbone/setup.py && \
    cd /opt/python3.5/lib/python3.5/site-packages/wishbone && \
    /opt/python3.5/bin/pip3 install .

##Install Combo
##To compile on Ubuntu prepend '#include <stdio.h>' to the Graph.h file
RUN mkdir -p /home/developer/Combo && \
    wget http://senseable.mit.edu/community_detection/combo.zip -O /tmp/combo.zip -q && \
    unzip -o /tmp/combo.zip -d /home/developer/Combo && \
    rm -rf /tmp/combo.zip && \
    echo '#!/bin/bash' > /home/developer/prependCombo.sh && \
    echo 'content=$(cat /home/developer/Combo/Graph.h)' >> /home/developer/prependCombo.sh && \
    echo 'echo -en "#include <stdio.h>\n$content" > /home/developer/Combo/Graph.h' >> /home/developer/prependCombo.sh && \
    chmod 777 /home/developer/prependCombo.sh && \ 
    /home/developer/prependCombo.sh && \
    cd /home/developer/Combo && make

##Install VorteX  
RUN wget http://web.stanford.edu/~samusik/vortex/vortex_dist_1-July-16.zip -O /tmp/VorteX.zip -q && \
    unzip -o /tmp/VorteX.zip -d /home/developer/VorteX && \
    rm -rf /tmp/VorteX.zip

##Install Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \ 
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    apt-get update -y && \
    apt-get install xdg-utils -y && \ 
    apt-get install google-chrome-stable -y

##Install Gedit
Run apt-get install gedit -y

##Share X11 socket with the container and use it directly
##Set-up user privileges
RUN apt-get install sudo -y && \
    mkdir -p /etc/sudoers.d && \
    chmod +x /home/developer/knime_3.2.0 && \
    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown developer:developer -R /home/developer && \
    chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo

USER developer
ENV HOME /home/developer
WORKDIR /home/developer
CMD /home/developer/knime_3.2.0/knime -data /home/developer/knime-workspace 
