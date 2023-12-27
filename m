Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CADFC81ED3F
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 09:23:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIPAb-0006MJ-7p; Wed, 27 Dec 2023 03:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rIPAU-0006KM-1y
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 03:21:34 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rIPAR-0002Jd-4M
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 03:21:33 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxK+l+3otlRfcEAA--.23761S3;
 Wed, 27 Dec 2023 16:21:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxib153otly4QMAA--.16227S10; 
 Wed, 27 Dec 2023 16:21:18 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org,
 maobibo@loongson.cn
Subject: [PATCH v3 08/17] hw/loongarch: Init efi_fdt table
Date: Wed, 27 Dec 2023 16:08:12 +0800
Message-Id: <20231227080821.3216113-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231227080821.3216113-1-gaosong@loongson.cn>
References: <20231227080821.3216113-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxib153otly4QMAA--.16227S10
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
 hw/loongarch/boot.c         | 11 +++++++++++
 include/hw/loongarch/boot.h |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 387602d669..087cb850b2 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -117,6 +117,16 @@ static void init_efi_initrd_table(struct efi_system_table *systab,
     p += ROUND_UP(sizeof(struct efi_initrd), 64);
 }
 
+static void init_efi_fdt_table(struct efi_system_table *systab)
+{
+    efi_guid_t tbl_guid = DEVICE_TREE_GUID;
+
+    /* efi_configuration_table 3 */
+    guidcpy(&systab->tables[2].guid, &tbl_guid);
+    systab->tables[2].table = (void *)0x100000; /* fdt_base 1MiB */
+    systab->nr_tables = 3;
+}
+
 static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
 {
     void *bp_tables_start;
@@ -139,6 +149,7 @@ static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
 
     init_efi_boot_memmap(systab, p, start);
     init_efi_initrd_table(systab, p, start);
+    init_efi_fdt_table(systab);
 
     systab->tables = (struct efi_configuration_table *)(bp_tables_start - start);
 }
diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index ce47056608..bbe8c8dd5d 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -34,6 +34,10 @@ typedef struct {
         EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, \
                  0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
 
+#define DEVICE_TREE_GUID \
+        EFI_GUID(0xb1b621d5, 0xf19c, 0x41a5,  0x83, 0x0b, \
+                 0xd9, 0x15, 0x2c, 0x69, 0xaa, 0xe0)
+
 struct efi_config_table {
     efi_guid_t guid;
     uint64_t *ptr;
-- 
2.25.1


