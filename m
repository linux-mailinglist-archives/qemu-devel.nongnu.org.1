Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC32978D44D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGtM-0000fH-0i; Wed, 30 Aug 2023 04:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qbGtK-0000Xz-Ad
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:49:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qbGtH-0007Ux-3L
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:49:34 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxfeuOAu9kkggdAA--.56989S3;
 Wed, 30 Aug 2023 16:49:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxF81+Au9kHhxnAA--.49766S21; 
 Wed, 30 Aug 2023 16:49:18 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v4 19/48] target/loongarch; Implement xvdiv/xvmod
Date: Wed, 30 Aug 2023 16:48:33 +0800
Message-Id: <20230830084902.2113960-20-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230830084902.2113960-1-gaosong@loongson.cn>
References: <20230830084902.2113960-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF81+Au9kHhxnAA--.49766S21
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
- XVDIV.{B/H/W/D}[U];
- XVMOD.{B/H/W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/vec.h                       |  7 +++++++
 target/loongarch/insns.decode                | 17 +++++++++++++++++
 target/loongarch/disas.c                     | 17 +++++++++++++++++
 target/loongarch/vec_helper.c                | 10 ++--------
 target/loongarch/insn_trans/trans_lasx.c.inc | 17 +++++++++++++++++
 5 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 06c8d7e314..ee50d53f4e 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -65,4 +65,11 @@
 #define DO_MADD(a, b, c)  (a + b * c)
 #define DO_MSUB(a, b, c)  (a - b * c)
 
+#define DO_DIVU(N, M) (unlikely(M == 0) ? 0 : N / M)
+#define DO_REMU(N, M) (unlikely(M == 0) ? 0 : N % M)
+#define DO_DIV(N, M)  (unlikely(M == 0) ? 0 :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? N : N / M)
+#define DO_REM(N, M)  (unlikely(M == 0) ? 0 :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
+
 #endif /* LOONGARCH_VEC_H */
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index d6fb51ae64..fa25c876b4 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1545,6 +1545,23 @@ xvmaddwod_w_hu_h 0111 01001011 11101 ..... ..... .....    @vvv
 xvmaddwod_d_wu_w 0111 01001011 11110 ..... ..... .....    @vvv
 xvmaddwod_q_du_d 0111 01001011 11111 ..... ..... .....    @vvv
 
+xvdiv_b          0111 01001110 00000 ..... ..... .....    @vvv
+xvdiv_h          0111 01001110 00001 ..... ..... .....    @vvv
+xvdiv_w          0111 01001110 00010 ..... ..... .....    @vvv
+xvdiv_d          0111 01001110 00011 ..... ..... .....    @vvv
+xvmod_b          0111 01001110 00100 ..... ..... .....    @vvv
+xvmod_h          0111 01001110 00101 ..... ..... .....    @vvv
+xvmod_w          0111 01001110 00110 ..... ..... .....    @vvv
+xvmod_d          0111 01001110 00111 ..... ..... .....    @vvv
+xvdiv_bu         0111 01001110 01000 ..... ..... .....    @vvv
+xvdiv_hu         0111 01001110 01001 ..... ..... .....    @vvv
+xvdiv_wu         0111 01001110 01010 ..... ..... .....    @vvv
+xvdiv_du         0111 01001110 01011 ..... ..... .....    @vvv
+xvmod_bu         0111 01001110 01100 ..... ..... .....    @vvv
+xvmod_hu         0111 01001110 01101 ..... ..... .....    @vvv
+xvmod_wu         0111 01001110 01110 ..... ..... .....    @vvv
+xvmod_du         0111 01001110 01111 ..... ..... .....    @vvv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index b115fe8315..72df9f0b08 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1962,6 +1962,23 @@ INSN_LASX(xvmaddwod_w_hu_h,  vvv)
 INSN_LASX(xvmaddwod_d_wu_w,  vvv)
 INSN_LASX(xvmaddwod_q_du_d,  vvv)
 
+INSN_LASX(xvdiv_b,           vvv)
+INSN_LASX(xvdiv_h,           vvv)
+INSN_LASX(xvdiv_w,           vvv)
+INSN_LASX(xvdiv_d,           vvv)
+INSN_LASX(xvdiv_bu,          vvv)
+INSN_LASX(xvdiv_hu,          vvv)
+INSN_LASX(xvdiv_wu,          vvv)
+INSN_LASX(xvdiv_du,          vvv)
+INSN_LASX(xvmod_b,           vvv)
+INSN_LASX(xvmod_h,           vvv)
+INSN_LASX(xvmod_w,           vvv)
+INSN_LASX(xvmod_d,           vvv)
+INSN_LASX(xvmod_bu,          vvv)
+INSN_LASX(xvmod_hu,          vvv)
+INSN_LASX(xvmod_wu,          vvv)
+INSN_LASX(xvmod_du,          vvv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 5a1bff8b04..d217d76ea7 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -621,13 +621,6 @@ VMADDWOD_U_S(vmaddwod_h_bu_b, 16, H, UH, B, UB, DO_MUL)
 VMADDWOD_U_S(vmaddwod_w_hu_h, 32, W, UW, H, UH, DO_MUL)
 VMADDWOD_U_S(vmaddwod_d_wu_w, 64, D, UD, W, UW, DO_MUL)
 
-#define DO_DIVU(N, M) (unlikely(M == 0) ? 0 : N / M)
-#define DO_REMU(N, M) (unlikely(M == 0) ? 0 : N % M)
-#define DO_DIV(N, M)  (unlikely(M == 0) ? 0 :\
-        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? N : N / M)
-#define DO_REM(N, M)  (unlikely(M == 0) ? 0 :\
-        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
-
 #define VDIV(NAME, BIT, E, DO_OP)                              \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
 {                                                              \
@@ -635,8 +628,9 @@ void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
     VReg *Vd = (VReg *)vd;                                     \
     VReg *Vj = (VReg *)vj;                                     \
     VReg *Vk = (VReg *)vk;                                     \
+    int oprsz = simd_oprsz(desc);                              \
                                                                \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                  \
         Vd->E(i) = DO_OP(Vj->E(i), Vk->E(i));                  \
     }                                                          \
 }
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 1073118417..fff6ddd3e0 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -291,6 +291,23 @@ TRANS(xvmaddwod_h_bu_b, LASX, gvec_vvv, 32, MO_8, do_vmaddwod_u_s)
 TRANS(xvmaddwod_w_hu_h, LASX, gvec_vvv, 32, MO_16, do_vmaddwod_u_s)
 TRANS(xvmaddwod_d_wu_w, LASX, gvec_vvv, 32, MO_32, do_vmaddwod_u_s)
 
