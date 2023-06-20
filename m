Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A20A8736840
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:46:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXqZ-0003K9-Oz; Tue, 20 Jun 2023 05:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXqV-0002sM-8f
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXqM-0006aR-PK
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:40:17 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxEemjc5Fk5iUHAA--.12645S3;
 Tue, 20 Jun 2023 17:38:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S46; 
 Tue, 20 Jun 2023 17:38:42 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 44/46] target/loongarch: Implement xvshuf xvperm{i}
 xvshuf4i xvextrins
Date: Tue, 20 Jun 2023 17:38:12 +0800
Message-Id: <20230620093814.123650-45-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S46
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
- XVSHUF.{B/H/W/D};
- XVPERM.W;
- XVSHUF4i.{B/H/W/D};
- XVPERMI.{W/D/Q};
- XVEXTRINS.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  21 +++
 target/loongarch/helper.h                    |  21 +++
 target/loongarch/insn_trans/trans_lasx.c.inc |  21 +++
 target/loongarch/insns.decode                |  21 +++
 target/loongarch/lasx_helper.c               | 168 +++++++++++++++++++
 target/loongarch/lsx_helper.c                |   3 +-
 target/loongarch/vec.h                       |   2 +
 7 files changed, 255 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 4b815c86b8..9af1c95641 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2574,3 +2574,24 @@ INSN_LASX(xvilvh_b,          xxx)
 INSN_LASX(xvilvh_h,          xxx)
 INSN_LASX(xvilvh_w,          xxx)
 INSN_LASX(xvilvh_d,          xxx)
+
+INSN_LASX(xvshuf_b,          xxxx)
+INSN_LASX(xvshuf_h,          xxx)
+INSN_LASX(xvshuf_w,          xxx)
+INSN_LASX(xvshuf_d,          xxx)
+
+INSN_LASX(xvperm_w,          xxx)
+
+INSN_LASX(xvshuf4i_b,        xx_i)
+INSN_LASX(xvshuf4i_h,        xx_i)
+INSN_LASX(xvshuf4i_w,        xx_i)
+INSN_LASX(xvshuf4i_d,        xx_i)
+
+INSN_LASX(xvpermi_w,         xx_i)
+INSN_LASX(xvpermi_d,         xx_i)
+INSN_LASX(xvpermi_q,         xx_i)
+
+INSN_LASX(xvextrins_d,       xx_i)
+INSN_LASX(xvextrins_w,       xx_i)
+INSN_LASX(xvextrins_h,       xx_i)
+INSN_LASX(xvextrins_b,       xx_i)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index dc5ab59f8e..1058a7de75 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -1264,3 +1264,24 @@ DEF_HELPER_4(xvilvh_b, void, env, i32, i32, i32)
 DEF_HELPER_4(xvilvh_h, void, env, i32, i32, i32)
 DEF_HELPER_4(xvilvh_w, void, env, i32, i32, i32)
 DEF_HELPER_4(xvilvh_d, void, env, i32, i32, i32)
