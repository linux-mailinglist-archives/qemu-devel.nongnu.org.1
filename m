Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84666736822
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:44:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXp5-0007Ai-1T; Tue, 20 Jun 2023 05:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXp1-00079E-Hn
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXov-0006Mg-Jy
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:44 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxvOqTc5FktyUHAA--.14671S3;
 Tue, 20 Jun 2023 17:38:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S24; 
 Tue, 20 Jun 2023 17:38:27 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 22/46] target/loongarch: Implement xvmskltz/xvmskgez/xvmsknz
Date: Tue, 20 Jun 2023 17:37:50 +0800
Message-Id: <20230620093814.123650-23-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S24
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch includes:
- XVMSKLTZ.{B/H/W/D};
- XVMSKGEZ.B;
- XVMSKNZ.B.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  7 ++
 target/loongarch/helper.h                    |  7 ++
 target/loongarch/insn_trans/trans_lasx.c.inc |  7 ++
 target/loongarch/insns.decode                |  7 ++
 target/loongarch/lasx_helper.c               | 95 ++++++++++++++++++++
 target/loongarch/lsx_helper.c                | 10 +--
 target/loongarch/vec.h                       |  6 ++
 7 files changed, 134 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index d0ccf3e86c..5a3c14f33d 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2014,6 +2014,13 @@ INSN_LASX(xvsigncov_h,       xxx)
 INSN_LASX(xvsigncov_w,       xxx)
 INSN_LASX(xvsigncov_d,       xxx)
 
+INSN_LASX(xvmskltz_b,        xx)
+INSN_LASX(xvmskltz_h,        xx)
+INSN_LASX(xvmskltz_w,        xx)
+INSN_LASX(xvmskltz_d,        xx)
+INSN_LASX(xvmskgez_b,        xx)
+INSN_LASX(xvmsknz_b,         xx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 53a33703b3..b7ba78ee06 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -922,3 +922,10 @@ DEF_HELPER_FLAGS_4(xvsigncov_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvsigncov_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvsigncov_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(xvsigncov_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_3(xvmskltz_b, void, env, i32, i32)
+DEF_HELPER_3(xvmskltz_h, void, env, i32, i32)
+DEF_HELPER_3(xvmskltz_w, void, env, i32, i32)
+DEF_HELPER_3(xvmskltz_d, void, env, i32, i32)
+DEF_HELPER_3(xvmskgez_b, void, env, i32, i32)
+DEF_HELPER_3(xvmsknz_b, void, env, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 9c24e82ac0..b0aad21a9d 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -1907,6 +1907,13 @@ TRANS(xvsigncov_h, gvec_xxx, MO_16, do_xvsigncov)
 TRANS(xvsigncov_w, gvec_xxx, MO_32, do_xvsigncov)
 TRANS(xvsigncov_d, gvec_xxx, MO_64, do_xvsigncov)
 
+TRANS(xvmskltz_b, gen_xx, gen_helper_xvmskltz_b)
+TRANS(xvmskltz_h, gen_xx, gen_helper_xvmskltz_h)
+TRANS(xvmskltz_w, gen_xx, gen_helper_xvmskltz_w)
+TRANS(xvmskltz_d, gen_xx, gen_helper_xvmskltz_d)
+TRANS(xvmskgez_b, gen_xx, gen_helper_xvmskgez_b)
+TRANS(xvmsknz_b, gen_xx, gen_helper_xvmsknz_b)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 887d7f5a90..b792a68fdf 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1618,6 +1618,13 @@ xvsigncov_h      0111 01010010 11101 ..... ..... .....    @xxx
 xvsigncov_w      0111 01010010 11110 ..... ..... .....    @xxx
 xvsigncov_d      0111 01010010 11111 ..... ..... .....    @xxx
 
+xvmskltz_b       0111 01101001 11000 10000 ..... .....    @xx
+xvmskltz_h       0111 01101001 11000 10001 ..... .....    @xx
+xvmskltz_w       0111 01101001 11000 10010 ..... .....    @xx
+xvmskltz_d       0111 01101001 11000 10011 ..... .....    @xx
+xvmskgez_b       0111 01101001 11000 10100 ..... .....    @xx
+xvmsknz_b        0111 01101001 11000 11000 ..... .....    @xx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index db7905fa4d..6aec554645 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -709,3 +709,98 @@ XDO_3OP(xvsigncov_b, 8, XB, DO_SIGNCOV)
 XDO_3OP(xvsigncov_h, 16, XH, DO_SIGNCOV)
 XDO_3OP(xvsigncov_w, 32, XW, DO_SIGNCOV)
 XDO_3OP(xvsigncov_d, 64, XD, DO_SIGNCOV)
+
+void HELPER(xvmskltz_b)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    uint16_t temp;
+    int i;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    for (i = 0; i < 2; i++) {
+        temp = 0;
+        temp = do_vmskltz_b(Xj->XD(2 * i));
+        temp |= (do_vmskltz_b(Xj->XD(2 * i + 1)) << 8);
+        Xd->XD(2 * i) = temp;
+        Xd->XD(2 * i + 1) = 0;
+    }
+}
+
+void HELPER(xvmskltz_h)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    uint16_t temp;
+    int i;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    for (i = 0; i < 2; i++) {
+        temp = 0;
+        temp = do_vmskltz_h(Xj->XD(2 * i));
+        temp |= (do_vmskltz_h(Xj->XD(2 * i + 1)) << 4);
+        Xd->XD(2 * i) = temp;
+        Xd->XD(2 * i + 1) = 0;
+    }
+}
+
+void HELPER(xvmskltz_w)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    uint16_t temp;
+    int i;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    for (i = 0; i < 2; i++) {
+        temp = do_vmskltz_w(Xj->XD(2 * i));
+        temp |= (do_vmskltz_w(Xj->XD(2 * i + 1)) << 2);
+        Xd->XD(2 * i) = temp;
+        Xd->XD(2 * i + 1) = 0;
+    }
+}
+
+void HELPER(xvmskltz_d)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    uint16_t temp;
+    int i;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    for (i = 0; i < 2; i++) {
+        temp = 0;
+        temp = do_vmskltz_d(Xj->XD(2 * i));
+        temp |= (do_vmskltz_d(Xj->XD(2 * i + 1)) << 1);
+        Xd->XD(2 * i) = temp;
+        Xd->XD(2 * i + 1) = 0;
+    }
+}
+
+void HELPER(xvmskgez_b)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    uint16_t temp;
+    int i;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    for (i = 0; i < 2; i++) {
+        temp = 0;
+        temp =  do_vmskltz_b(Xj->XD(2 * i));
+        temp |= (do_vmskltz_b(Xj->XD(2 * i + 1)) << 8);
+        Xd->XD(2 * i) = (uint16_t)(~temp);
+        Xd->XD(2 * i + 1) = 0;
+    }
+}
+
+void HELPER(xvmsknz_b)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    uint16_t temp;
+    int i;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    for (i = 0; i < 2; i++) {
+        temp = 0;
+        temp = do_vmskez_b(Xj->XD(2 * i));
+        temp |= (do_vmskez_b(Xj->XD(2 * i + 1)) << 8);
+        Xd->XD(2 * i) = (uint16_t)(~temp);
+        Xd->XD(2 * i + 1) = 0;
+    }
+}
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index dadba47513..e64155f38c 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -653,7 +653,7 @@ DO_3OP(vsigncov_h, 16, H, DO_SIGNCOV)
 DO_3OP(vsigncov_w, 32, W, DO_SIGNCOV)
 DO_3OP(vsigncov_d, 64, D, DO_SIGNCOV)
 
