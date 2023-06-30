Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD64174364E
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:00:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92f-0008Ce-1M; Fri, 30 Jun 2023 03:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92X-0008Bn-Gy
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92T-00080E-Us
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:36 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxV8VZi55khzQEAA--.6971S3;
 Fri, 30 Jun 2023 15:59:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S24; 
 Fri, 30 Jun 2023 15:59:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 22/46] target/loongarch: Implement xvmskltz/xvmskgez/xvmsknz
Date: Fri, 30 Jun 2023 15:58:40 +0800
Message-Id: <20230630075904.45940-23-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S24
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
- XVMSKLTZ.{B/H/W/D};
- XVMSKGEZ.B;
- XVMSKNZ.B.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |   7 ++
 target/loongarch/helper.h                    |  12 +-
 target/loongarch/insn_trans/trans_lasx.c.inc |   7 ++
 target/loongarch/insns.decode                |   7 ++
 target/loongarch/vec_helper.c                | 115 +++++++++++++------
 5 files changed, 106 insertions(+), 42 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 85e0cb7c8d..1a11153343 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2010,6 +2010,13 @@ INSN_LASX(vext2xv_wu_hu,     vv)
 INSN_LASX(vext2xv_du_hu,     vv)
 INSN_LASX(vext2xv_du_wu,     vv)
 
+INSN_LASX(xvmskltz_b,        vv)
+INSN_LASX(xvmskltz_h,        vv)
+INSN_LASX(xvmskltz_w,        vv)
+INSN_LASX(xvmskltz_d,        vv)
+INSN_LASX(xvmskgez_b,        vv)
+INSN_LASX(xvmsknz_b,         vv)
+
 INSN_LASX(xvsigncov_b,       vvv)
 INSN_LASX(xvsigncov_h,       vvv)
 INSN_LASX(xvsigncov_w,       vvv)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 81d0f06cc0..33bf60e82d 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -357,12 +357,12 @@ DEF_HELPER_FLAGS_4(vsigncov_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsigncov_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsigncov_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
-DEF_HELPER_3(vmskltz_b, void, env, i32, i32)
-DEF_HELPER_3(vmskltz_h, void, env, i32, i32)
-DEF_HELPER_3(vmskltz_w, void, env, i32, i32)
-DEF_HELPER_3(vmskltz_d, void, env, i32, i32)
-DEF_HELPER_3(vmskgez_b, void, env, i32, i32)
-DEF_HELPER_3(vmsknz_b, void, env, i32,i32)
+DEF_HELPER_4(vmskltz_b, void, env, i32, i32, i32)
+DEF_HELPER_4(vmskltz_h, void, env, i32, i32, i32)
+DEF_HELPER_4(vmskltz_w, void, env, i32, i32, i32)
+DEF_HELPER_4(vmskltz_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vmskgez_b, void, env, i32, i32, i32)
+DEF_HELPER_4(vmsknz_b, void, env, i32, i32,i32)
 
 DEF_HELPER_FLAGS_4(vnori_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 6bb6b215cf..5ac866fa87 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -397,6 +397,13 @@ TRANS(xvsigncov_h, gvec_vvv, 32, MO_16, do_vsigncov)
 TRANS(xvsigncov_w, gvec_vvv, 32, MO_32, do_vsigncov)
 TRANS(xvsigncov_d, gvec_vvv, 32, MO_64, do_vsigncov)
 
+TRANS(xvmskltz_b, gen_vv, 32, gen_helper_vmskltz_b)
+TRANS(xvmskltz_h, gen_vv, 32, gen_helper_vmskltz_h)
+TRANS(xvmskltz_w, gen_vv, 32, gen_helper_vmskltz_w)
+TRANS(xvmskltz_d, gen_vv, 32, gen_helper_vmskltz_d)
+TRANS(xvmskgez_b, gen_vv, 32, gen_helper_vmskgez_b)
+TRANS(xvmsknz_b, gen_vv, 32, gen_helper_vmsknz_b)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 7bbda1a142..6a161d6d20 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1598,6 +1598,13 @@ xvsigncov_h      0111 01010010 11101 ..... ..... .....    @vvv
 xvsigncov_w      0111 01010010 11110 ..... ..... .....    @vvv
 xvsigncov_d      0111 01010010 11111 ..... ..... .....    @vvv
 
+xvmskltz_b       0111 01101001 11000 10000 ..... .....    @vv
+xvmskltz_h       0111 01101001 11000 10001 ..... .....    @vv
+xvmskltz_w       0111 01101001 11000 10010 ..... .....    @vv
+xvmskltz_d       0111 01101001 11000 10011 ..... .....    @vv
+xvmskgez_b       0111 01101001 11000 10100 ..... .....    @vv
+xvmsknz_b        0111 01101001 11000 11000 ..... .....    @vv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 49d114f5ac..91f089292d 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -780,16 +780,23 @@ static uint64_t do_vmskltz_b(int64_t val)
     return c >> 56;
 }
 
-void HELPER(vmskltz_b)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmskltz_b)(CPULoongArchState *env,
+                       uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
-    uint16_t temp = 0;
+    int i, max;
+    uint16_t temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
-    temp = do_vmskltz_b(Vj->D(0));
-    temp |= (do_vmskltz_b(Vj->D(1)) << 8);
-    Vd->D(0) = temp;
-    Vd->D(1) = 0;
+    max = (oprsz == 16) ? 1 : 2;
+
+    for (i = 0; i < max; i++) {
+        temp = 0;
+        temp = do_vmskltz_b(Vj->D(2 * i));
+        temp |= (do_vmskltz_b(Vj->D(2 * i  + 1)) << 8);
+        Vd->D(2 * i) = temp;
+        Vd->D(2 * i + 1) = 0;
+    }
 }
 
 static uint64_t do_vmskltz_h(int64_t val)
