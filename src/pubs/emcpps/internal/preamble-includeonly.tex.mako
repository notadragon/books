
%T%<%
%T%   includelistdecl = pub.config.get("book", "includeonly", fallback="") 
%T%   includeonlylist = []
%T%   for incl in includelistdecl.split(","):
%T%     if incl.startswith("*"):
%T%       includeonlylist.extend(pub.outline.sectionfiles(incl[1:]))
%T%     elif incl:
%T%       includeonlylist.append(incl)
%T%%>
%T%% if includeonlylist:
\includeonly{${",".join(includeonlylist)}}
%T%% endif