-static uint64_t do_vmskltz_b(int64_t val)
+uint64_t do_vmskltz_b(int64_t val)
 {
     uint64_t m = 0x8080808080808080ULL;
     uint64_t c =  val & m;
@@ -675,7 +675,7 @@ void HELPER(vmskltz_b)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     Vd->D(1) = 0;
 }
 
-static uint64_t do_vmskltz_h(int64_t val)
+uint64_t do_vmskltz_h(int64_t val)
 {
     uint64_t m = 0x8000800080008000ULL;
     uint64_t c =  val & m;
@@ -696,7 +696,7 @@ void HELPER(vmskltz_h)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     Vd->D(1) = 0;
 }
 
-static uint64_t do_vmskltz_w(int64_t val)
+uint64_t do_vmskltz_w(int64_t val)
 {
     uint64_t m = 0x8000000080000000ULL;
     uint64_t c =  val & m;
@@ -716,7 +716,7 @@ void HELPER(vmskltz_w)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     Vd->D(1) = 0;
 }
 
-static uint64_t do_vmskltz_d(int64_t val)
+uint64_t do_vmskltz_d(int64_t val)
 {
     return (uint64_t)val >> 63;
 }
@@ -744,7 +744,7 @@ void HELPER(vmskgez_b)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     Vd->D(1) = 0;
 }
 
-static uint64_t do_vmskez_b(uint64_t a)
+uint64_t do_vmskez_b(uint64_t a)
 {
     uint64_t m = 0x7f7f7f7f7f7f7f7fULL;
     uint64_t c = ~(((a & m) + m) | a | m);
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index f6ad3f78dd..d5a880b3fd 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -75,4 +75,10 @@
 
 #define DO_SIGNCOV(a, b)  (a == 0 ? 0 : a < 0 ? -b : b)
 
+uint64_t do_vmskltz_b(int64_t val);
+uint64_t do_vmskltz_h(int64_t val);
+uint64_t do_vmskltz_w(int64_t val);
+uint64_t do_vmskltz_d(int64_t val);
+uint64_t do_vmskez_b(uint64_t val);
+
 #endif /* LOONGARCH_VEC_H */
-- 
2.39.1


