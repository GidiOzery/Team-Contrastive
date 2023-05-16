# Initial model pre-trained on PD: https://tri-ml-public.s3.amazonaws.com/github/permatrack/pd_17fr_21ep_vis.pth
# Resulting model trained on KITTI half train: https://tri-ml-public.s3.amazonaws.com/github/permatrack/kitti_half_pd_5ep.pth

cd src
# train
python main.py tracking --exp_id kitti_half --occlusion_thresh 0.15 --visibility_thresh 0.05 --dataset joint --dataset1 kitti_tracking --dataset2 pd_tracking --dataset_version train_half --same_aug_pre --hm_disturb 0.0 --lost_disturb 0.0 --fp_disturb 0.0 --gpus 0,1,2,3,4,5,6,7 --batch_size 2 --load_model ../models/pd_17fr_21ep_vis.pth --val_intervals 1 --is_recurrent --gru_filter_size 7 --input_len 17 --pre_thresh 0.4 --hm_weight 0.5 --const_v_over_occl --sup_invis --invis_hm_weight 20 --use_occl_len --occl_len_mult 5 --visibility --num_iter 5000 --num_epochs 5 --lr_step 4 --visibility_thresh_eval 0.2 
# test
CUDA_VISIBLE_DEVICES=0 python test.py tracking --exp_id kitti_half --dataset kitti_tracking --dataset_version val_half --track_thresh 0.4 --resume --is_recurrent --gru_filter_size 7  --num_gru_layers 1 --visibility --visibility_thresh_eval 0.2 --stream_test
