Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2F5744E6C
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 17:51:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFzK7-0004PZ-W8; Sun, 02 Jul 2023 11:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzK6-0004PA-AE
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:49:14 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzK4-0007R1-Dz
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NbYwBJKPZsJu1nxMNVD6PhDa955mRSYxjAw5kFMc3x8=; b=Q5TP8wULNMe1NR/Zsq3wTAUm7e
 Vo0VYnsWT/K6d4Z2aBdxEylyox5zQe5S5e7NOKptUv4ArT8yILT/fyCrVivAJ3vBpszBI25qWAa/N
 XBu4xfuCaQQnUbegBtgFrbuRsxJXbmhih3XNtFURRpezdlrqEKljqNpTva4OhZjEPgGOJvOz3c3Hi
 EgkEPBYXONVLKYMwi1DL6buH6K10I9kS9KoBbPDNnOtLKxAQ7IVhS1dQjzJmlLsHSHRuFTpqxrkJC
 r2R7FOpf6jhKyBPzTAeuwby0QIdPCchC6apjSodapnRtf/1mEsoN/OWxrkOTnqMWmgoXYCjdatEzP
 UOBq0b3mgczxr7YXiiu0yKTugaB+d97hGKS9tYtt1LOE/tYYQnIyYTMBlB2r60xobllapPrzajBWF
 HhxWzysNhAZgoCtxK+F/ZYV/rfP5ml7t92zeXAflawJNNUPaHEXVfQavuFMPIBD2Tx/vHazgujlTe
 oxHBZCHhufS9leXmnvK+GFmddAmD7GNWsQvY4FA+fIxMsy+q8mOV3/qED7NPZIVvdY92kbWRmQMnT
 bCQSbpPcz2ChKdB1hpCyOs+9ns3QYm6jqFB2lobryZoVXq0zA3WxGznYR8CucK+O8bBcT1f/3PAXU
 ScWeQ00l2jL4q5rIeDk+UWOdnSCvrq2OcRFkurb6U=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzJo-0001Ji-T4; Sun, 02 Jul 2023 16:49:00 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  2 Jul 2023 16:48:23 +0100
Message-Id: <20230702154838.722809-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 06/21] q800: allow accesses to RAM area even if less memory is
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
index 081b95e9cf..3209309173 100644
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
@@ -218,6 +221,27 @@ static const MemoryRegionOps machine_id_ops = {
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
@@ -262,7 +286,11 @@ static void q800_machine_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, &m->cpu);
 
     /* RAM */
-    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
+    memory_region_init_io(&m->ramio, OBJECT(machine), &ramio_ops, &m->ramio,
+                          "ram", RAM_SIZE);
+    memory_region_add_subregion(get_system_memory(), 0x0, &m->ramio);
+
+    memory_region_add_subregion(&m->ramio, 0, machine->ram);
 
     /*
      * Create container for all IO devices
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 98097165d9..04e4e0bce3 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -60,6 +60,7 @@ struct Q800MachineState {
     MacfbNubusState macfb;
     DJMEMCState djmemc;
     IOSBState iosb;
+    MemoryRegion ramio;
     MemoryRegion macio;
     MemoryRegion macio_alias;
     MemoryRegion machine_id;
-- 
2.30.2


