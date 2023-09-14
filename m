Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6601D79F83A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:36:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgc6N-0006wh-QS; Wed, 13 Sep 2023 22:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgc53-0003Ko-Ao
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgc50-00056K-9p
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:45 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dx_7uRbwJlxPgmAA--.16321S3;
 Thu, 14 Sep 2023 10:27:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdxmbwJlJ+UDAA--.7298S55; 
 Thu, 14 Sep 2023 10:27:28 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 53/57] target/loongarch: Implement xvpack xvpick xvilv{l/h}
Date: Thu, 14 Sep 2023 10:26:41 +0800
Message-Id: <20230914022645.1151356-54-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914022645.1151356-1-gaosong@loongson.cn>
References: <20230914022645.1151356-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdxmbwJlJ+UDAA--.7298S55
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/insns.decode               |  27 ++++
 target/loongarch/disas.c                    |  27 ++++
 target/loongarch/vec_helper.c               | 138 +++++++++++---------
 target/loongarch/insn_trans/trans_vec.c.inc |  24 ++++
 4 files changed, 156 insertions(+), 60 deletions(-)

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
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index d091402db6..74ae916a10 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2547,3 +2547,30 @@ INSN_LASX(xvpickve_d,        vv_i)
 
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
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 26d48ed921..2bbaee628b 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -3241,12 +3241,13 @@ XVPICKVE(xvpickve_d, D, 64, 0x3)
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
 {                                                              \
     int i;                                                     \
-    VReg temp;                                                 \
+    VReg temp = {};                                            \
     VReg *Vd = (VReg *)vd;                                     \
     VReg *Vj = (VReg *)vj;                                     \
     VReg *Vk = (VReg *)vk;                                     \
+    int oprsz = simd_oprsz(desc);                              \
                                                                \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                  \
         temp.E(2 * i + 1) = Vj->E(2 * i);                      \
         temp.E(2 *i) = Vk->E(2 * i);                           \
     }                                                          \
@@ -3262,12 +3263,13 @@ VPACKEV(vpackev_d, 128, D)
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
 {                                                              \
     int i;                                                     \
-    VReg temp;                                                 \
+    VReg temp = {};                                            \
     VReg *Vd = (VReg *)vd;                                     \
     VReg *Vj = (VReg *)vj;                                     \
     VReg *Vk = (VReg *)vk;                                     \
+    int oprsz = simd_oprsz(desc);                              \
                                                                \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                 \
         temp.E(2 * i + 1) = Vj->E(2 * i + 1);                  \
         temp.E(2 * i) = Vk->E(2 * i + 1);                      \
     }                                                          \
@@ -3279,20 +3281,24 @@ VPACKOD(vpackod_h, 32, H)
 VPACKOD(vpackod_w, 64, W)
 VPACKOD(vpackod_d, 128, D)
 
-#define VPICKEV(NAME, BIT, E)                                  \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
-{                                                              \
-    int i;                                                     \
-    VReg temp;                                                 \
-    VReg *Vd = (VReg *)vd;                                     \
-    VReg *Vj = (VReg *)vj;                                     \
-    VReg *Vk = (VReg *)vk;                                     \
-                                                               \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
-        temp.E(i + LSX_LEN/BIT) = Vj->E(2 * i);                \
-        temp.E(i) = Vk->E(2 * i);                              \
-    }                                                          \
-    *Vd = temp;                                                \
+#define VPICKEV(NAME, BIT, E)                                         \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)        \
+{                                                                     \
+    int i, j, ofs;                                                    \
+    VReg temp = {};                                                   \
+    VReg *Vd = (VReg *)vd;                                            \
+    VReg *Vj = (VReg *)vj;                                            \
+    VReg *Vk = (VReg *)vk;                                            \
+    int oprsz = simd_oprsz(desc);                                     \
+                                                                      \
+    ofs = LSX_LEN / BIT;                                              \
+    for (i = 0; i < oprsz / 16; i++) {                                \
+        for (j = 0; j < ofs; j++) {                                   \
+            temp.E(j + ofs * (2 * i + 1)) = Vj->E(2 * (j + ofs * i)); \
+            temp.E(j + ofs * 2 * i) = Vk->E(2 * (j + ofs * i));       \
+        }                                                             \
+    }                                                                 \
+    *Vd = temp;                                                       \
 }
 
 VPICKEV(vpickev_b, 16, B)
@@ -3300,20 +3306,24 @@ VPICKEV(vpickev_h, 32, H)
 VPICKEV(vpickev_w, 64, W)
 VPICKEV(vpickev_d, 128, D)
 
