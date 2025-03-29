Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 466F0A75700
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Mar 2025 16:44:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyYLh-0003fU-Sl; Sat, 29 Mar 2025 11:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tyYLK-0003bb-Mw
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 11:43:31 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tyYLI-0003Bm-0A
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 11:43:30 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BD8D34E6036;
 Sat, 29 Mar 2025 16:43:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id hdVUEhX8Btmg; Sat, 29 Mar 2025 16:43:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C01E34E602E; Sat, 29 Mar 2025 16:43:22 +0100 (CET)
Message-ID: <87fd654be0c91a1ebd3b0c2c1a2beca0c480f546.1743262839.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1743262839.git.balaton@eik.bme.hu>
References: <cover.1743262839.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/2] system/datadir: Add new type constant for DTB files
To: qemu-devel@nongnu.org
Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 29 Mar 2025 16:43:22 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

Currently DTB files are mixed with ROMs under BIOS type. Separate them
under a new type constant and turn defines into an enum while at it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/microblaze/boot.c   |  2 +-
 hw/ppc/ppc440_bamboo.c |  2 +-
 hw/ppc/sam460ex.c      |  2 +-
 hw/ppc/virtex_ml507.c  |  2 +-
 include/qemu/datadir.h | 13 +++++++++----
 system/datadir.c       |  3 ++-
 6 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 60b4ef0abe..4a9c9df318 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -130,7 +130,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, bool is_little_endian,
     dtb_arg = current_machine->dtb;
     /* default to pcbios dtb as passed by machine_init */
     if (!dtb_arg && dtb_filename) {
-        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, dtb_filename);
+        filename = qemu_find_file(QEMU_FILE_TYPE_DTB, dtb_filename);
     }
 
     boot_info.machine_cpu_reset = machine_cpu_reset;
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 099fda3909..6fff0d8afb 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -64,7 +64,7 @@ static int bamboo_load_device_tree(MachineState *machine,
     uint32_t tb_freq = 400000000;
     uint32_t clock_freq = 400000000;
 
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_FILE);
+    filename = qemu_find_file(QEMU_FILE_TYPE_DTB, BINARY_DEVICE_TREE_FILE);
     if (!filename) {
         return -1;
     }
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 7dc3b309c8..327fac440f 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -142,7 +142,7 @@ static int sam460ex_load_device_tree(MachineState *machine,
     uint32_t clock_freq = CPU_FREQ;
     int offset;
 
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_FILE);
+    filename = qemu_find_file(QEMU_FILE_TYPE_DTB, BINARY_DEVICE_TREE_FILE);
     if (!filename) {
         error_report("Couldn't find dtb file `%s'", BINARY_DEVICE_TREE_FILE);
         exit(1);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 17115be74d..c9969ae48a 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -146,7 +146,7 @@ static int xilinx_load_device_tree(MachineState *machine,
         /* Try the local "ppc.dtb" override.  */
         fdt = load_device_tree("ppc.dtb", &fdt_size);
         if (!fdt) {
-            path = qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_FILE);
+            path = qemu_find_file(QEMU_FILE_TYPE_DTB, BINARY_DEVICE_TREE_FILE);
             if (path) {
                 fdt = load_device_tree(path, &fdt_size);
                 g_free(path);
diff --git a/include/qemu/datadir.h b/include/qemu/datadir.h
index 21f9097f58..16db3d8cd3 100644
--- a/include/qemu/datadir.h
+++ b/include/qemu/datadir.h
@@ -1,12 +1,17 @@
 #ifndef QEMU_DATADIR_H
 #define QEMU_DATADIR_H
 
-#define QEMU_FILE_TYPE_BIOS   0
-#define QEMU_FILE_TYPE_KEYMAP 1
+typedef enum {
+    QEMU_FILE_TYPE_BIOS,
+    QEMU_FILE_TYPE_KEYMAP,
+    QEMU_FILE_TYPE_DTB,
+} QemuFileType;
+
 /**
  * qemu_find_file:
  * @type: QEMU_FILE_TYPE_BIOS (for BIOS, VGA BIOS)
- *        or QEMU_FILE_TYPE_KEYMAP (for keymaps).
+ *        QEMU_FILE_TYPE_KEYMAP (for keymaps)
+ *        QEMU_FILE_TYPE_DTB (for device tree blobs).
  * @name: Relative or absolute file name
  *
  * If @name exists on disk as an absolute path, or a path relative
@@ -20,7 +25,7 @@
  *
  * Returns: a path that can access @name, or NULL if no matching file exists.
  */
-char *qemu_find_file(int type, const char *name);
+char *qemu_find_file(QemuFileType type, const char *name);
 void qemu_add_default_firmwarepath(void);
 void qemu_add_data_dir(char *path);
 void qemu_list_data_dirs(void);
diff --git a/system/datadir.c b/system/datadir.c
index c9237cb5d4..e450b84ce9 100644
--- a/system/datadir.c
+++ b/system/datadir.c
@@ -30,7 +30,7 @@
 static const char *data_dir[16];
 static int data_dir_idx;
 
-char *qemu_find_file(int type, const char *name)
+char *qemu_find_file(QemuFileType type, const char *name)
 {
     int i;
     const char *subdir;
@@ -44,6 +44,7 @@ char *qemu_find_file(int type, const char *name)
 
     switch (type) {
     case QEMU_FILE_TYPE_BIOS:
+    case QEMU_FILE_TYPE_DTB:
         subdir = "";
         break;
     case QEMU_FILE_TYPE_KEYMAP:
-- 
2.41.3


