#coding:utf-8
#workpath=$1
workpath=$HOME/work2017/Research_of_DA/dataSets/office-dataset/
echo 'your dataset_path is  '$workpath
#'/home/gui/work2017/Research_of_transfer_Learning/dataSets/office-dataset/'
cate_arr=("back_pack"  "bike_helmet"  'bottle'  'desk_lamp'  'desktop_computer'  'file_cabinet'  'keyboard' 'laptop_computer'  'mobile_phone'  'mouse'  'printer'  'projector'  'ring_binder'  'ruler'  'speaker' 'trash_can')
path_source=${workpath}'amazon_source/'
path_source_train=${workpath}'amazon_source_train/'
path_source_test=${workpath}'amazon_source_test/'
path_target=${workpath}'webcam_target/'
path_target_train=${workpath}'webcam_target_train/'
path_target_test=${workpath}'webcam_target_test/'

### function create_dir() 
create_dir(){
    if test -d $1
    then
        echo $1'    exists'
    else
        mkdir $1
    fi
}


### function create_img_arr (frame_0001.jpg .......)
### 最好别用数组，尽量用while来代替,因为数组不方便作为函数的参数

### function cp_or_mv_img_from_to
cp_or_mv_img_from_to(){
    img_num=$3
    from=$4     #${workpath}amazon/images/ 
    to=$5       #${path_source}
    for cate in ${cate_arr[*]}
    do
        echo --------------
        create_dir ${to}${cate}
        int_k=1
        while ((int_k<=$img_num))
        do
            if ((int_k<10))
    	    then
                $1 $2 ${from}${cate}/frame_000${int_k}.jpg   ${to}${cate}/
            else
                $1 $2 ${from}${cate}/frame_00${int_k}.jpg   ${to}${cate}/
            fi
            let int_k++
        done
    done
}

rm -r $path_source
rm -r $path_source_train
rm -r $path_source_test
rm -r $path_target
rm -r $path_target_train
rm -r $path_target_test


create_dir $path_source
create_dir $path_source_train
create_dir $path_source_test
create_dir $path_target
create_dir $path_target_train
create_dir $path_target_test



## cp -r 20 images of per category (16 categories) of amazon to path_source
cp_or_mv_img_from_to  cp -r 30  ${workpath}amazon/images/   ${path_source}
## cp -r 11 images of per category (16 categories) of webcam to path_target
cp_or_mv_img_from_to  cp -r 11  ${workpath}webcam/images/   ${path_target}
cp -r $path_target*    $path_target_test
cp -r $path_source*    $path_source_test
cp_or_mv_img_from_to  mv -f 20  ${path_source_test}  ${path_source_train}
cp_or_mv_img_from_to  mv -f  1  ${path_target_test}  ${path_target_train}


#for cate in ${cate_arr[*]}
#do
#    create_dir ${path_target_train}${cate}/
#	mv ${path_target_test}${cate}/frame_0001.jpg ${path_target_train}${cate}/
#done



## resize pictures 
echo '  resize images to             299   '
python ./resize_all_images.py --dataset_path $workpath  --size 299

