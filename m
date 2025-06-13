Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE7FAD809F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Jun 2025 03:55:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPtcr-0006Eb-UQ; Thu, 12 Jun 2025 21:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1uPtcp-0006EA-Ca
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 21:54:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1uPtcn-0007DJ-H0
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 21:54:35 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxjazXhEto4GoVAQ--.17864S3;
 Fri, 13 Jun 2025 09:54:31 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxb8evhEtoiJIYAQ--.6626S4;
 Fri, 13 Jun 2025 09:54:30 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH V1 2/2] hw/loongarch: add rtc acpi table
Date: Fri, 13 Jun 2025 09:31:16 +0800
Message-Id: <49c55c9e6c49a89ec4438725ebf178e458572229.1749777563.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1749777563.git.lixianglai@loongson.cn>
References: <cover.1749777563.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8evhEtoiJIYAQ--.6626S4
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
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

Add the acpi table to the loongson rtc hardware
so that the virtual machine kernel can use the
loongson RTC-related drivers.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Xianglai Li <lixianglai@loongson.cn>

 hw/loongarch/virt-acpi-build.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 2cd2d9d842..2cfc5421c5 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -473,6 +473,29 @@ static void acpi_dsdt_add_tpm(Aml *scope, LoongArchVirtMachineState *vms)
 }
 #endif
 
+static void acpi_dsdt_add_rtc(Aml *scope)
+{
+    uint32_t rtc_irq = VIRT_RTC_IRQ;
+    Aml *dev = aml_device("RTC");
+
+    aml_append(dev, aml_name_decl("_HID", aml_string("LOON0001")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+
+    Aml *crs = aml_resource_template();
+    aml_append(crs,
+        aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                         AML_NON_CACHEABLE, AML_READ_WRITE,
+                         0, VIRT_RTC_REG_BASE,
+                         VIRT_RTC_REG_BASE + VIRT_RTC_LEN - 1,
+                         0, VIRT_RTC_LEN));
+    aml_append(crs,
+               aml_interrupt(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
+                             AML_EXCLUSIVE, &rtc_irq, 1));
+
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+}
+
 /* build DSDT */
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
@@ -488,6 +511,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     for (i = 0; i < VIRT_UART_COUNT; i++) {
         build_uart_device_aml(dsdt, i);
     }
+    acpi_dsdt_add_rtc(dsdt);
     build_pci_device_aml(dsdt, lvms);
     build_la_ged_aml(dsdt, machine);
     build_flash_aml(dsdt, lvms);
-- 
2.39.1


