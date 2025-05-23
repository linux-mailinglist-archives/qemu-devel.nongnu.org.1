Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 893A6AC19CB
	for <lists+qemu-devel@lfdr.de>; Fri, 23 May 2025 03:42:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIHOZ-0006rN-MC; Thu, 22 May 2025 21:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uIHOU-0006qP-Ct; Thu, 22 May 2025 21:40:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1uIHOR-00056q-2k; Thu, 22 May 2025 21:40:17 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxHHL20S9oUbz3AA--.7052S3;
 Fri, 23 May 2025 09:40:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBx3MTz0S9oStbpAA--.8898S2;
 Fri, 23 May 2025 09:40:03 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, maobibo@loongson.cn, philmd@linaro.org,
 lorenz.hetterich@cispa.de, qemu-stable@nongnu.org
Subject: [PATCH] target/loongarch: add check for fcond
Date: Fri, 23 May 2025 09:17:45 +0800
Message-Id: <20250523011745.3833883-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3MTz0S9oStbpAA--.8898S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

fcond only has 22 types, add a check for fcond.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2972

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/insn_trans/trans_fcmp.c.inc | 11 ++++++++---
 target/loongarch/tcg/insn_trans/trans_vec.c.inc  |  4 ++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc b/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
index 3babf69e4a..5be759d30c 100644
--- a/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
@@ -4,10 +4,15 @@
  */
 
 /* bit0(signaling/quiet) bit1(lt) bit2(eq) bit3(un) bit4(neq) */
-static uint32_t get_fcmp_flags(int cond)
+static uint32_t get_fcmp_flags(DisasContext *ctx, int cond)
 {
     uint32_t flags = 0;
 
+    /*check cond , cond =[0-8,10,12] */
+    if ((cond > 8) &&(cond != 10) && (cond != 12)) {
+        generate_exception(ctx, EXCCODE_INE);
+    }
+
     if (cond & 0x1) {
         flags |= FCMP_LT;
     }
@@ -39,7 +44,7 @@ static bool trans_fcmp_cond_s(DisasContext *ctx, arg_fcmp_cond_s *a)
     src1 = get_fpr(ctx, a->fj);
     src2 = get_fpr(ctx, a->fk);
     fn = (a->fcond & 1 ? gen_helper_fcmp_s_s : gen_helper_fcmp_c_s);
-    flags = get_fcmp_flags(a->fcond >> 1);
+    flags = get_fcmp_flags(ctx, a->fcond >> 1);
 
     fn(var, tcg_env, src1, src2, tcg_constant_i32(flags));
 
@@ -63,7 +68,7 @@ static bool trans_fcmp_cond_d(DisasContext *ctx, arg_fcmp_cond_d *a)
     src1 = get_fpr(ctx, a->fj);
     src2 = get_fpr(ctx, a->fk);
     fn = (a->fcond & 1 ? gen_helper_fcmp_s_d : gen_helper_fcmp_c_d);
-    flags = get_fcmp_flags(a->fcond >> 1);
+    flags = get_fcmp_flags(ctx, a->fcond >> 1);
 
     fn(var, tcg_env, src1, src2, tcg_constant_i32(flags));
 
diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index b33622ff79..0128a2398f 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -4666,7 +4666,7 @@ static bool do_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a, uint32_t sz)
     }
 
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_s : gen_helper_vfcmp_c_s);
-    flags = get_fcmp_flags(a->fcond >> 1);
+    flags = get_fcmp_flags(ctx, a->fcond >> 1);
     fn(tcg_env, oprsz, vd, vj, vk, tcg_constant_i32(flags));
 
     return true;
@@ -4686,7 +4686,7 @@ static bool do_vfcmp_cond_d(DisasContext *ctx, arg_vvv_fcond *a, uint32_t sz)
     }
 
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_d : gen_helper_vfcmp_c_d);
-    flags = get_fcmp_flags(a->fcond >> 1);
+    flags = get_fcmp_flags(ctx, a->fcond >> 1);
     fn(tcg_env, oprsz, vd, vj, vk, tcg_constant_i32(flags));
 
     return true;
-- 
2.34.1


