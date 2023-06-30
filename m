Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF71743684
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:07:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF94g-0004Id-2R; Fri, 30 Jun 2023 04:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF94A-0003mW-81
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:01:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF946-00007A-S9
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:01:17 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dx+cVci55kkjQEAA--.6967S3;
 Fri, 30 Jun 2023 15:59:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S29; 
 Fri, 30 Jun 2023 15:59:23 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 27/46] target/loongarch: Implement xvsrlr xvsrar
Date: Fri, 30 Jun 2023 15:58:45 +0800
Message-Id: <20230630075904.45940-28-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S29
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
- XVSRLR[I].{B/H/W/D};
- XVSRAR[I].{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 18 +++++++++++
 target/loongarch/helper.h                    | 34 ++++++++++----------
 target/loongarch/insn_trans/trans_lasx.c.inc | 18 +++++++++++
 target/loongarch/insns.decode                | 17 ++++++++++
 target/loongarch/vec_helper.c                | 28 +++++++++-------
 5 files changed, 86 insertions(+), 29 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 93c205fa32..9109203a05 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2086,6 +2086,24 @@ INSN_LASX(xvsllwil_wu_hu,    vv_i)
 INSN_LASX(xvsllwil_du_wu,    vv_i)
 INSN_LASX(xvextl_qu_du,      vv)
 
+INSN_LASX(xvsrlr_b,          vvv)
+INSN_LASX(xvsrlr_h,          vvv)
+INSN_LASX(xvsrlr_w,          vvv)
+INSN_LASX(xvsrlr_d,          vvv)
+INSN_LASX(xvsrlri_b,         vv_i)
+INSN_LASX(xvsrlri_h,         vv_i)
+INSN_LASX(xvsrlri_w,         vv_i)
+INSN_LASX(xvsrlri_d,         vv_i)
+
+INSN_LASX(xvsrar_b,          vvv)
+INSN_LASX(xvsrar_h,          vvv)
+INSN_LASX(xvsrar_w,          vvv)
+INSN_LASX(xvsrar_d,          vvv)
+INSN_LASX(xvsrari_b,         vv_i)
+INSN_LASX(xvsrari_h,         vv_i)
+INSN_LASX(xvsrari_w,         vv_i)
+INSN_LASX(xvsrari_d,         vv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 81c3ad4cc0..b4828b1829 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -375,23 +375,23 @@ DEF_HELPER_5(vsllwil_wu_hu, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vsllwil_du_wu, void, env, i32, i32, i32, i32)
 DEF_HELPER_4(vextl_qu_du, void, env, i32, i32, i32)
 
-DEF_HELPER_4(vsrlr_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlr_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlr_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlr_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlri_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlri_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlri_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlri_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vsrar_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrar_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrar_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrar_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrari_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrari_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrari_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrari_d, void, env, i32, i32, i32)
+DEF_HELPER_5(vsrlr_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlr_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlr_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlr_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlri_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlri_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlri_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsrlri_d, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_5(vsrar_b, void, env, int, i32, i32, i32)
+DEF_HELPER_5(vsrar_h, void, env, int, i32, i32, i32)
+DEF_HELPER_5(vsrar_w, void, env, int, i32, i32, i32)
+DEF_HELPER_5(vsrar_d, void, env, int, i32, i32, i32)
+DEF_HELPER_5(vsrari_b, void, env, int, i32, i32, i32)
+DEF_HELPER_5(vsrari_h, void, env, int, i32, i32, i32)
+DEF_HELPER_5(vsrari_w, void, env, int, i32, i32, i32)
+DEF_HELPER_5(vsrari_d, void, env, int, i32, i32, i32)
 
 DEF_HELPER_4(vsrln_b_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrln_h_w, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 497940b6fd..2f654ef401 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -462,6 +462,24 @@ TRANS(xvsllwil_wu_hu, gen_vv_i, 32, gen_helper_vsllwil_wu_hu)
 TRANS(xvsllwil_du_wu, gen_vv_i, 32, gen_helper_vsllwil_du_wu)
 TRANS(xvextl_qu_du, gen_vv, 32, gen_helper_vextl_qu_du)
 
+TRANS(xvsrlr_b, gen_vvv, 32, gen_helper_vsrlr_b)
+TRANS(xvsrlr_h, gen_vvv, 32, gen_helper_vsrlr_h)
+TRANS(xvsrlr_w, gen_vvv, 32, gen_helper_vsrlr_w)
+TRANS(xvsrlr_d, gen_vvv, 32, gen_helper_vsrlr_d)
+TRANS(xvsrlri_b, gen_vv_i, 32, gen_helper_vsrlri_b)
+TRANS(xvsrlri_h, gen_vv_i, 32, gen_helper_vsrlri_h)
+TRANS(xvsrlri_w, gen_vv_i, 32, gen_helper_vsrlri_w)
+TRANS(xvsrlri_d, gen_vv_i, 32, gen_helper_vsrlri_d)
+
+TRANS(xvsrar_b, gen_vvv, 32, gen_helper_vsrar_b)
+TRANS(xvsrar_h, gen_vvv, 32, gen_helper_vsrar_h)
+TRANS(xvsrar_w, gen_vvv, 32, gen_helper_vsrar_w)
+TRANS(xvsrar_d, gen_vvv, 32, gen_helper_vsrar_d)
+TRANS(xvsrari_b, gen_vv_i, 32, gen_helper_vsrari_b)
+TRANS(xvsrari_h, gen_vv_i, 32, gen_helper_vsrari_h)
+TRANS(xvsrari_w, gen_vv_i, 32, gen_helper_vsrari_w)
+TRANS(xvsrari_d, gen_vv_i, 32, gen_helper_vsrari_d)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 8a7933eccc..ca0951e1cc 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1661,6 +1661,23 @@ xvsllwil_wu_hu   0111 01110000 11000 1 .... ..... .....   @vv_ui4
 xvsllwil_du_wu   0111 01110000 11001 ..... ..... .....    @vv_ui5
 xvextl_qu_du     0111 01110000 11010 00000 ..... .....    @vv
 
+xvsrlr_b         0111 01001111 00000 ..... ..... .....    @vvv
+xvsrlr_h         0111 01001111 00001 ..... ..... .....    @vvv
+xvsrlr_w         0111 01001111 00010 ..... ..... .....    @vvv
+xvsrlr_d         0111 01001111 00011 ..... ..... .....    @vvv
+xvsrlri_b        0111 01101010 01000 01 ... ..... .....   @vv_ui3
+xvsrlri_h        0111 01101010 01000 1 .... ..... .....   @vv_ui4
+xvsrlri_w        0111 01101010 01001 ..... ..... .....    @vv_ui5
+xvsrlri_d        0111 01101010 0101 ...... ..... .....    @vv_ui6
+xvsrar_b         0111 01001111 00100 ..... ..... .....    @vvv
+xvsrar_h         0111 01001111 00101 ..... ..... .....    @vvv
+xvsrar_w         0111 01001111 00110 ..... ..... .....    @vvv
+xvsrar_d         0111 01001111 00111 ..... ..... .....    @vvv
+xvsrari_b        0111 01101010 10000 01 ... ..... .....   @vv_ui3
+xvsrari_h        0111 01101010 10000 1 .... ..... .....   @vv_ui4
+xvsrari_w        0111 01101010 10001 ..... ..... .....    @vv_ui5
+xvsrari_d        0111 01101010 1001 ...... ..... .....    @vv_ui6
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 58b2b7da12..b745240f8c 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -1012,15 +1012,16 @@ do_vsrlr(W, uint32_t)
 do_vsrlr(D, uint64_t)
 
 #define VSRLR(NAME, BIT, T, E)                                  \
-void HELPER(NAME)(CPULoongArchState *env,                       \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,       \
                   uint32_t vd, uint32_t vj, uint32_t vk)        \
 {                                                               \
-    int i;                                                      \
+    int i, len;                                                 \
     VReg *Vd = &(env->fpr[vd].vreg);                            \
     VReg *Vj = &(env->fpr[vj].vreg);                            \
     VReg *Vk = &(env->fpr[vk].vreg);                            \
                                                                 \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                         \
+    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;                   \
+    for (i = 0; i < len / BIT; i++) {                           \
         Vd->E(i) = do_vsrlr_ ## E(Vj->E(i), ((T)Vk->E(i))%BIT); \
     }                                                           \
 }
@@ -1031,14 +1032,15 @@ VSRLR(vsrlr_w, 32, uint32_t, W)
 VSRLR(vsrlr_d, 64, uint64_t, D)
 
 #define VSRLRI(NAME, BIT, E)                              \
-void HELPER(NAME)(CPULoongArchState *env,                 \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz, \
                   uint32_t vd, uint32_t vj, uint32_t imm) \
 {                                                         \
-    int i;                                                \
+    int i, len;                                           \
     VReg *Vd = &(env->fpr[vd].vreg);                      \
     VReg *Vj = &(env->fpr[vj].vreg);                      \
                                                           \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                   \
+    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;             \
+    for (i = 0; i < len / BIT; i++) {                     \
         Vd->E(i) = do_vsrlr_ ## E(Vj->E(i), imm);         \
     }                                                     \
 }
@@ -1064,15 +1066,16 @@ do_vsrar(W, int32_t)
 do_vsrar(D, int64_t)
 
 #define VSRAR(NAME, BIT, T, E)                                  \
-void HELPER(NAME)(CPULoongArchState *env,                       \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,       \
                   uint32_t vd, uint32_t vj, uint32_t vk)        \
 {                                                               \
-    int i;                                                      \
+    int i, len;                                                 \
     VReg *Vd = &(env->fpr[vd].vreg);                            \
     VReg *Vj = &(env->fpr[vj].vreg);                            \
     VReg *Vk = &(env->fpr[vk].vreg);                            \
                                                                 \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                         \
+    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;                   \
+    for (i = 0; i < len / BIT; i++) {                           \
         Vd->E(i) = do_vsrar_ ## E(Vj->E(i), ((T)Vk->E(i))%BIT); \
     }                                                           \
 }
@@ -1083,14 +1086,15 @@ VSRAR(vsrar_w, 32, uint32_t, W)
 VSRAR(vsrar_d, 64, uint64_t, D)
 
 #define VSRARI(NAME, BIT, E)                              \
-void HELPER(NAME)(CPULoongArchState *env,                 \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz, \
                   uint32_t vd, uint32_t vj, uint32_t imm) \
 {                                                         \
-    int i;                                                \
+    int i, len;                                           \
     VReg *Vd = &(env->fpr[vd].vreg);                      \
     VReg *Vj = &(env->fpr[vj].vreg);                      \
                                                           \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                   \
+    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;             \
+    for (i = 0; i < len / BIT; i++) {                     \
         Vd->E(i) = do_vsrar_ ## E(Vj->E(i), imm);         \
     }                                                     \
 }
-- 
2.39.1


