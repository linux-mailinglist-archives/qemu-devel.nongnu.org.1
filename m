Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 953EE9D4581
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Nov 2024 02:51:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwJ3-0004p2-Ao; Wed, 20 Nov 2024 20:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwJ1-0004cL-1P
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:48:27 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwIy-0004k7-OA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=9+JUQklo1fAygUmg6bP51Hb2Kw75ebMHVooLkGmxJb8=; b=G2l6wby7s4PHfXm
 lVpwpOackaLd3ILYRkfYJSLyj0zbLBaucoTDqvWOajwhJkh8RlkTnw6XrZa23wlYtEC5nrjKN0B6Z
 qDHjJm3GWxE06KD6LgGMftIg3jtLo+fwLNBb6j7JlzNSnAAThbFD3lBof2f9Vzeev1B0Xnt9U71+V
 xA=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 40/43] target/hexagon: Emit annotations for helpers
Date: Thu, 21 Nov 2024 02:49:44 +0100
Message-ID: <20241121014947.18666-41-anjo@rev.ng>
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

Adds the following LLVM_ANNOTATE attributes to helper functions generated
by Hexagon:

  1. "helper-to-tcg", to specify that a given helper functions should be
     translated, and;

  2. "immediate: ..." to make sure immediate arguments to helper
     functions remain immediates in the emitted TCG code (e.g. slot).

  3. "ptr-to-offset: ..." to make sure pointer arguments are treated as
     immediates representing an offset into the CPU state, needed to
     work with gvec.

Two functions are also added to hex_common.py, to firstly parse the
generated file containing all successfully translated helper functions,
and secondly to expose the indices of immediate and pointer (vector)
arguments to helper functions.  The latter is needed to generate the
input of helper-to-tcg.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/gen_helper_funcs.py  | 17 ++++++++++-
 target/hexagon/gen_helper_protos.py |  2 +-
 target/hexagon/gen_tcg_funcs.py     |  2 +-
 target/hexagon/hex_common.py        | 45 +++++++++++++++++++++++------
 target/hexagon/op_helper.c          |  1 +
 5 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/target/hexagon/gen_helper_funcs.py b/target/hexagon/gen_helper_funcs.py
index c1f806ac4b..7f0844d843 100755
--- a/target/hexagon/gen_helper_funcs.py
+++ b/target/hexagon/gen_helper_funcs.py
@@ -41,9 +41,23 @@ def gen_helper_function(f, tag, tagregs, tagimms):
     ret_type = hex_common.helper_ret_type(tag, regs).func_arg
 
     declared = []
-    for arg in hex_common.helper_args(tag, regs, imms):
+    helper_args, imm_inds, hvx_inds = hex_common.helper_args(tag, regs, imms)
+    for arg in helper_args:
         declared.append(arg.func_arg)
 
+    ## Specify that helpers should be translated by helper-to-tcg
+    f.write(f'LLVM_ANNOTATE("helper-to-tcg")\n')
+    ## Specify which arguments to the helper function should be treated as
+    ## immediate arguments
+    if len(imm_inds) > 0:
+        imm_inds_str = ','.join(str(i) for i in imm_inds)
+        f.write(f'LLVM_ANNOTATE("immediate: {imm_inds_str}")\n')
+    ## Specify which arguments to the helper function should be treated as
+    ## gvec vectors
+    if len(hvx_inds) > 0:
+        hvx_inds_str = ','.join(str(i) for i in hvx_inds)
+        f.write(f'LLVM_ANNOTATE("ptr-to-offset: {hvx_inds_str}")\n')
+
     arguments = ", ".join(declared)
     f.write(f"{ret_type} HELPER({tag})({arguments})\n")
     f.write("{\n")
@@ -51,6 +65,7 @@ def gen_helper_function(f, tag, tagregs, tagimms):
         f.write(hex_common.code_fmt(f"""\
             uint32_t EA;
         """))
+
     ## Declare the return variable
     if not hex_common.is_predicated(tag):
         for regtype, regid in regs:
diff --git a/target/hexagon/gen_helper_protos.py b/target/hexagon/gen_helper_protos.py
index 77f8e0a6a3..2082757891 100755
--- a/target/hexagon/gen_helper_protos.py
+++ b/target/hexagon/gen_helper_protos.py
@@ -36,7 +36,7 @@ def gen_helper_prototype(f, tag, tagregs, tagimms):
     ret_type = hex_common.helper_ret_type(tag, regs).proto_arg
     declared.append(ret_type)
 