-#define VPICKOD(NAME, BIT, E)                                  \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
-{                                                              \
-    int i;                                                     \
-    VReg temp;                                                 \
-    VReg *Vd = (VReg *)vd;                                     \
-    VReg *Vj = (VReg *)vj;                                     \
-    VReg *Vk = (VReg *)vk;                                     \
-                                                               \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
-        temp.E(i + LSX_LEN/BIT) = Vj->E(2 * i + 1);            \
-        temp.E(i) = Vk->E(2 * i + 1);                          \
-    }                                                          \
-    *Vd = temp;                                                \
+#define VPICKOD(NAME, BIT, E)                                             \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)            \
+{                                                                         \
+    int i, j, ofs;                                                        \
+    VReg temp = {};                                                       \
+    VReg *Vd = (VReg *)vd;                                                \
+    VReg *Vj = (VReg *)vj;                                                \
+    VReg *Vk = (VReg *)vk;                                                \
+    int oprsz = simd_oprsz(desc);                                         \
+                                                                          \
+    ofs = LSX_LEN / BIT;                                                  \
+    for (i = 0; i < oprsz / 16; i++) {                                    \
+        for (j = 0; j < ofs; j++) {                                       \
+            temp.E(j + ofs * (2 * i + 1)) = Vj->E(2 * (j + ofs * i) + 1); \
+            temp.E(j + ofs * 2 * i) = Vk->E(2 * (j + ofs * i) + 1);       \
+        }                                                                 \
+    }                                                                     \
+    *Vd = temp;                                                           \
 }
 
 VPICKOD(vpickod_b, 16, B)
@@ -3321,20 +3331,24 @@ VPICKOD(vpickod_h, 32, H)
 VPICKOD(vpickod_w, 64, W)
 VPICKOD(vpickod_d, 128, D)
 
-#define VILVL(NAME, BIT, E)                                    \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
-{                                                              \
-    int i;                                                     \
-    VReg temp;                                                 \
-    VReg *Vd = (VReg *)vd;                                     \
-    VReg *Vj = (VReg *)vj;                                     \
-    VReg *Vk = (VReg *)vk;                                     \
-                                                               \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
-        temp.E(2 * i + 1) = Vj->E(i);                          \
-        temp.E(2 * i) = Vk->E(i);                              \
-    }                                                          \
-    *Vd = temp;                                                \
+#define VILVL(NAME, BIT, E)                                         \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)      \
+{                                                                   \
+    int i, j, ofs;                                                  \
+    VReg temp = {};                                                 \
+    VReg *Vd = (VReg *)vd;                                          \
+    VReg *Vj = (VReg *)vj;                                          \
+    VReg *Vk = (VReg *)vk;                                          \
+    int oprsz = simd_oprsz(desc);                                   \
+                                                                    \
+    ofs = LSX_LEN / BIT;                                            \
+    for (i = 0; i < oprsz / 16; i++) {                              \
+        for (j = 0; j < ofs; j++) {                                 \
+            temp.E(2 * (j + ofs * i) + 1) = Vj->E(j + ofs * 2 * i); \
+            temp.E(2 * (j + ofs * i)) = Vk->E(j + ofs * 2 * i);     \
+        }                                                           \
+    }                                                               \
+    *Vd = temp;                                                     \
 }
 
 VILVL(vilvl_b, 16, B)
@@ -3342,20 +3356,24 @@ VILVL(vilvl_h, 32, H)
 VILVL(vilvl_w, 64, W)
 VILVL(vilvl_d, 128, D)
 
-#define VILVH(NAME, BIT, E)                                    \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
-{                                                              \
-    int i;                                                     \
-    VReg temp;                                                 \
-    VReg *Vd = (VReg *)vd;                                     \
-    VReg *Vj = (VReg *)vj;                                     \
-    VReg *Vk = (VReg *)vk;                                     \
-                                                               \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
-        temp.E(2 * i + 1) = Vj->E(i + LSX_LEN/BIT);            \
-        temp.E(2 * i) = Vk->E(i + LSX_LEN/BIT);                \
-    }                                                          \
-    *Vd = temp;                                                \
+#define VILVH(NAME, BIT, E)                                               \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)            \
+{                                                                         \
+    int i, j, ofs;                                                        \
+    VReg temp = {};                                                       \
+    VReg *Vd = (VReg *)vd;                                                \
+    VReg *Vj = (VReg *)vj;                                                \
+    VReg *Vk = (VReg *)vk;                                                \
+    int oprsz = simd_oprsz(desc);                                         \
+                                                                          \
+    ofs = LSX_LEN / BIT;                                                  \
+    for (i = 0; i < oprsz / 16; i++) {                                    \
+        for (j = 0; j < ofs; j++) {                                       \
+            temp.E(2 * (j + ofs * i) + 1) = Vj->E(j + ofs * (2 * i + 1)); \
+            temp.E(2 * (j + ofs * i)) = Vk->E(j + ofs * (2 * i + 1));     \
+        }                                                                 \
+    }                                                                     \
+    *Vd = temp;                                                           \
 }
 
 VILVH(vilvh_b, 16, B)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index dbaf3124fc..2b55ce4464 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -5170,6 +5170,14 @@ TRANS(vpackod_b, LSX, gen_vvv, gen_helper_vpackod_b)
 TRANS(vpackod_h, LSX, gen_vvv, gen_helper_vpackod_h)
 TRANS(vpackod_w, LSX, gen_vvv, gen_helper_vpackod_w)
 TRANS(vpackod_d, LSX, gen_vvv, gen_helper_vpackod_d)
