Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B0374365E
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:02:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92H-00086N-1p; Fri, 30 Jun 2023 03:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92E-00084F-NG
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92A-0007uX-Kh
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:18 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx28ZJi55kWTQEAA--.6777S3;
 Fri, 30 Jun 2023 15:59:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S3; 
 Fri, 30 Jun 2023 15:59:05 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 01/46] target/loongarch: Add LASX data support
Date: Fri, 30 Jun 2023 15:58:19 +0800
Message-Id: <20230630075904.45940-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S3
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 linux-user/loongarch64/signal.c |  1 +
 target/loongarch/cpu.c          |  1 +
 target/loongarch/cpu.h          | 24 +++++++++++---------
 target/loongarch/gdbstub.c      |  1 +
 target/loongarch/internals.h    | 22 ------------------
 target/loongarch/lsx_helper.c   |  1 +
 target/loongarch/machine.c      | 40 ++++++++++++++++++++++++++++++---
 target/loongarch/vec.h          | 33 +++++++++++++++++++++++++++
 8 files changed, 87 insertions(+), 36 deletions(-)
 create mode 100644 target/loongarch/vec.h

diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index bb8efb1172..39572c1190 100644
--- a/linux-user/loongarch64/signal.c
+++ b/linux-user/loongarch64/signal.c
@@ -12,6 +12,7 @@
 #include "linux-user/trace.h"
 
 #include "target/loongarch/internals.h"
+#include "target/loongarch/vec.h"
 
 /* FP context was used */
 #define SC_USED_FP              (1 << 0)
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ad93ecac92..5037cfc02c 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -18,6 +18,7 @@
 #include "cpu-csr.h"
 #include "sysemu/reset.h"
 #include "tcg/tcg.h"
