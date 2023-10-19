Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D50B7D0527
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 00:55:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtbtL-0008Au-Ry; Thu, 19 Oct 2023 18:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtbtI-00088M-Gb
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 18:53:20 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtbtG-0002g3-21
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 18:53:20 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EC3136124A;
 Thu, 19 Oct 2023 22:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8106DC433C8;
 Thu, 19 Oct 2023 22:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697755996;
 bh=P9lOt1zhr8EoLg+6EC27KcemcHD4V4dF6HhXq1h5+cg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BUcJwrUc2pJYCaRx6ItSNt19pjmTx3fRf3nbZOgxaRZ1KQnt9BakSQI/UCRmGQLmv
 IdGxmh1BPwqMdosUSj20Kpr4pDE7LNO8Tdopj1cXMeeRvh5Q7V8r5ac3nMw1m9mhOJ
 DG2ioL+IVn5wKdSrSGZg51bqAYJdpiqDDaNHw5jforneb8kaK8TGDXVGs22/MS1nr2
 k+c4YtyrIQmrRlPmr2GKtuVWY4TVWNeRSKkAVGpJp33WVkxt3Zy6bwM2MMe2bUfCYv
 DzVSlFzzVLCr5yX8c/KhV1R0ezdwG6M05Hf3irZC0UCdb32iMyiB32tcnRJKxZUG3w
 wxUHIxCZj/F+g==
From: deller@kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/11] hw/hppa: Provide RTC and DebugOutputPort on CPU #0
Date: Fri, 20 Oct 2023 00:52:55 +0200
Message-ID: <20231019225257.383071-10-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019225257.383071-1-deller@kernel.org>
References: <20231019225257.383071-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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

For SeaBIOS-hppa, the RTC and DebugOutputPort were in the I/O area of
the LASI chip of the emulated B160L machine.
Since we will add other machines without a LASI chip, move the emulated
devices into the I/O area of CPU#0 instead.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/hppa_hardware.h |  1 -
 hw/hppa/machine.c       | 67 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index a5ac3dd0fd..a9be7bb851 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -18,7 +18,6 @@
 #define LASI_UART_HPA   0xffd05000
 #define LASI_SCSI_HPA   0xffd06000
 #define LASI_LAN_HPA    0xffd07000
-#define LASI_RTC_HPA    0xffd09000
 #define LASI_LPT_HPA    0xffd02000
 #define LASI_AUDIO_HPA  0xffd04000
 #define LASI_PS2KBD_HPA 0xffd08000
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index de925259ea..d459ba631b 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -103,6 +103,63 @@ static ISABus *hppa_isa_bus(void)
     return isa_bus;
 }
 
+/*
+ * Helper functions to emulate RTC clock and DebugOutputPort
+ */
+static time_t rtc_ref;
+
+static uint64_t io_cpu_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t val = 0;
+
+    switch (addr) {
+    case 0:             /* RTC clock */
+        val = time(NULL);
+        val += rtc_ref;
+        break;
+    case 8:             /* DebugOutputPort */
+        return 0xe9;    /* readback */
+    }
+    return val;
+}
+
+static void io_cpu_write(void *opaque, hwaddr addr,
+                         uint64_t val, unsigned size)
+{
+    unsigned char ch;
+    Chardev *debugout;
+
+    switch (addr) {
+    case 0:             /* RTC clock */
+        rtc_ref = val - time(NULL);
+        break;
+    case 8:             /* DebugOutputPort */
+        ch = val;
+        debugout = serial_hd(0);
+        if (debugout) {
+            qemu_chr_fe_write_all(debugout->be, &ch, 1);
+        } else {
+            fprintf(stderr, "%c", ch);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps hppa_io_helper_ops = {
+    .read = io_cpu_read,
+    .write = io_cpu_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+
 static uint64_t cpu_hppa_to_phys(void *opaque, uint64_t addr)
 {
     addr &= (0x10000000 - 1);
@@ -151,6 +208,10 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus)
     fw_cfg_add_file(fw_cfg, "/etc/hppa/power-button-addr",
                     g_memdup(&val, sizeof(val)), sizeof(val));
 
+    val = cpu_to_le64(CPU_HPA + 16);
+    fw_cfg_add_file(fw_cfg, "/etc/hppa/rtc-addr",
+                    g_memdup(&val, sizeof(val)), sizeof(val));
+
     val = cpu_to_le64(CPU_HPA + 24);
     fw_cfg_add_file(fw_cfg, "/etc/hppa/DebugOutputPort",
                     g_memdup(&val, sizeof(val)), sizeof(val));
@@ -222,6 +283,12 @@ static void machine_hppa_init(MachineState *machine)
         g_free(name);
     }
 
+    /* RTC and DebugOutputPort on CPU #0 */
+    cpu_region = g_new(MemoryRegion, 1);
+    memory_region_init_io(cpu_region, OBJECT(cpu[0]), &hppa_io_helper_ops,
+                          cpu[0], "cpu0-io-rtc", 2 * sizeof(uint64_t));
+    memory_region_add_subregion(addr_space, CPU_HPA + 16, cpu_region);
+
     /* Main memory region. */
     if (machine->ram_size > 3 * GiB) {
         error_report("RAM size is currently restricted to 3GB");
-- 
2.41.0


