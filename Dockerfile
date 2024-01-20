FROM toposoid/python-nlp-english:0.5-SNAPSHOT

WORKDIR /app
ARG TARGET_BRANCH
ENV DEPLOYMENT=local

RUN apt-get update \
&& apt-get -y install git \
&& git clone https://github.com/toposoid/toposoid-common-nlp-english-web.git \
&& cd toposoid-common-nlp-english-web \
&& git fetch origin ${TARGET_BRANCH} \
&& git checkout ${TARGET_BRANCH} \
&& pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt \
&& mkdir -p models \
&& mkdir -p models/sentence-transformers_paraphrase-multilingual-mpnet-base-v2 \
&& mv -f /tmp/paraphrase-multilingual-mpnet-base-v2/* ./models/sentence-transformers_paraphrase-multilingual-mpnet-base-v2/


COPY ./docker-entrypoint.sh /app/
ENTRYPOINT ["/app/docker-entrypoint.sh"]