@@ -801,16 +808,23 @@ static uint64_t do_vmskltz_h(int64_t val)
     return c >> 60;
 }
 
-void HELPER(vmskltz_h)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmskltz_h)(CPULoongArchState *env,
+                       uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
-    uint16_t temp = 0;
+    int i, max;
+    uint16_t temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
-    temp = do_vmskltz_h(Vj->D(0));
-    temp |= (do_vmskltz_h(Vj->D(1)) << 4);
-    Vd->D(0) = temp;
-    Vd->D(1) = 0;
+    max = (oprsz == 16) ? 1 : 2;
+
+    for (i = 0; i < max; i++) {
+        temp = 0;
+        temp = do_vmskltz_h(Vj->D(2 * i));
+        temp |= (do_vmskltz_h(Vj->D(2 * i + 1)) << 4);
+        Vd->D(2 * i) = temp;
+        Vd->D(2 * i + 1) = 0;
+    }
 }
 
 static uint64_t do_vmskltz_w(int64_t val)
@@ -821,44 +835,66 @@ static uint64_t do_vmskltz_w(int64_t val)
     return c >> 62;
 }
 
-void HELPER(vmskltz_w)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmskltz_w)(CPULoongArchState *env,
+                       uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
-    uint16_t temp = 0;
+    int i, max;
+    uint16_t temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
-    temp = do_vmskltz_w(Vj->D(0));
-    temp |= (do_vmskltz_w(Vj->D(1)) << 2);
-    Vd->D(0) = temp;
-    Vd->D(1) = 0;
+    max = (oprsz == 16) ? 1 : 2;
+
+    for (i = 0; i < max; i++) {
+        temp = 0;
+        temp = do_vmskltz_w(Vj->D(2 * i));
+        temp |= (do_vmskltz_w(Vj->D(2 * i + 1)) << 2);
+        Vd->D(2 * i) = temp;
+        Vd->D(2 * i + 1) = 0;
+    }
 }
 
 static uint64_t do_vmskltz_d(int64_t val)
 {
     return (uint64_t)val >> 63;
 }
-void HELPER(vmskltz_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+
+void HELPER(vmskltz_d)(CPULoongArchState *env,
+                       uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
-    uint16_t temp = 0;
+    int i, max;
+    uint16_t temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
-    temp = do_vmskltz_d(Vj->D(0));
-    temp |= (do_vmskltz_d(Vj->D(1)) << 1);
-    Vd->D(0) = temp;
-    Vd->D(1) = 0;
+    max = (oprsz == 16) ? 1 : 2;
+
+    for (i = 0; i < max; i++) {
+        temp = 0;
+        temp = do_vmskltz_d(Vj->D(2 * i));
+        temp |= (do_vmskltz_d(Vj->D(2 * i + 1)) << 1);
+        Vd->D(2 * i) = temp;
+        Vd->D(2 * i + 1) = 0;
+    }
 }
 
-void HELPER(vmskgez_b)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmskgez_b)(CPULoongArchState *env,
+                       uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
-    uint16_t temp = 0;
+    int i, max;
+    uint16_t temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
-    temp =  do_vmskltz_b(Vj->D(0));
-    temp |= (do_vmskltz_b(Vj->D(1)) << 8);
-    Vd->D(0) = (uint16_t)(~temp);
-    Vd->D(1) = 0;
+    max = (oprsz == 16) ? 1 : 2;
+
+    for (i = 0; i < max; i++) {
+        temp = 0;
+        temp =  do_vmskltz_b(Vj->D(2 * i));
+        temp |= (do_vmskltz_b(Vj->D(2 * i + 1)) << 8);
+        Vd->D(2 * i) = (uint16_t)(~temp);
+        Vd->D(2 * i + 1) = 0;
+    }
 }
 
 static uint64_t do_vmskez_b(uint64_t a)
@@ -871,16 +907,23 @@ static uint64_t do_vmskez_b(uint64_t a)
     return c >> 56;
 }
 
-void HELPER(vmsknz_b)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmsknz_b)(CPULoongArchState *env,
+                      uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
-    uint16_t temp = 0;
+    int i, max;
+    uint16_t temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
-    temp = do_vmskez_b(Vj->D(0));
-    temp |= (do_vmskez_b(Vj->D(1)) << 8);
-    Vd->D(0) = (uint16_t)(~temp);
-    Vd->D(1) = 0;
+    max = (oprsz == 16) ? 1 : 2;
+
+    for (i = 0; i < max; i++) {
+        temp = 0;
+        temp = do_vmskez_b(Vj->D(2 * i));
+        temp |= (do_vmskez_b(Vj->D(2 * i + 1)) << 8);
+        Vd->D(2 * i) = (uint16_t)(~temp);
+        Vd->D(2 * i + 1) = 0;
+    }
 }
 
 void HELPER(vnori_b)(void *vd, void *vj, uint64_t imm, uint32_t v)
-- 
2.39.1


