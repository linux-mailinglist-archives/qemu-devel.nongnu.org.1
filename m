Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B50E6743650
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:00:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92s-0008Py-Ho; Fri, 30 Jun 2023 03:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92k-0008J8-6Y
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92h-00084Y-9x
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:49 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx2cVli55ksTQEAA--.6751S3;
 Fri, 30 Jun 2023 15:59:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S45; 
 Fri, 30 Jun 2023 15:59:32 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 43/46] target/loongarch: Implement xvpack xvpick xvilv{l/h}
Date: Fri, 30 Jun 2023 15:59:01 +0800
Message-Id: <20230630075904.45940-44-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S45
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
- XVPACK{EV/OD}.{B/H/W/D};
- XVPICK{EV/OD}.{B/H/W/D};
- XVILV{L/H}.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  27 +++
 target/loongarch/helper.h                    |  52 ++---
 target/loongarch/insn_trans/trans_lasx.c.inc |  27 +++
 target/loongarch/insns.decode                |  27 +++
 target/loongarch/vec_helper.c                | 202 ++++++++++---------
 5 files changed, 219 insertions(+), 116 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index ac7dd3021d..9b6a07bbb0 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2548,3 +2548,30 @@ INSN_LASX(xvpickve_d,        vv_i)
 
 INSN_LASX(xvbsll_v,          vv_i)
 INSN_LASX(xvbsrl_v,          vv_i)
