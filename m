Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF0EAD1C4F
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Jun 2025 13:13:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOaPT-0005FV-Dp; Mon, 09 Jun 2025 07:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uOaPN-0005Du-PP
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:11:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uOaPH-00075d-CL
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:11:16 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxmnFJwUZoXW4RAQ--.43940S3;
 Mon, 09 Jun 2025 19:11:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAxzxtFwUZoiU0SAQ--.4222S11;
 Mon, 09 Jun 2025 19:11:05 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH 09/10] target/loongarch: loongarch CPU supoort avec irqs
Date: Mon,  9 Jun 2025 18:48:32 +0800
Message-Id: <20250609104833.839811-10-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250609104833.839811-1-gaosong@loongson.cn>
References: <20250609104833.839811-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzxtFwUZoiU0SAQ--.4222S11
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu-csr.h |  1 +
 target/loongarch/cpu.c     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 0834e91f30..83f6cb081a 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -39,6 +39,7 @@ FIELD(CSR_ECFG, VS, 16, 3)
 
 #define LOONGARCH_CSR_ESTAT          0x5 /* Exception status */
 FIELD(CSR_ESTAT, IS, 0, 13)
+FIELD(CSR_ESTAT, MSGINT, 14, 1)
 FIELD(CSR_ESTAT, ECODE, 16, 6)
 FIELD(CSR_ESTAT, ESUBCODE, 22, 9)
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index bde9f917fc..207d11266f 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -127,6 +127,23 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
         return;
     }
 
+    /* do INTC_AVEC irqs */
+    if (irq == INT_AVEC) {
+        for (int i = 256; i >= 0; i--) {
+            if (test_bit(i, &(env->CSR_MSGIS[i / 64]))) {
+                env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, INTNUM, i);
+                env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, ACTIVE, 0);
+                env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 1);
+                cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+                clear_bit(i, &(env->CSR_MSGIS[i / 64]));
+            }
+        }
+    } else {
+       env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 0);
+       env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, ACTIVE, 1);
+       return;
+    }
+
     if (kvm_enabled()) {
         kvm_loongarch_set_interrupt(cpu, irq, level);
     } else if (tcg_enabled()) {
-- 
2.34.1


