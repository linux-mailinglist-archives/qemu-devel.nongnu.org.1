Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD7282CA1D
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 06:59:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOX1e-0007QE-48; Sat, 13 Jan 2024 00:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1b-0007PT-P0
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:43 -0500
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1a-00082e-4O
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id CE914B81C20;
 Sat, 13 Jan 2024 05:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B62C433F1;
 Sat, 13 Jan 2024 05:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705125460;
 bh=IJ5Hk2c4pKpbKMUvwDlIeYXsDmcBPJqd+q6o7IPAq8A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IyUWrTXAX9cPKHJHwBHJQMUYI7EyhLBkz7tNhbGuDR+W2KuWTs8lBR9WJP4sxEh86
 wTZoCjHEscqG0gdtB2DbS5rWZd3Y7z39txIcZZXazDedGIJ93KoDamDOudpncqWscs
 rXoTjt4EP/cowHN0R4nZ5LVPxDCPMGWNgB5xNyDgNXWzazjUqGouLbemPuWaT4lv1+
 yJqCMqifQ1J9MnBhtJBLVK/wbNNi7TiilUTyaWYRW5GpVrH1SIlXIhFuquYzlQxaNx
 eCiJs3pmzcM90ycMp12xewBNrf86W21SsomFwJ/0hlH6fX5Xcg+XEVbWRKa+U3VsJD
 KYZIx4Rm4vPDQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bruno Haible <bruno@clisp.org>
Subject: [PULL 05/10] hw/hppa: Move software power button address back into PDC
Date: Sat, 13 Jan 2024 06:57:23 +0100
Message-ID: <20240113055729.4480-6-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113055729.4480-1-deller@kernel.org>
References: <20240113055729.4480-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=deller@kernel.org; helo=ams.source.kernel.org
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
---
 hw/hppa/machine.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

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
2.43.0


