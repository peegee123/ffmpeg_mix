#!/bin/bash

#  INPUT_VIDEO_FILE_URL=myvid.trigger.txt OUTPUT_THUMBS_FILE_NAME=myth POSITION_TIME_DURATION="00:00:00" ./docker/copy_thumbs.sh 
# export INPUT_VIDEO_FILE_URL=s3://thumbnailcreatorstack-multimediaappstore443f8064-rimuopwe7qs3/videos/myvid.trigger.txt
# export AWS_REGION=eu-west-2

#echo "Downloading ${INPUT_VIDEO_FILE_URL}..."

echo "------  1 this is version 12 (19-may-2021 at 23:49)"


echo "------  1 trigger file is ${INPUT_VIDEO_FILE_URL}"

echo "------  1 INPUT_VIDEO_FILE_URL = ${INPUT_VIDEO_FILE_URL}"
echo "------  1 OUTPUT_THUMBS_FILE_NAME = ${OUTPUT_THUMBS_FILE_NAME}"
echo "------  1 POSITION_TIME_DURATION = ${POSITION_TIME_DURATION}"
echo "------  1 OUTPUT_S3_PATH = ${OUTPUT_S3_PATH}"
echo "------  1 OUTPUT_THUMBS_FILE_NAME = ${OUTPUT_THUMBS_FILE_NAME}"

# ls -ltr 

export vbase="`echo "${INPUT_VIDEO_FILE_URL}" | cut -d'.' -f 1`"
export v1="${vbase}_1.mp4"
export v2="${vbase}_2.mp4"
export v3="${vbase}_3.mp4"
export v4="${vbase}_4.mp4"
echo "------  1 vbase = ${vbase}"
echo "------  1 v1 = ${v1}"
echo "------  1 v2 = ${v2}"
echo "------  1 v3 = ${v3}"
echo "------  1 v4 = ${v4}"

echo "---> p1" `date`


# thumbnailcreatorstack-multimediaappstore443f8064-rimuopwe7qs3/thumbnails/BigBuckBunny_2.mp4.png

# thumbnailcreatorstack-multimediaappstore443f8064-rimuopwe7qs3/thumbnails/BigBuckBunny.mp4.png

# https://s3uploader-s3uploadbucket-l01rl6n0wu8a.s3.amazonaws.com/myvideo_peter_1.mp4
# aws s3 cp ${INPUT_VIDEO_FILE_URL} video.mp4
aws s3 cp ${v1} v1.mp4
aws s3 cp ${v2} v2.mp4
aws s3 cp ${v3} v3.mp4
aws s3 cp ${v4} v4.mp4

echo "---> p2" `date`

# ffmpeg -i video.mp4 -ss ${POSITION_TIME_DURATION} -vframes 1 -vcodec png -an -y ${OUTPUT_THUMBS_FILE_NAME}
# ffmpeg -y -i v1.mp4 "${OUTPUT_THUMBS_FILE_NAME}.mp4"


ffmpeg -y -i v1.mp4 -i v2.mp4 -i v3.mp4 -i v4.mp4 \
-filter_complex "[0:v:0][1:v:0][2:v:0][3:v:0]xstack=inputs=4:layout=0_0|0_h0|w0_0|w0_h0[outv]; \
      [0:a:0][1:a:0][2:a:0][3:a:0]amix=inputs=4[outa] \
      " \
	-map "[outv]" -map "[outa]" \
	-r 60 \
    "${OUTPUT_THUMBS_FILE_NAME}.mp4"


echo "---> p3" `date`




# myvideo_john.trigger.txt.png.mp4
ffmpeg -i "${OUTPUT_THUMBS_FILE_NAME}.mp4" -codec: copy -start_number 0 -hls_time 10 -hls_list_size 0 -f hls "${OUTPUT_THUMBS_FILE_NAME}.m3u8"

echo "---> p4" `date`


# list all HLS files
ls -l1  "${OUTPUT_THUMBS_FILE_NAME}"*.ts
ls -l1  "${OUTPUT_THUMBS_FILE_NAME}".m3u8


echo "Copying ${OUTPUT_THUMBS_FILE_NAME} to S3 at ${OUTPUT_S3_PATH}/${OUTPUT_THUMBS_FILE_NAME}..."
echo "Copying all HLS files..."

