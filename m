Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB8D809F05
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 10:15:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBWvw-00016W-US; Fri, 08 Dec 2023 04:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rBWvf-00010k-7I
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:13:51 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rBWvb-0008FA-Oz
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:13:50 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxjutF3nJlq+w_AA--.59399S3;
 Fri, 08 Dec 2023 17:13:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxH91A3nJlrE5YAA--.822S7; 
 Fri, 08 Dec 2023 17:13:40 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, peter.maydell@linaro.org,
 maobibo@loongson.cn
Subject: [PATCH v1 05/17] hw/loongarch: Init efi_system_table
Date: Fri,  8 Dec 2023 17:00:30 +0800
Message-Id: <20231208090042.2672425-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231208090042.2672425-1-gaosong@loongson.cn>
References: <20231208090042.2672425-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxH91A3nJlrE5YAA--.822S7
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

Add init_systab and set boot_info->a2

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/boot.c         | 39 +++++++++++++++++++++++++++++
 include/hw/loongarch/boot.h | 50 +++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 742a70b7f0..b9353027b2 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -16,10 +16,14 @@
 
 enum {
     SLAVE_BOOT,
+    EFI_SYSTAB,
+    EFI_TABLES,
 };
 
 static const MemMapEntry loader_rommap[] = {
     [SLAVE_BOOT] = {0xf100000, 0x10000},
+    [EFI_SYSTAB] = {0xf200000, 0x10000},
+    [EFI_TABLES] = {0xf300000, 0x10000},
 };
 
 static unsigned int slave_boot_code[] = {
@@ -70,6 +74,39 @@ static unsigned int slave_boot_code[] = {
     0x4c000020,   /* jirl       $r0,$r1,0           */
 };
 
+static void init_systab(struct loongarch_boot_info *info)
+{
+    struct efi_system_table *systab;
+    struct efi_configuration_table *efi_tables;
+    systab = g_malloc0(loader_rommap[EFI_SYSTAB].size);
+    efi_tables = g_malloc0(loader_rommap[EFI_TABLES].size);
+
+    systab->hdr.signature = EFI_SYSTEM_TABLE_SIGNATURE;
+    systab->hdr.revision = EFI_SPECIFICATION_VERSION;
+    systab->hdr.revision = sizeof(struct efi_system_table),
+    systab->fw_revision = FW_VERSION << 16 | FW_PATCHLEVEL << 8;
+    systab->runtime = 0;
+    systab->boottime = 0;
+    systab->nr_tables = 0;
+    systab->tables = efi_tables;
+
+    rom_add_blob_fixed("tables_rom", efi_tables,
+                       loader_rommap[EFI_TABLES].size,
+                       loader_rommap[EFI_TABLES].base);
+
+    systab->tables = (struct efi_configuration_table *)
+                     loader_rommap[EFI_TABLES].base;
+
+    rom_add_blob_fixed("systab_rom", systab,
+                       loader_rommap[EFI_SYSTAB].size,
+                       loader_rommap[EFI_SYSTAB].base);
+
+    info->a2 = loader_rommap[EFI_SYSTAB].base;
+
+    g_free(systab);
+    g_free(efi_tables);
+}
+
 static int init_cmdline(struct loongarch_boot_info *info)
 {
     hwaddr cmdline_addr;
@@ -131,6 +168,7 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
     }
 
     init_cmdline(info);
+    init_systab(info);
 
     return kernel_entry;
 }
@@ -145,6 +183,7 @@ static void reset_load_elf(void *opaque)
 	if (cpu == LOONGARCH_CPU(first_cpu)) {
             env->gpr[4] = env->boot_info->a0;
             env->gpr[5] = env->boot_info->a1;
+            env->gpr[6] = env->boot_info->a2;
         }
         cpu_set_pc(CPU(cpu), env->elf_address);
     }
diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index 3275c1e295..4ee116b25d 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -8,6 +8,56 @@
 #ifndef HW_LOONGARCH_BOOT_H
 #define HW_LOONGARCH_BOOT_H
 
+/* UEFI 2.10 */
+#define EFI_SYSTEM_TABLE_SIGNATURE       0x5453595320494249
+#define EFI_2_100_SYSTEM_TABLE_REVISION  ((2<<16) | (100))
+#define EFI_SPECIFICATION_VERSION        EFI_SYSTEM_TABLE_REVISION
+#define EFI_SYSTEM_TABLE_REVISION        EFI_2_100_SYSTEM_TABLE_REVISION
+
+#define FW_VERSION 0x1
+#define FW_PATCHLEVEL 0x0
+
+#define EFI_MAX_CONFIGURATION_TABLES 16
+
+typedef struct {
+    uint8_t b[16];
+} efi_guid_t __attribute__((aligned(8)));
+
+struct efi_config_table {
+    efi_guid_t guid;
+    uint64_t *ptr;
+    const char name[16];
+};
+
+typedef struct {
+    uint64_t signature;
+    uint32_t revision;
+    uint32_t headersize;
+    uint32_t crc32;
+    uint32_t reserved;
+} efi_table_hdr_t;
+
+struct efi_configuration_table {
+    efi_guid_t guid;
+    void *table;
+};
+
+struct efi_system_table {
+    efi_table_hdr_t hdr;
+    uint64_t fw_vendor;        /* physical addr of CHAR16 vendor string */
+    uint32_t fw_revision;
+    uint64_t con_in_handle;
+    uint64_t *con_in;
+    uint64_t con_out_handle;
+    uint64_t *con_out;
+    uint64_t stderr_handle;
+    uint64_t stderr;
+    uint64_t *runtime;
+    uint64_t *boottime;
+    uint64_t nr_tables;
+    struct efi_configuration_table *tables;
+};
+
 struct loongarch_boot_info {
     uint64_t ram_size;
     const char *kernel_filename;
-- 
2.25.1


