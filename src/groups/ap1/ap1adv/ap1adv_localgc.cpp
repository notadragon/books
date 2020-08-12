// ap1adv_localgc.cpp                                                 -*-C++-*-
#include <ap1adv_localgc.h>

#include <bsls_ident.h>
BSLS_IDENT_RCSID(ap1adv_localgc_cpp,"$Id$ $CSID$")

#include <bdlma_sequentialallocator.h>
#include <bslma_allocator.h>

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
namespace ap1adv {

//---------------------------------GENERATED EXTRACT : ap1 ap1adv_localgc_cpp_1
// ----Listing start: ap1-body.tex:834-----
    struct GraphNode {
        bsl::string d_payload;
        bsl::vector<GraphNode *> d_outgoingEdges;
        GraphNode(const bsl::string& payload, bslma::Allocator *alloc);
        ~GraphNode() { }
    };
    GraphNode::GraphNode(const bsl::string& payload, bslma::Allocator *alloc)
    : d_payload(payload, alloc), d_outgoingEdges(alloc) {
        d_outgoingEdges.reserve(2); // Typical fan-out is 2.
    }
    // ...
// ----Listing done: ap1-body.tex:846-----
//-----------------------------END GENERATED EXTRACT : ap1 ap1adv_localgc_cpp_1

void testLocalGc(const bsl::string& nodename)
//---------------------------------GENERATED EXTRACT : ap1 ap1adv_localgc_cpp_2
// ----Listing start: ap1-body.tex:847-----
    {
        bdlma::SequentialAllocator alloc;
        GraphNode *start = new(alloc) GraphNode("start", &alloc);
        // ...
        GraphNode *n = new(alloc) GraphNode(nodename, &alloc);
            start->d_outgoingEdges.push_back(n);
        n->d_outgoingEdges.push_back(start); // cycles are no problem
        // ...
        // 'alloc' destructor calls 'alloc.release()'
    }
// ----Listing done: ap1-body.tex:858-----
//-----------------------------END GENERATED EXTRACT : ap1 ap1adv_localgc_cpp_2

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
