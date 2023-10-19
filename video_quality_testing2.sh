#!/bin/bash
echo "
"
echo "Welcome to video quality analysis script, we analysis: Overall bit rate, PSNR, SSIM and VMAF"
echo "
"
echo "??????????????????????????????????????????????????????????????????????"
echo "Please specify the test subject file name? example: file.mpg, .mp4 etc"
echo "??????????????????????????????????????????????????????????????????????"
read varfilename
echo "
"
echo "?????????????????????????????????????????????????????????????????"
echo "Please specify the source file name? example: file.mxf, .mov etc"
echo "?????????????????????????????????????????????????????????????????"
read varsourcename
echo "
"
#Please add in your paths
original_video_path="/your/file/path/$varsourcename"
distorted_video_path="/your/file/path/$varfilename"
output_log="/your/file/path/output.log"
ssim_log="/your/file/path/ssim.log"
vmaf_model_path="/your/file/path/something.json"
#example
#vmaf_model_path="/opt/homebrew/Cellar/libvmaf/2.3.1/share/libvmaf/model/vmaf_v0.6.1.json"

echo "
"
echo " Please note: these are the locations where the script is picking the files from:
       $original_video_path
       $distorted_video_path
       If you would like to change these please change the variables:
       original_video_path (source file)
       distorted_video_path (transcoded output)"
echo "
"

echo "----------------------------------------------------------------------------------------"
echo "starting analysis on $original_video_path 
against $distorted_video_path"
echo "-----------------------------------------------------------------------------------------"

# Function to calculate PSNR (Peak Signal-to-Noise Ratio)
calculate_psnr() {
    psnr=$(ffmpeg -i "$1" -i "$2" -filter_complex "psnr" -f null - 2>&1 | grep "PSNR" )
    echo "$psnr"
}

# Function to calculate SSIM (Structural Similarity)
calculate_ssim() {
    ssim=$(ffmpeg -i "$1" -i "$2" -filter_complex "ssim" -f null - 2>&1 | grep "All")
    echo "$ssim"
}

# Function to calculate VMAF (Video Multimethod Assessment Fusion)
calculate_vmaf() {
    #vmaf_score=$(ffmpeg -hide_banner -loglevel error -i "$1" -i "$2" --filter_complex "libvmaf=model_path=$vmaf_model_path:psnr=1:ssim=1:ms_ssim=1:log_fmt=json" -f null - 2>&1 | grep "VMAF score:" | awk '{print $NF}')
    vmaf_score=$(ffmpeg -hide_banner -i "$1" -i "$2" -filter_complex "libvmaf=$vmaf_model_path" -f null - 2>&1 >/dev/null)
    echo "$vmaf_score"
}

overall_bit() {
    overallmode=$(mediainfo $2 | grep "Overall bit rate" )
    echo "$overallmode"
}

# Tsduck check on subtitles
#calculate_subtitles() {
#    subtitles_result=$("$vqmt_executable" -orig "$1" -dist "$2" -metr vqm -o "$output_log")
#    subtitles_score=$(grep "VQM =" "$output_log" | awk '{print $NF}')
#    echo "$vqm_subtitles"
#}

bitrate=$(overall_bit "$original_video_path" "$distorted_video_path")
echo "-------------------------------------------------------------------"
echo "Bitrate mode: $bitrate"
echo "-------------------------------------------------------------------"
echo "
"
# Calculate PSNR
psnr=$(calculate_psnr "$original_video_path" "$distorted_video_path")
echo "--------------------------------------------------------------------------------------------------------------------------------------"
echo "PSNR: $psnr"
echo "--------------------------------------------------------------------------------------------------------------------------------------"
echo "
"
echo " Notes: 
       Typical values for the Peak Signal-to-Noise Ratio aka PSNR in lossy image and video compression are between 30 and 50 dB, 
       provided the bit depth is 8 bits, where higher is better. 
       The processing quality of 12-bit images is considered high when the PSNR value is 60 dB or higher. 
       For 16-bit data typical values for the PSNR are between 60 and 80 dB.
       
       FOR EXAMPLE:
       PSNR y: 
       This is the PSNR value for the luma (brightness) component of the image.

       PSNR u: 
       This is the PSNR value for the chroma U component of the image (usually representing the blue color).

       PSNR v: 
       This is the PSNR value for the chroma V component of the image (usually representing the red color).

       Average PSNR: 
       This is the average PSNR value, which is typically calculated as the average of the PSNR values for all components (Y, U, V) combined.

       Minimum PSNR:
       This is the minimum PSNR value among all the components. It indicates the lowest quality portion of the compressed or reconstructed image.

       Maximum PSNR: inf (infinity)
       An infinite value for PSNR indicates that the compressed or reconstructed image is identical to the original, as there is no loss in quality."

# Calculate SSIM
ssim=$(calculate_ssim "$original_video_path" "$distorted_video_path")
echo "--------------------------------------------------------------------------------------------------------------------------------------"
echo "SSIM: $ssim"
echo "--------------------------------------------------------------------------------------------------------------------------------------"
echo "
"
echo " Notes: 
       Structural Similarity Index (SSIM), which is another metric used to assess the quality of compressed or reconstructed images compared to the original. 
       SSIM measures the similarity in terms of luminance, contrast, and structure between two images. The SSIM values range from -1 to 1, 
       where 1 indicates a perfect match and -1 indicates no similarity.

       FOR EXAMPLE:

       SSIM Y: 0.975144 (16.045738)
       This is the SSIM value for the luminance (Y) component of the image. 
       The second value in parentheses (16.045738) is likely the mean squared error (MSE) between the original and reconstructed Y component.

       SSIM U: 0.974585 (15.949045)
       This is the SSIM value for the chroma U component of the image (usually representing the blue color). 
       The second value in parentheses (15.949045) is likely the mean squared error (MSE) between the original and reconstructed U component.

       SSIM V: 0.981442 (17.314704)
       This is the SSIM value for the chroma V component of the image (usually representing the red color). 
       The second value in parentheses (17.314704) is likely the mean squared error (MSE) between the original and reconstructed V component.

       SSIM All: 0.976579 (16.303914)
       This is the SSIM value considering all components (Y, U, V) combined. 
       The second value in parentheses (16.303914) is likely the overall mean squared error (MSE) between the original and reconstructed image."

# Calculate VMAF
vmaf=$(calculate_vmaf "$original_video_path" "$distorted_video_path")
echo "-------------------------------------------------------------------"
echo "VMAF: $vmaf"
echo "-------------------------------------------------------------------"
echo "
"
echo " Notes: 
       VMAF stands for Video Multimethod Assessment Fusion, and it is another objective video quality metric commonly used to evaluate the perceptual quality of compressed or reconstructed videos compared to the original. 
       Unlike PSNR and SSIM, VMAF is designed to incorporate multiple methods and machine learning models to better align with human perception.

       VMAF scores range from 0 to 100, where higher scores indicate better perceptual video quality. 
       A VMAF score of 100 would represent perfect similarity to the original video, while a score of 0 would mean there is no perceptual similarity.
       Generally, scores above 90 are considered excellent, scores between 80 and 90 are very good, scores between 70 and 80 are good, 
       and scores below 70 may indicate noticeable quality degradation."

echo "*********************************************************************"
echo "The analysis is complete for this file: $varfilename" 
echo "*********************************************************************"

# Calculate subtitles
# subtitles=$(calculate_vqm "$original_video_path" "$distorted_video_path")
# echo "subtitles: $vqm"
