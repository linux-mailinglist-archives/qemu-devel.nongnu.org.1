Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C1B7D0529
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 00:55:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtbtI-00088D-Mz; Thu, 19 Oct 2023 18:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtbtG-00086m-QR
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 18:53:18 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtbtF-0002fg-6H
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 18:53:18 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5E4E261DC9;
 Thu, 19 Oct 2023 22:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8904C433CA;
 Thu, 19 Oct 2023 22:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697755995;
 bh=LtsT3+C0oZ5sExfPYx4Q4kZBMR5ZW+7e31OtsUD5Rzo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o3SJE88dBFhCbXqg3BNN6MYeVGATJ56DpKNX/uFD97tw89WUa4DSfkh8x4AtMEn2X
 +jq50xy5vSoArwhML+ez3tLkYhvKW/MBkJ82ntMFnSS1zqVFj3sPTxIZp1ymVWBcW9
 VDaOD95o1u0YXTAs8fTM1+ouiiT/aNp/nelWNUDdpYvyM4K93I/376gC8C3NFiGr86
 +O5ALxUqtJSwUtOYefQl7rFwgNQRdAeXjUP/IAPEBiHw4E084T61P6GZB350xYHH3g
 LjHGd0tW4UK7AhRVobO4Eel//rULvi+9efibL7KHRKjBk8vlMO3+SCiH/a5JpNffUg
 rSe1HbK1L8F9Q==
From: deller@kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/11] hw/hppa: Export machine name, BTLBs,
 power-button address via fw_cfg
Date: Fri, 20 Oct 2023 00:52:54 +0200
Message-ID: <20231019225257.383071-9-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019225257.383071-1-deller@kernel.org>
References: <20231019225257.383071-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Provide necessary info to SeaBIOS-hppa.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index c6d8deffcf..de925259ea 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -118,11 +118,13 @@ static void fw_cfg_boot_set(void *opaque, const char *boot_device,
     fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
 }
 
-static FWCfgState *create_fw_cfg(MachineState *ms)
+static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus)
 {
     FWCfgState *fw_cfg;
     uint64_t val;
     const char qemu_version[] = QEMU_VERSION;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    int len;
 
     fw_cfg = fw_cfg_init_mem(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
@@ -137,8 +139,20 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
     fw_cfg_add_file(fw_cfg, "/etc/cpu/tlb_entries",
                     g_memdup(&val, sizeof(val)), sizeof(val));
 
+    val = cpu_to_le64(HPPA_BTLB_ENTRIES);
+    fw_cfg_add_file(fw_cfg, "/etc/cpu/btlb_entries",
+                    g_memdup(&val, sizeof(val)), sizeof(val));
+
+    len = strlen(mc->name) + 1;
+    fw_cfg_add_file(fw_cfg, "/etc/hppa/machine",
+                    g_memdup(mc->name, len), len);
+
     val = cpu_to_le64(HPA_POWER_BUTTON);
-    fw_cfg_add_file(fw_cfg, "/etc/power-button-addr",
+    fw_cfg_add_file(fw_cfg, "/etc/hppa/power-button-addr",
+                    g_memdup(&val, sizeof(val)), sizeof(val));
+
+    val = cpu_to_le64(CPU_HPA + 24);
+    fw_cfg_add_file(fw_cfg, "/etc/hppa/DebugOutputPort",
                     g_memdup(&val, sizeof(val)), sizeof(val));
 
     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ms->boot_config.order[0]);
@@ -148,6 +162,8 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
                     g_memdup(qemu_version, sizeof(qemu_version)),
                     sizeof(qemu_version));
 
+    fw_cfg_add_extra_pci_roots(pci_bus, fw_cfg);
+
     return fw_cfg;
 }
 
@@ -250,7 +266,7 @@ static void machine_hppa_init(MachineState *machine)
                      parallel_hds[0]);
 
     /* fw_cfg configuration interface */
-    create_fw_cfg(machine);
+    create_fw_cfg(machine, pci_bus);
 
     /* SCSI disk setup. */
     dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
-- 
2.41.0


