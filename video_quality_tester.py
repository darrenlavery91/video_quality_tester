import subprocess
from moviepy.editor import VideoFileClip

# Set the paths to your video files and VMAF model
original_video_path = "/your/file/path/source_video.mp4"
distorted_video_path = "/your/file/path/test_video.mp4"
vmaf_model_path = "/your/file/path/something.json"

# Function to calculate PSNR (Peak Signal-to-Noise Ratio)
def calculate_psnr(original_path, distorted_path):
    cmd = [
        "ffmpeg",
        "-i", original_path,
        "-i", distorted_path,
        "-filter_complex", "psnr",
        "-f", "null",
        "-"
    ]
    result = subprocess.check_output(cmd, stderr=subprocess.STDOUT).decode()
    psnr = [line for line in result.split('\n') if "PSNR" in line][0]
    return psnr

# Function to calculate SSIM (Structural Similarity)
def calculate_ssim(original_path, distorted_path):
    cmd = [
        "ffmpeg",
        "-i", original_path,
        "-i", distorted_path,
        "-filter_complex", "ssim",
        "-f", "null",
        "-"
    ]
    result = subprocess.check_output(cmd, stderr=subprocess.STDOUT).decode()
    ssim = [line for line in result.split('\n') if "All" in line][0]
    return ssim

# Function to calculate VMAF (Video Multimethod Assessment Fusion)
def calculate_vmaf(original_path, distorted_path):
    video_clip_original = VideoFileClip(original_path)
    video_clip_distorted = VideoFileClip(distorted_path)
    vmaf = video_clip_original.vmaf(video_clip_distorted, model_path=vmaf_model_path)
    return vmaf

# Calculate PSNR
psnr_result = calculate_psnr(original_video_path, distorted_video_path)
print("PSNR:", psnr_result)

# Calculate SSIM
ssim_result = calculate_ssim(original_video_path, distorted_video_path)
print("SSIM:", ssim_result)

# Calculate VMAF
vmaf_result = calculate_vmaf(original_video_path, distorted_video_path)
print("VMAF:", vmaf_result)
