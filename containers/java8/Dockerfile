FROM alpine:3.7 as builder

RUN apk add --no-cache gcc musl-dev bash wget tar make

RUN wget https://github.com/ifaisalalam/GNU-time/releases/download/2.0.0/gnu-time-faisal-2.0.0.tar.gz

RUN tar xzf gnu-time-faisal-2.0.0.tar.gz

WORKDIR GNU-time/

RUN ./configure && make && make install

FROM alpine:3.7

RUN apk add --no-cache openjdk8 bash

ENV PATH="/usr/lib/jvm/java-1.8-openjdk/bin:${PATH}"

COPY compile.sh /bin/compile.sh

COPY run.sh /bin/run.sh

COPY --from=builder /usr/local/bin/time /usr/local/bin/time

RUN chmod 755 /bin/compile.sh

RUN chmod 755 /bin/run.sh
