Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD797BF7D8
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 11:49:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq9Mq-0005H8-2g; Tue, 10 Oct 2023 05:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1qq9Mm-0005GZ-GW
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:49:28 -0400
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1qq9Mj-0003RV-Rs
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1696931360; bh=OLhX4vfki3kTiZgCZbuitbsuzq3iTs9aeIWAHhfnkzQ=;
 h=From:Date:Subject:To:Cc:From;
 b=TaS2f6WjfMnWk7uzqSne8P/mzF2ZsasTBwlsmM5CDWDFJAjpMWSb/bl0SBzxk0/kn
 v849gLLkqtBTzWy3PDkC6aIRPrQupH5oBd5A5UPLsv+zqAN9Zafc9IPIcMf8ggdqVS
 4O1SGMZt3Fz/SvvtqGkEdTKFxfNRlwJZwU7w6jGc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Tue, 10 Oct 2023 11:49:16 +0200
Subject: [PATCH v2] hw/loongarch: remove global loaderparams variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231010-loongarch-loader-params-v2-1-512cc7959683@t-8ch.de>
X-B4-Tracking: v=1; b=H4sIABweJWUC/02MSwrDMAxErxK0roLtfvJZ9R6lC9lRYkMTBzmUQ
 sjdK7rqZpgHM2+HwpK4QF/tIPxOJeVFwZ0qCJGWiTENyuCMO1tjDb5yXiaSELXRwIIrCc0FR+O
 D8S74KxPoexUe0+dnfjyVR8kzblGY/nymcxq2rd2la5obWl3kmcp9wzbEemA4ji9ICcIbowAAA
 A==
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696931359; l=5601;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=OLhX4vfki3kTiZgCZbuitbsuzq3iTs9aeIWAHhfnkzQ=;
 b=4BYh4tY61+HcKXFcu4WH+bK1sRR2oTwAve7ihocZGXyKap8BMw/8lnTOVFIzmRSvgsyywWERX
 oHHKXVRlVfuAum/QFWg20m02ZJycfjkbGpIPNyz9sJtlSH5PWIDal0g
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Passing the struct around explicitly makes the control-flow more
obvious.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
Changes in v2:
- Drop initialize loaderparams variable
- Link to v1: https://lore.kernel.org/qemu-devel/20231009210018.249776-1-thomas@t-8ch.de/
---
 hw/loongarch/virt.c | 50 +++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2629128aeda4..88bf0b0e97e1 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -47,6 +47,13 @@
 #include "qemu/error-report.h"
 
 
+struct loaderparams {
+    uint64_t ram_size;
+    const char *kernel_filename;
+    const char *kernel_cmdline;
+    const char *initrd_filename;
+};
+
 static void virt_flash_create(LoongArchMachineState *lams)
 {
     DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
@@ -411,24 +418,17 @@ static const MemoryRegionOps loongarch_virt_pm_ops = {
     }
 };
 
-static struct _loaderparams {
-    uint64_t ram_size;
-    const char *kernel_filename;
-    const char *kernel_cmdline;
-    const char *initrd_filename;
-} loaderparams;
-
 static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
 {
     return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
 }
 
-static int64_t load_kernel_info(void)
+static int64_t load_kernel_info(const struct loaderparams *loaderparams)
 {
     uint64_t kernel_entry, kernel_low, kernel_high;
     ssize_t kernel_size;
 
-    kernel_size = load_elf(loaderparams.kernel_filename, NULL,
+    kernel_size = load_elf(loaderparams->kernel_filename, NULL,
                            cpu_loongarch_virt_to_phys, NULL,
                            &kernel_entry, &kernel_low,
                            &kernel_high, NULL, 0,
@@ -436,7 +436,7 @@ static int64_t load_kernel_info(void)
 
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
-                     loaderparams.kernel_filename,
+                     loaderparams->kernel_filename,
                      load_elf_strerror(kernel_size));
         exit(1);
     }
@@ -728,7 +728,8 @@ static void reset_load_elf(void *opaque)
     }
 }
 
-static void fw_cfg_add_kernel_info(FWCfgState *fw_cfg)
+static void fw_cfg_add_kernel_info(const struct loaderparams *loaderparams,
+                                   FWCfgState *fw_cfg)
 {
     /*
      * Expose the kernel, the command line, and the initrd in fw_cfg.
@@ -737,36 +738,38 @@ static void fw_cfg_add_kernel_info(FWCfgState *fw_cfg)
      */
     load_image_to_fw_cfg(fw_cfg,
                          FW_CFG_KERNEL_SIZE, FW_CFG_KERNEL_DATA,
-                         loaderparams.kernel_filename,
+                         loaderparams->kernel_filename,
                          false);
 
-    if (loaderparams.initrd_filename) {
+    if (loaderparams->initrd_filename) {
         load_image_to_fw_cfg(fw_cfg,
                              FW_CFG_INITRD_SIZE, FW_CFG_INITRD_DATA,
-                             loaderparams.initrd_filename, false);
+                             loaderparams->initrd_filename, false);
     }
 
-    if (loaderparams.kernel_cmdline) {
+    if (loaderparams->kernel_cmdline) {
         fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
-                       strlen(loaderparams.kernel_cmdline) + 1);
+                       strlen(loaderparams->kernel_cmdline) + 1);
         fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA,
-                          loaderparams.kernel_cmdline);
+                          loaderparams->kernel_cmdline);
     }
 }
 
-static void loongarch_firmware_boot(LoongArchMachineState *lams)
+static void loongarch_firmware_boot(LoongArchMachineState *lams,
+                                    const struct loaderparams *loaderparams)
 {
-    fw_cfg_add_kernel_info(lams->fw_cfg);
+    fw_cfg_add_kernel_info(loaderparams, lams->fw_cfg);
 }
 
-static void loongarch_direct_kernel_boot(LoongArchMachineState *lams)
+static void loongarch_direct_kernel_boot(LoongArchMachineState *lams,
+                                         const struct loaderparams *loaderparams)
 {
     MachineState *machine = MACHINE(lams);
     int64_t kernel_addr = 0;
     LoongArchCPU *lacpu;
     int i;
 
-    kernel_addr = load_kernel_info();
+    kernel_addr = load_kernel_info(loaderparams);
     if (!machine->firmware) {
         for (i = 0; i < machine->smp.cpus; i++) {
             lacpu = LOONGARCH_CPU(qemu_get_cpu(i));
@@ -793,6 +796,7 @@ static void loongarch_init(MachineState *machine)
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     CPUState *cpu;
     char *ramName = NULL;
+    struct loaderparams loaderparams = { };
 
     if (!cpu_model) {
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
@@ -898,9 +902,9 @@ static void loongarch_init(MachineState *machine)
     /* load the kernel. */
     if (loaderparams.kernel_filename) {
         if (lams->bios_loaded) {
-            loongarch_firmware_boot(lams);
+            loongarch_firmware_boot(lams, &loaderparams);
         } else {
-            loongarch_direct_kernel_boot(lams);
+            loongarch_direct_kernel_boot(lams, &loaderparams);
         }
     }
     fdt_add_flash_node(lams);

---
base-commit: 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d
change-id: 20231010-loongarch-loader-params-f0bc0b2cb5ea

Best regards,
-- 
Thomas Weißschuh <thomas@t-8ch.de>


