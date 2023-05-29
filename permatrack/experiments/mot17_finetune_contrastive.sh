# Initial model pre-trained on PD + CrowdHuman: https://tri-ml-public.s3.amazonaws.com/github/permatrack/crowdhuman.pth
# Resulting model trained on MOT17 full train: https://tri-ml-public.s3.amazonaws.com/github/permatrack/mot_full.pth

cd src
# train
python main.py tracking --exp_id mot17_with_contrastive --occlusion_thresh 0.15 --visibility_thresh 0.05 --dataset joint --dataset1 mot --dataset2 pd_tracking --dataset_version 17trainval --same_aug_pre --hm_disturb 0.0 --lost_disturb 0.0 --fp_disturb 0.0 --gpus 0 --batch_size 2 --load_model ../models/crowdhuman.pth --val_intervals 1 --is_recurrent --gru_filter_size 7 --input_len 13 --pre_thresh 0.4 --hm_weight 0.5 --const_v_over_occl --sup_invis --invis_hm_weight 20 --use_occl_len --occl_len_mult 5 --visibility --num_iter 1600 --num_epochs 5 --lr_step 4 --visibility_thresh_eval 0.1 --ltrb_amodal --reuse_hm --input_h=256 --input_w=512 --only_ped --dataset_fraction=1.0 --save_all --contrastive_loss
#python main.py tracking --exp_id mot17_half --occlusion_thresh 0.15 --visibility_thresh 0.05 --dataset joint --dataset1 mot --dataset2 pd_tracking --dataset_version 17trainval --same_aug_pre --hm_disturb 0.0 --lost_disturb 0.0 --fp_disturb 0.0 --gpus 0,1,2,3,4,5,6,7 --batch_size 2 --load_model ../models/crowdhuman.pth --val_intervals 1 --is_recurrent --gru_filter_size 7 --input_len 17 --pre_thresh 0.4 --hm_weight 0.5 --const_v_over_occl --sup_invis --invis_hm_weight 20 --use_occl_len --occl_len_mult 5 --visibility --num_iter 1600 --num_epochs 5 --lr_step 4 --visibility_thresh_eval 0.1 --ltrb_amodal --only_ped --reuse_hm
# test
#CUDA_VISIBLE_DEVICES=0 python test.py tracking --exp_id mot17_with_contrastive --dataset mot --dataset_version test --track_thresh 0.4 --resume --is_recurrent --gru_filter_size 7 --num_gru_layers 1 --visibility_thresh_eval 0.1 --stream_test --ltrb_amodal --visibility --max_age 32 --trainval --save_results
#cd ..
