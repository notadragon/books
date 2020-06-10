from pygments.lexers.c_cpp import CppLexer
from pygments.token import Name,Keyword

class CppPresentationLexer(CppLexer):
    name = 'C++Presentation'
    aliases = ['c++presentation']
    filenames = ['*.h','*.cpp']
