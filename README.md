# Video Quality Analysis Script

## Introduction

This Bash script is designed to analyze video quality, focusing on the following metrics: Overall bit rate, PSNR (Peak Signal-to-Noise Ratio), SSIM (Structural Similarity), and VMAF (Video Multimethod Assessment Fusion). It allows you to compare two video files and extract quality-related information.

## Prerequisites

Before using this script, make sure you have the following prerequisites in place:

- **Bash Shell**: Ensure you are using a Bash shell environment.
- **FFmpeg**: FFmpeg is required for video analysis. Make sure it's installed and available in your system's PATH.
- **MediaInfo**: MediaInfo is used to extract information about video files. Install it if not already available.
- **VMAF Model**: If you intend to use VMAF analysis, you'll need a VMAF model file. Ensure you have the correct path to the model in the script.

## How to Use

1. Clone or download this script to your local machine.

2. Make the script executable using the following command:

   ```bash
   chmod +x video_quality_analysis.sh

### NOTES IF YOU USING THE PYTHON VERSION

Before running the script, you'll need to install the moviepy library. You can install it using pip:

    ```bash
    pip install moviepy

Edit the script to provide the correct file paths. You will need to set the following variables in the script:

original_video_path: Path to the source video file (e.g., original video).
distorted_video_path: Path to the test video file (e.g., transcoded output).
output_log: Path to the log file where the analysis results will be stored.
ssim_log: Path to the log file where SSIM results will be stored.
vmaf_model_path: Path to the VMAF model file.
Run the script with the following command:

    ```bash
    ./video_quality_analysis.sh
    
## The script will perform the following tasks:

Calculate overall bit rate of the video files.
Calculate PSNR (Peak Signal-to-Noise Ratio) for video quality comparison.
Calculate SSIM (Structural Similarity) for video quality comparison.
Calculate VMAF (Video Multimethod Assessment Fusion) for perceptual video quality.
The script will display the results on the console and save them to the specified log files.

## Notes
Ensure that you provide the correct paths to the video files and the VMAF model.
Make sure FFmpeg and MediaInfo are installed and accessible in your system's PATH.
The script provides PSNR, SSIM, and VMAF scores to assess video quality. Interpret the scores according to the provided descriptions.
Customize the script further as needed for your specific video quality analysis requirements.
Disclaimer
This script serves as a basic video quality analysis tool and may require adjustments or additional features to meet specific use cases.

Use this script responsibly and in compliance with all relevant laws and regulations.

## Scoring Notes
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
       
VMAF stands for Video Multimethod Assessment Fusion, and it is another objective video quality metric commonly used to evaluate the perceptual quality of compressed or reconstructed videos compared to the original. 
       Unlike PSNR and SSIM, VMAF is designed to incorporate multiple methods and machine learning models to better align with human perception.

       VMAF scores range from 0 to 100, where higher scores indicate better perceptual video quality. 
       A VMAF score of 100 would represent perfect similarity to the original video, while a score of 0 would mean there is no perceptual similarity.
       Generally, scores above 90 are considered excellent, scores between 80 and 90 are very good, scores between 70 and 80 are good, 
       and scores below 70 may indicate noticeable quality degradation."


## License
This script is provided under an open-source license.