-    for arg in hex_common.helper_args(tag, regs, imms):
+    for arg in hex_common.helper_args(tag, regs, imms)[0]:
         declared.append(arg.proto_arg)
 
     arguments = ", ".join(declared)
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index c2ba91ddc0..a06edeb9de 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -85,7 +85,7 @@ def gen_tcg_func(f, tag, regs, imms):
         if ret_type != "void":
             declared.append(ret_type)
 
-        for arg in hex_common.helper_args(tag, regs, imms):
+        for arg in hex_common.helper_args(tag, regs, imms)[0]:
             declared.append(arg.call_arg)
 
         arguments = ", ".join(declared)
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index bb20711a2e..fc4c9f648e 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -32,6 +32,7 @@
 tags = []  # list of all tags
 overrides = {}  # tags with helper overrides
 idef_parser_enabled = {}  # tags enabled for idef-parser
+helper_to_tcg_enabled = {}  # tags enabled for helper-to-tcg
 
 # We should do this as a hash for performance,
 # but to keep order let's keep it as a list.
@@ -262,6 +263,10 @@ def is_idef_parser_enabled(tag):
     return tag in idef_parser_enabled
 
 
+def is_helper_to_tcg_enabled(tag):
+    return tag in helper_to_tcg_enabled
+
+
 def is_hvx_insn(tag):
     return "A_CVI" in attribdict[tag]
 
@@ -304,6 +309,13 @@ def read_idef_parser_enabled_file(name):
         idef_parser_enabled = set(lines)
 
 
+def read_helper_to_tcg_enabled_file(name):
+    global helper_to_tcg_enabled
+    with open(name, "r") as helper_to_tcg_enabled_file:
+        lines = helper_to_tcg_enabled_file.read().strip().split("\n")
+        helper_to_tcg_enabled = set(lines)
+
+
 def is_predicated(tag):
     return "A_CONDEXEC" in attribdict[tag]
 
@@ -383,7 +395,7 @@ def hvx_off(self):
     def helper_proto_type(self):
         return "ptr"
     def helper_arg_type(self):
-        return "void *"
+        return "void * restrict"
     def helper_arg_name(self):
         return f"{self.reg_tcg()}_void"
 
@@ -719,7 +731,7 @@ def decl_tcg(self, f, tag, regno):
             const intptr_t {self.hvx_off()} =
                 {vreg_offset_func(tag)}(ctx, {self.reg_num}, 1, true);
         """))
-        if not skip_qemu_helper(tag):
+        if not skip_qemu_helper(tag) and not is_helper_to_tcg_enabled(tag):
             f.write(code_fmt(f"""\
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
@@ -744,7 +756,7 @@ def decl_tcg(self, f, tag, regno):
         f.write(code_fmt(f"""\
             const intptr_t {self.hvx_off()} = vreg_src_off(ctx, {self.reg_num});
         """))
-        if not skip_qemu_helper(tag):
+        if not skip_qemu_helper(tag) and not is_helper_to_tcg_enabled(tag):
             f.write(code_fmt(f"""\
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
@@ -785,7 +797,7 @@ def decl_tcg(self, f, tag, regno):
                              vreg_src_off(ctx, {self.reg_num}),
                              sizeof(MMVector), sizeof(MMVector));
         """))
