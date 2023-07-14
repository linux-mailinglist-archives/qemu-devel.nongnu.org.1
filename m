Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A6C7539DA
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:44:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH9J-0000fc-Jt; Fri, 14 Jul 2023 07:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH9B-0000ZM-I8; Fri, 14 Jul 2023 07:39:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH96-0004Jl-RG; Fri, 14 Jul 2023 07:39:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 215E213D9A;
 Fri, 14 Jul 2023 14:38:57 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 17CFF14BA9;
 Fri, 14 Jul 2023 14:38:41 +0300 (MSK)
Received: (nullmailer pid 1186237 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 14/29] tree-wide spelling fixes in comments and some
 messages: hexagon
Date: Fri, 14 Jul 2023 14:38:19 +0300
Message-Id: <20230714113834.1186117-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/hexagon/README                       |  2 +-
 target/hexagon/fma_emu.c                    |  2 +-
 target/hexagon/idef-parser/README.rst       |  2 +-
 target/hexagon/idef-parser/idef-parser.h    |  2 +-
 target/hexagon/idef-parser/parser-helpers.c |  6 +++---
 target/hexagon/imported/alu.idef            |  8 ++++----
 target/hexagon/imported/macros.def          |  2 +-
 target/hexagon/imported/mmvec/ext.idef      | 10 +++++-----
 tests/tcg/hexagon/fpstuff.c                 |  2 +-
 tests/tcg/hexagon/test_clobber.S            |  2 +-
 10 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/hexagon/README b/target/hexagon/README
index 43811178e9..e757bcb64a 100644
--- a/target/hexagon/README
+++ b/target/hexagon/README
@@ -241,3 +241,3 @@ VLIW packet semantics differ from serial semantics in that all input operands
 are read, then the operations are performed, then all the results are written.
-For exmaple, this packet performs a swap of registers r0 and r1
+For example, this packet performs a swap of registers r0 and r1
     { r0 = r1; r1 = r0 }
diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index d3b45d494f..05a56d8c10 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -417,3 +417,3 @@ static SUFFIX accum_round_##SUFFIX(Accum a, float_status * fp_status) \
      * shifted out lots of bits from B, or if we had no shift / 1 shift sticky \
-     * shoudl be 0  \
+     * should be 0  \
      */ \
diff --git a/target/hexagon/idef-parser/README.rst b/target/hexagon/idef-parser/README.rst
index debeddfde5..d0aa34309b 100644
--- a/target/hexagon/idef-parser/README.rst
+++ b/target/hexagon/idef-parser/README.rst
@@ -442,3 +442,3 @@ Run-time errors can be divided between lexing and parsing errors, lexing errors
 are hard to detect, since the ``var`` token will catch everything which is not
-catched by other tokens, but easy to fix, because most of the time a simple
+caught by other tokens, but easy to fix, because most of the time a simple
 regex editing will be enough.
