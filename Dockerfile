FROM heroku/heroku:18

COPY . /tmp/buildpack

RUN mkdir -p /tmp/build /tmp/cache /tmp/env /tmp/cache/buildcache/testcachedir
RUN echo "testcachedir" >> /tmp/build/.buildcache
RUN dd if=/dev/zero of=/tmp/cache/buildcache/testcachedir/output.dat  bs=1M  count=1
RUN tar cz --file /tmp/cache/buildcache/testcachedir.tar.gz --directory /tmp/cache/buildcache testcachedir
CMD /tmp/buildpack/bin/detect /tmp/build && /tmp/buildpack/bin/compile /tmp/build /tmp/cache /tmp/env
