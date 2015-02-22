#Reading from a text file.bytesWritten

print("Opening and closing a file");

text_file = open("genre/adventure/ThreeMusketeers.txt", "r");

#print text_file.read(6); #prints first 6 character of file....Line 1
lines = []
master_lines = ""
for line in text_file:
    print master_lines
    if line == '\n':
        lines.append(line + "\n")
        master_lines += " ".join(lines)
        lines = []
    else:
        lines.append("<p>"+line.rstrip()+"</p>")
print master_lines

text_file.close()
