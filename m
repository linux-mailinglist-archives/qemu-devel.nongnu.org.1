Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B20F81ED41
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 09:23:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIPAe-0006Nf-04; Wed, 27 Dec 2023 03:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rIPAW-0006L8-Sq
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 03:21:37 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rIPAR-0002Ja-58
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 03:21:36 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxXYd+3otlQPcEAA--.964S3;
 Wed, 27 Dec 2023 16:21:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxib153otly4QMAA--.16227S8; 
 Wed, 27 Dec 2023 16:21:17 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org,
 maobibo@loongson.cn
Subject: [PATCH v3 06/17] hw/loongarch: Init efi_boot_memmap table
Date: Wed, 27 Dec 2023 16:08:10 +0800
Message-Id: <20231227080821.3216113-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231227080821.3216113-1-gaosong@loongson.cn>
References: <20231227080821.3216113-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxib153otly4QMAA--.16227S8
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
 hw/loongarch/boot.c         | 40 +++++++++++++++++++++++++++++++++++++
 hw/loongarch/virt.c         | 11 ++--------
 include/hw/loongarch/boot.h | 27 +++++++++++++++++++++++++
 include/hw/loongarch/virt.h | 11 ++++++++++
 4 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index b8b44d41f9..4103fb2781 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -63,8 +63,43 @@ static unsigned int slave_boot_code[] = {
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
+
+    p += ROUND_UP(sizeof(struct efi_boot_memmap) +
+                  sizeof(efi_memory_desc_t) * memmap_entries, 64);
+}
+
 static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
 {
+    void *bp_tables_start;
     struct efi_system_table *systab = p;
 
     info->a2 = (uint64_t)p - (uint64_t)start;
@@ -80,6 +115,11 @@ static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
     p += ROUND_UP(sizeof(struct efi_system_table), 64);
 
     systab->tables = p;
+    bp_tables_start = p;
+
+    init_efi_boot_memmap(systab, p, start);
+
+    systab->tables = (struct efi_configuration_table *)(bp_tables_start - start);
 }
 
 static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 4794af4825..795c2cd95c 100644
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
index 90cccd9aa1..3e8728f1af 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -31,6 +31,17 @@
 #define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN)
 #define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN)
 
+
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


