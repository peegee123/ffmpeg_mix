# ffmpeg_mix


Derived from the base [jrottenberg/ffmpeg](https://hub.docker.com/r/jrottenberg/ffmpeg/) docker image, this image encapsulates the creation of a thumbnail image from a video file.

## Build image

```

cd /Users/peterwoods/Downloads/thumbnail-creator-main
export OUTPUT_S3_PATH=s3uploader-s3uploadbucket-l01rl6n0wu8a/thumbnails
export OUTPUT_THUMBS_FILE_NAME=mythumb.mp4.png
export INPUT_VIDEO_FILE_URL="s3://s3uploader-s3uploadbucket-l01rl6n0wu8a/myvideo_john.trigger.txt"
export AWS_REGION=eu-west-2

```

## Run

```
./docker/copy_thumbs.sh 



```
After running the above command, the thumbnail image `test.png` will be created from the video `1234_test.mp4` in the S3 bucket `pgw-video-processed`.


	