-        if not skip_qemu_helper(tag):
+        if not skip_qemu_helper(tag) and not is_helper_to_tcg_enabled(tag):
             f.write(code_fmt(f"""\
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
@@ -814,7 +826,7 @@ def decl_tcg(self, f, tag, regno):
         f.write(code_fmt(f"""\
             const intptr_t {self.hvx_off()} = offsetof(CPUHexagonState, vtmp);
         """))
-        if not skip_qemu_helper(tag):
+        if not skip_qemu_helper(tag) and not is_helper_to_tcg_enabled(tag):
             f.write(code_fmt(f"""\
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
@@ -850,7 +862,7 @@ def decl_tcg(self, f, tag, regno):
             const intptr_t {self.hvx_off()} =
                 {vreg_offset_func(tag)}(ctx, {self.reg_num}, 2, true);
         """))
-        if not skip_qemu_helper(tag):
+        if not skip_qemu_helper(tag) and not is_helper_to_tcg_enabled(tag):
             f.write(code_fmt(f"""\
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
@@ -882,7 +894,7 @@ def decl_tcg(self, f, tag, regno):
                              vreg_src_off(ctx, {self.reg_num} ^ 1),
                              sizeof(MMVector), sizeof(MMVector));
         """))
-        if not skip_qemu_helper(tag):
+        if not skip_qemu_helper(tag) and not is_helper_to_tcg_enabled(tag):
             f.write(code_fmt(f"""\
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
@@ -909,7 +921,7 @@ def decl_tcg(self, f, tag, regno):
                              vreg_src_off(ctx, {self.reg_num} ^ 1),
                              sizeof(MMVector), sizeof(MMVector));
         """))
-        if not skip_qemu_helper(tag):
+        if not skip_qemu_helper(tag) and not is_helper_to_tcg_enabled(tag):
             f.write(code_fmt(f"""\
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
@@ -1092,8 +1104,13 @@ def helper_ret_type(tag, regs):
         raise Exception("numscalarresults > 1")
     return return_type
 
+
 def helper_args(tag, regs, imms):
     args = []
+    # Used to ensure immediates are passed translated as immediates by
+    # helper-to-tcg.
+    imm_indices = []
+    hvx_indices = []
 
     ## First argument is the CPU state
     if need_env(tag):
@@ -1114,16 +1131,20 @@ def helper_args(tag, regs, imms):
     for regtype, regid in regs:
         reg = get_register(tag, regtype, regid)
         if reg.is_written() and reg.is_hvx_reg():
+            hvx_indices.append(len(args))
             args.append(reg.helper_arg())
 
     ## Pass the source registers
     for regtype, regid in regs:
         reg = get_register(tag, regtype, regid)
         if reg.is_read() and not (reg.is_hvx_reg() and reg.is_readwrite()):
+            if reg.is_hvx_reg():
+                hvx_indices.append(len(args))
             args.append(reg.helper_arg())
 
     ## Pass the immediates
     for immlett, bits, immshift in imms:
+        imm_indices.append(len(args))
         args.append(HelperArg(
             "s32",
             f"tcg_constant_tl({imm_name(immlett)})",
@@ -1132,24 +1153,28 @@ def helper_args(tag, regs, imms):
 
     ## Other stuff the helper might need
     if need_pkt_has_multi_cof(tag):
+        imm_indices.append(len(args))
         args.append(HelperArg(
             "i32",
             "tcg_constant_tl(ctx->pkt->pkt_has_multi_cof)",
             "uint32_t pkt_has_multi_cof"
         ))
     if need_pkt_need_commit(tag):
+        imm_indices.append(len(args))
         args.append(HelperArg(
             "i32",
             "tcg_constant_tl(ctx->need_commit)",
             "uint32_t pkt_need_commit"
         ))
     if need_PC(tag):
+        imm_indices.append(len(args))
         args.append(HelperArg(
             "i32",
             "tcg_constant_tl(ctx->pkt->pc)",
             "target_ulong PC"
         ))
     if need_next_PC(tag):
+        imm_indices.append(len(args))
         args.append(HelperArg(
             "i32",
             "tcg_constant_tl(ctx->next_PC)",
@@ -1168,18 +1193,20 @@ def helper_args(tag, regs, imms):
             "uint32_t SP"
         ))
     if need_slot(tag):
+        imm_indices.append(len(args))
         args.append(HelperArg(
             "i32",
             "gen_slotval(ctx)",
             "uint32_t slotval"
         ))
     if need_part1(tag):
+        imm_indices.append(len(args))
         args.append(HelperArg(
             "i32",
             "tcg_constant_tl(insn->part1)"
             "uint32_t part1"
         ))
-    return args
+    return args, imm_indices, hvx_indices
 
 
 def parse_common_args(desc):
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 0f9c6ab19f..182e8fdeab 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -31,6 +31,7 @@
 #include "mmvec/macros.h"
 #include "op_helper.h"
 #include "translate.h"
+#include "helper-to-tcg/annotate.h"
 
 #define SF_BIAS        127
 #define SF_MANTBITS    23
-- 
2.45.2


