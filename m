Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1BD75356A
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:48:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKERy-0002gK-Fg; Fri, 14 Jul 2023 04:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKERr-00024Z-FO
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKERo-0004pa-5l
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:47 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxxPBnC7Fkgs4EAA--.13505S3;
 Fri, 14 Jul 2023 16:46:31 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S25; 
 Fri, 14 Jul 2023 16:46:30 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 23/47] target/loongarch: Implement xvmskltz/xvmskgez/xvmsknz
Date: Fri, 14 Jul 2023 16:45:51 +0800
Message-Id: <20230714084615.2448038-24-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S25
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
 target/loongarch/disas.c                     |  7 ++
 target/loongarch/insn_trans/trans_lasx.c.inc |  7 ++
 target/loongarch/insns.decode                |  7 ++
 target/loongarch/vec_helper.c                | 80 ++++++++++++++------
 4 files changed, 76 insertions(+), 25 deletions(-)

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
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 7aab6528a7..0a68d9ae61 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -340,6 +340,13 @@ TRANS(xvsigncov_h, gvec_vvv, 32, MO_16, do_vsigncov)
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
index 126b67eea5..9d13b6544c 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -783,14 +783,19 @@ static uint64_t do_vmskltz_b(int64_t val)
 
 void HELPER(vmskltz_b)(void *vd, void *vj, uint32_t desc)
 {
+    int i;
     uint16_t temp = 0;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
 
-    temp = do_vmskltz_b(Vj->D(0));
-    temp |= (do_vmskltz_b(Vj->D(1)) << 8);
-    Vd->D(0) = temp;
-    Vd->D(1) = 0;
+    for (i = 0; i < oprsz / 16; i++) {
+        temp = 0;
+        temp = do_vmskltz_b(Vj->D(2 * i));
+        temp |= (do_vmskltz_b(Vj->D(2 * i  + 1)) << 8);
+        Vd->D(2 * i) = temp;
+        Vd->D(2 * i + 1) = 0;
+    }
 }
 
 static uint64_t do_vmskltz_h(int64_t val)
@@ -804,14 +809,19 @@ static uint64_t do_vmskltz_h(int64_t val)
 
 void HELPER(vmskltz_h)(void *vd, void *vj, uint32_t desc)
 {
+    int i;
     uint16_t temp = 0;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
 
-    temp = do_vmskltz_h(Vj->D(0));
-    temp |= (do_vmskltz_h(Vj->D(1)) << 4);
-    Vd->D(0) = temp;
-    Vd->D(1) = 0;
+    for (i = 0; i < oprsz / 16; i++) {
+        temp = 0;
+        temp = do_vmskltz_h(Vj->D(2 * i));
+        temp |= (do_vmskltz_h(Vj->D(2 * i + 1)) << 4);
+        Vd->D(2 * i) = temp;
+        Vd->D(2 * i + 1) = 0;
+    }
 }
 
 static uint64_t do_vmskltz_w(int64_t val)
@@ -824,14 +834,19 @@ static uint64_t do_vmskltz_w(int64_t val)
 
 void HELPER(vmskltz_w)(void *vd, void *vj, uint32_t desc)
 {
+    int i;
     uint16_t temp = 0;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
 
-    temp = do_vmskltz_w(Vj->D(0));
-    temp |= (do_vmskltz_w(Vj->D(1)) << 2);
-    Vd->D(0) = temp;
-    Vd->D(1) = 0;
+    for (i = 0; i < oprsz / 16; i++) {
+        temp = 0;
+        temp = do_vmskltz_w(Vj->D(2 * i));
+        temp |= (do_vmskltz_w(Vj->D(2 * i + 1)) << 2);
+        Vd->D(2 * i) = temp;
+        Vd->D(2 * i + 1) = 0;
+    }
 }
 
 static uint64_t do_vmskltz_d(int64_t val)
@@ -840,26 +855,36 @@ static uint64_t do_vmskltz_d(int64_t val)
 }
 void HELPER(vmskltz_d)(void *vd, void *vj, uint32_t desc)
 {
+    int i;
     uint16_t temp = 0;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
 
-    temp = do_vmskltz_d(Vj->D(0));
-    temp |= (do_vmskltz_d(Vj->D(1)) << 1);
-    Vd->D(0) = temp;
-    Vd->D(1) = 0;
+    for (i = 0; i < oprsz / 16; i++) {
+        temp = 0;
+        temp = do_vmskltz_d(Vj->D(2 * i));
+        temp |= (do_vmskltz_d(Vj->D(2 * i + 1)) << 1);
+        Vd->D(2 * i) = temp;
+        Vd->D(2 * i + 1) = 0;
+    }
 }
 
 void HELPER(vmskgez_b)(void *vd, void *vj, uint32_t desc)
 {
+    int i;
     uint16_t temp = 0;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
 
-    temp =  do_vmskltz_b(Vj->D(0));
-    temp |= (do_vmskltz_b(Vj->D(1)) << 8);
-    Vd->D(0) = (uint16_t)(~temp);
-    Vd->D(1) = 0;
+    for (i = 0; i < oprsz / 16; i++) {
+        temp = 0;
+        temp =  do_vmskltz_b(Vj->D(2 * i));
+        temp |= (do_vmskltz_b(Vj->D(2 * i + 1)) << 8);
+        Vd->D(2 * i) = (uint16_t)(~temp);
+        Vd->D(2 * i + 1) = 0;
+    }
 }
 
 static uint64_t do_vmskez_b(uint64_t a)
@@ -872,16 +897,21 @@ static uint64_t do_vmskez_b(uint64_t a)
     return c >> 56;
 }
 
-void HELPER(vmsknz_b)(void vd, void vj, uint32_t desc)
+void HELPER(vmsknz_b)(void *vd, void *vj, uint32_t desc)
 {
+    int i;
     uint16_t temp = 0;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
 
-    temp = do_vmskez_b(Vj->D(0));
-    temp |= (do_vmskez_b(Vj->D(1)) << 8);
-    Vd->D(0) = (uint16_t)(~temp);
-    Vd->D(1) = 0;
+    for (i = 0; i < oprsz / 16; i++) {
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


