#!/usr/bin/env python3

import bs4
import sys
import urllib.parse

year=int(sys.argv[1])
url = sys.argv[2]
sourcefile = sys.argv[3]

try:
  if year >= 2012:
      soup = bs4.BeautifulSoup(open(sourcefile), "html.parser")
  
  if year >= 2017:
      tables = soup.find_all("table")
  
      for table in tables:
          for row in table.find_all("tr"):
              cells = row.find_all("td")
              if len(cells)  < 4:
                  continue

              link = cells[0].find_all("a")
              if not link:
                  continue
              link = link[0]
              
              pnum = "".join([ str(x) for x in link.contents]).strip()
              href = link["href"]
              lurl = urllib.parse.urljoin(url,href)
              title = "".join([ str(x) for x in cells[1].contents]).strip()
              author = "".join([ str(x) for x in cells[2].contents]).strip()
              date = "".join([ str(x) for x in cells[3].contents]).strip()
              
              print(f"""
@techReport{{wg21{pnum},
    author      = {{{{{author}}}}},
    title       = {{{title}}},
    institution = {{WG21 - The C++ Standards Committee}},
    number      = {{{pnum}}},
    year        = {{{year}}},
    date        = {{{date}}},
    url         = {{http://wg21.link/{pnum}}},
    fullurl     = {{{lurl}}},
}} 
""")
                  #print(f"Pnum {pnum} Link {link} href {href} url {lurl}")
                  #print(f"Title {title} Author {author} Date {date}")
except:
    print(f"Error processing year {year}")
    raise
