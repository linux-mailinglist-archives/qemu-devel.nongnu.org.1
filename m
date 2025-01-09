Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68919A06E75
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Jan 2025 07:59:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVmUu-00045u-3Y; Thu, 09 Jan 2025 01:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tVmUp-00044M-FW
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:58:23 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tVmUn-0000V2-DL
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:58:23 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxmeGCc39nUnBgAA--.61944S3;
 Thu, 09 Jan 2025 14:58:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxXMV8c39nCtkaAA--.46678S5;
 Thu, 09 Jan 2025 14:58:10 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 3/6] target/loongarch: Only support 64bit pte width
Date: Thu,  9 Jan 2025 14:58:01 +0800
Message-Id: <20250109065804.1569654-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250109065804.1569654-1-maobibo@loongson.cn>
References: <20250109065804.1569654-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxXMV8c39nCtkaAA--.46678S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

iFrom LoongArch Reference Manual pte width can be 64bit, 128bit
or more. Instead real hardware only supports 64bit pte width.
For 12bit pte, there is no detail definition for all 128bit
from manual.

Here only 64bit pte width is supported for simplicity, will add
this in later if real hw support it and there is definition for
all the bits from manual.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/helper.h                     |  1 +
 target/loongarch/tcg/csr_helper.c             | 21 +++++++++++++++++++
 .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
 target/loongarch/tcg/tlb_helper.c             | 17 +++------------
 4 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index b3b64a0215..943517b5f2 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -104,6 +104,7 @@ DEF_HELPER_2(csrwr_estat, i64, env, tl)
 DEF_HELPER_2(csrwr_asid, i64, env, tl)
 DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
 DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
+DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
 DEF_HELPER_2(iocsrrd_b, i64, env, tl)
 DEF_HELPER_2(iocsrrd_h, i64, env, tl)
 DEF_HELPER_2(iocsrrd_w, i64, env, tl)
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 15f94caefa..6c95be9910 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
 #include "internals.h"
@@ -95,3 +96,23 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
     }
     return old_v;
 }
+
+target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
+{
+    int shift;
+    int64_t old_v = env->CSR_PWCL;
+
+    /*
+     * The real hardware only supports 64bit PTE width now, 128bit or others
+     * treated as illegal.
+     */
+    shift = FIELD_EX64(val, CSR_PWCL, PTEWIDTH);
+    if (shift) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Attempted set pte width with %d bit\n", 64 << shift);
+        val = FIELD_DP64(val, CSR_PWCL, PTEWIDTH, 0);
+    }
+
+    env->CSR_PWCL = val;
+    return old_v;
+}
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 7e4ec93edb..30f9b83fb2 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -95,7 +95,7 @@ static const CSRInfo csr_info[] = {
     CSR_OFF(PGDL),
     CSR_OFF(PGDH),
     CSR_OFF_FUNCS(PGD, CSRFL_READONLY, gen_helper_csrrd_pgd, NULL),
-    CSR_OFF(PWCL),
+    CSR_OFF_FUNCS(PWCL, 0, NULL, gen_helper_csrwr_pwcl),
     CSR_OFF(PWCH),
     CSR_OFF(STLBPS),
     CSR_OFF(RVACFG),
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 97f38fc391..8c61fe728c 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -512,7 +512,6 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
 {
     CPUState *cs = env_cpu(env);
     target_ulong badvaddr, index, phys, ret;
-    int shift;
     uint64_t dir_base, dir_width;
 
     if (unlikely((level == 0) || (level > 4))) {
@@ -537,14 +536,9 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
 
     badvaddr = env->CSR_TLBRBADV;
     base = base & TARGET_PHYS_MASK;
-
-    /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
-    shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
-    shift = (shift + 1) * 3;
-
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
-    phys = base | index << shift;
+    phys = base | index << 3;
     ret = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
     return ret;
 }
@@ -554,7 +548,6 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
 {
     CPUState *cs = env_cpu(env);
     target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1, ps, badv;
-    int shift;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
     uint64_t dir_base, dir_width;
@@ -595,16 +588,12 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
             tmp0 += MAKE_64BIT_MASK(ps, 1);
         }
     } else {
-        /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
-        shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
-        shift = (shift + 1) * 3;
         badv = env->CSR_TLBRBADV;
 
         ptindex = (badv >> ptbase) & ((1 << ptwidth) - 1);
         ptindex = ptindex & ~0x1;   /* clear bit 0 */
-        ptoffset0 = ptindex << shift;
-        ptoffset1 = (ptindex + 1) << shift;
-
+        ptoffset0 = ptindex << 3;
+        ptoffset1 = (ptindex + 1) << 3;
         phys = base | (odd ? ptoffset1 : ptoffset0);
         tmp0 = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
         ps = ptbase;
-- 
2.43.5


