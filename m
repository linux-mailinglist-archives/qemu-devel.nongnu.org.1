Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F77736800
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXop-00074K-68; Tue, 20 Jun 2023 05:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXoi-00072D-Ie
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXod-0006Gk-I3
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:28 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxLuuJc5FkiSUHAA--.14913S3;
 Tue, 20 Jun 2023 17:38:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S6; 
 Tue, 20 Jun 2023 17:38:17 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 04/46] target/loongarch: Implement xvadd/xvsub
Date: Tue, 20 Jun 2023 17:37:32 +0800
Message-Id: <20230620093814.123650-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S6
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
- XVADD.{B/H/W/D/Q};
- XVSUB.{B/H/W/D/Q}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 23 ++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 59 ++++++++++++++++++++
 target/loongarch/insns.decode                | 23 ++++++++
 target/loongarch/translate.c                 | 17 ++++++
 4 files changed, 122 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 5c402d944d..696f78c491 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1695,3 +1695,26 @@ INSN_LSX(vstelm_d,         vr_ii)
 INSN_LSX(vstelm_w,         vr_ii)
 INSN_LSX(vstelm_h,         vr_ii)
 INSN_LSX(vstelm_b,         vr_ii)
+
+#define INSN_LASX(insn, type)                               \
+static bool trans_##insn(DisasContext *ctx, arg_##type * a) \
+{                                                           \
+    output_##type(ctx, a, #insn);                           \
+    return true;                                            \
+}
+
+static void output_xxx(DisasContext *ctx, arg_xxx * a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, x%d, x%d", a->xd, a->xj, a->xk);
+}
+
+INSN_LASX(xvadd_b,           xxx)
+INSN_LASX(xvadd_h,           xxx)
+INSN_LASX(xvadd_w,           xxx)
+INSN_LASX(xvadd_d,           xxx)
+INSN_LASX(xvadd_q,           xxx)
+INSN_LASX(xvsub_b,           xxx)
+INSN_LASX(xvsub_h,           xxx)
+INSN_LASX(xvsub_w,           xxx)
+INSN_LASX(xvsub_d,           xxx)
+INSN_LASX(xvsub_q,           xxx)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 75a77f5dce..c918522f96 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -14,3 +14,62 @@
 #else
 #define CHECK_ASXE
 #endif
+
+static bool gvec_xxx(DisasContext *ctx, arg_xxx *a, MemOp mop,
+                     void (*func)(unsigned, uint32_t, uint32_t,
+                                  uint32_t, uint32_t, uint32_t))
+{
+    uint32_t xd_ofs, xj_ofs, xk_ofs;
+
+    CHECK_ASXE;
+
+    xd_ofs = vec_full_offset(a->xd);
+    xj_ofs = vec_full_offset(a->xj);
+    xk_ofs = vec_full_offset(a->xk);
+
+    func(mop, xd_ofs, xj_ofs, xk_ofs, 32, ctx->vl / 8);
+    return true;
+}
+
+TRANS(xvadd_b, gvec_xxx, MO_8, tcg_gen_gvec_add)
+TRANS(xvadd_h, gvec_xxx, MO_16, tcg_gen_gvec_add)
+TRANS(xvadd_w, gvec_xxx, MO_32, tcg_gen_gvec_add)
+TRANS(xvadd_d, gvec_xxx, MO_64, tcg_gen_gvec_add)
+
+#define XVADDSUB_Q(NAME)                                        \
+static bool trans_xv## NAME ##_q(DisasContext *ctx, arg_xxx *a) \
+{                                                               \
+    TCGv_i64 rh, rl, ah, al, bh, bl;                            \
+    int i;                                                      \
+                                                                \
+    CHECK_ASXE;                                                 \
+                                                                \
+    rh = tcg_temp_new_i64();                                    \
+    rl = tcg_temp_new_i64();                                    \
+    ah = tcg_temp_new_i64();                                    \
+    al = tcg_temp_new_i64();                                    \
+    bh = tcg_temp_new_i64();                                    \
+    bl = tcg_temp_new_i64();                                    \
+                                                                \
+    for (i = 0; i < 2; i++) {                                   \
+        get_xreg64(ah, a->xj, 1 + i * 2);                       \
+        get_xreg64(al, a->xj, 0 + i * 2);                       \
+        get_xreg64(bh, a->xk, 1 + i * 2);                       \
+        get_xreg64(bl, a->xk, 0 + i * 2);                       \
+                                                                \
+        tcg_gen_## NAME ##2_i64(rl, rh, al, ah, bl, bh);        \
+                                                                \
+        set_xreg64(rh, a->xd, 1 + i * 2);                       \
+        set_xreg64(rl, a->xd, 0 + i * 2);                       \
+   }                                                            \
+                                                                \
+    return true;                                                \
+}
+
+XVADDSUB_Q(add)
+XVADDSUB_Q(sub)
+
+TRANS(xvsub_b, gvec_xxx, MO_8, tcg_gen_gvec_sub)
+TRANS(xvsub_h, gvec_xxx, MO_16, tcg_gen_gvec_sub)
+TRANS(xvsub_w, gvec_xxx, MO_32, tcg_gen_gvec_sub)
+TRANS(xvsub_d, gvec_xxx, MO_64, tcg_gen_gvec_sub)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index c9c3bc2c73..bac1903975 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1296,3 +1296,26 @@ vstelm_d         0011 00010001 0 . ........ ..... .....   @vr_i8i1
 vstelm_w         0011 00010010 .. ........ ..... .....    @vr_i8i2
 vstelm_h         0011 0001010 ... ........ ..... .....    @vr_i8i3
 vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
