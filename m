Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1177CC7EA
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsmHt-00065d-I4; Tue, 17 Oct 2023 11:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qsmHn-00061P-I9
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:47:11 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qsmHk-000363-KU
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:47:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 63FF1B81EB0;
 Tue, 17 Oct 2023 15:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B78C433C8;
 Tue, 17 Oct 2023 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697557626;
 bh=P9lOt1zhr8EoLg+6EC27KcemcHD4V4dF6HhXq1h5+cg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IBhRy6+S3T29nSUPQDDwXavk7atmGCJAU+sosof6EprhLyY8drtuXlY7KMu82kSvk
 iJ21/JKSonAVB2LACpwg/PqSiZL5XzFwelWcNQG96G0j4b/QTeubS7Tg0ZHHnarhE0
 KZVroRCxVNddynQK5+1ttWHNUPOPAnEraylLHWuW73UolFhiLh6f/kL14ye6tHDKbM
 89MpMUGQwl1k0kP0W+mDAPvxD8g+9RkReCIQ1D4DZOgyrLfbz2T/H6n+oAvmhhyNne
 6ZJl4ERjSfjTwIV0yPe3AJeAhxqnBb1aShEnSDbRI84IekLaATDAzppBFrWMvRLcdC
 JTf8O25D+BgsA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 09/11] hw/hppa: Provide RTC and DebugOutputPort on CPU #0
Date: Tue, 17 Oct 2023 17:46:43 +0200
Message-ID: <20231017154645.95844-10-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017154645.95844-1-deller@kernel.org>
References: <20231017154645.95844-1-deller@kernel.org>
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


