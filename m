Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA00170FFB4
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:12:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vmJ-0002i0-4a; Wed, 24 May 2023 17:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmF-0002ea-QN
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmE-00027H-6v
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1eGvyhO8DEv9nzoj+qD2t88LY4O3C3sOFmnQjH5m238=; b=ChNZNqJMd9srND0b7+NlSo/CUh
 4P0FhPLDCk3qcmNEYUdZtBTFTPIUPyaJkuM3009CxZB0wtnbt8HBZWx/34sRzK6Vh+o3BVeOxr1nm
 AGJYgOcHiug55yvU4OGhMx2MW2Su59WKE23sumg6CGBB+Pageb5Uyn3jqij0bbdmCtbV7MheMBIx0
 Dq1tHF0hGLW5Ecsq/YbzakkMSOjl6wGVZvNQvt6p20nvLJf0sWAp/rwW9EoAGzp3ykuiYQ7r/sqNK
 xXAIaHkpfWRHJgPkqIySCX1mfu9nvzSGPc1G58lzgfDlLXU8vs8HkFtkmfcW1m0SejXHTVV2JxyiJ
 pLeLrnvmpUYdmrhyMzE/K5GlpueraGQ4hfjIGd2SW7201I6XASmydXWa2Y6P8Tf+bJ6ZksdbCsbgI
 j0e0xlxKQusxG0bm7cftNPwLNDfCruT2VaqE/YCaGdjhWMT2Skihshost3ZWnRY8rlnFIR3khJfA1
 weY+lnNU1/LKPDaVbnbySHM4qbIRQOXvRdGvlkS9eF0qXN3tNX8aLSknlgLkUNcDu1uyTG36+NaKS
 pKyyA8H4knKgCaRJ6oIBpWaXPAC+iBs13L6YqJq2r3E1v+zQQyT4pqCII0pldSozrZCPduZ6uWFbK
 /6o7fVcQzJEy9+KifpxdMN6IK/jRcZ3da5IupqSr4=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vm4-0005XR-Ge; Wed, 24 May 2023 22:12:04 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:47 +0100
Message-Id: <20230524211104.686087-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 13/30] q800: allow accesses to RAM area even if less memory is
 available
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

MacOS attempts a series of writes and reads over the entire RAM area in order
to determine the amount of RAM within the machine. Allow accesses to the
entire RAM area ignoring writes and always reading zero for areas where there
is no physical RAM installed to allow MacOS to detect the memory size without
faulting.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
 include/hw/m68k/q800.h |  1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 8310670ec2..d12aeaa20e 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -86,6 +86,9 @@
 
 #define MAC_CLOCK  3686418
 
+/* Size of whole RAM area */
+#define RAM_SIZE              0x40000000
+
 /*
  * Slot 0x9 is reserved for use by the in-built framebuffer whilst only
  * slots 0xc, 0xd and 0xe physically exist on the Quadra 800
@@ -452,6 +455,27 @@ static const MemoryRegionOps machine_id_ops = {
     },
 };
 
+static uint64_t ramio_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0x0;
+}
+
+static void ramio_write(void *opaque, hwaddr addr, uint64_t val,
+                        unsigned size)
+{
+    return;
+}
+
+static const MemoryRegionOps ramio_ops = {
+    .read = ramio_read,
+    .write = ramio_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
 static void q800_machine_init(MachineState *machine)
 {
     Q800MachineState *m = Q800_MACHINE(machine);
@@ -497,7 +521,11 @@ static void q800_machine_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, m->cpu);
 
     /* RAM */
-    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
+    memory_region_init_io(&m->ramio, NULL, &ramio_ops, &m->ramio,
+                          "ram", RAM_SIZE);
+    memory_region_add_subregion(get_system_memory(), 0x0, &m->ramio);
+
+    memory_region_add_subregion(&m->ramio, 0, machine->ram);
 
     /*
      * Create container for all IO devices
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index e57aec849a..0602d07d3d 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -34,6 +34,7 @@ struct Q800MachineState {
     MemoryRegion rom;
     DeviceState *glue;
     DeviceState *djmemc;
+    MemoryRegion ramio;
 
     MemoryRegion macio;
     MemoryRegion macio_alias;
-- 
2.30.2


