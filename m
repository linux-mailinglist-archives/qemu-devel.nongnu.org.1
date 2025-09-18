Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B9EB512BC
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 11:39:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwHFH-0003kg-O0; Wed, 10 Sep 2025 05:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uwHEr-0003ei-RG
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 05:35:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uwHEc-0007e4-Pa
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 05:35:40 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx6tFaRsFodMEIAA--.18812S3;
 Wed, 10 Sep 2025 17:35:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxE+RWRsFoj8+LAA--.52579S7;
 Wed, 10 Sep 2025 17:35:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v7 05/11] target/loongarch: add msg interrupt CSR registers
Date: Wed, 10 Sep 2025 17:11:44 +0800
Message-Id: <20250910091150.2424979-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250910091150.2424979-1-gaosong@loongson.cn>
References: <20250910091150.2424979-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxE+RWRsFoj8+LAA--.52579S7
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

include CSR_MSGIS0-3, CSR_MSGIR and CSR_MSGIE.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu-csr.h |  3 +++
 target/loongarch/cpu.h     | 11 +++++++++++
 target/loongarch/machine.c | 25 +++++++++++++++++++++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 0834e91f30..4792677086 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -186,6 +186,9 @@ FIELD(CSR_MERRCTL, ISMERR, 0, 1)
 
 #define LOONGARCH_CSR_CTAG           0x98 /* TagLo + TagHi */
 
+#define LOONGARCH_CSR_MSGIS(N)       (0xa0 + N)
+#define LOONGARCH_CSR_MSGIR               0xa4
+
 /* Direct map windows CSRs*/
 #define LOONGARCH_CSR_DMW(N)         (0x180 + N)
 FIELD(CSR_DMW, PLV0, 0, 1)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 1e8a9dbef8..807a710810 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -233,6 +233,13 @@ FIELD(TLB_MISC, ASID, 1, 10)
 FIELD(TLB_MISC, VPPN, 13, 35)
 FIELD(TLB_MISC, PS, 48, 6)
 
+/*Msg interrupt registers */
+#define N_MSGIS                4
+FIELD(CSR_MSGIS, IS, 0, 63)
+FIELD(CSR_MSGIR, INTNUM, 0, 8)
+FIELD(CSR_MSGIR, ACTIVE, 31, 1)
+FIELD(CSR_MSGIE, PT, 0, 8)
+
 #define LSX_LEN    (128)
 #define LASX_LEN   (256)
 
@@ -350,6 +357,10 @@ typedef struct CPUArchState {
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
+    /* Msg interrupt registers */
+    uint64_t CSR_MSGIS[N_MSGIS];
+    uint64_t CSR_MSGIR;
+    uint64_t CSR_MSGIE;
     struct {
         uint64_t guest_addr;
     } stealtime;
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 4e70f5c879..0cc787462c 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -45,6 +45,26 @@ static const VMStateDescription vmstate_fpu = {
     },
 };
 
+static bool avec_needed(void *opaque)
+{
+    LoongArchCPU *cpu = opaque;
+
+    return FIELD_EX64(cpu->env.cpucfg[1], CPUCFG1, MSG_INT);
+}
+
+static const VMStateDescription vmstate_avec = {
+    .name = "cpu/msg",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = avec_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.CSR_MSGIS, LoongArchCPU, N_MSGIS),
+        VMSTATE_UINT64(env.CSR_MSGIR, LoongArchCPU),
+        VMSTATE_UINT64(env.CSR_MSGIE, LoongArchCPU),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_lsxh_reg = {
     .name = "lsxh_reg",
     .version_id = 1,
@@ -168,8 +188,8 @@ static const VMStateDescription vmstate_tlb = {
 /* LoongArch CPU state */
 const VMStateDescription vmstate_loongarch_cpu = {
     .name = "cpu",
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
         VMSTATE_UINTTL(env.pc, LoongArchCPU),
@@ -245,6 +265,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
         &vmstate_tlb,
 #endif
         &vmstate_lbt,
+        &vmstate_avec,
         NULL
     }
 };
-- 
2.41.0


