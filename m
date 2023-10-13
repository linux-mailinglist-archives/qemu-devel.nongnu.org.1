Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C177C7FED
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:20:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDNO-00051q-6X; Fri, 13 Oct 2023 04:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qrDN3-0003hV-It
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:18:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qrDMx-0003SO-Q0
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:18:08 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dx_7s0_Shl7aQxAA--.36508S3;
 Fri, 13 Oct 2023 16:17:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxbNwt_ShlyKIiAA--.7352S5; 
 Fri, 13 Oct 2023 16:17:53 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, stefanha@gmail.com,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/7] hw/loongarch: remove global loaderparams variable
Date: Fri, 13 Oct 2023 16:17:46 +0800
Message-Id: <20231013081750.2944412-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231013081750.2944412-1-gaosong@loongson.cn>
References: <20231013081750.2944412-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxbNwt_ShlyKIiAA--.7352S5
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

From: Thomas Weißschuh <thomas@t-8ch.de>

Passing the struct around explicitly makes the control-flow more
obvious.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20231010-loongarch-loader-params-v2-1-512cc7959683@t-8ch.de>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 50 ++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index b0a004f860..c6f64e941b 100644
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
-- 
2.25.1