+
+INSN_LASX(xvpackev_b,        vvv)
+INSN_LASX(xvpackev_h,        vvv)
+INSN_LASX(xvpackev_w,        vvv)
+INSN_LASX(xvpackev_d,        vvv)
+INSN_LASX(xvpackod_b,        vvv)
+INSN_LASX(xvpackod_h,        vvv)
+INSN_LASX(xvpackod_w,        vvv)
+INSN_LASX(xvpackod_d,        vvv)
+
+INSN_LASX(xvpickev_b,        vvv)
+INSN_LASX(xvpickev_h,        vvv)
+INSN_LASX(xvpickev_w,        vvv)
+INSN_LASX(xvpickev_d,        vvv)
+INSN_LASX(xvpickod_b,        vvv)
+INSN_LASX(xvpickod_h,        vvv)
+INSN_LASX(xvpickod_w,        vvv)
+INSN_LASX(xvpickod_d,        vvv)
+
+INSN_LASX(xvilvl_b,          vvv)
+INSN_LASX(xvilvl_h,          vvv)
+INSN_LASX(xvilvl_w,          vvv)
+INSN_LASX(xvilvl_d,          vvv)
+INSN_LASX(xvilvh_b,          vvv)
+INSN_LASX(xvilvh_h,          vvv)
+INSN_LASX(xvilvh_w,          vvv)
+INSN_LASX(xvilvh_d,          vvv)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index ca7296e652..ce6dc97500 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -672,32 +672,32 @@ DEF_HELPER_5(xvinsve0_d, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(xvpickve_w, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(xvpickve_d, void, env, i32, i32, i32, i32)
 
-DEF_HELPER_4(vpackev_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vpackev_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vpackev_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vpackev_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vpackod_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vpackod_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vpackod_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vpackod_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vpickev_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vpickev_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vpickev_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vpickev_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vpickod_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vpickod_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vpickod_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vpickod_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vilvl_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vilvl_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vilvl_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vilvl_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vilvh_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vilvh_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vilvh_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vilvh_d, void, env, i32, i32, i32)
+DEF_HELPER_5(vpackev_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpackev_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpackev_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpackev_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpackod_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpackod_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpackod_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpackod_d, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_5(vpickev_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpickev_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpickev_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpickev_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpickod_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpickod_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpickod_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vpickod_d, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_5(vilvl_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vilvl_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vilvl_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vilvl_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vilvh_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vilvh_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vilvh_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vilvh_d, void, env, i32, i32, i32, i32)
 
 DEF_HELPER_5(vshuf_b, void, env, i32, i32, i32, i32)
 DEF_HELPER_4(vshuf_h, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index c411762756..c059e2fdcc 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -935,3 +935,30 @@ TRANS(xvpickve_d, gen_vv_i, 32, gen_helper_xvpickve_d)
 
 TRANS(xvbsll_v, do_vbsll_v, 32)
 TRANS(xvbsrl_v, do_vbsrl_v, 32)
+
+TRANS(xvpackev_b, gen_vvv, 32, gen_helper_vpackev_b)
+TRANS(xvpackev_h, gen_vvv, 32, gen_helper_vpackev_h)
+TRANS(xvpackev_w, gen_vvv, 32, gen_helper_vpackev_w)
+TRANS(xvpackev_d, gen_vvv, 32, gen_helper_vpackev_d)
+TRANS(xvpackod_b, gen_vvv, 32, gen_helper_vpackod_b)
+TRANS(xvpackod_h, gen_vvv, 32, gen_helper_vpackod_h)
+TRANS(xvpackod_w, gen_vvv, 32, gen_helper_vpackod_w)
+TRANS(xvpackod_d, gen_vvv, 32, gen_helper_vpackod_d)
+
+TRANS(xvpickev_b, gen_vvv, 32, gen_helper_vpickev_b)
+TRANS(xvpickev_h, gen_vvv, 32, gen_helper_vpickev_h)
+TRANS(xvpickev_w, gen_vvv, 32, gen_helper_vpickev_w)
+TRANS(xvpickev_d, gen_vvv, 32, gen_helper_vpickev_d)
+TRANS(xvpickod_b, gen_vvv, 32, gen_helper_vpickod_b)
+TRANS(xvpickod_h, gen_vvv, 32, gen_helper_vpickod_h)
+TRANS(xvpickod_w, gen_vvv, 32, gen_helper_vpickod_w)
+TRANS(xvpickod_d, gen_vvv, 32, gen_helper_vpickod_d)
+
+TRANS(xvilvl_b, gen_vvv, 32, gen_helper_vilvl_b)
+TRANS(xvilvl_h, gen_vvv, 32, gen_helper_vilvl_h)
+TRANS(xvilvl_w, gen_vvv, 32, gen_helper_vilvl_w)
+TRANS(xvilvl_d, gen_vvv, 32, gen_helper_vilvl_d)
+TRANS(xvilvh_b, gen_vvv, 32, gen_helper_vilvh_b)
+TRANS(xvilvh_h, gen_vvv, 32, gen_helper_vilvh_h)
+TRANS(xvilvh_w, gen_vvv, 32, gen_helper_vilvh_w)
+TRANS(xvilvh_d, gen_vvv, 32, gen_helper_vilvh_d)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 74383ba3bc..a325b861c1 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -2012,3 +2012,30 @@ xvpickve_d       0111 01110000 00111 110 .. ..... .....   @vv_ui2
 
 xvbsll_v         0111 01101000 11100 ..... ..... .....    @vv_ui5
 xvbsrl_v         0111 01101000 11101 ..... ..... .....    @vv_ui5
+
+xvpackev_b       0111 01010001 01100 ..... ..... .....    @vvv
+xvpackev_h       0111 01010001 01101 ..... ..... .....    @vvv
+xvpackev_w       0111 01010001 01110 ..... ..... .....    @vvv
+xvpackev_d       0111 01010001 01111 ..... ..... .....    @vvv
+xvpackod_b       0111 01010001 10000 ..... ..... .....    @vvv
+xvpackod_h       0111 01010001 10001 ..... ..... .....    @vvv
+xvpackod_w       0111 01010001 10010 ..... ..... .....    @vvv
+xvpackod_d       0111 01010001 10011 ..... ..... .....    @vvv
+
+xvpickev_b       0111 01010001 11100 ..... ..... .....    @vvv
+xvpickev_h       0111 01010001 11101 ..... ..... .....    @vvv
+xvpickev_w       0111 01010001 11110 ..... ..... .....    @vvv
+xvpickev_d       0111 01010001 11111 ..... ..... .....    @vvv
+xvpickod_b       0111 01010010 00000 ..... ..... .....    @vvv
+xvpickod_h       0111 01010010 00001 ..... ..... .....    @vvv
+xvpickod_w       0111 01010010 00010 ..... ..... .....    @vvv
+xvpickod_d       0111 01010010 00011 ..... ..... .....    @vvv
+
+xvilvl_b         0111 01010001 10100 ..... ..... .....    @vvv
+xvilvl_h         0111 01010001 10101 ..... ..... .....    @vvv
+xvilvl_w         0111 01010001 10110 ..... ..... .....    @vvv
+xvilvl_d         0111 01010001 10111 ..... ..... .....    @vvv
+xvilvh_b         0111 01010001 11000 ..... ..... .....    @vvv
+xvilvh_h         0111 01010001 11001 ..... ..... .....    @vvv
+xvilvh_w         0111 01010001 11010 ..... ..... .....    @vvv
+xvilvh_d         0111 01010001 11011 ..... ..... .....    @vvv
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 65faf9f7a7..d641c718f6 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -3272,21 +3272,22 @@ void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz, \
 XVPICKVE(xvpickve_w, W, 32, 0x7)
 XVPICKVE(xvpickve_d, D, 64, 0x3)
 
-#define VPACKEV(NAME, BIT, E)                            \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i;                                               \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
-        temp.E(2 * i + 1) = Vj->E(2 * i);                \
-        temp.E(2 *i) = Vk->E(2 * i);                     \
-    }                                                    \
-    *Vd = temp;                                          \
+#define VPACKEV(NAME, BIT, E)                             \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz, \
+                  uint32_t vd, uint32_t vj, uint32_t vk)  \
+{                                                         \
+    int i, len;                                           \
+    VReg temp;                                            \
+    VReg *Vd = &(env->fpr[vd].vreg);                      \
+    VReg *Vj = &(env->fpr[vj].vreg);                      \
+    VReg *Vk = &(env->fpr[vk].vreg);                      \
+                                                          \
+    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;             \
+    for (i = 0; i < len / BIT; i++) {                     \
+        temp.E(2 * i + 1) = Vj->E(2 * i);                 \
+        temp.E(2 *i) = Vk->E(2 * i);                      \
+    }                                                     \
+    *Vd = temp;                                           \
 }
 
 VPACKEV(vpackev_b, 16, B)
@@ -3294,21 +3295,22 @@ VPACKEV(vpackev_h, 32, H)
 VPACKEV(vpackev_w, 64, W)
 VPACKEV(vpackev_d, 128, D)
 
-#define VPACKOD(NAME, BIT, E)                            \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i;                                               \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
-        temp.E(2 * i + 1) = Vj->E(2 * i + 1);            \
-        temp.E(2 * i) = Vk->E(2 * i + 1);                \
-    }                                                    \
-    *Vd = temp;                                          \
+#define VPACKOD(NAME, BIT, E)                             \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz, \
+                  uint32_t vd, uint32_t vj, uint32_t vk)  \
+{                                                         \
+    int i, len;                                           \
+    VReg temp;                                            \
+    VReg *Vd = &(env->fpr[vd].vreg);                      \
+    VReg *Vj = &(env->fpr[vj].vreg);                      \
+    VReg *Vk = &(env->fpr[vk].vreg);                      \
+                                                          \
+    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;             \
+    for (i = 0; i < len / BIT; i++) {                     \
+        temp.E(2 * i + 1) = Vj->E(2 * i + 1);             \
+        temp.E(2 * i) = Vk->E(2 * i + 1);                 \
+    }                                                     \
+    *Vd = temp;                                           \
 }
 
 VPACKOD(vpackod_b, 16, B)
@@ -3316,21 +3318,26 @@ VPACKOD(vpackod_h, 32, H)
 VPACKOD(vpackod_w, 64, W)
 VPACKOD(vpackod_d, 128, D)
 
-#define VPICKEV(NAME, BIT, E)                            \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i;                                               \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
-        temp.E(i + LSX_LEN/BIT) = Vj->E(2 * i);          \
-        temp.E(i) = Vk->E(2 * i);                        \
-    }                                                    \
-    *Vd = temp;                                          \
+#define VPICKEV(NAME, BIT, E)                             \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz, \
+                  uint32_t vd, uint32_t vj, uint32_t vk)  \
+{                                                         \
+    int i, max;                                           \
+    VReg temp;                                            \
+    VReg *Vd = &(env->fpr[vd].vreg);                      \
+    VReg *Vj = &(env->fpr[vj].vreg);                      \
+    VReg *Vk = &(env->fpr[vk].vreg);                      \
+                                                          \
+    max = LSX_LEN / BIT;                                  \
+    for (i = 0; i < max; i++) {                           \
+        temp.E(i + max) = Vj->E(2 * i);                   \
+        temp.E(i) = Vk->E(2 * i);                         \
+        if (oprsz == 32) {                                \
+            temp.E(i + max * 3) = Vj->E(2 * i + max * 2); \
+            temp.E(i + max * 2) = Vk->E(2 * i + max * 2); \
+        }                                                 \
+    }                                                     \
+    *Vd = temp;                                           \
 }
 
 VPICKEV(vpickev_b, 16, B)
