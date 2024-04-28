Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA1D8B4AEB
	for <lists+qemu-devel@lfdr.de>; Sun, 28 Apr 2024 11:10:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s10Y6-00031R-Kp; Sun, 28 Apr 2024 05:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s10Xv-0002m3-Eg
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:10:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s10Xs-0004ka-A9
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:10:06 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxR+n8ES5m3VkEAA--.3501S3;
 Sun, 28 Apr 2024 17:08:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxpFb1ES5mmCgIAA--.5818S7; 
 Sun, 28 Apr 2024 17:08:11 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 05/17] hw/loongarch: Init efi_system_table
Date: Sun, 28 Apr 2024 16:51:05 +0800
Message-Id: <20240428085117.2422473-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240428085117.2422473-1-gaosong@loongson.cn>
References: <20240428085117.2422473-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxpFb1ES5mmCgIAA--.5818S7
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20240426091551.2397867-6-gaosong@loongson.cn>
---
 hw/loongarch/boot.c         | 22 +++++++++++++++++
 include/hw/loongarch/boot.h | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index aca5ad388e..46a241a04c 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -63,6 +63,25 @@ static const unsigned int slave_boot_code[] = {
     0x4c000020,   /* jirl       $zero, $ra,0                   */
 };
 
+static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
+{
+    struct efi_system_table *systab = p;
+
+    info->a2 = (uint64_t)p - (uint64_t)start;
+
+    systab->hdr.signature = EFI_SYSTEM_TABLE_SIGNATURE;
+    systab->hdr.revision = EFI_SPECIFICATION_VERSION;
+    systab->hdr.revision = sizeof(struct efi_system_table),
+    systab->fw_revision = FW_VERSION << 16 | FW_PATCHLEVEL << 8;
+    systab->runtime = 0;
+    systab->boottime = 0;
+    systab->nr_tables = 0;
+
+    p += ROUND_UP(sizeof(struct efi_system_table), 64 * KiB);
+
+    systab->tables = p;
+}
+
 static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
 {
     hwaddr cmdline_addr = (hwaddr)p - (hwaddr)start;
@@ -135,6 +154,7 @@ static void reset_load_elf(void *opaque)
 	if (cpu == LOONGARCH_CPU(first_cpu)) {
             env->gpr[4] = env->boot_info->a0;
             env->gpr[5] = env->boot_info->a1;
+            env->gpr[6] = env->boot_info->a2;
         }
         cpu_set_pc(CPU(cpu), env->elf_address);
     }
@@ -179,6 +199,8 @@ static void init_boot_rom(struct loongarch_boot_info *info, void *p)
 
     init_cmdline(info, p, start);
     p += COMMAND_LINE_SIZE;
+
+    init_systab(info, p, start);
 }
 
 static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index 3275c1e295..cf0e4d4f91 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -8,6 +8,54 @@
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
+typedef struct {
+    uint8_t b[16];
+} efi_guid_t QEMU_ALIGNED(8);
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
+    uint64_t stderr_placeholder;
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