+
+DEF_HELPER_5(xvshuf_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_4(xvshuf_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvshuf_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvshuf_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvperm_w, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvshuf4i_b, void, env, i32, i32, i32)
+DEF_HELPER_4(xvshuf4i_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvshuf4i_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvshuf4i_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvpermi_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpermi_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpermi_q, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvextrins_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvextrins_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvextrins_h, void, env, i32, i32, i32)
+DEF_HELPER_4(xvextrins_b, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 75ac0ae1f1..1344f75113 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -3083,3 +3083,24 @@ TRANS(xvilvh_b, gen_xxx, gen_helper_xvilvh_b)
 TRANS(xvilvh_h, gen_xxx, gen_helper_xvilvh_h)
 TRANS(xvilvh_w, gen_xxx, gen_helper_xvilvh_w)
 TRANS(xvilvh_d, gen_xxx, gen_helper_xvilvh_d)
+
+TRANS(xvshuf_b, gen_xxxx, gen_helper_xvshuf_b)
+TRANS(xvshuf_h, gen_xxx, gen_helper_xvshuf_h)
+TRANS(xvshuf_w, gen_xxx, gen_helper_xvshuf_w)
+TRANS(xvshuf_d, gen_xxx, gen_helper_xvshuf_d)
+
+TRANS(xvperm_w, gen_xxx, gen_helper_xvperm_w)
+
+TRANS(xvshuf4i_b, gen_xx_i, gen_helper_xvshuf4i_b)
+TRANS(xvshuf4i_h, gen_xx_i, gen_helper_xvshuf4i_h)
+TRANS(xvshuf4i_w, gen_xx_i, gen_helper_xvshuf4i_w)
+TRANS(xvshuf4i_d, gen_xx_i, gen_helper_xvshuf4i_d)
+
+TRANS(xvpermi_w, gen_xx_i, gen_helper_xvpermi_w)
+TRANS(xvpermi_d, gen_xx_i, gen_helper_xvpermi_d)
+TRANS(xvpermi_q, gen_xx_i, gen_helper_xvpermi_q)
+
+TRANS(xvextrins_b, gen_xx_i, gen_helper_xvextrins_b)
+TRANS(xvextrins_h, gen_xx_i, gen_helper_xvextrins_h)
+TRANS(xvextrins_w, gen_xx_i, gen_helper_xvextrins_w)
+TRANS(xvextrins_d, gen_xx_i, gen_helper_xvextrins_d)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 5c3a18fbe2..9c6a6037e9 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -2078,3 +2078,24 @@ xvilvh_b         0111 01010001 11000 ..... ..... .....    @xxx
 xvilvh_h         0111 01010001 11001 ..... ..... .....    @xxx
 xvilvh_w         0111 01010001 11010 ..... ..... .....    @xxx
 xvilvh_d         0111 01010001 11011 ..... ..... .....    @xxx
+
+xvshuf_b         0000 11010110 ..... ..... ..... .....    @xxxx
+xvshuf_h         0111 01010111 10101 ..... ..... .....    @xxx
+xvshuf_w         0111 01010111 10110 ..... ..... .....    @xxx
+xvshuf_d         0111 01010111 10111 ..... ..... .....    @xxx
+
+xvperm_w         0111 01010111 11010 ..... ..... .....    @xxx
+
+xvshuf4i_b       0111 01111001 00 ........ ..... .....    @xx_ui8
+xvshuf4i_h       0111 01111001 01 ........ ..... .....    @xx_ui8
+xvshuf4i_w       0111 01111001 10 ........ ..... .....    @xx_ui8
+xvshuf4i_d       0111 01111001 11 ........ ..... .....    @xx_ui8
+
+xvpermi_w        0111 01111110 01 ........ ..... .....    @xx_ui8
+xvpermi_d        0111 01111110 10 ........ ..... .....    @xx_ui8
+xvpermi_q        0111 01111110 11 ........ ..... .....    @xx_ui8
+
+xvextrins_d      0111 01111000 00 ........ ..... .....    @xx_ui8
+xvextrins_w      0111 01111000 01 ........ ..... .....    @xx_ui8
+xvextrins_h      0111 01111000 10 ........ ..... .....    @xx_ui8
+xvextrins_b      0111 01111000 11 ........ ..... .....    @xx_ui8
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 50991998bf..a0338dfa6d 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -2992,3 +2992,171 @@ XVILVH(xvilvh_b, 8, XB)
 XVILVH(xvilvh_h, 16, XH)
 XVILVH(xvilvh_w, 32, XW)
 XVILVH(xvilvh_d, 64, XD)
+
+void HELPER(xvshuf_b)(CPULoongArchState *env,
+                      uint32_t xd, uint32_t xj, uint32_t xk, uint32_t xa)
+{
+    int i, m;
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+    XReg *Xk = &(env->fpr[xk].xreg);
+    XReg *Xa = &(env->fpr[xa].xreg);
+
+    m = LASX_LEN / (8 * 2);
+    for (i = 0; i < 2 * m ; i++) {
+        uint64_t k = (uint8_t)Xa->XB(i) % (2 * m);
+        if (i < m) {
+            temp.XB(i) = k < m ? Xk->XB(k) : Xj->XB(k - m);
+        } else {
+            temp.XB(i) = k < m ? Xk->XB(k + m) : Xj->XB(k);
+        }
+    }
+    *Xd = temp;
+}
+
+#define XVSHUF(NAME, BIT, E)                             \
+void HELPER(NAME)(CPULoongArchState *env,                \
+                  uint32_t xd, uint32_t xj, uint32_t xk) \
+{                                                        \
+    int i, m;                                            \
+    XReg temp;                                           \
+    XReg *Xd = &(env->fpr[xd].xreg);                     \
+    XReg *Xj = &(env->fpr[xj].xreg);                     \
+    XReg *Xk = &(env->fpr[xk].xreg);                     \
+                                                         \
+    m = LASX_LEN / (BIT * 2);                            \
+    for (i = 0; i < m * 2; i++) {                        \
+        uint64_t k  = (uint8_t)Xd->E(i) % (2 * m);       \
+        if (i < m) {                                     \
+            temp.E(i) = k < m ? Xk->E(k) : Xj->E(k - m); \
+        } else {                                         \
+            temp.E(i) = k < m ? Xk->E(k + m) : Xj->E(k); \
+        }                                                \
+    }                                                    \
+    *Xd = temp;                                          \
+}
+
+XVSHUF(xvshuf_h, 16, XH)
+XVSHUF(xvshuf_w, 32, XW)
+XVSHUF(xvshuf_d, 64, XD)
+
+void HELPER(xvperm_w)(CPULoongArchState *env,
+                      uint32_t xd, uint32_t xj, uint32_t xk)
+{
+    int i, m;
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+    XReg *Xk = &(env->fpr[xk].xreg);
+
+    m = LASX_LEN / 32;
+    for (i = 0; i < m ; i++) {
+        uint64_t k = (uint8_t)Xk->XW(i) % 8;
+        temp.XW(i) = Xj->XW(k);
+    }
+    *Xd = temp;
+}
+
+#define XVSHUF4I(NAME, BIT, E)                                      \
+void HELPER(NAME)(CPULoongArchState *env,                           \
+                  uint32_t xd, uint32_t xj, uint32_t imm)           \
+{                                                                   \
+    int i, m;                                                       \
+    XReg temp;                                                      \
+    XReg *Xd = &(env->fpr[xd].xreg);                                \
+    XReg *Xj = &(env->fpr[xj].xreg);                                \
+                                                                    \
+    m = LASX_LEN / BIT;                                             \
+    for (i = 0; i < m; i++) {                                       \
+        if (i < (m / 2)) {                                          \
+            temp.E(i) = Xj->E(SHF_POS(i, imm));                     \
+        } else {                                                    \
+            temp.E(i) = Xj->E(SHF_POS(i - (m / 2), imm) + (m / 2)); \
+        }                                                           \
+    }                                                               \
+    *Xd = temp;                                                     \
+}
+
+XVSHUF4I(xvshuf4i_b, 8, XB)
+XVSHUF4I(xvshuf4i_h, 16, XH)
+XVSHUF4I(xvshuf4i_w, 32, XW)
+
+void HELPER(xvshuf4i_d)(CPULoongArchState *env,
+                        uint32_t xd, uint32_t xj, uint32_t imm)
+{
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    XReg temp;
+    temp.XD(0) = (imm & 2 ? Xj : Xd)->XD(imm & 1);
+    temp.XD(1) = (imm & 8 ? Xj : Xd)->XD((imm >> 2) & 1);
+    temp.XD(2) = (imm & 2 ? Xj : Xd)->XD((imm & 1) + 2);
+    temp.XD(3) = (imm & 8 ? Xj : Xd)->XD(((imm >> 2) & 1) + 2);
+    *Xd = temp;
+}
+
+void HELPER(xvpermi_w)(CPULoongArchState *env,
+                       uint32_t xd, uint32_t xj, uint32_t imm)
+{
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    temp.XW(0) = Xj->XW(imm & 0x3);
+    temp.XW(1) = Xj->XW((imm >> 2) & 0x3);
+    temp.XW(2) = Xd->XW((imm >> 4) & 0x3);
+    temp.XW(3) = Xd->XW((imm >> 6) & 0x3);
+    temp.XW(4) = Xj->XW((imm & 0x3) + 4);
+    temp.XW(5) = Xj->XW(((imm >> 2) & 0x3) + 4);
+    temp.XW(6) = Xd->XW(((imm >> 4) & 0x3) + 4);
+    temp.XW(7) = Xd->XW(((imm >> 6) & 0x3) + 4);
+    *Xd = temp;
+}
+
+void HELPER(xvpermi_d)(CPULoongArchState *env,
+                       uint32_t xd, uint32_t xj, uint32_t imm)
+{
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    temp.XD(0) = Xj->XD(imm & 0x3);
+    temp.XD(1) = Xj->XD((imm >> 2) & 0x3);
+    temp.XD(2) = Xj->XD((imm >> 4) & 0x3);
+    temp.XD(3) = Xj->XD((imm >> 6) & 0x3);
+    *Xd = temp;
+}
+
+void HELPER(xvpermi_q)(CPULoongArchState *env,
+                       uint32_t xd, uint32_t xj, uint32_t imm)
+{
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    temp.XQ(0) = (imm & 0x3) > 1 ? Xd->XQ((imm & 0x3) - 2) : Xj->XQ(imm & 0x3);
+    temp.XQ(1) = ((imm >> 4) & 0x3) > 1 ? Xd->XQ(((imm >> 4) & 0x3) - 2) :
+                                          Xj->XQ((imm >> 4) & 0x3);
+    *Xd = temp;
+}
+
+#define XVEXTRINS(NAME, BIT, E, MASK)                     \
+void HELPER(NAME)(CPULoongArchState *env,                 \
+                  uint32_t xd, uint32_t xj, uint32_t imm) \
+{                                                         \
+    int ins, extr, m;                                     \
+    XReg *Xd = &(env->fpr[xd].xreg);                      \
+    XReg *Xj = &(env->fpr[xj].xreg);                      \
+                                                          \
+    m = LASX_LEN / (BIT * 2);                             \
+    ins = (imm >> 4) & MASK;                              \
+    extr = imm & MASK;                                    \
+    Xd->E(ins) = Xj->E(extr);                             \
+    Xd->E(ins + m) = Xj->E(extr + m);                     \
+}
+
+XVEXTRINS(xvextrins_b, 8, XB, 0xf)
+XVEXTRINS(xvextrins_h, 16, XH, 0x7)
+XVEXTRINS(xvextrins_w, 32, XW, 0x3)
+XVEXTRINS(xvextrins_d, 64, XD, 0x1)
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index 00c9835948..c40e0d65ca 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -2909,8 +2909,7 @@ void HELPER(NAME)(CPULoongArchState *env,                 \
     VReg *Vj = &(env->fpr[vj].vreg);                      \
                                                           \
     for (i = 0; i < LSX_LEN/BIT; i++) {                   \
-         temp.E(i) = Vj->E(((i) & 0xfc) + (((imm) >>      \
-                           (2 * ((i) & 0x03))) & 0x03));  \
+        temp.E(i) = Vj->E(SHF_POS(i, imm));               \
     }                                                     \
     *Vd = temp;                                           \
 }
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index cfac1c0e1c..09d070a865 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -96,6 +96,8 @@
 #define VSLE(a, b) (a <= b ? -1 : 0)
 #define VSLT(a, b) (a < b ? -1 : 0)
 
+#define SHF_POS(i, imm) (((i) & 0xfc) + (((imm) >> (2 * ((i) & 0x03))) & 0x03))
+
 uint64_t do_vmskltz_b(int64_t val);
 uint64_t do_vmskltz_h(int64_t val);
 uint64_t do_vmskltz_w(int64_t val);
-- 
2.39.1