+#include "vec.h"
 
 const char * const regnames[32] = {
     "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ed04027af1..c39c261bc4 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -246,18 +246,20 @@ FIELD(TLB_MISC, ASID, 1, 10)
 FIELD(TLB_MISC, VPPN, 13, 35)
 FIELD(TLB_MISC, PS, 48, 6)
 
-#define LSX_LEN   (128)
+#define LSX_LEN    (128)
+#define LASX_LEN   (256)
+
 typedef union VReg {
-    int8_t   B[LSX_LEN / 8];
-    int16_t  H[LSX_LEN / 16];
-    int32_t  W[LSX_LEN / 32];
-    int64_t  D[LSX_LEN / 64];
-    uint8_t  UB[LSX_LEN / 8];
-    uint16_t UH[LSX_LEN / 16];
-    uint32_t UW[LSX_LEN / 32];
-    uint64_t UD[LSX_LEN / 64];
-    Int128   Q[LSX_LEN / 128];
-}VReg;
+    int8_t   B[LASX_LEN / 8];
+    int16_t  H[LASX_LEN / 16];
+    int32_t  W[LASX_LEN / 32];
+    int64_t  D[LASX_LEN / 64];
+    uint8_t  UB[LASX_LEN / 8];
+    uint16_t UH[LASX_LEN / 16];
+    uint32_t UW[LASX_LEN / 32];
+    uint64_t UD[LASX_LEN / 64];
+    Int128   Q[LASX_LEN / 128];
+} VReg;
 
 typedef union fpr_t fpr_t;
 union fpr_t {
diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index 0752fff924..94c427f4da 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -11,6 +11,7 @@
 #include "internals.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
+#include "vec.h"
 
 uint64_t read_fcc(CPULoongArchState *env)
 {
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 7b0f29c942..c492863cc5 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -21,28 +21,6 @@
 /* Global bit for huge page */
 #define LOONGARCH_HGLOBAL_SHIFT     12
 
-#if  HOST_BIG_ENDIAN
-#define B(x)  B[15 - (x)]
-#define H(x)  H[7 - (x)]
-#define W(x)  W[3 - (x)]
-#define D(x)  D[1 - (x)]
-#define UB(x) UB[15 - (x)]
-#define UH(x) UH[7 - (x)]
-#define UW(x) UW[3 - (x)]
-#define UD(x) UD[1 -(x)]
-#define Q(x)  Q[x]
-#else
-#define B(x)  B[x]
-#define H(x)  H[x]
-#define W(x)  W[x]
-#define D(x)  D[x]
-#define UB(x) UB[x]
-#define UH(x) UH[x]
-#define UW(x) UW[x]
-#define UD(x) UD[x]
-#define Q(x)  Q[x]
-#endif
-
 void loongarch_translate_init(void);
 
 void loongarch_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index 9571f0aef0..b231a2798b 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -12,6 +12,7 @@
 #include "fpu/softfloat.h"
 #include "internals.h"
 #include "tcg/tcg.h"
+#include "vec.h"
 
 #define DO_ADD(a, b)  (a + b)
 #define DO_SUB(a, b)  (a - b)
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index d8ac99c9a4..48fe044529 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "migration/cpu.h"
-#include "internals.h"
+#include "vec.h"
 
 static const VMStateDescription vmstate_fpu_reg = {
     .name = "fpu_reg",
@@ -76,6 +76,39 @@ static const VMStateDescription vmstate_lsx = {
     },
 };
 
+static const VMStateDescription vmstate_lasxh_reg = {
+    .name = "lasxh_reg",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(UD(2), VReg),
+        VMSTATE_UINT64(UD(3), VReg),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+#define VMSTATE_LASXH_REGS(_field, _state, _start)          \
+    VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, 32, 0, \
+                             vmstate_lasxh_reg, fpr_t)
+
+static bool lasx_needed(void *opaque)
+{
+    LoongArchCPU *cpu = opaque;
+
+    return FIELD_EX64(cpu->env.cpucfg[2], CPUCFG2, LASX);
+}
+
+static const VMStateDescription vmstate_lasx = {
+    .name = "cpu/lasx",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = lasx_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_LASXH_REGS(env.fpr, LoongArchCPU, 0),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 /* TLB state */
 const VMStateDescription vmstate_tlb = {
     .name = "cpu/tlb",
@@ -92,8 +125,8 @@ const VMStateDescription vmstate_tlb = {
 /* LoongArch CPU state */
 const VMStateDescription vmstate_loongarch_cpu = {
     .name = "cpu",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
         VMSTATE_UINTTL(env.pc, LoongArchCPU),
@@ -163,6 +196,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
     .subsections = (const VMStateDescription*[]) {
         &vmstate_fpu,
         &vmstate_lsx,
+        &vmstate_lasx,
         NULL
     }
 };
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
new file mode 100644
index 0000000000..655192a6ac
--- /dev/null
+++ b/target/loongarch/vec.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU LoongArch vector utilitites
+ *
+ * Copyright (c) 2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef LOONGARCH_VEC_H
+#define LOONGARCH_VEC_H
+
+#if HOST_BIG_ENDIAN
+#define B(x)  B[(x) ^ 15]
+#define H(x)  H[(x) ^ 7]
+#define W(x)  W[(x) ^ 3]
+#define D(x)  D[(x) ^ 2]
+#define UB(x) UB[(x) ^ 15]
+#define UH(x) UH[(x) ^ 7]
+#define UW(x) UW[(x) ^ 3]
+#define UD(x) UD[(x) ^ 2]
+#define Q(x)  Q[(x) ^ 1]
+#else
+#define B(x)  B[x]
+#define H(x)  H[x]
+#define W(x)  W[x]
+#define D(x)  D[x]
+#define UB(x) UB[x]
+#define UH(x) UH[x]
+#define UW(x) UW[x]
+#define UD(x) UD[x]
+#define Q(x)  Q[x]
+#endif /* HOST_BIG_ENDIAN */
+
+#endif /* LOONGARCH_VEC_H */
-- 
2.39.1


