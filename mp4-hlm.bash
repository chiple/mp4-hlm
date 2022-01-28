cd movs
dirs=($(ls -d */))
cur_dir=$(pwd)

for dir in ${dirs[@]};
do
       cd $cur_dir/$dir	
       movies=($(ls))
       for movie in ${movies[@]};
       do
	       echo $movie | sed 's/.mp4//g' | { read fname ; mkdir -p $fname ; mv ./$movie ./$fname/ ;\
	       cd $fname; pwd; ffmpeg -i *.mp4 -c:v copy -c:a copy -f hls -hls_time 9 -hls_playlist_type vod -hls_segment_filename "video%3d.ts" $fname.m3u8
       }
       done
	
done
