Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B537A75357F
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:49:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKEU6-0002PB-4J; Fri, 14 Jul 2023 04:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKETq-0001sY-G1
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:48:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKETo-0005Ej-8T
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:48:50 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxCPJvC7Fkps4EAA--.13361S3;
 Fri, 14 Jul 2023 16:46:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S37; 
 Fri, 14 Jul 2023 16:46:38 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 35/47] target/loongarch: Implement xvbitclr xvbitset
 xvbitrev
Date: Fri, 14 Jul 2023 16:46:03 +0800
Message-Id: <20230714084615.2448038-36-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S37
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
- XVBITCLR[I].{B/H/W/D};
- XVBITSET[I].{B/H/W/D};
- XVBITREV[I].{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 25 ++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 27 +++++++++++
 target/loongarch/insns.decode                | 27 +++++++++++
 target/loongarch/vec.h                       |  4 ++
 target/loongarch/vec_helper.c                | 48 ++++++++++----------
 5 files changed, 106 insertions(+), 25 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 9e31f9bbbc..dad9243fd7 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2210,6 +2210,31 @@ INSN_LASX(xvpcnt_h,          vv)
 INSN_LASX(xvpcnt_w,          vv)
 INSN_LASX(xvpcnt_d,          vv)
 
+INSN_LASX(xvbitclr_b,        vvv)
+INSN_LASX(xvbitclr_h,        vvv)
+INSN_LASX(xvbitclr_w,        vvv)
+INSN_LASX(xvbitclr_d,        vvv)
+INSN_LASX(xvbitclri_b,       vv_i)
+INSN_LASX(xvbitclri_h,       vv_i)
+INSN_LASX(xvbitclri_w,       vv_i)
+INSN_LASX(xvbitclri_d,       vv_i)
+INSN_LASX(xvbitset_b,        vvv)
+INSN_LASX(xvbitset_h,        vvv)
+INSN_LASX(xvbitset_w,        vvv)
+INSN_LASX(xvbitset_d,        vvv)
+INSN_LASX(xvbitseti_b,       vv_i)
+INSN_LASX(xvbitseti_h,       vv_i)
+INSN_LASX(xvbitseti_w,       vv_i)
+INSN_LASX(xvbitseti_d,       vv_i)
+INSN_LASX(xvbitrev_b,        vvv)
+INSN_LASX(xvbitrev_h,        vvv)
+INSN_LASX(xvbitrev_w,        vvv)
+INSN_LASX(xvbitrev_d,        vvv)
+INSN_LASX(xvbitrevi_b,       vv_i)
+INSN_LASX(xvbitrevi_h,       vv_i)
+INSN_LASX(xvbitrevi_w,       vv_i)
+INSN_LASX(xvbitrevi_d,       vv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 94824569a0..e52c7551d9 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -529,6 +529,33 @@ TRANS(xvpcnt_h, gen_vv, 32, gen_helper_vpcnt_h)
 TRANS(xvpcnt_w, gen_vv, 32, gen_helper_vpcnt_w)
 TRANS(xvpcnt_d, gen_vv, 32, gen_helper_vpcnt_d)
 
+TRANS(xvbitclr_b, gvec_vvv, 32, MO_8, do_vbitclr)
+TRANS(xvbitclr_h, gvec_vvv, 32, MO_16, do_vbitclr)
+TRANS(xvbitclr_w, gvec_vvv, 32, MO_32, do_vbitclr)
+TRANS(xvbitclr_d, gvec_vvv, 32, MO_64, do_vbitclr)
+TRANS(xvbitclri_b, gvec_vv_i, 32, MO_8, do_vbitclri)
+TRANS(xvbitclri_h, gvec_vv_i, 32, MO_16, do_vbitclri)
+TRANS(xvbitclri_w, gvec_vv_i, 32, MO_32, do_vbitclri)
+TRANS(xvbitclri_d, gvec_vv_i, 32, MO_64, do_vbitclri)
+
+TRANS(xvbitset_b, gvec_vvv, 32, MO_8, do_vbitset)
+TRANS(xvbitset_h, gvec_vvv, 32, MO_16, do_vbitset)
+TRANS(xvbitset_w, gvec_vvv, 32, MO_32, do_vbitset)
+TRANS(xvbitset_d, gvec_vvv, 32, MO_64, do_vbitset)
+TRANS(xvbitseti_b, gvec_vv_i, 32, MO_8, do_vbitseti)
+TRANS(xvbitseti_h, gvec_vv_i, 32, MO_16, do_vbitseti)
+TRANS(xvbitseti_w, gvec_vv_i, 32, MO_32, do_vbitseti)
+TRANS(xvbitseti_d, gvec_vv_i, 32, MO_64, do_vbitseti)
+
+TRANS(xvbitrev_b, gvec_vvv, 32, MO_8, do_vbitrev)
+TRANS(xvbitrev_h, gvec_vvv, 32, MO_16, do_vbitrev)
+TRANS(xvbitrev_w, gvec_vvv, 32, MO_32, do_vbitrev)
+TRANS(xvbitrev_d, gvec_vvv, 32, MO_64, do_vbitrev)
+TRANS(xvbitrevi_b, gvec_vv_i, 32, MO_8, do_vbitrevi)
+TRANS(xvbitrevi_h, gvec_vv_i, 32, MO_16, do_vbitrevi)
+TRANS(xvbitrevi_w, gvec_vv_i, 32, MO_32, do_vbitrevi)
+TRANS(xvbitrevi_d, gvec_vv_i, 32, MO_64, do_vbitrevi)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index d683c6a6ab..cb6db8002a 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1784,6 +1784,33 @@ xvpcnt_h         0111 01101001 11000 01001 ..... .....    @vv
 xvpcnt_w         0111 01101001 11000 01010 ..... .....    @vv
 xvpcnt_d         0111 01101001 11000 01011 ..... .....    @vv
 
+xvbitclr_b       0111 01010000 11000 ..... ..... .....    @vvv
+xvbitclr_h       0111 01010000 11001 ..... ..... .....    @vvv
+xvbitclr_w       0111 01010000 11010 ..... ..... .....    @vvv
+xvbitclr_d       0111 01010000 11011 ..... ..... .....    @vvv
+xvbitclri_b      0111 01110001 00000 01 ... ..... .....   @vv_ui3
+xvbitclri_h      0111 01110001 00000 1 .... ..... .....   @vv_ui4
+xvbitclri_w      0111 01110001 00001 ..... ..... .....    @vv_ui5
+xvbitclri_d      0111 01110001 0001 ...... ..... .....    @vv_ui6
+
+xvbitset_b       0111 01010000 11100 ..... ..... .....    @vvv
+xvbitset_h       0111 01010000 11101 ..... ..... .....    @vvv
+xvbitset_w       0111 01010000 11110 ..... ..... .....    @vvv
+xvbitset_d       0111 01010000 11111 ..... ..... .....    @vvv
+xvbitseti_b      0111 01110001 01000 01 ... ..... .....   @vv_ui3
+xvbitseti_h      0111 01110001 01000 1 .... ..... .....   @vv_ui4
+xvbitseti_w      0111 01110001 01001 ..... ..... .....    @vv_ui5
+xvbitseti_d      0111 01110001 0101 ...... ..... .....    @vv_ui6
+
+xvbitrev_b       0111 01010001 00000 ..... ..... .....    @vvv
+xvbitrev_h       0111 01010001 00001 ..... ..... .....    @vvv
+xvbitrev_w       0111 01010001 00010 ..... ..... .....    @vvv
+xvbitrev_d       0111 01010001 00011 ..... ..... .....    @vvv
+xvbitrevi_b      0111 01110001 10000 01 ... ..... .....   @vv_ui3
+xvbitrevi_h      0111 01110001 10000 1 .... ..... .....   @vv_ui4
+xvbitrevi_w      0111 01110001 10001 ..... ..... .....    @vv_ui5
+xvbitrevi_d      0111 01110001 1001 ...... ..... .....    @vv_ui6
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 4497cd4a6d..aae70f9de9 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -85,4 +85,8 @@
 #define DO_CLZ_W(N)  (clz32(N))
 #define DO_CLZ_D(N)  (clz64(N))
 
+#define DO_BITCLR(a, bit) (a & ~(1ull << bit))
+#define DO_BITSET(a, bit) (a | 1ull << bit)
+#define DO_BITREV(a, bit) (a ^ (1ull << bit))
+
 #endif /* LOONGARCH_VEC_H */
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 57e9a9ed65..922eac40fb 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -2195,21 +2195,18 @@ VPCNT(vpcnt_h, 16, UH, ctpop16)
 VPCNT(vpcnt_w, 32, UW, ctpop32)
 VPCNT(vpcnt_d, 64, UD, ctpop64)
 
-#define DO_BITCLR(a, bit) (a & ~(1ull << bit))
-#define DO_BITSET(a, bit) (a | 1ull << bit)
-#define DO_BITREV(a, bit) (a ^ (1ull << bit))
-
-#define DO_BIT(NAME, BIT, E, DO_OP)                         \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v) \
-{                                                           \
-    int i;                                                  \
-    VReg *Vd = (VReg *)vd;                                  \
-    VReg *Vj = (VReg *)vj;                                  \
-    VReg *Vk = (VReg *)vk;                                  \
-                                                            \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                     \
-        Vd->E(i) = DO_OP(Vj->E(i), Vk->E(i)%BIT);           \
-    }                                                       \
+#define DO_BIT(NAME, BIT, E, DO_OP)                            \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+    int oprsz = simd_oprsz(desc);                              \
+                                                               \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                  \
+        Vd->E(i) = DO_OP(Vj->E(i), Vk->E(i) % BIT);            \
+    }                                                          \
 }
 
 DO_BIT(vbitclr_b, 8, UB, DO_BITCLR)
@@ -2225,16 +2222,17 @@ DO_BIT(vbitrev_h, 16, UH, DO_BITREV)
 DO_BIT(vbitrev_w, 32, UW, DO_BITREV)
 DO_BIT(vbitrev_d, 64, UD, DO_BITREV)
 
-#define DO_BITI(NAME, BIT, E, DO_OP)                            \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t v) \
-{                                                               \
-    int i;                                                      \
-    VReg *Vd = (VReg *)vd;                                      \
-    VReg *Vj = (VReg *)vj;                                      \
-                                                                \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                         \
-        Vd->E(i) = DO_OP(Vj->E(i), imm);                        \
-    }                                                           \
+#define DO_BITI(NAME, BIT, E, DO_OP)                               \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    int i;                                                         \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+    int oprsz = simd_oprsz(desc);                                  \
+                                                                   \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                      \
+        Vd->E(i) = DO_OP(Vj->E(i), imm);                           \
+    }                                                              \
 }
 
 DO_BITI(vbitclri_b, 8, UB, DO_BITCLR)
-- 
2.39.1