echo aws s3 cp "${OUTPUT_THUMBS_FILE_NAME}.m3u8" s3://${OUTPUT_S3_PATH}/${OUTPUT_THUMBS_FILE_NAME}.m3u8 --region ${AWS_REGION}
aws s3 cp "${OUTPUT_THUMBS_FILE_NAME}.m3u8" s3://${OUTPUT_S3_PATH}/${OUTPUT_THUMBS_FILE_NAME}.m3u8 --region ${AWS_REGION}


echo "---> p5" `date`


#echo aws s3 cp "${OUTPUT_THUMBS_FILE_NAME}"*.ts s3://${OUTPUT_S3_PATH}/${OUTPUT_THUMBS_FILE_NAME} --region ${AWS_REGION}
#aws s3 cp "${OUTPUT_THUMBS_FILE_NAME}"*.ts s3://${OUTPUT_S3_PATH}/${OUTPUT_THUMBS_FILE_NAME} --region ${AWS_REGION}

#echo aws s3 cp "${OUTPUT_THUMBS_FILE_NAME}"*.ts s3://${OUTPUT_S3_PATH}/ --region ${AWS_REGION}
#aws s3 cp "${OUTPUT_THUMBS_FILE_NAME}"*.ts s3://${OUTPUT_S3_PATH}/ --region ${AWS_REGION}

echo aws s3 sync . s3://${OUTPUT_S3_PATH}/ --region ${AWS_REGION} --exclude "*" --include "${OUTPUT_THUMBS_FILE_NAME}*.ts"
aws s3 sync . s3://${OUTPUT_S3_PATH}/ --region ${AWS_REGION} --exclude "*" --include "${OUTPUT_THUMBS_FILE_NAME}*.ts"


echo "---> p6" `date`

#
echo aws s3 cp "${OUTPUT_THUMBS_FILE_NAME}.mp4" s3://${OUTPUT_S3_PATH}/${OUTPUT_THUMBS_FILE_NAME}.mp4 --region ${AWS_REGION}
aws s3 cp "${OUTPUT_THUMBS_FILE_NAME}.mp4" s3://${OUTPUT_S3_PATH}/${OUTPUT_THUMBS_FILE_NAME}.mp4 --region ${AWS_REGION}


echo "---> p7" `date`


#
echo aws s3 cp "${OUTPUT_THUMBS_FILE_NAME}.mp4" "s3://test1stack-hellobucket-164mp5o6olqdp/${OUTPUT_THUMBS_FILE_NAME}.mp4" --region ${AWS_REGION}
aws s3 cp "${OUTPUT_THUMBS_FILE_NAME}.mp4" "s3://test1stack-hellobucket-164mp5o6olqdp/${OUTPUT_THUMBS_FILE_NAME}.mp4" --region ${AWS_REGION}

echo "---> p8" `date`


cat /proc/cpuinfo
cat /proc/meminfo
free -m
vmstat -s
lscpu
nproc --all
getconf _NPROCESSORS_ONLN



exit




# Remove echo, as 
echo sed -e "s/ptest1.mp4/"${OUTPUT_THUMBS_FILE_NAME}.mp4"/g" aws-mediaconvert-job-ptest1.json
sed -e "s/ptest1.mp4/"${OUTPUT_THUMBS_FILE_NAME}.mp4"/g" aws-mediaconvert-job-ptest1.json > aws-mc-job.json

echo "---> p3a" `date`


cat aws-mc-job.json

echo "---> p4" `date`

echo aws mediaconvert describe-endpoints --region ${AWS_REGION} 
aws mediaconvert describe-endpoints --region ${AWS_REGION}


echo "---> p6" `date`




#
echo aws mediaconvert create-job --endpoint-url https://ey3xqwxpb.mediaconvert.eu-west-2.amazonaws.com --region eu-west-2  --cli-input-json file://aws-mc-job.json
aws mediaconvert create-job --endpoint-url https://ey3xqwxpb.mediaconvert.eu-west-2.amazonaws.com --region eu-west-2  --cli-input-json file://aws-mc-job.json

echo "---> p7" `date`

#
echo "---> p9 - done" `date`

# ffmpeg transcode logic removed




