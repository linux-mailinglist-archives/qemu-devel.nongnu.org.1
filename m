Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1612EA48EF1
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Feb 2025 04:03:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnqer-0008S4-O2; Thu, 27 Feb 2025 22:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tnqeY-0008CC-6i
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 22:03:07 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tnqeP-0005zB-Oe
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 22:03:05 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxaWpcJ8FnpIiFAA--.32736S3;
 Fri, 28 Feb 2025 11:02:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxbsVaJ8FnFCgtAA--.37567S2;
 Fri, 28 Feb 2025 11:02:51 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] hw/loongarch/virt: Replace RSDT with XSDT table
Date: Fri, 28 Feb 2025 11:02:50 +0800
Message-Id: <20250228030250.510635-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxbsVaJ8FnFCgtAA--.37567S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

XSDT table is introduced in ACPI Specification 5.0, it supports 64-bit
address in the table. There is LoongArch system support from ACPI
Specification 6.4 and later, XSDT is supported by LoongArch system.

Here replace RSDT with XSDT table.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt-acpi-build.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 9ca88d63ae..43ed8e2825 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -485,7 +485,7 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
     GArray *table_offsets;
     AcpiFadtData fadt_data;
-    unsigned facs, rsdt, dsdt;
+    unsigned facs, xsdt, dsdt;
     uint8_t *u;
     GArray *tables_blob = tables->table_data;
 
@@ -571,17 +571,17 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     }
 
     /* RSDT is pointed to by RSDP */
-    rsdt = tables_blob->len;
-    build_rsdt(tables_blob, tables->linker, table_offsets,
+    xsdt = tables_blob->len;
+    build_xsdt(tables_blob, tables->linker, table_offsets,
                lvms->oem_id, lvms->oem_table_id);
 
     /* RSDP is in FSEG memory, so allocate it separately */
     {
         AcpiRsdpData rsdp_data = {
-            .revision = 0,
+            .revision = 2,
             .oem_id = lvms->oem_id,
-            .xsdt_tbl_offset = NULL,
-            .rsdt_tbl_offset = &rsdt,
+            .xsdt_tbl_offset = &xsdt,
+            .rsdt_tbl_offset = NULL,
         };
         build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
     }

base-commit: b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124
-- 
2.39.3


