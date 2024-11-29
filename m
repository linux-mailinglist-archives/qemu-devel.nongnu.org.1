Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B139D456D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Nov 2024 02:49:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwI2-0001hV-Rl; Wed, 20 Nov 2024 20:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwI1-0001gk-6O
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:25 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHx-0004aC-OZ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=l7AFrdw6Z5v8pKLgQV4E0S1CKxSIr+1atnVYTuO0AmQ=; b=Uk1rkfoGtu0uxGu
 fUeAp9b6F9c6NIFrJ2WNUjf48zF9mk55+/KEUbGqSu2XbcLpWKB217uwsbRYhVO+dXCE9rkOn+Pq2
 z1CgPIeLjCjeSMs3MmSlGdQXe1vF4xnLJawCTQswQtaKIV8UtnV6TvXVcB4OX2pcbyf0mMTCribMC
 ok=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 29/43] helper-to-tcg: Introduce TCG register allocation
Date: Thu, 21 Nov 2024 02:49:33 +0100
Message-ID: <20241121014947.18666-30-anjo@rev.ng>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
References: <20241121014947.18666-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Based on the assumption of a cycle free IR, this commit adds a simple
register allocator for emitted values in TCG.  The goal of this pass is
to reduce the number of temporaries required in the output code, which
is especially important when dealing with gvec vectors as to not require
very large amounts of temporary storage in CPUArchState.

For each LLVM value in the IR, the allocator will assign a struct TcgV
reprensenting a variable in the output TCG.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../helper-to-tcg/include/CmdLineOptions.h    |   2 +
 subprojects/helper-to-tcg/meson.build         |   1 +
 .../passes/backend/TcgTempAllocationPass.cpp  | 594 ++++++++++++++++++
 .../passes/backend/TcgTempAllocationPass.h    |  79 +++
 .../helper-to-tcg/pipeline/Pipeline.cpp       |   6 +
 5 files changed, 682 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgTempAllocationPass.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgTempAllocationPass.h

diff --git a/subprojects/helper-to-tcg/include/CmdLineOptions.h b/subprojects/helper-to-tcg/include/CmdLineOptions.h
index 9553e26407..a5e467f8be 100644
--- a/subprojects/helper-to-tcg/include/CmdLineOptions.h
+++ b/subprojects/helper-to-tcg/include/CmdLineOptions.h
@@ -25,3 +25,5 @@ extern llvm::cl::list<std::string> InputFiles;
 extern llvm::cl::opt<bool> TranslateAllHelpers;
 // Options for PrepareForTcgPass
 extern llvm::cl::opt<std::string> TcgGlobalMappingsName;
