Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B04379972E
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 11:51:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeuaO-0005i8-4l; Sat, 09 Sep 2023 05:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaN-0005hz-9O
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:03 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaL-0005H4-4u
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jy6K0cKwB1zQ7ttHjHuJHcM4wAstBU3zagIKsjH/jMQ=; b=1TuC8eHmxv6hWb71uZbslMe+1N
 Hl7FIe1Xg994acaFZtC5LlTmeVE1wATPOxPrB6iMpovtGEQKT78tqjkOtKz+MA/eUISkhwcKbJq8Y
 1sBOkfwAOCethTkEU1M638wGze7zNjj06INmG4Xg2BJ+hu+ITDHHEx3gp4nSVD/b7NWWSXeFh7aWS
 0QUwlSiGNcQ6d1VYHd+1Xt6neiI5JQT+7QSV6EsacAR1G44+WXJcUeoIkvFPNQsmNz8UypNCeVUN9
 LEomDxOYSNzNgCbPepyTtHJKQ8hUYDINyDr/VSMAllk6HWfnrSa+lFT5S7cBc7/XJjz6sUINgZ+oT
 8s0+HWqcCv/P+o9CeVLQjMyVX3tyUY7K+UgCvzxPU7A5Fbl8tPv5jN/EVQRZoX4UmHMLdb9DvqXSL
 EYbYjXXQq5HOTs8/5NuuWLX2pVuvTSVGVgv0KbBjJoDvurV31ZsQ58pMOVeXm4IjddbG1nonoYWHY
 f+SMLXKQhuk3ORvESt0M6amRIoO7KoP/Le/7sjZk6BmOL422+ur0p8/xW4RL8WGfI3J2ECd1Beg7R
 kYWju4AKp6QNcRMV+mvk9Y8ewdQSsW4w0Mh61L+0Yj8tpA6iF1+AvdNA9DHbtmaW43OUOGFKoAAe/
 CgOsU0HHvYcMkZXDoOgA49/3EBMl7Y4FCWryn9Ms0=;
Received: from [2a00:23c4:8baf:5f00:e007:7058:31bc:5be9]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaE-0000uO-RW; Sat, 09 Sep 2023 10:48:58 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sat,  9 Sep 2023 10:48:13 +0100
Message-Id: <20230909094827.33871-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:e007:7058:31bc:5be9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 06/20] q800: allow accesses to RAM area even if less memory
 is available
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

MacOS attempts a series of writes and reads over the entire RAM area in order
to determine the amount of RAM within the machine. Allow accesses to the
entire RAM area ignoring writes and always reading zero for areas where there
is no physical RAM installed to allow MacOS to detect the memory size without
faulting.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
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
2.39.2


