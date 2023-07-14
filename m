Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 416E97535A1
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:51:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKES7-0003cj-2w; Fri, 14 Jul 2023 04:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKERt-0002JS-Qm
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKERr-0004qC-HO
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:49 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxNvFqC7Fki84EAA--.13493S3;
 Fri, 14 Jul 2023 16:46:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S30; 
 Fri, 14 Jul 2023 16:46:34 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 28/47] target/loongarch: Implement xvsrlr xvsrar
Date: Fri, 14 Jul 2023 16:45:56 +0800
Message-Id: <20230714084615.2448038-29-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S30
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
 target/loongarch/disas.c                     | 18 ++++++++++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 18 ++++++++++++++++++
 target/loongarch/insns.decode                | 17 +++++++++++++++++
 target/loongarch/vec_helper.c                | 12 ++++++++----
 4 files changed, 61 insertions(+), 4 deletions(-)

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
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index b51e80dece..aebe384220 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -405,6 +405,24 @@ TRANS(xvsllwil_wu_hu, gen_vv_i, 32, gen_helper_vsllwil_wu_hu)
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
index dcf75d421c..38b55e00ca 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -997,8 +997,9 @@ void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)  \
     VReg *Vd = (VReg *)vd;                                      \
     VReg *Vj = (VReg *)vj;                                      \
     VReg *Vk = (VReg *)vk;                                      \
+    int oprsz = simd_oprsz(desc);                               \
                                                                 \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                         \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                   \
         Vd->E(i) = do_vsrlr_ ## E(Vj->E(i), ((T)Vk->E(i))%BIT); \
     }                                                           \
 }
@@ -1014,8 +1015,9 @@ void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
     int i;                                                         \
     VReg *Vd = (VReg *)vd;                                         \
     VReg *Vj = (VReg *)vj;                                         \
+    int oprsz = simd_oprsz(desc);                                  \
                                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                            \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                      \
         Vd->E(i) = do_vsrlr_ ## E(Vj->E(i), imm);                  \
     }                                                              \
 }
@@ -1047,8 +1049,9 @@ void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)  \
     VReg *Vd = (VReg *)vd;                                      \
     VReg *Vj = (VReg *)vj;                                      \
     VReg *Vk = (VReg *)vk;                                      \
+    int oprsz = simd_oprsz(desc);                               \
                                                                 \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                         \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                   \
         Vd->E(i) = do_vsrar_ ## E(Vj->E(i), ((T)Vk->E(i))%BIT); \
     }                                                           \
 }
@@ -1064,8 +1067,9 @@ void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
     int i;                                                         \
     VReg *Vd = (VReg *)vd;                                         \
     VReg *Vj = (VReg *)vj;                                         \
+    int oprsz = simd_oprsz(desc);                                  \
                                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                            \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                      \
         Vd->E(i) = do_vsrar_ ## E(Vj->E(i), imm);                  \
     }                                                              \
 }
-- 
2.39.1


