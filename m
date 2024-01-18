Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C87831372
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:57:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNGm-0008Hs-7Z; Thu, 18 Jan 2024 02:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNGc-0007ee-4x; Thu, 18 Jan 2024 02:56:51 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNGZ-00080f-Ec; Thu, 18 Jan 2024 02:56:49 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 118B64504C;
 Thu, 18 Jan 2024 10:54:37 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3A145661B4;
 Thu, 18 Jan 2024 10:54:07 +0300 (MSK)
Received: (nullmailer pid 2381729 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Bruno Haible <bruno@clisp.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 33/38] hw/hppa: Move software power button address back
 into PDC
Date: Thu, 18 Jan 2024 10:53:00 +0300
Message-Id: <20240118075404.2381519-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit ed35afcb331a972210816435d6b1b5de17fc7d4f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 54ca2fd91a..9e611620cc 100644
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
@@ -221,7 +220,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
     fw_cfg_add_file(fw_cfg, "/etc/hppa/machine",
                     g_memdup(mc->name, len), len);
 
-    val = cpu_to_le64(HPA_POWER_BUTTON);
+    val = cpu_to_le64(soft_power_reg);
     fw_cfg_add_file(fw_cfg, "/etc/hppa/power-button-addr",
                     g_memdup(&val, sizeof(val)), sizeof(val));
 
@@ -295,6 +294,8 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
         ram_max = 0xf0000000;      /* 3.75 GB (32-bit CPU) */
     }
 
+    soft_power_reg = translate(NULL, HPA_POWER_BUTTON);
+
     for (unsigned int i = 0; i < smp_cpus; i++) {
         g_autofree char *name = g_strdup_printf("cpu%u-io-eir", i);
 
-- 
2.39.2