+TRANS(xvpackev_b, LASX, gen_xxx, gen_helper_vpackev_b)
+TRANS(xvpackev_h, LASX, gen_xxx, gen_helper_vpackev_h)
+TRANS(xvpackev_w, LASX, gen_xxx, gen_helper_vpackev_w)
+TRANS(xvpackev_d, LASX, gen_xxx, gen_helper_vpackev_d)
+TRANS(xvpackod_b, LASX, gen_xxx, gen_helper_vpackod_b)
+TRANS(xvpackod_h, LASX, gen_xxx, gen_helper_vpackod_h)
+TRANS(xvpackod_w, LASX, gen_xxx, gen_helper_vpackod_w)
+TRANS(xvpackod_d, LASX, gen_xxx, gen_helper_vpackod_d)
 
 TRANS(vpickev_b, LSX, gen_vvv, gen_helper_vpickev_b)
 TRANS(vpickev_h, LSX, gen_vvv, gen_helper_vpickev_h)
@@ -5179,6 +5187,14 @@ TRANS(vpickod_b, LSX, gen_vvv, gen_helper_vpickod_b)
 TRANS(vpickod_h, LSX, gen_vvv, gen_helper_vpickod_h)
 TRANS(vpickod_w, LSX, gen_vvv, gen_helper_vpickod_w)
 TRANS(vpickod_d, LSX, gen_vvv, gen_helper_vpickod_d)
+TRANS(xvpickev_b, LASX, gen_xxx, gen_helper_vpickev_b)
+TRANS(xvpickev_h, LASX, gen_xxx, gen_helper_vpickev_h)
+TRANS(xvpickev_w, LASX, gen_xxx, gen_helper_vpickev_w)
+TRANS(xvpickev_d, LASX, gen_xxx, gen_helper_vpickev_d)
+TRANS(xvpickod_b, LASX, gen_xxx, gen_helper_vpickod_b)
+TRANS(xvpickod_h, LASX, gen_xxx, gen_helper_vpickod_h)
+TRANS(xvpickod_w, LASX, gen_xxx, gen_helper_vpickod_w)
+TRANS(xvpickod_d, LASX, gen_xxx, gen_helper_vpickod_d)
 
 TRANS(vilvl_b, LSX, gen_vvv, gen_helper_vilvl_b)
 TRANS(vilvl_h, LSX, gen_vvv, gen_helper_vilvl_h)
@@ -5188,6 +5204,14 @@ TRANS(vilvh_b, LSX, gen_vvv, gen_helper_vilvh_b)
 TRANS(vilvh_h, LSX, gen_vvv, gen_helper_vilvh_h)
 TRANS(vilvh_w, LSX, gen_vvv, gen_helper_vilvh_w)
 TRANS(vilvh_d, LSX, gen_vvv, gen_helper_vilvh_d)
+TRANS(xvilvl_b, LASX, gen_xxx, gen_helper_vilvl_b)
+TRANS(xvilvl_h, LASX, gen_xxx, gen_helper_vilvl_h)
+TRANS(xvilvl_w, LASX, gen_xxx, gen_helper_vilvl_w)
+TRANS(xvilvl_d, LASX, gen_xxx, gen_helper_vilvl_d)
+TRANS(xvilvh_b, LASX, gen_xxx, gen_helper_vilvh_b)
+TRANS(xvilvh_h, LASX, gen_xxx, gen_helper_vilvh_h)
+TRANS(xvilvh_w, LASX, gen_xxx, gen_helper_vilvh_w)
+TRANS(xvilvh_d, LASX, gen_xxx, gen_helper_vilvh_d)
 
 TRANS(vshuf_b, LSX, gen_vvvv, gen_helper_vshuf_b)
 TRANS(vshuf_h, LSX, gen_vvv, gen_helper_vshuf_h)
-- 
2.39.1


