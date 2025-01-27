FROM docker.io/amiklos/hcppipeline:4.10

RUN pip install pathlib

RUN rm /run.py 

COPY run.py /run.py

RUN chmod 777 /run.py

ENTRYPOINT ["/run.py"]
