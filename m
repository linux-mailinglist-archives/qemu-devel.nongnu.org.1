Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E2779F815
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:31:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgc6K-0006IX-2E; Wed, 13 Sep 2023 22:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgc4v-0003JQ-8V
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgc4s-00050n-V4
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:37 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxuOiKbwJltPgmAA--.39692S3;
 Thu, 14 Sep 2023 10:27:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdxmbwJlJ+UDAA--.7298S47; 
 Thu, 14 Sep 2023 10:27:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 45/57] target/loongarch: Implement xvfrstp
Date: Thu, 14 Sep 2023 10:26:33 +0800
Message-Id: <20230914022645.1151356-46-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914022645.1151356-1-gaosong@loongson.cn>
References: <20230914022645.1151356-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdxmbwJlJ+UDAA--.7298S47
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
- XVFRSTP[I].{B/H}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/insns.decode               |  5 ++++
 target/loongarch/disas.c                    |  5 ++++
 target/loongarch/vec_helper.c               | 32 +++++++++++++--------
 target/loongarch/insn_trans/trans_vec.c.inc |  4 +++
 4 files changed, 34 insertions(+), 12 deletions(-)

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
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 7f04c912aa..1c4aecaa93 100644
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
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index ec63efb428..9ddbbc665a 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -2369,18 +2369,22 @@ DO_BITI(vbitrevi_d, 64, UD, DO_BITREV)
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
@@ -2389,17 +2393,21 @@ VFRSTP(vfrstp_h, 16, 0x7, H)
 #define VFRSTPI(NAME, BIT, E)                                      \
 void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
 {                                                                  \
-    int i, m;                                                      \
+    int i, j, m, ofs;                                              \
     VReg *Vd = (VReg *)vd;                                         \
     VReg *Vj = (VReg *)vj;                                         \
+    int oprsz = simd_oprsz(desc);                                  \
                                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                            \
-        if (Vj->E(i) < 0) {                                        \
-            break;                                                 \
+    ofs = LSX_LEN / BIT;                                           \
+    m = imm % ofs;                                                 \
+    for (i = 0; i < oprsz / 16; i++) {                             \
+        for (j = 0; j < ofs; j++) {                                \
+            if (Vj->E(j + ofs * i) < 0) {                          \
+                break;                                             \
+            }                                                      \
         }                                                          \
+        Vd->E(m + i * ofs) = j;                                    \
     }                                                              \
-    m = imm % (LSX_LEN/BIT);                                       \
-    Vd->E(m) = i;                                                  \
 }
 
 VFRSTPI(vfrstpi_b, 8,  B)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 9e7eb30356..c1e7130a73 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -4300,6 +4300,10 @@ TRANS(vfrstp_b, LSX, gen_vvv, gen_helper_vfrstp_b)
 TRANS(vfrstp_h, LSX, gen_vvv, gen_helper_vfrstp_h)
 TRANS(vfrstpi_b, LSX, gen_vv_i, gen_helper_vfrstpi_b)
 TRANS(vfrstpi_h, LSX, gen_vv_i, gen_helper_vfrstpi_h)
+TRANS(xvfrstp_b, LASX, gen_xxx, gen_helper_vfrstp_b)
+TRANS(xvfrstp_h, LASX, gen_xxx, gen_helper_vfrstp_h)
+TRANS(xvfrstpi_b, LASX, gen_xx_i, gen_helper_vfrstpi_b)
+TRANS(xvfrstpi_h, LASX, gen_xx_i, gen_helper_vfrstpi_h)
 
 TRANS(vfadd_s, LSX, gen_vvv_ptr, gen_helper_vfadd_s)
 TRANS(vfadd_d, LSX, gen_vvv_ptr, gen_helper_vfadd_d)
-- 
2.39.1


