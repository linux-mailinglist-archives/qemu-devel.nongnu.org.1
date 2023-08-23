Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41C78501B
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:53:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgnO-0001UU-2n; Wed, 23 Aug 2023 01:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgnF-0001Sr-Oe
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:52:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgnC-0007Lu-Rg
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:52:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A6D741C395
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 08:52:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4FD8B2123D;
 Wed, 23 Aug 2023 08:52:02 +0300 (MSK)
Received: (nullmailer pid 1917477 invoked by uid 1000);
 Wed, 23 Aug 2023 05:52:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 08/24] mips: spelling fixes
Date: Wed, 23 Aug 2023 08:51:39 +0300
Message-Id: <20230823055155.1917375-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1691405748.git.mjt@tls.msk.ru>
References: <cover.1691405748.git.mjt@tls.msk.ru>
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
---
 hw/mips/malta.c                 |  2 +-
 target/mips/cpu-defs.c.inc      |  2 +-
 target/mips/tcg/msa_helper.c    | 12 ++++++------
 target/mips/tcg/mxu_translate.c |  6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index f9618fa5f5..16e9c4773f 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -628,5 +628,5 @@ static void bl_setup_gt64120_jump_kernel(void **p, uint64_t run_addr,
     };
 
-    /* Bus endianess is always reversed */
+    /* Bus endianness is always reversed */
 #if TARGET_BIG_ENDIAN
 #define cpu_to_gt32(x) (x)
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 03185d9aa0..c0c389c59a 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -1046,5 +1046,5 @@ static void mvp_init(CPUMIPSState *env)
     }
 
-    /* MVPConf1 implemented, TLB sharable, no gating storage support,
+    /* MVPConf1 implemented, TLB shareable, no gating storage support,
        programmable cache partitioning implemented, number of allocatable
        and shareable TLB entries, MVP has allocatable TCs, 2 VPEs
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 29b31d70fe..6e93a19a93 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -803,7 +803,7 @@ void helper_msa_bset_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
  * | HADD_S.W      | Vector Signed Horizontal Add (word)                      |
  * | HADD_S.D      | Vector Signed Horizontal Add (doubleword)                |
- * | HADD_U.H      | Vector Unigned Horizontal Add (halfword)                 |
- * | HADD_U.W      | Vector Unigned Horizontal Add (word)                     |
- * | HADD_U.D      | Vector Unigned Horizontal Add (doubleword)               |
+ * | HADD_U.H      | Vector Unsigned Horizontal Add (halfword)                |
+ * | HADD_U.W      | Vector Unsigned Horizontal Add (word)                    |
+ * | HADD_U.D      | Vector Unsigned Horizontal Add (doubleword)              |
  * +---------------+----------------------------------------------------------+
  */
@@ -3452,7 +3452,7 @@ void helper_msa_mulv_d(CPUMIPSState *env,
  * | HSUB_S.W      | Vector Signed Horizontal Subtract (word)                 |
  * | HSUB_S.D      | Vector Signed Horizontal Subtract (doubleword)           |
- * | HSUB_U.H      | Vector Unigned Horizontal Subtract (halfword)            |
- * | HSUB_U.W      | Vector Unigned Horizontal Subtract (word)                |
- * | HSUB_U.D      | Vector Unigned Horizontal Subtract (doubleword)          |
+ * | HSUB_U.H      | Vector Unsigned Horizontal Subtract (halfword)           |
+ * | HSUB_U.W      | Vector Unsigned Horizontal Subtract (word)               |
+ * | HSUB_U.D      | Vector Unsigned Horizontal Subtract (doubleword)         |
  * | SUBS_S.B      | Vector Signed Saturated Subtract (of Signed) (byte)      |
  * | SUBS_S.H      | Vector Signed Saturated Subtract (of Signed) (halfword)  |
diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index e662acd5df..cfcd8ac9bc 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -2978,5 +2978,5 @@ static void gen_mxu_Q8ADD(DisasContext *ctx)
  *    to 16-bit and put results as packed 16-bit data
  *    into XRa and XRd.
- *    aptn2 manages action add or subract of pairs of data.
+ *    aptn2 manages action add or subtract of pairs of data.
  *
  *  Q8ACCE XRa, XRb, XRc, XRd, aptn2
@@ -2985,5 +2985,5 @@ static void gen_mxu_Q8ADD(DisasContext *ctx)
  *    to 16-bit and accumulate results as packed 16-bit data
  *    into XRa and XRd.
- *    aptn2 manages action add or subract of pairs of data.
+ *    aptn2 manages action add or subtract of pairs of data.
  */
 static void gen_mxu_q8adde(DisasContext *ctx, bool accumulate)
@@ -4057,5 +4057,5 @@ static void gen_mxu_s32sfl(DisasContext *ctx)
 /*
  *  Q8SAD XRa, XRd, XRb, XRc
- *    Typical SAD opration for motion estimation.
+ *    Typical SAD operation for motion estimation.
  */
 static void gen_mxu_q8sad(DisasContext *ctx)
-- 
2.39.2


