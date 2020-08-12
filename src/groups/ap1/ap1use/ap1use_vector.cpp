// ap1use_vector.cpp                                                  -*-C++-*-
#include <ap1use_vector.h>

#include <bsls_ident.h>
BSLS_IDENT_RCSID(ap1use_vector_cpp,"$Id$ $CSID$")

#include <bdlma_sequentialallocator.h>
#include <bsl_vector.h>

//------------------------------------------------------------GENERATOR EXTRACT
// Grab the contents of the corresponding parts extracted from the LaTeX source
//..
//  #!/bin/bash
//
//  cat ../../../../build/$1/listings/$2.lst
//--------------------------------------------------------END GENERATOR EXTRACT

namespace BloombergLP {
namespace ap1use {

void testVectors()
{
//------------------------------------GENERATED EXTRACT : ap1 ap1use_vector_cpp
// ----Listing start: ap1-body.tex:504-----
    bsl::vector<int> vec(10, 8); // original (w/default allocator)
    bdlma::SequentialAllocator alloc2;
    bsl::vector<int> vec1(vec, &alloc2);          // extended copy ctor
    bsl::vector<int> vec2(std::move(vec),
                          &alloc2);               // extended move ctor (C++11)
    bsl::vector<int> vec3(bslmf::MovableRefUtil::move(vec),
    &alloc2);               // extended move ctor (C++03)
// ----Listing done: ap1-body.tex:512-----
//--------------------------------END GENERATED EXTRACT : ap1 ap1use_vector_cpp
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
