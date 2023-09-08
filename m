Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F89379854B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:58:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYDq-00071e-K6; Fri, 08 Sep 2023 05:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYDj-0006zh-OQ; Fri, 08 Sep 2023 05:56:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYDf-0006UL-SH; Fri, 08 Sep 2023 05:56:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9E574200CB;
 Fri,  8 Sep 2023 12:56:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 98C0D26911;
 Fri,  8 Sep 2023 12:55:56 +0300 (MSK)
Received: (nullmailer pid 275949 invoked by uid 1000);
 Fri, 08 Sep 2023 09:55:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Brian Cain <bcain@quicinc.com>
Subject: [PULL 03/23] hexagon: spelling fixes
Date: Fri,  8 Sep 2023 12:55:00 +0300
Message-Id: <20230908095520.275866-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230908095520.275866-1-mjt@tls.msk.ru>
References: <20230908095520.275866-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Brian Cain <bcain@quicinc.com>
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
@@ -239,7 +239,7 @@ helper_funcs_generated.c.inc.  There are also several helpers used for debugging
 
 VLIW packet semantics differ from serial semantics in that all input operands
 are read, then the operations are performed, then all the results are written.
-For exmaple, this packet performs a swap of registers r0 and r1
+For example, this packet performs a swap of registers r0 and r1
     { r0 = r1; r1 = r0 }
 Note that the result is different if the instructions are executed serially.
 
diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index d3b45d494f..05a56d8c10 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -415,7 +415,7 @@ static SUFFIX accum_round_##SUFFIX(Accum a, float_status * fp_status) \
      * We want to normalize left until we have a leading one in bit 24 \
      * Theoretically, we only need to shift a maximum of one to the left if we \
      * shifted out lots of bits from B, or if we had no shift / 1 shift sticky \
