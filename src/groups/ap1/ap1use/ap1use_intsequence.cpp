// ap1use_intsequence.cpp                                             -*-C++-*-
#include <ap1use_intsequence.h>

#include <bsls_ident.h>
BSLS_IDENT_RCSID(ap1use_intsequence_cpp,"$Id$ $CSID$")

#include <bdlma_localsequentialallocator.h>

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
namespace ok {
//-----------------------------GENERATED EXTRACT : ap1 ap1use_intsequence_cpp_1
// ----Listing start: ap1-body.tex:556-----
    void makeIntSequence(bsl::vector<int> *v, int n) {
        v->reserve(n);
        for (int x = 1; x <= n; ++x) {
            v->push_back(x);
        }
    }
// ----Listing done: ap1-body.tex:563-----
//-------------------------END GENERATED EXTRACT : ap1 ap1use_intsequence_cpp_1

void testMakeIntSequence()
{
//-----------------------------GENERATED EXTRACT : ap1 ap1use_intsequence_cpp_2
// ----Listing start: ap1-body.tex:564-----
    bdlma::LocalSequentialAllocator<300> mySeqAllocator;
    bsl::vector<int> seq(&mySeqAllocator);
    makeIntSequence(&seq, 60);
// ----Listing done: ap1-body.tex:568-----
//-------------------------END GENERATED EXTRACT : ap1 ap1use_intsequence_cpp_2
}
}  // close namespace ok
namespace oops {
//-----------------------------GENERATED EXTRACT : ap1 ap1use_intsequence_cpp_3
// ----Listing start: ap1-body.tex:587-----
    bsl::vector<int> makeIntSequence(int n) {
        bdlma::LocalSequentialAllocator<512> mySeqAllocator;
        bsl::vector<int> ret(&mySeqAllocator);
        ret.reserve(n);
        for (int x = 1; x <= n; ++x) {
            ret.push_back(x);
        }
        return ret;
    }
// ----Listing done: ap1-body.tex:597-----
//-------------------------END GENERATED EXTRACT : ap1 ap1use_intsequence_cpp_3

void testMakeIntSequence()
{
//-----------------------------GENERATED EXTRACT : ap1 ap1use_intsequence_cpp_4
// ----Listing start: ap1-body.tex:598-----
    bsl::vector<int> seq = makeIntSequence(60); // Disaster waiting to happen
// ----Listing done: ap1-body.tex:600-----
//-------------------------END GENERATED EXTRACT : ap1 ap1use_intsequence_cpp_4
}
}  // close namespace oops;
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
