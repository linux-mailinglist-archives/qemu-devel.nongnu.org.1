Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 001BA82C763
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:44:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQGM-0008VH-3c; Fri, 12 Jan 2024 17:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOQGH-0008Uw-MO
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:44:25 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOQGF-0003fX-Hq
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:44:25 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 14BB961E88;
 Fri, 12 Jan 2024 22:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D52C433F1;
 Fri, 12 Jan 2024 22:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705099461;
 bh=6lQRnjOWgZC3UkE0YNlulkB0sgFWSybE1icJT+rZBg4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R+SbOLhdtS1BmUTmMrDBqkEGSOPD6Qy88BEVx8GU+uQRhHibw7K2piWqn4IG5VMZm
 pK0bOF9pJPrMGshhU2+vNiCvZ79YmkmOpLXY0zNonhNLv6HcmJSfJGvjjMLQ8BgfLt
 8TJc+qtHd0078NOlhdpZx8JfC/L11gBObOB7Uvi3sopDNWQsuM27X+LGvrEog4jE7l
 ypWSxAwXwl4tZtFhdP4g4tLwWc0/bOeapfhDxdVPG1vVf5FTqFTqOvPvt7aFNWrwxR
 o+V9k4aE9Pz5/hdjX1wh9ongOA1cmfsodfWTjf2OyLmM5HUxjwl0KyOZcyDm7BChwY
 S8CT0gpQTzq7g==
Date: Fri, 12 Jan 2024 23:44:17 +0100
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v3 5/9] hw/hppa: Move software power button address back
 into PDC
Message-ID: <ZaHAwUC1V3WJpk5T@p100>
References: <20240112102927.35406-1-deller@kernel.org>
 <20240112102927.35406-6-deller@kernel.org>
 <477fa733-0957-4026-ac06-57d76d4b0388@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <477fa733-0957-4026-ac06-57d76d4b0388@linaro.org>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> I think it would be better to pass this as a parameter to create_fw_cfg, or
> to drop the translated FW_CFG_IO_BASE parameter and merely pass in translate
> itself.

Like this?


The various operating systems (e.g. Linux, NetBSD) have issues
mapping the power button when it's stored in page zero.
NetBSD even crashes, because it fails to map that page and then
accesses unmapped memory.

Since we now have a consistent memory mapping of PDC in 32-bit
and 64-bit address space (the lower 32-bits of the address are in
sync) the power button can be moved back to PDC space.

This patch fixes the power button on Linux, NetBSD and HP-UX.

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: Bruno Haible <bruno@clisp.org>

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 54ca2fd91a..da85050f60 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -36,8 +36,8 @@
 
 #define MIN_SEABIOS_HPPA_VERSION 12 /* require at least this fw version */
 
-/* Power button address at &PAGE0->pad[4] */
-#define HPA_POWER_BUTTON (0x40 + 4 * sizeof(uint32_t))
+#define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
+static hwaddr soft_power_reg;
 
 #define enable_lasi_lan()       0
 
@@ -45,7 +45,6 @@ static DeviceState *lasi_dev;
 
 static void hppa_powerdown_req(Notifier *n, void *opaque)
 {
-    hwaddr soft_power_reg = HPA_POWER_BUTTON;
     uint32_t val;
 
     val = ldl_be_phys(&address_space_memory, soft_power_reg);
@@ -191,7 +190,7 @@ static void fw_cfg_boot_set(void *opaque, const char *boot_device,
 }
 
 static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
-                                 hwaddr addr)
+                                 hwaddr addr, hwaddr pwr_button_addr)
 {
     FWCfgState *fw_cfg;
     uint64_t val;
@@ -221,7 +220,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
     fw_cfg_add_file(fw_cfg, "/etc/hppa/machine",
                     g_memdup(mc->name, len), len);
 
-    val = cpu_to_le64(HPA_POWER_BUTTON);
+    val = cpu_to_le64(pwr_button_addr);
     fw_cfg_add_file(fw_cfg, "/etc/hppa/power-button-addr",
                     g_memdup(&val, sizeof(val)), sizeof(val));
 
@@ -295,6 +294,8 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
         ram_max = 0xf0000000;      /* 3.75 GB (32-bit CPU) */
     }
 
+    soft_power_reg = translate(NULL, HPA_POWER_BUTTON);
+
     for (unsigned int i = 0; i < smp_cpus; i++) {
         g_autofree char *name = g_strdup_printf("cpu%u-io-eir", i);
 
@@ -407,7 +408,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     qemu_register_powerdown_notifier(&hppa_system_powerdown_notifier);
 
     /* fw_cfg configuration interface */
-    create_fw_cfg(machine, pci_bus, translate(NULL, FW_CFG_IO_BASE));
+    create_fw_cfg(machine, pci_bus, translate(NULL, FW_CFG_IO_BASE),
+        translate(NULL, HPA_POWER_BUTTON));
 
     /* Load firmware.  Given that this is not "real" firmware,
        but one explicitly written for the emulation, we might as

