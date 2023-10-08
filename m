Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B447BCCAC
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:27:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCs-00085n-Mh; Sun, 08 Oct 2023 02:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCp-00083l-7w
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:23:59 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCn-0007kh-Et
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:23:58 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N0F9t-1rlTzx3v4J-00xHyB; Sun, 08
 Oct 2023 08:23:55 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 06/20] q800: allow accesses to RAM area even if less memory is
 available
Date: Sun,  8 Oct 2023 08:23:35 +0200
Message-ID: <20231008062349.2733552-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:c1upbkwUH4goI9U/W/eC0rJ7zWjvdUKkrn3UkDFXYssYouDQArr
 xbtuC2suGB6fCrObZzn3XB1KGOI9Rea3mEY/p19lOkEpRho7fon9VahfWYlfYseeWBmP4ZX
 j7xx93JqOQZp2QWXIylH5yRZTCbxJyaDwByQsrSpaQcvAyvcRf6XZ2F0BTXmqynxSKawAqV
 xxhJuN7RqDKb9GONq8Zkw==
UI-OutboundReport: notjunk:1;M01:P0:K4wCtnu2NCE=;xxJzv/a414yqd7UwKmKn/qJofUQ
 IqJ7HVQDISeTJPEOFBWbpducjqzCcxzL5C+ocgOzQWIcvzgiQc2BH8ORvu3qhu55VAGQpQIV6
 0FyA7grQHm8+yZG+h030AMdypTtl6gViczbIOsoxumYgbJr3VdJ9uF6SlXtroxkY3l6/AZpU2
 fO873p3lzXNr62CZaozCRbUsraiBJ6sCLLMz1pl6+spwoCIHiwbUMqifKcEAwYnDW5Sx7p8Hi
 rOrDkDw/K+Ad6UaPXbWKzSHZxZHhShhGGiQ+uUkLOqsnWn6n98LwmIMrmIZBeELLU+o8U1Eoz
 hi0aCnXV4pS29Zo+agAmLagtXtFzvotc6QTOXJIz1n3d0CqTTo5JqgJRtOlJcQRiTvdwnh905
 PMr2cEDoKi8yI7x3p11lzAT49J09y9IJIBHpeSUyl3gyLa0QTtaSYj6hWm3AsuFq3KzzJn4U8
 V0Tf0N9wNdXsgwyvL2hhRO9PPi7LgChX7Ko/zAdUIG5//xg9tybuQ6a67/KYTgiN+mkA3gnrA
 7mZawGZG5KclBJhhIqd5hrD2uTx4rOWkkiUHKzEM8xC5wVq7WcO4V7URZYmACNWETtX+I1Dth
 ENB44HEdUbdRYnR+mCpLUIPpKhfK79dQGRvTCP+D2QIPQG22nUALmErvvNvul+0FTW9PbzSY3
 VPQy3cg3valZnUUh7YnCeTUwLOgusN/1fuIsDF8LqpXQebmjydZIShw/9QbpCvEQRnI39Id0s
 n0N1SFESORXgN00yM6dQUiVoC0ygvyBiZQOgeTxqn1ljzt/kvwxOivuWhj+aDckHrwRQu9Xg9
 hV8POIjDYodygJA6ScV0IZLsbLI8ddFhpME1LVqALokaKnXY/jEKQVIlLNfVwl9xSY6qXQpqi
 xoVs1ILCdWPHYLA==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

MacOS attempts a series of writes and reads over the entire RAM area in order
to determine the amount of RAM within the machine. Allow accesses to the
entire RAM area ignoring writes and always reading zero for areas where there
is no physical RAM installed to allow MacOS to detect the memory size without
faulting.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231004083806.757242-7-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h |  1 +
 hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 98097165d954..04e4e0bce35a 100644
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
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 081b95e9cf66..3209309173f3 100644
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
-- 
2.41.0


