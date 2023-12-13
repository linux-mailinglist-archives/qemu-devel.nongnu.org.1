Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E95809F0F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 10:16:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBWvx-00016u-HQ; Fri, 08 Dec 2023 04:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rBWvf-00010j-7h
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:13:51 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rBWvc-0008Fc-Ay
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:13:50 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx5_FI3nJlsuw_AA--.62138S3;
 Fri, 08 Dec 2023 17:13:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxH91A3nJlrE5YAA--.822S9; 
 Fri, 08 Dec 2023 17:13:43 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, peter.maydell@linaro.org,
 maobibo@loongson.cn
Subject: [PATCH v1 07/17] hw/loongarch: Init efi_initrd table
Date: Fri,  8 Dec 2023 17:00:32 +0800
Message-Id: <20231208090042.2672425-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231208090042.2672425-1-gaosong@loongson.cn>
References: <20231208090042.2672425-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxH91A3nJlrE5YAA--.822S9
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
 hw/loongarch/boot.c         | 29 +++++++++++++++++++++++++++--
 include/hw/loongarch/boot.h |  9 +++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 60babe3a6e..991df2cc14 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -14,11 +14,15 @@
 #include "qemu/error-report.h"
 #include "sysemu/reset.h"
 
+ram_addr_t initrd_offset;
+uint64_t initrd_size;
+
 enum {
     SLAVE_BOOT,
     EFI_SYSTAB,
     EFI_TABLES,
     EFI_MEMMAP,
+    EFI_INITRD,
 };
 
 static const MemMapEntry loader_rommap[] = {
@@ -26,6 +30,7 @@ static const MemMapEntry loader_rommap[] = {
     [EFI_SYSTAB] = {0xf200000, 0x10000},
     [EFI_TABLES] = {0xf300000, 0x10000},
     [EFI_MEMMAP] = {0xf400000, 0x10000},
+    [EFI_INITRD] = {0xf500000, 0x10000},
 };
 
 static unsigned int slave_boot_code[] = {
@@ -117,6 +122,26 @@ static void init_efi_boot_memmap(struct efi_system_table *systab)
     g_free(boot_memmap);
 }
 
+static void init_efi_initrd_table(struct efi_system_table *systab)
+{
+    efi_guid_t tbl_guid = LINUX_EFI_INITRD_MEDIA_GUID;
+    struct efi_initrd *initrd_table  = g_malloc0(loader_rommap[EFI_INITRD].size);
+
+    initrd_table->base = initrd_offset;
+    initrd_table->size = initrd_size;
+
+    rom_add_blob_fixed("initrd_tbl_rom", initrd_table,
+                       loader_rommap[EFI_INITRD].size,
+                       loader_rommap[EFI_INITRD].base);
+
+    /* efi_configuration_table 2 */
+    guidcpy(&systab->tables[1].guid, &tbl_guid);
+    systab->tables[1].table = (void *)loader_rommap[EFI_INITRD].base;
+    systab->nr_tables = 2;
+
+    g_free(initrd_table);
+}
+
 static void init_systab(struct loongarch_boot_info *info)
 {
     struct efi_system_table *systab;
@@ -134,6 +159,7 @@ static void init_systab(struct loongarch_boot_info *info)
     systab->tables = efi_tables;
 
     init_efi_boot_memmap(systab);
+    init_efi_initrd_table(systab);
 
     rom_add_blob_fixed("tables_rom", efi_tables,
                        loader_rommap[EFI_TABLES].size,
@@ -173,8 +199,7 @@ static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
 
 static int64_t load_kernel_info(struct loongarch_boot_info *info)
 {
-    uint64_t kernel_entry, kernel_low, kernel_high, initrd_size;
-    ram_addr_t initrd_offset;
+    uint64_t kernel_entry, kernel_low, kernel_high;
     ssize_t kernel_size;
 
     kernel_size = load_elf(info->kernel_filename, NULL,
diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index bef9ab659e..e482b829f7 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -32,6 +32,10 @@ typedef struct {
         EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, \
                  0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
 
+#define LINUX_EFI_INITRD_MEDIA_GUID \
+        EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, \
+                 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
+
 struct efi_config_table {
     efi_guid_t guid;
     uint64_t *ptr;
@@ -85,6 +89,11 @@ struct efi_boot_memmap {
     efi_memory_desc_t map[32];
 };
 
+struct efi_initrd {
+    uint64_t base;
+    uint64_t size;
+};
+
 struct loongarch_boot_info {
     uint64_t ram_size;
     const char *kernel_filename;
-- 
2.25.1