+TRANS(xvdiv_b, LASX, gen_vvv, 32, gen_helper_vdiv_b)
+TRANS(xvdiv_h, LASX, gen_vvv, 32, gen_helper_vdiv_h)
+TRANS(xvdiv_w, LASX, gen_vvv, 32, gen_helper_vdiv_w)
+TRANS(xvdiv_d, LASX, gen_vvv, 32, gen_helper_vdiv_d)
+TRANS(xvdiv_bu, LASX, gen_vvv, 32, gen_helper_vdiv_bu)
+TRANS(xvdiv_hu, LASX, gen_vvv, 32, gen_helper_vdiv_hu)
+TRANS(xvdiv_wu, LASX, gen_vvv, 32, gen_helper_vdiv_wu)
+TRANS(xvdiv_du, LASX, gen_vvv, 32, gen_helper_vdiv_du)
+TRANS(xvmod_b, LASX, gen_vvv, 32, gen_helper_vmod_b)
+TRANS(xvmod_h, LASX, gen_vvv, 32, gen_helper_vmod_h)
+TRANS(xvmod_w, LASX, gen_vvv, 32, gen_helper_vmod_w)
+TRANS(xvmod_d, LASX, gen_vvv, 32, gen_helper_vmod_d)
+TRANS(xvmod_bu, LASX, gen_vvv, 32, gen_helper_vmod_bu)
+TRANS(xvmod_hu, LASX, gen_vvv, 32, gen_helper_vmod_hu)
+TRANS(xvmod_wu, LASX, gen_vvv, 32, gen_helper_vmod_wu)
+TRANS(xvmod_du, LASX, gen_vvv, 32, gen_helper_vmod_du)
+
 TRANS(xvreplgr2vr_b, LASX, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, LASX, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, LASX, gvec_dup, 32, MO_32)
-- 
2.39.1


