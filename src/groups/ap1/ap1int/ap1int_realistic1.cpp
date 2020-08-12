// ap1int_realistic1.cpp                                              -*-C++-*-
#include <ap1int_realistic1.h>

#include <bsls_ident.h>
BSLS_IDENT_RCSID(ap1int_realistic1_cpp,"$Id$ $CSID$")

#include <bdlpcre_regex.h>

#include <bslma_allocator.h>
#include <bslma_default.h>

#include <bslmt_once.h>

#include <bsl_string.h>
#include <bsl_vector.h>

//------------------------------------------------------------GENERATOR EXTRACT
// Grab the contents of the corresponding parts extracted from the LaTeX source
//..
//  #!/bin/bash
//
//  cat ../../../../build/$1/listings/$2.lst
//--------------------------------------------------------END GENERATOR EXTRACT

namespace BloombergLP {
namespace ap1int {

//--------------------------------GENERATED EXTRACT : ap1 ap1int_realistic1_cpp
// ----Listing start: ap1-body.tex:101-----
    void loadInstrumentPattern(bdlpcre::RegEx *regex);

    bsl::string_view findInstrument(bsl::string_view wholeTopic,
                                    bslma::Allocator *transient)
    {
         static bdlpcre::RegEx pattern(bslma::Default::globalAllocator());
         BSLMT_ONCE_DO { loadInstrumentPattern(&pattern); }
         bsl::vector<bslstl::StringRef> matches(transient);
         matches.reserve(pattern.numSubpatterns() + 1);
         pattern.matchRaw(&matches, wholeTopic.data(), wholeTopic.size());
         return matches.empty() ? wholeTopic : bsl::string_view(matches[0]);
    }
// ----Listing done: ap1-body.tex:114-----
//----------------------------END GENERATED EXTRACT : ap1 ap1int_realistic1_cpp

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