+// Options for TcgTempAllocation
+extern llvm::cl::opt<uint32_t> GuestPtrSize;
diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index 09caa74c63..ad3c307b6b 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -50,6 +50,7 @@ sources = [
     'passes/PrepareForTcgPass/TransformGEPs.cpp',
     'passes/PrepareForTcgPass/CanonicalizeIR.cpp',
     'passes/PrepareForTcgPass/IdentityMap.cpp',
+    'passes/backend/TcgTempAllocationPass.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/passes/backend/TcgTempAllocationPass.cpp b/subprojects/helper-to-tcg/passes/backend/TcgTempAllocationPass.cpp
new file mode 100644
index 0000000000..3ee679ec02
--- /dev/null
+++ b/subprojects/helper-to-tcg/passes/backend/TcgTempAllocationPass.cpp
@@ -0,0 +1,594 @@
+//
+//  Copyright(c) 2024 rev.ng Labs Srl. All Rights Reserved.
+//
+//  This program is free software; you can redistribute it and/or modify
+//  it under the terms of the GNU General Public License as published by
+//  the Free Software Foundation; either version 2 of the License, or
+//  (at your option) any later version.
+//
+//  This program is distributed in the hope that it will be useful,
+//  but WITHOUT ANY WARRANTY; without even the implied warranty of
+//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+//  GNU General Public License for more details.
+//
+//  You should have received a copy of the GNU General Public License
+//  along with this program; if not, see <http://www.gnu.org/licenses/>.
+//
+
+#include "TcgTempAllocationPass.h"
+#include "PseudoInst.h"
+#include "backend/TcgEmit.h"
+#include "llvm-compat.h"
+#include <CmdLineOptions.h>
+#include <Error.h>
+#include <FunctionAnnotation.h>
+
+#include <llvm/ADT/Optional.h>
+#include <llvm/ADT/PostOrderIterator.h>
+#include <llvm/IR/BasicBlock.h>
+#include <llvm/IR/CFG.h>
+#include <llvm/IR/Constants.h>
+#include <llvm/IR/Function.h>
+#include <llvm/IR/Instructions.h>
+#include <llvm/IR/IntrinsicInst.h>
+#include <llvm/IR/Intrinsics.h>
+#include <llvm/IR/Module.h>
+#include <llvm/Transforms/Utils/Cloning.h>
+
+using namespace llvm;
+
+// Type to represent a list of free TcgV's that can be reused when
+// we need a new temporary. Exists for the duration of a function,
+// and is expected to be small <= 8 free TcgV's at any time.
+//
+// This justifies the type being an array, since iteration times to
+// find a free element will be small.
+using FreeListVector = SmallVector<TcgV, 8>;
+
+// Finds the first TcgV in FreeList with a matching TcgSize and Kind
+// Iterates over the FreeList to find a TcgV with matching TcgSize and Kind
+static Optional<TcgV> findFreeTcgV(FreeListVector &FreeList, uint32_t TcgSize,
+                                   TcgVKind Kind)
+{
+    for (size_t i = 0; i < FreeList.size(); ++i) {
+        if (FreeList[i].TcgSize == TcgSize and FreeList[i].Kind == Kind) {
+            TcgV Tcg = FreeList[i];
+            // Swap-remove
+            FreeList[i] = FreeList.back();
+            FreeList.pop_back();
+            return Tcg;
+        }
+    }
+    return None;
+}
+
+//
+// Functions for mapping an LLVM Value to a TcgV
+//
+
+// Provides a C string representation of a ConstantInt
+static std::string constantIntToStr(const ConstantInt *C)
+{
+    SmallString<20> ResultStr;
+    auto *Int = cast<ConstantInt>(C);
+    const APInt Value = Int->getUniqueInteger();
+    const char *SuffixStr = "";
+    const bool Negative = Int->isNegative();
+    if (Value.ugt(UINT32_MAX) or C->getBitWidth() == 64) {
+        SuffixStr = Int->isNegative() ? "ll" : "ull";
+    }
+    if (Int->getBitWidth() == 1) {
+        ResultStr = (Value.getBoolValue()) ? "true" : "false";
+    } else {
+        bool IsMax = (Negative) ? Value.isMaxSignedValue() : Value.isMaxValue();
+        bool IsMin = Negative and Value.isMinSignedValue();
+        unsigned Bitwidth = Value.getBitWidth();
+        if (IsMax) {
+            return Twine("INT").concat(Twine(Bitwidth)).concat("_MAX").str();
+        } else if (IsMin) {
+            return Twine("INT").concat(Twine(Bitwidth)).concat("_MIN").str();
+        } else {
+            Value.toString(ResultStr, 10, Value.isNegative(), true);
+        }
+    }
+    return Twine(ResultStr).concat(SuffixStr).str();
+}
+
+// Given an integer LLVM value assign it to a TcgV, either by creating a new
+// one or finding a suitable one on the FreeList
+static Expected<TcgV> mapInteger(TempAllocationData &TAD,
+                                 FreeListVector &FreeList, const Value *V)
+{
+    auto *Ty = cast<IntegerType>(V->getType());
+
+    uint32_t LlvmSize = Ty->getBitWidth();
+    if (LlvmSize > 64) {
+        return mkError("Bit widths > 64 are not supported: ", V);
+    }
+
+    if (isa<ConstantInt>(V)) {
+        // Constant integer
+        auto Tcg = TcgV::makeImmediate(constantIntToStr(cast<ConstantInt>(V)),
+                                       llvmToTcgSize(LlvmSize), LlvmSize);
+        return TAD.map(V, Tcg);
+    } else if (isa<Argument>(V)) {
+        // Argument
+        uint32_t TcgSize = llvmToTcgSize(LlvmSize);
+        auto ArgInfoIt = TAD.Args.ArgInfoMap.find(V);
+        if (ArgInfoIt != TAD.Args.ArgInfoMap.end() and
+            ArgInfoIt->second == ArgImmediate) {
+            auto Tcg = TcgV::makeImmediate(tcg::mkName("i"), TcgSize, LlvmSize);
+            return TAD.map(V, Tcg);
+        } else {
+            auto Tcg = TcgV::makeTemp(TcgSize, LlvmSize, IrValue);
+            return TAD.map(V, Tcg);
+        }
+    } else {
+        // Non-constant integer
+        uint32_t TcgSize = 0;
+        auto *ICmp = dyn_cast<ICmpInst>(V);
+        if (ICmp) {
+            // icmp's return i1's and are used as either 32-bit or 64-bit TCGv
+            // in QEMU.  Assume the TcgSize from operands.
+            assert(LlvmSize == 1);
+            auto *IntTy0 =
+                dyn_cast<IntegerType>(ICmp->getOperand(0)->getType());
+            if (!IntTy0) {
+                return mkError("Icmp on non-integer type");
+            }
+            TcgSize = llvmToTcgSize(IntTy0->getBitWidth());
+        } else {
+            // Normal integer, get the TcgSize from the LlvmSize as for
+            // constants
+            TcgSize = llvmToTcgSize(LlvmSize);
+        }
+
+        Optional<TcgV> Tcg = findFreeTcgV(FreeList, TcgSize, IrValue);
+        if (Tcg) {
+            // Found a TcgV of the corresponding TcgSize, update LlvmSize
+            Tcg->LlvmSize = LlvmSize;
+            return TAD.map(V, *Tcg);
+        } else {
+            // Otherwise, create a new value
+            const auto Tcg = TcgV::makeTemp(TcgSize, LlvmSize, IrValue);
+            return TAD.map(V, Tcg);
+        }
+    }
+}
+
+// Given an vector LLVM value assign it to a TcgV, either by creating a new
+// one or finding a suitable one on the FreeList.  Special care is taken to
+// map individual elements of constant vectors.
+static Expected<TcgV> mapVector(TempAllocationData &TAD,
+                                FreeListVector &FreeList, const Value *V,
+                                VectorType *VecTy)
+{
+    auto *IntTy = dyn_cast<IntegerType>(VecTy->getElementType());
+    if (!IntTy) {
+        return mkError("Vectors of non-integer element type not supported!\n");
+    }
+    uint32_t ElementCount = compat::getVectorElementCount(VecTy);
+    uint32_t ElementWidth = IntTy->getBitWidth();
+
+    if (ElementWidth == 1) {
+        return mkError("Invalid vector width");
+    }
+
+    auto *ICmp = dyn_cast<ICmpInst>(V);
+    if (ICmp) {
+        auto *VecTy = cast<VectorType>(ICmp->getOperand(0)->getType());
+        auto *IntTy = cast<IntegerType>(VecTy->getElementType());
+        ElementWidth = IntTy->getBitWidth();
+    }
+
+    uint32_t VectorWidth = ElementCount * ElementWidth;
+
+    // Create or find a TcgV
+    Optional<TcgV> Tcg = findFreeTcgV(FreeList, VectorWidth, IrPtrToOffset);
+    if (Tcg) {
+        Tcg->LlvmSize = ElementWidth;
+        Tcg->VectorElementCount = ElementCount;
+    } else {
+        Tcg = TcgV::makeVector(VectorWidth, ElementWidth, ElementCount);
+    }
+
+    // For constant vectors, make sure all individual elements are mapped
+    auto *Const = dyn_cast<Constant>(V);
+    if (Const) {
+        // Make sure all arguments being splatted are mapped
+        Constant *Splat = Const->getSplatValue();
+        if (Splat) {
+            // Map single splatted value
+            //   <32 x i32> <i32 255, i32 255, ..., i32 255>
+            // or,
+            //   <32 x i32> <i32 %1, i32 %1, ..., i32 %1>
+            assert(mapInteger(TAD, FreeList, Splat));
+        } else {
+            // Map constant elements of vector where elements differ
+            //   <32 x i32> <i32 1, i32 %5, ..., i32 16>
+            for (unsigned I = 0; I < Tcg->VectorElementCount; ++I) {
+                Value *V = Const->getAggregateElement(I);
+                assert(mapInteger(TAD, FreeList, V));
+            }
+        }
+    }
+
+    return TAD.map(V, *Tcg);
+}
+
+// Given an pointer LLVM value assign it to a TcgV, either by creating a new
+// one or finding a suitable one on the FreeList.  NOTE: Pointers may be mapped
+// to env via comparison with TempAllocationData::EnvPtr.
+static Expected<TcgV> mapPointer(TempAllocationData &TAD,
+                                 FreeListVector &FreeList, const Value *V)
+{
+    auto *Ty = cast<PointerType>(V->getType());
+    auto *ElTy = Ty->getPointerElementType();
+    if (isa<Argument>(V)) {
+        auto ArgInfoIt = TAD.Args.ArgInfoMap.find(V);
+        if (ArgInfoIt != TAD.Args.ArgInfoMap.end() and
+            ArgInfoIt->second == ArgPtrToOffset) {
+            const auto Tcg = TcgV::makeVector(GuestPtrSize, GuestPtrSize, 1);
+            return TAD.map(V, Tcg);
+        } else {
+            auto IsEnv = (TAD.Args.EnvPtr.hasValue() && *TAD.Args.EnvPtr == V);
+            const auto Tcg = TcgV::makeTemp(GuestPtrSize, GuestPtrSize,
+                                            IsEnv ? IrEnv : IrPtr);
+            return TAD.map(V, Tcg);
+        }
+    } else if (isa<AllocaInst>(V)) {
+        // `alloca`s represent stack variables in LLVM IR and return
+        // pointers, we can simply map them to `IrValue`s
+        auto *IntTy = dyn_cast<IntegerType>(ElTy);
+        if (!IntTy) {
+            return mkError("alloca with unsupported type: ", V);
+        }
+
+        const uint32_t LlvmBitWidth = IntTy->getBitWidth();
+        if (LlvmBitWidth > 64) {
+            return mkError("alloca with unsupported size: ", V);
+        }
+        const uint32_t TcgBitWidth = llvmToTcgSize(LlvmBitWidth);
+
+        // find or create a new IrValue
+        Optional<TcgV> Tcg = findFreeTcgV(FreeList, TcgBitWidth, IrValue);
+        if (Tcg) {
+            return TAD.map(V, *Tcg);
+        } else {
+            const auto Tcg = TcgV::makeTemp(TcgBitWidth, LlvmBitWidth, IrValue);
+            return TAD.map(V, Tcg);
+        }
+    } else if (isa<VectorType>(ElTy)) {
+        return mapVector(TAD, FreeList, V, cast<VectorType>(ElTy));
+    } else {
+        // Otherwise, find or create a new IrPtr of the target pointer size
+        Optional<TcgV> Tcg = findFreeTcgV(FreeList, GuestPtrSize, IrPtr);
+        if (Tcg) {
+            return TAD.map(V, *Tcg);
+        } else {
+            auto Tcg = TcgV::makeTemp(GuestPtrSize, GuestPtrSize, IrPtr);
+            return TAD.map(V, Tcg);
+        }
+    }
+
+    return mkError("Unable to map constant ", V);
+}
+
+// Given a LLVM value, assigns a TcgV by type (integer, pointer, vector).  If
+// the given value has already been mapped to a TcgV, return it.
+static Expected<TcgV> mapValue(TempAllocationData &Data,
+                               FreeListVector &FreeList, const Value *V)
+{
+    // Return previously mapped value
+    auto It = Data.Map.find(V);
+    if (It != Data.Map.end()) {
+        return It->second;
+    }
+
+    Type *Ty = V->getType();
+    if (isa<IntegerType>(Ty)) {
+        return mapInteger(Data, FreeList, V);
+    } else if (isa<PointerType>(Ty)) {
+        return mapPointer(Data, FreeList, V);
+    } else if (isa<VectorType>(Ty)) {
+        return mapVector(Data, FreeList, V, cast<VectorType>(Ty));
+    }
+
+    return mkError("Unable to map value ", V);
+}
+
+static bool shouldSkipInstruction(const Instruction *const I,
+                                  bool SkipReturnMov)
+{
+    // Skip returns if we're skipping return mov's
+    if (isa<ReturnInst>(I) and SkipReturnMov) {
+        return true;
+    }
+    // Skip assertions
+    auto Call = dyn_cast<CallInst>(I);
+    if (!Call) {
+        return false;
+    }
+    Function *F = Call->getCalledFunction();
+    if (!F) {
+        return false;
+    }
+    StringRef Name = F->getName();
+    return (Name == "__assert_fail" or Name == "g_assertion_message_expr" or
+            isa<DbgValueInst>(I) or isa<DbgLabelInst>(I));
+}
+
+static bool shouldSkipValue(const Value *const V)
+{
+    return (isa<GlobalValue>(V) or isa<ConstantExpr>(V) or isa<BasicBlock>(V));
+}
+
+// Wrapper function to extract operands from GEP, call,
+// and other instruction
+static const iterator_range<User::const_op_iterator>
+getOperands(const Instruction *const I)
+{
+    switch (I->getOpcode()) {
+    case Instruction::GetElementPtr:
+        return cast<GetElementPtrInst>(I)->operands();
+    case Instruction::Call:
+        return cast<CallInst>(I)->args();
+    default:
+        return I->operands();
+    }
+}
+
+// A mapping of the return TCG variable to the value RetV is valid
+// if no use of an argument is found between the use of value (where
+// IBegin/BbBegin starts) and it's definition
+// use of an argument is found between the old mapping
+// and the new.
+static bool isRetMapValid(Arguments &Args,
+                          po_iterator<const Function *> BbBegin,
+                          po_iterator<const Function *> BbEnd,
+                          BasicBlock::const_reverse_iterator IBegin,
+                          BasicBlock::const_reverse_iterator IEnd,
+                          const Value *RetV)
+{
+    auto BbIt = BbBegin;
+    auto IIt = IBegin;
+
+    do {
+        do {
+            if (cast<Value>(&*IIt) == RetV) {
+                return true;
+            }
+
+            for (auto &V : getOperands(&*IIt)) {
+                if (isa<Argument>(V) and Args.ArgInfoMap[V] != ArgImmediate) {
+                    return false;
+                }
+            }
+        } while (++IIt != IEnd);
+
+        ++BbIt;
+        IEnd = (*BbIt)->rend();
+        IIt = (*BbIt)->rbegin();
+    } while (BbIt != BbEnd);
+
+    return false;
+}
+
+Expected<TempAllocationData>
+allocateTemporaries(const Function &F, const AnnotationMapTy &Annotations)
+{
+    TempAllocationData Data;
+    FreeListVector FreeList;
+
+    assert(!F.isDeclaration());
+
+    // Use function annotation data to force type of arguments
+    auto It = Annotations.find(&F);
+    if (It != Annotations.end()) {
+        for (const Annotation &Ann : It->second) {
+            ArgumentKind Kind;
+            switch (Ann.Kind) {
+            case AnnotationKind::HelperToTcg:
+                continue;
+            case AnnotationKind::Immediate:
+                Kind = ArgImmediate;
+                break;
+            case AnnotationKind::PtrToOffset:
+                Kind = ArgPtrToOffset;
+                break;
+            default:
+                abort();
+            }
+
+            for (uint32_t i : Ann.ArgIndices) {
+                assert(i < F.arg_size());
+                Data.Args.ArgInfoMap[F.getArg(i)] = Kind;
+            }
+        }
+    }
+
+    for (const Argument &Arg : F.args()) {
+        // Check if argument corresponds to Env, if so set the special
+        // EnvPtr field.
+        auto Ptr = dyn_cast<PointerType>(Arg.getType());
+        if (Ptr) {
+            auto *Struct = dyn_cast<StructType>(Ptr->getPointerElementType());
+            // TODO: Identifying Env in this way is a bit fragile to name
+            // changes in QEMU, and assumes any non-QEMU code will still adopt
+            // the CPUArchState naming convention. Better is to handle all
+            // pointer-to-struct args as env.
+            if (Struct and Struct->getName() == "struct.CPUArchState") {
+                assert(!Data.Args.EnvPtr.hasValue());
+                Data.Args.EnvPtr = &Arg;
+            }
+        }
+
+        // If we didn't force an argument kind via annotations, assume ArgTemp
+        if (Data.Args.ArgInfoMap.find(&Arg) == Data.Args.ArgInfoMap.end()) {
+            Data.Args.ArgInfoMap[&Arg] = ArgTemp;
+        }
+
+        Data.Args.Args.insert(&Arg);
+    }
+
+    // The PrepareForOptPass removes all functions with non-int/void return
+    // types, assert this assumption.
+    Type *RetTy = F.getReturnType();
+    assert(isa<IntegerType>(RetTy) or RetTy->isVoidTy());
+    // Map integer return values
+    if (auto IntTy = dyn_cast<IntegerType>(RetTy)) {
+        Data.ReturnValue = TcgV::makeTemp(llvmToTcgSize(IntTy->getBitWidth()),
+                                          IntTy->getBitWidth(), IrValue);
+    }
+
+    // Begin/end iterators over basic blocks in the function. Used for checking
+    // that the initial return value map is valid and later used for iterating
+    // over basic blocks.
+    auto ItBbBegin = po_begin(&F);
+    auto ItBbEnd = po_end(&F);
+
+    // Skip mov's to return value if possible, results of previous
+    // instructions might have been assigned the return value.
+    //
+    // This is possible if:
+    //   1. The return value is not an argument.
+    //   2. The return value is not a constant.
+    //   3. No use of an argument has occured after the definition of the
+    //      value being returned.
+    {
+        const Instruction &I = *ItBbBegin->rbegin();
+
+        auto Ret = dyn_cast<ReturnInst>(&I);
+        if (Ret and Ret->getNumOperands() == 1) {
+            Value *RetV = Ret->getReturnValue();
+            bool ValidRetV = !isa<Argument>(RetV) and !isa<ConstantInt>(RetV);
+            if (ValidRetV and isRetMapValid(Data.Args, ItBbBegin, ItBbEnd,
+                                            (*ItBbBegin)->rbegin(),
+                                            (*ItBbBegin)->rend(), RetV)) {
+                Data.Map.try_emplace(RetV, *Data.ReturnValue);
+                Data.SkipReturnMov = true;
+            }
+        }
+    }
+
+    // Iterate over instructions in reverse and try to allocate TCG variables.
+    //
+    // The algorithm is very straight forward, we keep a FreeList of TCG
+    // variables we can reuse.  Variables are allocated on first use and
+    // "freed" on definition.
+    //
+    // We allow reuse of the return TCG variable in order to save one variable
+    // and skip the return mov if possible.  Since source and return variables
+    // can overlap, when take the conservative route and only allow reuse of
+    // the return variable if no arguments have been used.
+
+    bool SeenArgUse = false;
+
+    for (auto ItBb = ItBbBegin; ItBb != ItBbEnd; ++ItBb) {
+        const BasicBlock *BB = *ItBb;
+        // Loop over instructions in the basic block in reverse
+        for (auto IIt = BB->rbegin(), IEnd = BB->rend(); IIt != IEnd; ++IIt) {
+            const Instruction &I = *IIt;
+            if (shouldSkipInstruction(&I, Data.SkipReturnMov)) {
+                continue;
+            }
+
+            // For calls to the identity mapping pseudo instruction
+            // we simply want to propagate the type allocated for the result of
+            // the call to the operand.
+            if (isa<CallInst>(&I)) {
+                auto *Call = cast<CallInst>(&I);
+                PseudoInst Inst = getPseudoInstFromCall(Call);
+                if (Inst == IdentityMap) {
+                    Value *Arg = Call->getArgOperand(0);
+                    Expected<TcgV> Tcg = mapValue(Data, FreeList, Arg);
+                    assert(Tcg);
+
+                    auto It = Data.Map.find(cast<Value>(&I));
+                    assert(It != Data.Map.end());
+                    uint8_t LlvmSize = It->second.LlvmSize;
+                    It->second = Tcg.get();
+                    It->second.LlvmSize = LlvmSize;
+                    continue;
+                }
+            }
+
+            // Check if we've encountered any non-immediate argument yet
+            for (const Use &U : getOperands(&I)) {
+                if (isa<Argument>(U) and
+                    Data.Args.ArgInfoMap[U] != ArgImmediate) {
+                    SeenArgUse = true;
+                }
+            }
+
+            // Free up variables as they are defined, iteration is in post order
+            // meaning uses of vars always occur before definitions.
+            bool IsArg = Data.Args.ArgInfoMap.find(cast<Value>(&I)) !=
+                         Data.Args.ArgInfoMap.end();
+            auto It = Data.Map.find(cast<Value>(&I));
+            if (!IsArg and It != Data.Map.end() and
+                !cast<Value>(&I)->getType()->isVoidTy()) {
+                TcgV &Tcg = It->second;
+                switch (Tcg.Kind) {
+                case IrValue:
+                case IrPtr:
+                case IrPtrToOffset:
+                    FreeList.push_back(Tcg);
+                    break;
+                case IrConst:
+                case IrEnv:
+                case IrImmediate:
+                    break;
+                default:
+                    abort();
+                }
+            }
+
+            // Loop over operands and assign TcgV's. On first encounter of a
+            // given operand we assign a new TcgV from the FreeList.
+            for (const Use &V : getOperands(&I)) {
+                auto It = Data.Map.find(V);
+                if (It != Data.Map.end() or shouldSkipValue(V)) {
+                    continue;
+                }
+
+                Expected<TcgV> Tcg = mapValue(Data, FreeList, V);
+                if (!Tcg) {
+                    return Tcg.takeError();
+                }
+
+                // If our value V got mapped to the return value,
+                // make sure the mapping is valid
+                //
+                // A mapping to the return value is valid as long as
+                // an argument has not been used.  This is to prevent clobbering
+                // in the case that arguments and the return value overlap.
+                if (Data.ReturnValue.hasValue() and *Tcg == *Data.ReturnValue) {
+                    bool Valid =
+                        isRetMapValid(Data.Args, ItBb, ItBbEnd, IIt, IEnd, V);
+                    if (!SeenArgUse and Valid) {
+                        continue;
+                    }
+
+                    // The mapping was not valid, erase it and assign a new one
+                    Data.Map.erase(V);
+                    Expected<TcgV> Tcg = mapValue(Data, FreeList, V);
+                    if (!Tcg) {
+                        return Tcg.takeError();
+                    }
+                }
+            }
+        }
+    }
+
+    // The above only maps arguments that are actually used, make a final pass
+    // over the arguments to map unused and immediate arguments.
+    for (auto V : Data.Args.Args) {
+        Expected<TcgV> Arg = mapValue(Data, FreeList, V);
+        if (!Arg) {
+            return Arg.takeError();
+        }
+    }
+
+    return Data;
+}
diff --git a/subprojects/helper-to-tcg/passes/backend/TcgTempAllocationPass.h b/subprojects/helper-to-tcg/passes/backend/TcgTempAllocationPass.h
new file mode 100644
index 0000000000..fff60d1ff6
--- /dev/null
+++ b/subprojects/helper-to-tcg/passes/backend/TcgTempAllocationPass.h
@@ -0,0 +1,79 @@
+//
+//  Copyright(c) 2024 rev.ng Labs Srl. All Rights Reserved.
+//
+//  This program is free software; you can redistribute it and/or modify
+//  it under the terms of the GNU General Public License as published by
+//  the Free Software Foundation; either version 2 of the License, or
+//  (at your option) any later version.
+//
+//  This program is distributed in the hope that it will be useful,
+//  but WITHOUT ANY WARRANTY; without even the implied warranty of
+//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+//  GNU General Public License for more details.
+//
+//  You should have received a copy of the GNU General Public License
+//  along with this program; if not, see <http://www.gnu.org/licenses/>.
+//
+
+#pragma once
+
+#include "FunctionAnnotation.h"
+#include "backend/TcgType.h"
+
+#include <llvm/ADT/SmallSet.h>
+#include <llvm/ADT/StringRef.h>
+#include <llvm/IR/BasicBlock.h>
+#include <llvm/Support/Error.h>
+
+//
+// TcgTempAllocationPass
+//
+// Analysis over the IR that performs basic register allocation to assign
+// identifiers representing TCGv's to all values in a given function.
+//
+// Note: Input code is assumed to be loop free, which drastically simplifies
+// the register allocation. This assumption is reasonable as we expect code
+// with loops to be either unrolled or vectorized, and we currently don't emit
+// for loops in C.
+//
+// This pass also contains the logic for mapping various LLVM values to a TcgV
+// struct, which is necessary in order to figure out what type we need for in
+// TCG.
+//
+
+namespace llvm
+{
+class Function;
+}
+
+enum ArgumentKind {
+    ArgTemp,
+    ArgImmediate,
+    ArgPtrToOffset,
+};
+
+struct Arguments {
+    llvm::Optional<const llvm::Value *> EnvPtr;
+    llvm::DenseMap<const llvm::Value *, ArgumentKind> ArgInfoMap;
+    llvm::SmallSet<const llvm::Value *, 8> Args;
+};
+
+struct TempAllocationData {
+    // Mapping of LLVM Values to the corresponding TcgV
+    llvm::DenseMap<const llvm::Value *, TcgV> Map;
+
+    // Whether or not the final mov in an instruction can safely
+    // be ignored or not.
+    bool SkipReturnMov = false;
+    llvm::Optional<TcgV> ReturnValue;
+    Arguments Args;
+
+    inline TcgV map(const llvm::Value *V, const TcgV &T)
+    {
+        return Map.try_emplace(V, T).first->second;
+    }
+};
+
+llvm::Expected<TempAllocationData>
+allocateTemporaries(const llvm::Function &F,
+                    const AnnotationMapTy &Annotations);
diff --git a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
index a8df592af3..b933a7bb1a 100644
--- a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
+++ b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
@@ -62,6 +62,12 @@ cl::opt<std::string> TcgGlobalMappingsName(
              "into a struct to TCG globals"),
     cl::init("mappings"), cl::cat(Cat));
 
+// Options for TcgTempAllocation
+cl::opt<uint32_t>
+    GuestPtrSize("guest-ptr-size",
+                 cl::desc("Pointer size of the guest architecture"),
+                 cl::init(32), cl::cat(Cat));
+
 // Define a TargetTransformInfo (TTI) subclass, this allows for overriding
 // common per-llvm-target information expected by other LLVM passes, such
 // as the width of the largest scalar/vector registers.  Needed for consistent
-- 
2.45.2