+
+#
+# LASX Argument sets
+#
+
+&xxx          xd xj xk
+
+#
+# LASX Formats
+#
+
+@xxx                .... ........ ..... xk:5 xj:5 xd:5    &xxx
+
+xvadd_b          0111 01000000 10100 ..... ..... .....    @xxx
+xvadd_h          0111 01000000 10101 ..... ..... .....    @xxx
+xvadd_w          0111 01000000 10110 ..... ..... .....    @xxx
+xvadd_d          0111 01000000 10111 ..... ..... .....    @xxx
+xvadd_q          0111 01010010 11010 ..... ..... .....    @xxx
+xvsub_b          0111 01000000 11000 ..... ..... .....    @xxx
+xvsub_h          0111 01000000 11001 ..... ..... .....    @xxx
+xvsub_w          0111 01000000 11010 ..... ..... .....    @xxx
+xvsub_d          0111 01000000 11011 ..... ..... .....    @xxx
+xvsub_q          0111 01010010 11011 ..... ..... .....    @xxx
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 6bf2d726d6..5300e14815 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -18,6 +18,7 @@
 #include "fpu/softfloat.h"
 #include "translate.h"
 #include "internals.h"
+#include "vec.h"
 
 /* Global register indices */
 TCGv cpu_gpr[32], cpu_pc;
@@ -48,6 +49,18 @@ static inline void set_vreg64(TCGv_i64 src, int regno, int index)
                    offsetof(CPULoongArchState, fpr[regno].vreg.D(index)));
 }
 
+static inline void get_xreg64(TCGv_i64 dest, int regno, int index)
+{
+    tcg_gen_ld_i64(dest, cpu_env,
+                   offsetof(CPULoongArchState, fpr[regno].xreg.XD(index)));
+}
+
+static inline void set_xreg64(TCGv_i64 src, int regno, int index)
+{
+    tcg_gen_st_i64(src, cpu_env,
+                   offsetof(CPULoongArchState, fpr[regno].xreg.XD(index)));
+}
+
 static inline int plus_1(DisasContext *ctx, int x)
 {
     return x + 1;
@@ -119,6 +132,10 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
         ctx->vl = LSX_LEN;
     }
 
+    if (FIELD_EX64(env->cpucfg[2], CPUCFG2, LASX)) {
+        ctx->vl = LASX_LEN;
+    }
+
     ctx->zero = tcg_constant_tl(0);
 }
 
-- 
2.39.1


