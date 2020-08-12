// ap1int_simple1.cpp                                                 -*-C++-*-
#include <ap1int_simple1.h>

#include <bsls_ident.h>
BSLS_IDENT_RCSID(ap1int_simple1_cpp,"$Id$ $CSID$")

#include <bsl_cstddef.h>
#include <bsl_set.h>
#include <bsl_string.h>

//------------------------------------------------------------GENERATOR EXTRACT
// Grab the contents of the corresponding parts extracted from the LaTeX source
//..
//  #!/bin/bash
//
//  cat ../../../../build/$1/listings/$2.lst
//--------------------------------------------------------END GENERATOR EXTRACT

namespace BloombergLP {
namespace ap1int {
namespace simple1 {
//-----------------------------------GENERATED EXTRACT : ap1 ap1int_simple1_cpp
// ----Listing start: ap1-body.tex:13-----
    bsl::size_t unique_chars(const bsl::string& s)
    {
         bsl::set<char> uniq;
         uniq.insert(s.begin(), s.end());
         return uniq.size();
    }
// ----Listing done: ap1-body.tex:20-----
//-------------------------------END GENERATED EXTRACT : ap1 ap1int_simple1_cpp
}  // close component namespace
}  // close package namespace
}  // close enterprise namespace

// ----------------------------------------------------------------------------
// Copyright 2015 Bloomberg Finance L.P.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ----------------------------- END-OF-FILE ----------------------------------