@@ -3338,21 +3345,26 @@ VPICKEV(vpickev_h, 32, H)
 VPICKEV(vpickev_w, 64, W)
 VPICKEV(vpickev_d, 128, D)
 
-#define VPICKOD(NAME, BIT, E)                            \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i;                                               \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
-        temp.E(i + LSX_LEN/BIT) = Vj->E(2 * i + 1);      \
-        temp.E(i) = Vk->E(2 * i + 1);                    \
-    }                                                    \
-    *Vd = temp;                                          \
+#define VPICKOD(NAME, BIT, E)                                 \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,     \
+                  uint32_t vd, uint32_t vj, uint32_t vk)      \
+{                                                             \
+    int i, max;                                               \
+    VReg temp;                                                \
+    VReg *Vd = &(env->fpr[vd].vreg);                          \
+    VReg *Vj = &(env->fpr[vj].vreg);                          \
+    VReg *Vk = &(env->fpr[vk].vreg);                          \
+                                                              \
+    max = LSX_LEN / BIT;                                      \
+    for (i = 0; i < max; i++) {                               \
+        temp.E(i + max) = Vj->E(2 * i + 1);                   \
+        temp.E(i) = Vk->E(2 * i + 1);                         \
+        if (oprsz == 32) {                                    \
+            temp.E(i + max * 3) = Vj->E(2 * i + 1 + max * 2); \
+            temp.E(i + max * 2) = Vk->E(2 * i + 1 + max * 2); \
+        }                                                     \
+    }                                                         \
+    *Vd = temp;                                               \
 }
 
 VPICKOD(vpickod_b, 16, B)
