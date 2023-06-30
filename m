Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1F674366F
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:04:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF945-0003ao-UB; Fri, 30 Jun 2023 04:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF93x-0003Is-J6
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:01:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF93u-00006e-U4
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:01:05 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxlMRii55kpDQEAA--.6775S3;
 Fri, 30 Jun 2023 15:59:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S37; 
 Fri, 30 Jun 2023 15:59:28 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 35/46] target/loongarch: Implement xvfrstp
Date: Fri, 30 Jun 2023 15:58:53 +0800
Message-Id: <20230630075904.45940-36-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S37
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
- XVFRSTP[I].{B/H}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  5 ++
 target/loongarch/helper.h                    |  8 +--
 target/loongarch/insn_trans/trans_lasx.c.inc |  5 ++
 target/loongarch/insns.decode                |  5 ++
 target/loongarch/vec_helper.c                | 73 ++++++++++++--------
 5 files changed, 65 insertions(+), 31 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index dad9243fd7..27d6252686 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2235,6 +2235,11 @@ INSN_LASX(xvbitrevi_h,       vv_i)
 INSN_LASX(xvbitrevi_w,       vv_i)
 INSN_LASX(xvbitrevi_d,       vv_i)
 
+INSN_LASX(xvfrstp_b,         vvv)
+INSN_LASX(xvfrstp_h,         vvv)
+INSN_LASX(xvfrstpi_b,        vv_i)
+INSN_LASX(xvfrstpi_h,        vv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index fee3459c1b..fa8e946ddd 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -526,10 +526,10 @@ DEF_HELPER_FLAGS_4(vbitrevi_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vbitrevi_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vbitrevi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
-DEF_HELPER_4(vfrstp_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vfrstp_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vfrstpi_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vfrstpi_h, void, env, i32, i32, i32)
+DEF_HELPER_5(vfrstp_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfrstp_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfrstpi_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfrstpi_h, void, env, i32, i32, i32, i32)
 
 DEF_HELPER_4(vfadd_s, void, env, i32, i32, i32)
 DEF_HELPER_4(vfadd_d, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 1f94fd3be0..4da02cdf08 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -613,6 +613,11 @@ TRANS(xvbitrevi_h, gvec_vv_i, 32, MO_16, do_vbitrevi)
 TRANS(xvbitrevi_w, gvec_vv_i, 32, MO_32, do_vbitrevi)
 TRANS(xvbitrevi_d, gvec_vv_i, 32, MO_64, do_vbitrevi)
 
+TRANS(xvfrstp_b, gen_vvv, 32, gen_helper_vfrstp_b)
+TRANS(xvfrstp_h, gen_vvv, 32, gen_helper_vfrstp_h)
+TRANS(xvfrstpi_b, gen_vv_i, 32, gen_helper_vfrstpi_b)
+TRANS(xvfrstpi_h, gen_vv_i, 32, gen_helper_vfrstpi_h)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index cb6db8002a..6035fe139c 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1811,6 +1811,11 @@ xvbitrevi_h      0111 01110001 10000 1 .... ..... .....   @vv_ui4
 xvbitrevi_w      0111 01110001 10001 ..... ..... .....    @vv_ui5
 xvbitrevi_d      0111 01110001 1001 ...... ..... .....    @vv_ui6
 
+xvfrstp_b        0111 01010010 10110 ..... ..... .....    @vvv
+xvfrstp_h        0111 01010010 10111 ..... ..... .....    @vvv
+xvfrstpi_b       0111 01101001 10100 ..... ..... .....    @vv_ui5
+xvfrstpi_h       0111 01101001 10101 ..... ..... .....    @vv_ui5
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index cae3dc860e..0c7938d7cf 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -2387,42 +2387,61 @@ DO_BITI(vbitrevi_h, 16, UH, DO_BITREV)
 DO_BITI(vbitrevi_w, 32, UW, DO_BITREV)
 DO_BITI(vbitrevi_d, 64, UD, DO_BITREV)
 
-#define VFRSTP(NAME, BIT, MASK, E)                       \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i, m;                                            \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
-        if (Vj->E(i) < 0) {                              \
-            break;                                       \
-        }                                                \
-    }                                                    \
-    m = Vk->E(0) & MASK;                                 \
-    Vd->E(m) = i;                                        \
-}
-
-VFRSTP(vfrstp_b, 8, 0xf, B)
-VFRSTP(vfrstp_h, 16, 0x7, H)
-
-#define VFRSTPI(NAME, BIT, E)                             \
-void HELPER(NAME)(CPULoongArchState *env,                 \
-                  uint32_t vd, uint32_t vj, uint32_t imm) \
+#define VFRSTP(NAME, BIT, MASK, E)                        \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz, \
+                  uint32_t vd, uint32_t vj, uint32_t vk)  \
 {                                                         \
-    int i, m;                                             \
+    int i, j, m, max;                                     \
     VReg *Vd = &(env->fpr[vd].vreg);                      \
     VReg *Vj = &(env->fpr[vj].vreg);                      \
+    VReg *Vk = &(env->fpr[vk].vreg);                      \
                                                           \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                   \
+    max = LSX_LEN / BIT;                                  \
+    m = Vk->E(0) & MASK;                                  \
+    for (i = 0; i < max; i++) {                           \
         if (Vj->E(i) < 0) {                               \
             break;                                        \
         }                                                 \
     }                                                     \
-    m = imm % (LSX_LEN/BIT);                              \
     Vd->E(m) = i;                                         \
+    if (oprsz == 32) {                                    \
+        for (j = 0; j < max; j++) {                       \
+            if (Vj->E(j + max) < 0) {                     \
+                break;                                    \
+            }                                             \
+        }                                                 \
+        m = Vk->E(max) & MASK;                            \
+        Vd->E(m + max) = j;                               \
+    }                                                     \
+}
+
+VFRSTP(vfrstp_b, 8, 0xf, B)
+VFRSTP(vfrstp_h, 16, 0x7, H)
+
+#define VFRSTPI(NAME, BIT, E)                              \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,  \
+                  uint32_t vd, uint32_t vj, uint32_t imm)  \
+{                                                          \
+    int i, j, m, max;                                      \
+    VReg *Vd = &(env->fpr[vd].vreg);                       \
+    VReg *Vj = &(env->fpr[vj].vreg);                       \
+                                                           \
+    max = LSX_LEN / BIT;                                   \
+    m = imm % max;                                         \
+    for (i = 0; i < max; i++) {                            \
+        if (Vj->E(i) < 0) {                                \
+            break;                                         \
+        }                                                  \
+    }                                                      \
+    Vd->E(m) = i;                                          \
+    if (oprsz == 32) {                                     \
+        for(j = 0; j < max; j++) {                         \
+            if(Vj->E(j + max) < 0) {                       \
+                break;                                     \
+            }                                              \
+        }                                                  \
+        Vd->E(m + max) = j;                                \
+    }                                                      \
 }
 
 VFRSTPI(vfrstpi_b, 8,  B)
-- 
2.39.1


