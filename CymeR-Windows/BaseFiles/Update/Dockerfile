FROM bmuchmore/cymer
MAINTAINER Brian Muchmore "brian.muchmore@genyo.es"

RUN sudo apt-get update -y && \
    echo 'source("http://bioconductor.org/biocLite.R")' > /home/developer/update.R && \
    echo 'biocLite("destiny")' >> /home/developer/update.R && \
    sudo Rscript /home/developer/update.R
 
USER developer
ENV HOME /home/developer
WORKDIR /home/developer
CMD /home/developer/knime_3.1.0/knime -data /home/developer/knime-workspace 






