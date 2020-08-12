// ap1adv_winking.cpp                                                 -*-C++-*-
#include <ap1adv_winking.h>

#include <bsls_ident.h>
BSLS_IDENT_RCSID(ap1adv_winking_cpp,"$Id$ $CSID$")

#include <bdlma_multipoolallocator.h>

#include <bdlt_calendar.h>

#include <bsl_list.h>
#include <bsl_vector.h>

//------------------------------------------------------------GENERATOR EXTRACT
// Grab the contents of the corresponding parts extracted from the LaTeX source
//..
//  #!/bin/bash
//
//  cat ../../../../build/$1/listings/$2.lst
//--------------------------------------------------------END GENERATOR EXTRACT

namespace BloombergLP {
namespace ap1adv {

void testWink()
{
//-----------------------------------GENERATED EXTRACT : ap1 ap1adv_winking_cpp
// ----Listing start: ap1-body.tex:792-----
    {
        bdlma::MultipoolAllocator alloc;
        bsl::vector<bsl::list<bdlt::Calendar> >& data =
            *new(alloc) bsl::vector<bsl::list<bdlt::Calendar> >(&alloc);
        // ... Build up and use 'data' here ...
        // When 'alloc' goes out of scope, 'data' gets winked out; no need to
        // call 'alloc.deleteObject(&data)'.
    }
// ----Listing done: ap1-body.tex:801-----
//-------------------------------END GENERATED EXTRACT : ap1 ap1adv_winking_cpp
}

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
