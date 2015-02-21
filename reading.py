#Reading from a text file.bytesWritten

print("Opening and closing a file");

text_file = open("write_it.txt", "w");

#print text_file.read(6); #prints first 6 character of file....Line 1
lines = []
master_lines = ""
for line in text_file:
	if line == '\n':
		lines.append(line + "\n")
		master_lines += " ".join(lines)
		lines = []
	else:
		lines.append(line.rstrip())
print master_lines