@@ -3360,21 +3372,26 @@ VPICKOD(vpickod_h, 32, H)
 VPICKOD(vpickod_w, 64, W)
 VPICKOD(vpickod_d, 128, D)
 
-#define VILVL(NAME, BIT, E)                              \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i;                                               \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
-        temp.E(2 * i + 1) = Vj->E(i);                    \
-        temp.E(2 * i) = Vk->E(i);                        \
-    }                                                    \
-    *Vd = temp;                                          \
+#define VILVL(NAME, BIT, E)                                   \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,     \
+                  uint32_t vd, uint32_t vj, uint32_t vk)      \
+{                                                             \
+    int i, max;                                               \
+    VReg temp;                                                \
+    VReg *Vd = &(env->fpr[vd].vreg);                          \
+    VReg *Vj = &(env->fpr[vj].vreg);                          \
+    VReg *Vk = &(env->fpr[vk].vreg);                          \
+                                                              \
+    max = LSX_LEN / BIT;                                      \
+    for (i = 0; i < max; i++) {                               \
+        temp.E(2 * i + 1) = Vj->E(i);                         \
+        temp.E(2 * i) = Vk->E(i);                             \
+        if (oprsz == 32) {                                    \
+            temp.E(2 * i + 1 + max * 2) = Vj->E(i + max * 2); \
+            temp.E(2 * i + max * 2) = Vk->E(i + max * 2);     \
+        }                                                     \
+    }                                                         \
+    *Vd = temp;                                               \
 }
 
 VILVL(vilvl_b, 16, B)
@@ -3382,21 +3399,26 @@ VILVL(vilvl_h, 32, H)
 VILVL(vilvl_w, 64, W)
 VILVL(vilvl_d, 128, D)
 
-#define VILVH(NAME, BIT, E)                              \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i;                                               \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
-        temp.E(2 * i + 1) = Vj->E(i + LSX_LEN/BIT);      \
-        temp.E(2 * i) = Vk->E(i + LSX_LEN/BIT);          \
-    }                                                    \
-    *Vd = temp;                                          \
+#define VILVH(NAME, BIT, E)                                   \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,     \
+                  uint32_t vd, uint32_t vj, uint32_t vk)      \
+{                                                             \
+    int i, max;                                               \
+    VReg temp;                                                \
+    VReg *Vd = &(env->fpr[vd].vreg);                          \
+    VReg *Vj = &(env->fpr[vj].vreg);                          \
+    VReg *Vk = &(env->fpr[vk].vreg);                          \
+                                                              \
+    max = LSX_LEN / BIT;                                      \
+    for (i = 0; i < max; i++) {                               \
+        temp.E(2 * i + 1) = Vj->E(i + max);                   \
+        temp.E(2 * i) = Vk->E(i + max);                       \
+        if (oprsz == 32) {                                    \
+            temp.E(2 * i + 1 + max * 2) = Vj->E(i + max * 3); \
+            temp.E(2 * i + max * 2) = Vk->E(i + max * 3);     \
+        }                                                     \
+    }                                                         \
+    *Vd = temp;                                               \
 }
 
 VILVH(vilvh_b, 16, B)
-- 
2.39.1


