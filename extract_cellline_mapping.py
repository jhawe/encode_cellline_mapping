####
# Simple parser for the encode controlled vocabulary file
####

# init
term = ""
tag = ""
tkeys = ["term", "type", "tag", "tissue", "sex", "termId", "organism"]
current_term = None

with open("controlled_vocab.txt") as file:
 for line in file:
  if(line[0] == "#"):
   continue

  val = line.strip()
  if(val == ""):
   continue

  val = val.split(" ")
  k = val[0]
  if(k == "term"):
   # print current cell type if !NA
   if(current_term != None):
    # could happen that we didn't encounter some
    # keywords -> fill in NA to get full lines
    for key in tkeys:
     if(key not in current_term.keys()):
      current_term[key] = ""
    print("\t".join(current_term.values()))
    current_term = None
   term = " ".join(val[1:])
  elif(k == "type"):
   if(" ".join(val[1:]) == "Cell Line"):
    current_term = {}
    current_term["term"] = term
    current_term["tag"] = tag
    current_term["type"] = " ".join(val[1:])
  elif(k == "tag"):
   tag = " ".join(val[1:])
  elif(k in ["organism","tissue", "sex", "termId"]):
   if(current_term != None):
    current_term[k] = " ".join(val[1:])

