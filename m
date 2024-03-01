Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A37886DE6B
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Mar 2024 10:40:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfzLz-0003GI-E6; Fri, 01 Mar 2024 04:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rfzLw-0003D0-2x
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:38:52 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rfzLr-0006Nu-ON
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:38:51 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxruskouFlUD0TAA--.48675S3;
 Fri, 01 Mar 2024 17:38:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDBMfouFlyZxLAA--.4871S9; 
 Fri, 01 Mar 2024 17:38:44 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, philmd@linaro.org,
 maobibo@loongson.cn, zhaotianrui@loongson.cn, lixianglai@loongson.cn,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com
Subject: [PATCH v5 07/17] hw/loongarch: Init efi_initrd table
Date: Fri,  1 Mar 2024 17:38:28 +0800
Message-Id: <20240301093839.663947-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240301093839.663947-1-gaosong@loongson.cn>
References: <20240301093839.663947-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDBMfouFlyZxLAA--.4871S9
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
 include/hw/loongarch/boot.h |  9 +++++++++
 hw/loongarch/boot.c         | 23 +++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index 7ad25080c5..ce47056608 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -30,6 +30,10 @@ typedef struct {
         EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, \
                  0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
 
+#define LINUX_EFI_INITRD_MEDIA_GUID \
+        EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, \
+                 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
+
 struct efi_config_table {
     efi_guid_t guid;
     uint64_t *ptr;
@@ -83,6 +87,11 @@ struct efi_boot_memmap {
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
diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index c086070bc8..6f56d4fd91 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -14,6 +14,9 @@
 #include "qemu/error-report.h"
 #include "sysemu/reset.h"
 
+ram_addr_t initrd_offset;
+uint64_t initrd_size;
+
 static const unsigned int slave_boot_code[] = {
                   /* Configure reset ebase.         */
     0x0400302c,   /* csrwr      $r12,0xc            */
@@ -93,6 +96,21 @@ static void init_efi_boot_memmap(struct efi_system_table *systab,
     }
 }
 
+static void init_efi_initrd_table(struct efi_system_table *systab,
+                                  void *p, void *start)
+{
+    efi_guid_t tbl_guid = LINUX_EFI_INITRD_MEDIA_GUID;
+    struct efi_initrd *initrd_table  = p;
+
+    /* efi_configuration_table 2 */
+    guidcpy(&systab->tables[1].guid, &tbl_guid);
+    systab->tables[1].table = (struct efi_configuration_table *)(p - start);
+    systab->nr_tables = 2;
+
+    initrd_table->base = initrd_offset;
+    initrd_table->size = initrd_size;
+}
+
 static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
 {
     void *bp_tables_start;
@@ -116,6 +134,8 @@ static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
     init_efi_boot_memmap(systab, p, start);
     p += ROUND_UP(sizeof(struct efi_boot_memmap) +
                   sizeof(efi_memory_desc_t) * memmap_entries, 64);
+    init_efi_initrd_table(systab, p, start);
+    p += ROUND_UP(sizeof(struct efi_initrd), 64);
 
     systab->tables = (struct efi_configuration_table *)(bp_tables_start - start);
 }
@@ -137,8 +157,7 @@ static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
 
 static int64_t load_kernel_info(struct loongarch_boot_info *info)
 {
-    uint64_t kernel_entry, kernel_low, kernel_high, initrd_size;
-    ram_addr_t initrd_offset;
+    uint64_t kernel_entry, kernel_low, kernel_high;
     ssize_t kernel_size;
 
     kernel_size = load_elf(info->kernel_filename, NULL,
-- 
2.25.1


