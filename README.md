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

## License
This script is provided under an open-source license.
