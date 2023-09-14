Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF7D79F80F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:30:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgc4r-0003H7-2H; Wed, 13 Sep 2023 22:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgc4l-0003FD-Jj
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgc4j-0004vq-8Q
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:27 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxjuuAbwJllfgmAA--.7255S3;
 Thu, 14 Sep 2023 10:27:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdxmbwJlJ+UDAA--.7298S34; 
 Thu, 14 Sep 2023 10:27:12 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 32/57] target/loongarch: Implement xvmskltz/xvmskgez/xvmsknz
Date: Thu, 14 Sep 2023 10:26:20 +0800
Message-Id: <20230914022645.1151356-33-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914022645.1151356-1-gaosong@loongson.cn>
References: <20230914022645.1151356-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdxmbwJlJ+UDAA--.7298S34
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
- XVMSKLTZ.{B/H/W/D};
- XVMSKGEZ.B;
- XVMSKNZ.B.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/insns.decode               |  7 ++
 target/loongarch/disas.c                    |  7 ++
 target/loongarch/vec_helper.c               | 78 ++++++++++++++-------
 target/loongarch/insn_trans/trans_vec.c.inc |  6 ++
 4 files changed, 74 insertions(+), 24 deletions(-)

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
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 1f01ec99d5..05710098ad 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2015,6 +2015,13 @@ INSN_LASX(xvsigncov_h,       vvv)
 INSN_LASX(xvsigncov_w,       vvv)
 INSN_LASX(xvsigncov_d,       vvv)
 
+INSN_LASX(xvmskltz_b,        vv)
+INSN_LASX(xvmskltz_h,        vv)
+INSN_LASX(xvmskltz_w,        vv)
+INSN_LASX(xvmskltz_d,        vv)
+INSN_LASX(xvmskgez_b,        vv)
+INSN_LASX(xvmsknz_b,         vv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 3dc20243fd..f749800880 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -810,14 +810,19 @@ static uint64_t do_vmskltz_b(int64_t val)
 
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
@@ -831,14 +836,19 @@ static uint64_t do_vmskltz_h(int64_t val)
 
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
@@ -851,14 +861,19 @@ static uint64_t do_vmskltz_w(int64_t val)
 
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
@@ -867,26 +882,36 @@ static uint64_t do_vmskltz_d(int64_t val)
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
@@ -901,14 +926,19 @@ static uint64_t do_vmskez_b(uint64_t a)
 
 void HELPER(vmsknz_b)(void *vd, void *vj, uint32_t desc)
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
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 492bbcd4e9..843ec6d4af 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -3423,6 +3423,12 @@ TRANS(vmskltz_w, LSX, gen_vv, gen_helper_vmskltz_w)
 TRANS(vmskltz_d, LSX, gen_vv, gen_helper_vmskltz_d)
 TRANS(vmskgez_b, LSX, gen_vv, gen_helper_vmskgez_b)
 TRANS(vmsknz_b, LSX, gen_vv, gen_helper_vmsknz_b)
+TRANS(xvmskltz_b, LASX, gen_xx, gen_helper_vmskltz_b)
+TRANS(xvmskltz_h, LASX, gen_xx, gen_helper_vmskltz_h)
+TRANS(xvmskltz_w, LASX, gen_xx, gen_helper_vmskltz_w)
+TRANS(xvmskltz_d, LASX, gen_xx, gen_helper_vmskltz_d)
+TRANS(xvmskgez_b, LASX, gen_xx, gen_helper_vmskgez_b)
+TRANS(xvmsknz_b, LASX, gen_xx, gen_helper_vmsknz_b)
 
 #define EXPAND_BYTE(bit)  ((uint64_t)(bit ? 0xff : 0))
 
-- 
2.39.1


