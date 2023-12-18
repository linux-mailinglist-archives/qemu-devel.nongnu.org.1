Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CDE8169A5
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 10:17:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF9hT-0000xG-Im; Mon, 18 Dec 2023 04:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rF9hP-0000vw-WA
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 04:14:08 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rF9hM-0007Tv-KW
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 04:14:07 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx9OpYDYBlLf4BAA--.6178S3;
 Mon, 18 Dec 2023 17:14:00 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxXeFRDYBlVfMJAA--.47541S8; 
 Mon, 18 Dec 2023 17:13:57 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, peter.maydell@linaro.org,
 maobibo@loongson.cn
Subject: [PATCH v2 06/17] hw/loongarch: Init efi_boot_memmap table
Date: Mon, 18 Dec 2023 17:00:48 +0800
Message-Id: <20231218090059.2678224-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231218090059.2678224-1-gaosong@loongson.cn>
References: <20231218090059.2678224-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXeFRDYBlVfMJAA--.47541S8
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
 hw/loongarch/boot.c         | 45 +++++++++++++++++++++++++++++++++++++
 hw/loongarch/virt.c         | 11 ++-------
 include/hw/loongarch/boot.h | 27 ++++++++++++++++++++++
 include/hw/loongarch/virt.h | 10 +++++++++
 4 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 7d043fd718..5d963176bd 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -18,12 +18,14 @@ enum {
     SLAVE_BOOT,
     EFI_SYSTAB,
     EFI_TABLES,
+    EFI_MEMMAP,
 };
 
 static const MemMapEntry loader_rommap[] = {
     [SLAVE_BOOT] = {0xf100000, 0x10000},
     [EFI_SYSTAB] = {0xf200000, 0x10000},
     [EFI_TABLES] = {0xf300000, 0x10000},
+    [EFI_MEMMAP] = {0xf400000, 0x10000},
 };
 
 static unsigned int slave_boot_code[] = {
@@ -74,6 +76,47 @@ static unsigned int slave_boot_code[] = {
     0x4c000020,   /* jirl       $r0,$r1,0           */
 };
 
+static inline void *guidcpy(void *dst, const void *src)
+{
+    return memcpy(dst, src, sizeof(efi_guid_t));
+}
+
+static void init_efi_boot_memmap(struct efi_system_table *systab)
+{
+    unsigned i;
+    struct efi_boot_memmap *boot_memmap;
+    efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
+
+    boot_memmap = g_malloc0(sizeof(struct efi_boot_memmap) +
+                            sizeof(efi_memory_desc_t) * 32);
+    if (!boot_memmap) {
+        error_report("init_boot_memmap :can not malloc memory\n");
+        exit(1);
+    }
+    boot_memmap->desc_size = sizeof(efi_memory_desc_t);
+    boot_memmap->desc_ver = 1;
+    boot_memmap->map_size = 0;
+
+    efi_memory_desc_t *map;
+    for (i = 0; i < memmap_entries; i++) {
+        map = (void *)boot_memmap + sizeof(*map);
+        map[i].type = memmap_table[i].type;
+        map[i].phys_addr = memmap_table[i].address;
+        map[i].num_pages = memmap_table[i].length >> 16; /* 64KB align*/
+    }
+
+    rom_add_blob_fixed("memmap_rom", boot_memmap,
+                       loader_rommap[EFI_MEMMAP].size,
+                       loader_rommap[EFI_MEMMAP].base);
+
+    /* efi_configuration_table 1 */
+    guidcpy(&systab->tables[0].guid, &tbl_guid);
+    systab->tables[0].table = (void *)loader_rommap[EFI_MEMMAP].base;
+    systab->nr_tables = 1;
+
+    g_free(boot_memmap);
+}
+
 static void init_systab(struct loongarch_boot_info *info)
 {
     struct efi_system_table *systab;
@@ -90,6 +133,8 @@ static void init_systab(struct loongarch_boot_info *info)
     systab->nr_tables = 0;
     systab->tables = efi_tables;
 
+    init_efi_boot_memmap(systab);
+
     rom_add_blob_fixed("tables_rom", efi_tables,
                        loader_rommap[EFI_TABLES].size,
                        loader_rommap[EFI_TABLES].base);
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 3e27d72f55..c45e724961 100644
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
diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index 4ee116b25d..bef9ab659e 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -23,6 +23,15 @@ typedef struct {
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
@@ -58,6 +67,24 @@ struct efi_system_table {
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
index d21de2cef4..aef4cd05b1 100644
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
-- 
2.25.1