diff --git a/target/hexagon/idef-parser/idef-parser.h b/target/hexagon/idef-parser/idef-parser.h
index d23e71f13b..3faa1deecd 100644
--- a/target/hexagon/idef-parser/idef-parser.h
+++ b/target/hexagon/idef-parser/idef-parser.h
@@ -75,3 +75,3 @@ typedef struct HexTmp {
 /**
- * Enum of the possible immediated, an immediate is a value which is known
+ * Enum of the possible immediate, an immediate is a value which is known
  * at tinycode generation time, e.g. an integer value, not a TCGv
diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
index 7b5ebafec2..ec43343801 100644
--- a/target/hexagon/idef-parser/parser-helpers.c
+++ b/target/hexagon/idef-parser/parser-helpers.c
@@ -461,3 +461,3 @@ static bool try_find_variable(Context *c, YYLTYPE *locp,
 
-/* Calls `try_find_variable` and asserts succcess. */
+/* Calls `try_find_variable` and asserts success. */
 static void find_variable(Context *c, YYLTYPE *locp,
@@ -551,3 +551,3 @@ HexValue gen_bin_cmp(Context *c,
     default:
-        fprintf(stderr, "Error in evalutating immediateness!");
+        fprintf(stderr, "Error in evaluating immediateness!");
         abort();
@@ -1166,3 +1166,3 @@ void gen_rdeposit_op(Context *c,
      * Otherwise if the width is not known, we fallback on reimplementing
-     * desposit in TCG.
+     * deposit in TCG.
      */
diff --git a/target/hexagon/imported/alu.idef b/target/hexagon/imported/alu.idef
index 58477ae40a..12d2aac5d4 100644
--- a/target/hexagon/imported/alu.idef
+++ b/target/hexagon/imported/alu.idef
@@ -294,12 +294,12 @@ Q6INSN(A4_combineii,"Rdd32=combine(#s8,#U6)",ATTRIBS(),"Set two small immediates
 Q6INSN(A2_combine_hh,"Rd32=combine(Rt.H32,Rs.H32)",ATTRIBS(),
-"Combine two halfs into a register", {RdV = (fGETUHALF(1,RtV)<<16) | fGETUHALF(1,RsV);})
+"Combine two halves into a register", {RdV = (fGETUHALF(1,RtV)<<16) | fGETUHALF(1,RsV);})
 
 Q6INSN(A2_combine_hl,"Rd32=combine(Rt.H32,Rs.L32)",ATTRIBS(),
-"Combine two halfs into a register", {RdV = (fGETUHALF(1,RtV)<<16) | fGETUHALF(0,RsV);})
+"Combine two halves into a register", {RdV = (fGETUHALF(1,RtV)<<16) | fGETUHALF(0,RsV);})
 
 Q6INSN(A2_combine_lh,"Rd32=combine(Rt.L32,Rs.H32)",ATTRIBS(),
-"Combine two halfs into a register", {RdV = (fGETUHALF(0,RtV)<<16) | fGETUHALF(1,RsV);})
+"Combine two halves into a register", {RdV = (fGETUHALF(0,RtV)<<16) | fGETUHALF(1,RsV);})
 
 Q6INSN(A2_combine_ll,"Rd32=combine(Rt.L32,Rs.L32)",ATTRIBS(),
-"Combine two halfs into a register", {RdV = (fGETUHALF(0,RtV)<<16) | fGETUHALF(0,RsV);})
+"Combine two halves into a register", {RdV = (fGETUHALF(0,RtV)<<16) | fGETUHALF(0,RsV);})
 
diff --git a/target/hexagon/imported/macros.def b/target/hexagon/imported/macros.def
index e23f91562e..4bbcfdd5e1 100755
--- a/target/hexagon/imported/macros.def
+++ b/target/hexagon/imported/macros.def
@@ -904,3 +904,3 @@ DEF_MACRO(
 DEF_MACRO(
-    fEA_GPI, /* Calculate EA with Global Poitner + Immediate */
+    fEA_GPI, /* Calculate EA with Global Pointer + Immediate */
     do { EA=fREAD_GP()+IMM; fGP_DOCHKPAGECROSS(fREAD_GP(),EA); } while (0),
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index ead32c243b..98daabfb07 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -19,3 +19,3 @@
  *
- *     HOYA: MULTI MEDIA INSTRUCITONS
+ *     HOYA: MULTI MEDIA INSTRUCTIONS
  *
@@ -297,3 +297,3 @@ MMVEC_EACH_EA(vS32b_new,"Aligned Vector Store New",ATTRIBS(ATTR_VMEM,A_STORE,A_C
 
-// V65 store relase, zero byte store
+// V65 store release, zero byte store
 MMVEC_EACH_EA(vS32b_srls,"Aligned Vector Scatter Release",ATTRIBS(ATTR_VMEM,A_STORE,A_CVI_SCATTER_RELEASE,A_CVI_NEW,A_RESTRICT_SLOT0ONLY),,"vmem",":scatter_release",fSTORERELEASE(EA,0))
@@ -2047,7 +2047,7 @@ VxV.uw[0] = RtV;)
 
-ITERATOR_INSN_MPY_SLOT_LATE(32,lvsplatw, "Vd32=vsplat(Rt32)", "Replicates scalar accross words in vector", VdV.uw[i] = RtV)
+ITERATOR_INSN_MPY_SLOT_LATE(32,lvsplatw, "Vd32=vsplat(Rt32)", "Replicates scalar across words in vector", VdV.uw[i] = RtV)
 
-ITERATOR_INSN_MPY_SLOT_LATE(16,lvsplath, "Vd32.h=vsplat(Rt32)", "Replicates scalar accross halves in vector", VdV.uh[i] = RtV)
+ITERATOR_INSN_MPY_SLOT_LATE(16,lvsplath, "Vd32.h=vsplat(Rt32)", "Replicates scalar across halves in vector", VdV.uh[i] = RtV)
 
-ITERATOR_INSN_MPY_SLOT_LATE(8,lvsplatb, "Vd32.b=vsplat(Rt32)", "Replicates scalar accross bytes in vector", VdV.ub[i] = RtV)
+ITERATOR_INSN_MPY_SLOT_LATE(8,lvsplatb, "Vd32.b=vsplat(Rt32)", "Replicates scalar across bytes in vector", VdV.ub[i] = RtV)
 
diff --git a/tests/tcg/hexagon/fpstuff.c b/tests/tcg/hexagon/fpstuff.c
index 344b9f7772..6aadaccabd 100644
--- a/tests/tcg/hexagon/fpstuff.c
+++ b/tests/tcg/hexagon/fpstuff.c
@@ -54,3 +54,3 @@ static void check_compare_exception(void)
 
-    /* Check that FP compares are quiet (don't raise any execptions) */
+    /* Check that FP compares are quiet (don't raise any exceptions) */
     asm (CLEAR_FPSTATUS
diff --git a/tests/tcg/hexagon/test_clobber.S b/tests/tcg/hexagon/test_clobber.S
index a7aeb2b60c..10046c30d2 100644
--- a/tests/tcg/hexagon/test_clobber.S
+++ b/tests/tcg/hexagon/test_clobber.S
@@ -1,3 +1,3 @@
 /*
- * Purpose: demonstrate the succesful operation of the register save mechanism,
+ * Purpose: demonstrate the successful operation of the register save mechanism,
  * in which the caller saves the registers that will be clobbered, and restores
-- 
2.39.2