-     * shoudl be 0  \
+     * should be 0  \
      */ \
     while ((int128_getlo(a.mant) & (1ULL << MANTBITS)) == 0) { \
         a = accum_norm_left(a); \
diff --git a/target/hexagon/idef-parser/README.rst b/target/hexagon/idef-parser/README.rst
index debeddfde5..d0aa34309b 100644
--- a/target/hexagon/idef-parser/README.rst
+++ b/target/hexagon/idef-parser/README.rst
@@ -440,7 +440,7 @@ interested part of the grammar.
 
 Run-time errors can be divided between lexing and parsing errors, lexing errors
 are hard to detect, since the ``var`` token will catch everything which is not
-catched by other tokens, but easy to fix, because most of the time a simple
+caught by other tokens, but easy to fix, because most of the time a simple
 regex editing will be enough.
 
 idef-parser features a fancy parsing error reporting scheme, which for each
diff --git a/target/hexagon/idef-parser/idef-parser.h b/target/hexagon/idef-parser/idef-parser.h
index d23e71f13b..3faa1deecd 100644
--- a/target/hexagon/idef-parser/idef-parser.h
+++ b/target/hexagon/idef-parser/idef-parser.h
@@ -73,7 +73,7 @@ typedef struct HexTmp {
 } HexTmp;
 
 /**
- * Enum of the possible immediated, an immediate is a value which is known
+ * Enum of the possible immediate, an immediate is a value which is known
  * at tinycode generation time, e.g. an integer value, not a TCGv
  */
 enum ImmUnionTag {
diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
index 7b5ebafec2..ec43343801 100644
--- a/target/hexagon/idef-parser/parser-helpers.c
+++ b/target/hexagon/idef-parser/parser-helpers.c
@@ -459,7 +459,7 @@ static bool try_find_variable(Context *c, YYLTYPE *locp,
     return false;
 }
 
-/* Calls `try_find_variable` and asserts succcess. */
+/* Calls `try_find_variable` and asserts success. */
 static void find_variable(Context *c, YYLTYPE *locp,
                           HexValue *dst,
                           HexValue *varid)
@@ -549,7 +549,7 @@ HexValue gen_bin_cmp(Context *c,
             ");\n");
         break;
     default:
-        fprintf(stderr, "Error in evalutating immediateness!");
+        fprintf(stderr, "Error in evaluating immediateness!");
         abort();
     }
     return res;
@@ -1164,7 +1164,7 @@ void gen_rdeposit_op(Context *c,
 {
     /*
      * Otherwise if the width is not known, we fallback on reimplementing
-     * desposit in TCG.
+     * deposit in TCG.
      */
     HexValue begin_m = *begin;
     HexValue value_m = *value;
diff --git a/target/hexagon/imported/alu.idef b/target/hexagon/imported/alu.idef
index 58477ae40a..12d2aac5d4 100644
--- a/target/hexagon/imported/alu.idef
+++ b/target/hexagon/imported/alu.idef
@@ -292,16 +292,16 @@ Q6INSN(A4_combineii,"Rdd32=combine(#s8,#U6)",ATTRIBS(),"Set two small immediates
 
 
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
 
 Q6INSN(A2_tfril,"Rx.L32=#u16",ATTRIBS(),
 "Set low 16-bits, leave upper 16 unchanged",{ fSETHALF(0,RxV,uiV);})
diff --git a/target/hexagon/imported/macros.def b/target/hexagon/imported/macros.def
index e23f91562e..4bbcfdd5e1 100755
--- a/target/hexagon/imported/macros.def
+++ b/target/hexagon/imported/macros.def
@@ -902,7 +902,7 @@ DEF_MACRO(
 )
 
 DEF_MACRO(
-    fEA_GPI, /* Calculate EA with Global Poitner + Immediate */
+    fEA_GPI, /* Calculate EA with Global Pointer + Immediate */
     do { EA=fREAD_GP()+IMM; fGP_DOCHKPAGECROSS(fREAD_GP(),EA); } while (0),
     ()
 )
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index ead32c243b..98daabfb07 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -17,7 +17,7 @@
 
 /******************************************************************************
  *
- *     HOYA: MULTI MEDIA INSTRUCITONS
+ *     HOYA: MULTI MEDIA INSTRUCTIONS
  *
  ******************************************************************************/
 
@@ -295,7 +295,7 @@ MMVEC_COND_EACH_EA(vS32Ub,"Unaligned Vector Store",ATTRIBS(ATTR_VMEMU,A_STORE,A_
 
 MMVEC_EACH_EA(vS32b_new,"Aligned Vector Store New",ATTRIBS(ATTR_VMEM,A_STORE,A_CVI_NEW,A_DOTNEWVALUE,A_RESTRICT_SLOT0ONLY),,"vmem","=Os8.new",fSTOREMMV(EA,fNEWVREG(OsN)))
 
-// V65 store relase, zero byte store
+// V65 store release, zero byte store
 MMVEC_EACH_EA(vS32b_srls,"Aligned Vector Scatter Release",ATTRIBS(ATTR_VMEM,A_STORE,A_CVI_SCATTER_RELEASE,A_CVI_NEW,A_RESTRICT_SLOT0ONLY),,"vmem",":scatter_release",fSTORERELEASE(EA,0))
 
 
@@ -2045,11 +2045,11 @@ VxV.uw[0] = RtV;)
 
 
 
-ITERATOR_INSN_MPY_SLOT_LATE(32,lvsplatw, "Vd32=vsplat(Rt32)", "Replicates scalar accross words in vector", VdV.uw[i] = RtV)
+ITERATOR_INSN_MPY_SLOT_LATE(32,lvsplatw, "Vd32=vsplat(Rt32)", "Replicates scalar across words in vector", VdV.uw[i] = RtV)
 
-ITERATOR_INSN_MPY_SLOT_LATE(16,lvsplath, "Vd32.h=vsplat(Rt32)", "Replicates scalar accross halves in vector", VdV.uh[i] = RtV)
+ITERATOR_INSN_MPY_SLOT_LATE(16,lvsplath, "Vd32.h=vsplat(Rt32)", "Replicates scalar across halves in vector", VdV.uh[i] = RtV)
 
-ITERATOR_INSN_MPY_SLOT_LATE(8,lvsplatb, "Vd32.b=vsplat(Rt32)", "Replicates scalar accross bytes in vector", VdV.ub[i] = RtV)
+ITERATOR_INSN_MPY_SLOT_LATE(8,lvsplatb, "Vd32.b=vsplat(Rt32)", "Replicates scalar across bytes in vector", VdV.ub[i] = RtV)
 
 
 ITERATOR_INSN_ANY_SLOT(32,vassign,"Vd32=Vu32","Copy a vector",VdV.w[i]=VuV.w[i])
diff --git a/tests/tcg/hexagon/fpstuff.c b/tests/tcg/hexagon/fpstuff.c
index 344b9f7772..6aadaccabd 100644
--- a/tests/tcg/hexagon/fpstuff.c
+++ b/tests/tcg/hexagon/fpstuff.c
@@ -52,7 +52,7 @@ static void check_compare_exception(void)
     uint32_t cmp;
     uint32_t usr;
 
-    /* Check that FP compares are quiet (don't raise any execptions) */
+    /* Check that FP compares are quiet (don't raise any exceptions) */
     asm (CLEAR_FPSTATUS
          "p0 = sfcmp.eq(%2, %3)\n\t"
          "%0 = p0\n\t"
diff --git a/tests/tcg/hexagon/test_clobber.S b/tests/tcg/hexagon/test_clobber.S
index a7aeb2b60c..10046c30d2 100644
--- a/tests/tcg/hexagon/test_clobber.S
+++ b/tests/tcg/hexagon/test_clobber.S
@@ -1,5 +1,5 @@
 /*
- * Purpose: demonstrate the succesful operation of the register save mechanism,
+ * Purpose: demonstrate the successful operation of the register save mechanism,
  * in which the caller saves the registers that will be clobbered, and restores
  * them after the call.
  */
-- 
2.39.2


