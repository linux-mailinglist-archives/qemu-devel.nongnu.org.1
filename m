Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 734437C962C
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 21:59:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrklc-0003vz-KL; Sat, 14 Oct 2023 15:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qrklZ-0003tO-F7
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 15:57:42 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qrklW-0004eO-Td
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 15:57:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 27502B80B78;
 Sat, 14 Oct 2023 19:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF8AC433C9;
 Sat, 14 Oct 2023 19:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697313456;
 bh=3FWfwVeYIqQFlYLkmYSJTxBaexgfoOzCMwvQaJxDeFg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=POommJBLIEC/JlcusqVHhpXzJ4ujbja/YNAW1IPPByLYr5+y0C/ijyjubqxWa1FNa
 odb7Fk2zNd+fRAwuC3IGLAHMkWsSo/DJtKep4PzmD2kxLYl98K+UmKI/l1grKHijE/
 yqR3Qt6/olJCjdRrfaOcWJzqivUcfLE+PCDJvzHGxruDwn6RhIXgtYnhmyzPx8jLvn
 1gb1H5/hlXYDDObQTlJph/it9dHC/M5wVJR4OjsNYaGdi5UyyOFUYfZn1A82qW2ef7
 53zZiXFg6dn8kDHWyMar59bldfCTFKFSLlQSNw1WTBJ+y1VcK6X4ihXXuue3KkzGDu
 f16Xcuyf1wRJw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 09/12] hw/hppa: Export machine name, BTLBs,
 power-button address via fw_cfg
Date: Sat, 14 Oct 2023 21:57:16 +0200
Message-ID: <20231014195719.151397-10-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014195719.151397-1-deller@kernel.org>
References: <20231014195719.151397-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.68.75; envelope-from=deller@kernel.org;
 helo=ams.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
 hw/hppa/machine.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index c6d8deffcf..be0caf4675 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -37,6 +37,7 @@
 
 #define enable_lasi_lan()       0
 
+static PCIBus *pci_bus;
 
 static void hppa_powerdown_req(Notifier *n, void *opaque)
 {
@@ -123,6 +124,8 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
     FWCfgState *fw_cfg;
     uint64_t val;
     const char qemu_version[] = QEMU_VERSION;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    int len;
 
     fw_cfg = fw_cfg_init_mem(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
@@ -137,8 +140,20 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
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
@@ -148,6 +163,8 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
                     g_memdup(qemu_version, sizeof(qemu_version)),
                     sizeof(qemu_version));
 
+    fw_cfg_add_extra_pci_roots(pci_bus, fw_cfg);
+
     return fw_cfg;
 }
 
-- 
2.41.0


