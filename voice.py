import subprocess
import sys

text = sys.argv[1]
output_file = sys.argv[2]
print(len(sys.argv))
if len(sys.argv) == 4:
    subprocess.run(["edge-tts","-f" ,text, "--voice", "zh-TW-HsiaoYuNeural", "--write-media", output_file])
    sys.exit()
    
subprocess.run(["edge-tts", "--text", text, "--voice", "zh-TW-HsiaoYuNeural", "--write-media", output_file])
