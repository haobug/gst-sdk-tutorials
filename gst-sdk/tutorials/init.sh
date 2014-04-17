base="http://docs.gstreamer.com/media/";
find ${PWD} -name "*.c" -type f|while read f;
do
if grep "${base}" "$f" > /dev/null;
then
    remote_url=`grep "${base}" "$f" |sed "s@.*\(http\:\/\/docs\.gstreamer\.com\/media\/.*\)\".*@\1@g"`
    mkdir -p media && \
    cd media && \
    aria2c ${remote_url} && \
    cd ${OLDPWD}
    prefix="`dirname ${base}`";
    #echo ${remote_url} |cut -c `echo ${prefix}|wc -c`-;
    sed -i "s@${prefix}@file://${PWD}@g" $f;
fi
done
