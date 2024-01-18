Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D9483188B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 12:37:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQQg8-0002Mo-88; Thu, 18 Jan 2024 06:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rQQfu-0002HM-8L
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 06:35:11 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rQQfp-0006t5-Mn
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 06:35:09 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxvuvjDKllmJ0BAA--.7635S3;
 Thu, 18 Jan 2024 19:34:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxLs_gDKll9GoIAA--.42875S8; 
 Thu, 18 Jan 2024 19:34:59 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 maobibo@loongson.cn, zhaotianrui@loongson.cn, lixianglai@loongson.cn
Subject: [PATCH v4 06/17] hw/loongarch: Init efi_boot_memmap table
Date: Thu, 18 Jan 2024 19:18:49 +0800
Message-Id: <20240118111900.1672536-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240118111900.1672536-1-gaosong@loongson.cn>
References: <20240118111900.1672536-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxLs_gDKll9GoIAA--.42875S8
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
Message-Id: <20231227080821.3216113-7-gaosong@loongson.cn>
---
 include/hw/loongarch/boot.h | 27 +++++++++++++++++++++++++
 include/hw/loongarch/virt.h | 10 ++++++++++
 hw/loongarch/boot.c         | 39 +++++++++++++++++++++++++++++++++++++
 hw/loongarch/virt.c         | 11 ++---------
 4 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index aa12a60ffb..7ad25080c5 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -21,6 +21,15 @@ typedef struct {
     uint8_t b[16];
 } efi_guid_t __attribute__((aligned(8)));
 
+#define EFI_GUID(a, b, c, d...) (efi_guid_t){ {                                \
+        (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
+        (b) & 0xff, ((b) >> 8) & 0xff,                                         \
+        (c) & 0xff, ((c) >> 8) & 0xff, d } }
+
+#define LINUX_EFI_BOOT_MEMMAP_GUID \
+        EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, \
+                 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
+
 struct efi_config_table {
     efi_guid_t guid;
     uint64_t *ptr;
@@ -56,6 +65,24 @@ struct efi_system_table {
     struct efi_configuration_table *tables;
 };
 
+typedef struct {
+    uint32_t type;
+    uint32_t pad;
+    uint64_t phys_addr;
+    uint64_t virt_addr;
+    uint64_t num_pages;
+    uint64_t attribute;
+} efi_memory_desc_t;
+
+struct efi_boot_memmap {
+    uint64_t map_size;
+    uint64_t desc_size;
+    uint32_t desc_ver;
+    uint64_t map_key;
+    uint64_t buff_size;
+    efi_memory_desc_t map[32];
+};
+
 struct loongarch_boot_info {
     uint64_t ram_size;
     const char *kernel_filename;
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 94ff15ad66..d937586dbb 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -33,6 +33,16 @@
 
 #define COMMAND_LINE_SIZE       512
 
+extern struct memmap_entry *memmap_table;
+extern unsigned memmap_entries;
+
+struct memmap_entry {
+    uint64_t address;
+    uint64_t length;
+    uint32_t type;
+    uint32_t reserved;
+};
+
 struct LoongArchMachineState {
     /*< private >*/
     MachineState parent_obj;
diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 769212fce2..c086070bc8 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -62,8 +62,40 @@ static const unsigned int slave_boot_code[] = {
     0x4c000020,   /* jirl       $r0,$r1,0           */
 };
 
+static inline void *guidcpy(void *dst, const void *src)
+{
+    return memcpy(dst, src, sizeof(efi_guid_t));
+}
+
+static void init_efi_boot_memmap(struct efi_system_table *systab,
+                                 void *p, void *start)
+{
+    unsigned i;
+    struct efi_boot_memmap *boot_memmap = p;
+    efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
+
+    /* efi_configuration_table 1 */
+    guidcpy(&systab->tables[0].guid, &tbl_guid);
+    systab->tables[0].table = (struct efi_configuration_table *)(p - start);
+    systab->nr_tables = 1;
+
+    boot_memmap->desc_size = sizeof(efi_memory_desc_t);
+    boot_memmap->desc_ver = 1;
+    boot_memmap->map_size = 0;
+
+    efi_memory_desc_t *map = p + sizeof(struct efi_boot_memmap);
+    for (i = 0; i < memmap_entries; i++) {
+        map = (void *)boot_memmap + sizeof(*map);
+        map[i].type = memmap_table[i].type;
+        map[i].phys_addr = memmap_table[i].address;
+        map[i].num_pages = memmap_table[i].length >> 16; /* 64KB align*/
+        p += sizeof(efi_memory_desc_t);
+    }
+}
+
 static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
 {
+    void *bp_tables_start;
     struct efi_system_table *systab = p;
 
     info->a2 = (uint64_t)p - (uint64_t)start;
@@ -79,6 +111,13 @@ static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
     p += ROUND_UP(sizeof(struct efi_system_table), 64);
 
     systab->tables = p;
+    bp_tables_start = p;
+
+    init_efi_boot_memmap(systab, p, start);
+    p += ROUND_UP(sizeof(struct efi_boot_memmap) +
+                  sizeof(efi_memory_desc_t) * memmap_entries, 64);
+
+    systab->tables = (struct efi_configuration_table *)(bp_tables_start - start);
 }
 
 static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 02a54033ee..5f5153e681 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -342,15 +342,8 @@ static void virt_powerdown_req(Notifier *notifier, void *opaque)
     acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
 }
 
-struct memmap_entry {
-    uint64_t address;
-    uint64_t length;
-    uint32_t type;
-    uint32_t reserved;
-};
-
-static struct memmap_entry *memmap_table;
-static unsigned memmap_entries;
+struct memmap_entry *memmap_table;
+unsigned memmap_entries;
 
 static void memmap_add_entry(uint64_t address, uint64_t length, uint32_t type)
 {
-- 
2.25.1


