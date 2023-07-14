Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31388753559
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:47:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKESL-0003xb-1O; Fri, 14 Jul 2023 04:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKES0-00033x-Ra
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKERx-0004tL-Li
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:56 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxJvFwC7FkqM4EAA--.13624S3;
 Fri, 14 Jul 2023 16:46:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S38; 
 Fri, 14 Jul 2023 16:46:39 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 36/47] target/loongarch: Implement xvfrstp
Date: Fri, 14 Jul 2023 16:46:04 +0800
Message-Id: <20230714084615.2448038-37-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S38
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
 target/loongarch/insn_trans/trans_lasx.c.inc |  5 ++
 target/loongarch/insns.decode                |  5 ++
 target/loongarch/vec_helper.c                | 48 ++++++++++++--------
 4 files changed, 43 insertions(+), 20 deletions(-)

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
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index e52c7551d9..081f692416 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -556,6 +556,11 @@ TRANS(xvbitrevi_h, gvec_vv_i, 32, MO_16, do_vbitrevi)
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
index 922eac40fb..24286bcef0 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -2251,37 +2251,45 @@ DO_BITI(vbitrevi_d, 64, UD, DO_BITREV)
 #define VFRSTP(NAME, BIT, MASK, E)                             \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
 {                                                              \
-    int i, m;                                                  \
+    int i, j, m, ofs;                                          \
     VReg *Vd = (VReg *)vd;                                     \
     VReg *Vj = (VReg *)vj;                                     \
     VReg *Vk = (VReg *)vk;                                     \
+    int oprsz = simd_oprsz(desc);                              \
                                                                \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
-        if (Vj->E(i) < 0) {                                    \
-            break;                                             \
+    ofs = LSX_LEN / BIT;                                       \
+    for (i = 0; i < oprsz / 16; i++) {                         \
+        m = Vk->E(i * ofs) & MASK;                             \
+        for (j = 0; j < ofs; j++) {                            \
+            if (Vj->E(j + ofs * i) < 0) {                      \
+                break;                                         \
+            }                                                  \
         }                                                      \
+        Vd->E(m + i * ofs) = j;                                \
     }                                                          \
-    m = Vk->E(0) & MASK;                                       \
-    Vd->E(m) = i;                                              \
 }
 
 VFRSTP(vfrstp_b, 8, 0xf, B)
 VFRSTP(vfrstp_h, 16, 0x7, H)
 
-#define VFRSTPI(NAME, BIT, E)                                     \
-void HELPER(NAME)(void *vd, void vj, uint64_t imm, uint32_t desc) \
-{                                                                 \
-    int i, m;                                                     \
-    VReg *Vd = (VReg *)vd;                                        \
-    VReg *Vj = (VReg *)vj;                                        \
-                                                                  \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                           \
-        if (Vj->E(i) < 0) {                                       \
-            break;                                                \
-        }                                                         \
-    }                                                             \
-    m = imm % (LSX_LEN/BIT);                                      \
-    Vd->E(m) = i;                                                 \
+#define VFRSTPI(NAME, BIT, E)                                       \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)  \
+{                                                                   \
+    int i, j, m, ofs;                                               \
+    VReg *Vd = (VReg *)vd;                                          \
+    VReg *Vj = (VReg *)vj;                                          \
+    int oprsz = simd_oprsz(desc);                                   \
+                                                                    \
+    ofs = LSX_LEN / BIT;                                            \
+    m = imm % ofs;                                                  \
+    for (i = 0; i < oprsz / 16; i++) {                              \
+        for (j = 0; j < ofs; j++) {                                 \
+            if (Vj->E(j + ofs * i) < 0) {                           \
+                break;                                              \
+            }                                                       \
+        }                                                           \
+        Vd->E(m + i * ofs) = j;                                     \
+    }                                                               \
 }
 
 VFRSTPI(vfrstpi_b, 8,  B)
-- 
2.39.1


