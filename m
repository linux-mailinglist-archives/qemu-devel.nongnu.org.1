Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 157C9ADFB92
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Jun 2025 05:04:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS5YR-000743-FA; Wed, 18 Jun 2025 23:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uS5YM-000734-5g
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 23:03:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uS5YJ-0006AQ-Ke
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 23:03:01 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxQK3dfVNouY4ZAQ--.41523S3;
 Thu, 19 Jun 2025 11:02:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxrhu7fVNoIXkgAQ--.48014S6;
 Thu, 19 Jun 2025 11:02:52 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v2 4/9] target/loongarch: add msg interrupt CSR registers
Date: Thu, 19 Jun 2025 10:39:39 +0800
Message-Id: <20250619023944.1278716-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250619023944.1278716-1-gaosong@loongson.cn>
References: <20250619023944.1278716-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxrhu7fVNoIXkgAQ--.48014S6
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 target/loongarch/cpu.c     |  7 +++++++
 target/loongarch/cpu.h     | 10 ++++++++++
 target/loongarch/machine.c |  5 +++++
 3 files changed, 22 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index abad84c054..bde9f917fc 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -523,6 +523,13 @@ static void loongarch_la464_initfn(Object *obj)
     env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
     env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
 
+    env->CSR_MSGIS[0] = 0;
+    env->CSR_MSGIS[1] = 0;
+    env->CSR_MSGIS[2] = 0;
+    env->CSR_MSGIS[3] = 0;
+    env->CSR_MSGIR = 0;
+    env->CSR_MSGIE = 0;
+
     loongarch_la464_init_csr(obj);
     loongarch_cpu_post_init(obj);
 }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 1169768632..231ad5a7cb 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -233,6 +233,12 @@ FIELD(TLB_MISC, ASID, 1, 10)
 FIELD(TLB_MISC, VPPN, 13, 35)
 FIELD(TLB_MISC, PS, 48, 6)
 
+/*Msg interrupt registers */
+FIELD(CSR_MSGIS, IS, 0, 63)
+FIELD(CSR_MSGIR, INTNUM, 0, 8)
+FIELD(CSR_MSGIR, ACTIVE, 31, 1)
+FIELD(CSR_MSGIE, PT, 0, 8)
+
 #define LSX_LEN    (128)
 #define LASX_LEN   (256)
 
@@ -350,6 +356,10 @@ typedef struct CPUArchState {
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
+    /* Msg interrupt registers */
+    uint64_t CSR_MSGIS[4];
+    uint64_t CSR_MSGIR;
+    uint64_t CSR_MSGIE;
     struct {
         uint64_t guest_addr;
     } stealtime;
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 4e70f5c879..7d5ee34f90 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -231,6 +231,11 @@ const VMStateDescription vmstate_loongarch_cpu = {
         VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
         VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
 
+        /* Msg interrupt CSRs */
+        VMSTATE_UINT64_ARRAY(env.CSR_MSGIS, LoongArchCPU, 4),
+        VMSTATE_UINT64(env.CSR_MSGIR, LoongArchCPU),
+        VMSTATE_UINT64(env.CSR_MSGIE, LoongArchCPU),
+
         VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
         /* PV steal time */
         VMSTATE_UINT64(env.stealtime.guest_addr, LoongArchCPU),
-- 
2.34.1


