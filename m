Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A96B0E877
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Jul 2025 04:06:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueOqh-0007pU-Ns; Tue, 22 Jul 2025 22:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1ueOq4-000795-Gj
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 22:04:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1ueOpx-0004Y3-Sz
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 22:04:12 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxqmoHQ4BofwAwAQ--.56709S3;
 Wed, 23 Jul 2025 10:03:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJBxZOQGQ4Bo9JIiAA--.48128S2;
 Wed, 23 Jul 2025 10:03:50 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn,
	lixianglai@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.co
Subject: [PATCH 1/1] hw/intc/loongarch_ipi: use physical CPU ID for
 kvm_ipi_access_regs
Date: Wed, 23 Jul 2025 09:40:54 +0800
Message-Id: <20250723014054.742353-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxZOQGQ4Bo9JIiAA--.48128S2
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

QEMU reboot after inserting no-configuous cpus may start failed
becaue the vcpu context may not have created on KVM, On QEMU side use physical CPU ID
for kvm_ipi_access_regs and do some check. On KVM use kvm_get_vcpu_by_cpuid get vcpu.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_ipi_kvm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/loongarch_ipi_kvm.c b/hw/intc/loongarch_ipi_kvm.c
index 4cb3acc921..1c26fdcb10 100644
--- a/hw/intc/loongarch_ipi_kvm.c
+++ b/hw/intc/loongarch_ipi_kvm.c
@@ -31,6 +31,11 @@ static void kvm_ipi_access_regs(void *opaque, bool write)
 
     for (cpu = 0; cpu < ipi->num_cpu; cpu++) {
         core = &ipi->cpu[cpu];
+        if (core == NULL || core->cpu == NULL ) {
+            continue;
+        }
+        cpu = core->cpu->cpu_index;
+
         attr = (cpu << 16) | CORE_STATUS_OFF;
         kvm_ipi_access_reg(fd, attr, &core->status, write);
 
-- 
2.43.0


