import os
import subprocess
import numpy as np

FFMPEG_EXE = r"D:\Hobbies\Game\ThreeKhingDom\TamQuoc_Gemini_Pro (2)\TamQuoc_Gemini_Pro\.venv\Lib\site-packages\imageio_ffmpeg\binaries\ffmpeg-win-x86_64-v9.0.2.exe"
BASE_DIR = r"TamQuoc_Gemini_Pro"
INCOMING = os.path.join(BASE_DIR, "source_clips", "incoming")
GUI_DIR = os.path.join(BASE_DIR, "tam_quoc_gui")

def extract_pcm(mp4_path: str, sr: int = 48000) -> np.ndarray:
    cmd = [
        FFMPEG_EXE, "-y",
        "-i", mp4_path,
        "-vn",
        "-f", "f32le",
        "-ac", "2",
        "-ar", str(sr),
        "-"
    ]
    proc = subprocess.run(cmd, capture_output=True, check=True)
    raw = np.frombuffer(proc.stdout, dtype=np.float32).reshape(-1, 2)
    return raw

def export_ogg(pcm: np.ndarray, ogg_path: str, sr: int = 48000) -> None:
    os.makedirs(os.path.dirname(ogg_path), exist_ok=True)
    cmd = [
        FFMPEG_EXE, "-y",
        "-f", "f32le",
        "-ar", str(sr),
        "-ac", "2",
        "-i", "-",
        "-c:a", "libvorbis",
        "-q:a", "6",
        ogg_path
    ]
    proc = subprocess.run(cmd, input=pcm.astype(np.float32).tobytes(), capture_output=True, check=True)
    print(f"Exported {ogg_path} ({len(pcm)} samples, {len(pcm)/sr:.3f}s)")

def make_strategist_audio():
    src = os.path.join(INCOMING, "background_stragist.mp4")
    dst = os.path.join(GUI_DIR, "assets", "strategist_bg_video", "bg_audio.ogg")
    raw = extract_pcm(src, 48000)
    
    # Strategist video starts at frame 26 (26/24s), length 96 frames (4.0s)
    s = int(round(26 * 48000 / 24))     # 52000
    N = int(round(96 * 48000 / 24))     # 192000
    W = int(round(0.35 * 48000))        # 16800 samples (~0.35s blend)
    
    # Overlap blend at boundary:
    # Segment from s to s + N + W
    G = raw[s : s + N + W]
    out = np.zeros((N, 2), dtype=np.float32)
    for i in range(N):
        if i < W:
            t = 0.5 * (1.0 - np.cos(np.pi * (i / W)))
            out[i] = (1.0 - t) * G[N + i] + t * G[i]
        else:
            out[i] = G[i]
            
    # Check boundary diff
    boundary_jump = np.max(np.abs(out[0] - out[-1]))
    print(f"Strategist bg_audio: boundary jump={boundary_jump:.6f}")
    
    # Normalize peak to -4.0 dB (approx 0.63)
    peak = np.max(np.abs(out))
    if peak > 0:
        out = out * (0.65 / peak)
    export_ogg(out, dst, 48000)

def make_merchant_audio():
    src = os.path.join(INCOMING, "background_merchant.mp4")
    dst = os.path.join(GUI_DIR, "assets", "merchant_bg_video", "bg_audio.ogg")
    raw = extract_pcm(src, 48000)
    
    # Merchant video duration: 144 frames @ 24fps = 6.000s = 288000 samples
    N = int(round(144 * 48000 / 24))
    W = int(round(0.40 * 48000))        # 19200 samples (~0.4s blend)
    
    # Use available samples up to 288000
    base = raw[:N].copy()
    
    # Smooth equal-power cyclic crossfade of tail into head
    for k in range(W):
        theta = 0.5 * np.pi * (k / W)
        c = np.cos(theta)
        s = np.sin(theta)
        # End smoothly meets beginning
        base[N - W + k] = c * raw[N - W + k] + s * raw[k]
        base[k] = s * raw[k] + c * raw[N - W + k]
        
    boundary_jump = np.max(np.abs(base[0] - base[-1]))
    print(f"Merchant bg_audio: boundary jump={boundary_jump:.6f}")
    
    # Raw merchant audio is quite quiet (peak ~0.06), boost cleanly to peak 0.65 (-3.7 dB)
    peak = np.max(np.abs(base))
    if peak > 0:
        base = base * (0.65 / peak)
    export_ogg(base, dst, 48000)

def make_commander_audio():
    src = os.path.join(INCOMING, "background_military_commander.mp4")
    dst = os.path.join(GUI_DIR, "assets", "commander_bg_video", "bg_audio.ogg")
    raw = extract_pcm(src, 48000)
    
    # Commander video duration: 192 frames @ 24fps = 8.000s = 384000 samples
    N = int(round(192 * 48000 / 24))
    W = int(round(0.40 * 48000))
    
    base = raw[:N].copy()
    for k in range(W):
        theta = 0.5 * np.pi * (k / W)
        c = np.cos(theta)
        s = np.sin(theta)
        base[N - W + k] = c * raw[N - W + k] + s * raw[k]
        base[k] = s * raw[k] + c * raw[N - W + k]
        
    boundary_jump = np.max(np.abs(base[0] - base[-1]))
    print(f"Commander bg_audio: boundary jump={boundary_jump:.6f}")
    
    peak = np.max(np.abs(base))
    if peak > 0:
        base = base * (0.65 / peak)
    export_ogg(base, dst, 48000)

if __name__ == "__main__":
    print("Building background audio loops...")
    make_strategist_audio()
    make_merchant_audio()
    make_commander_audio()
    print("All background audio loops built successfully!")
