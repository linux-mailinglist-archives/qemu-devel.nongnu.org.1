Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D827B3997
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 20:03:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmHmd-0002wo-E0; Fri, 29 Sep 2023 14:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHmX-0002w4-9w
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 14:00:06 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHmR-0005Qa-Jw
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 14:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jy6K0cKwB1zQ7ttHjHuJHcM4wAstBU3zagIKsjH/jMQ=; b=pCeDic7tolKXkdDJHJMr3BrA8D
 Rhm5wVWJ0YLxw7FLapiSboG3T9mTtfgizmstJWFxZSwVOlEX08apuslIpufhxqJ4GRrTjSoEUCt5m
 L+UdA+oaI5tilxbZRlkKlVZaKvRY6TiWKOY9FIv62RxJjRArMh0h89bkA5XOEeo//u85YHMpOYtuR
 gzbJuzJ3hshIvDgxPT41+x6RUdYr6hxVkY9yvNRhCUrNxrB21h2nKnDJ/IPmBY7sH+LfBNRls5Oax
 oe4N0m0rMv1i8sB4V1M/uaeDx21eF0ZI4KxEY1/ZmrfREtE2dn/S0KewUCRjmxtD/NCTSTAddoFhk
 9IhbBuc0vzkMfDs4exwdHlivhKwQ9ttdJy5XP+Fvbvn2dLvTzR+zlTjaWBXlVNArXMlXo3pTrMg4g
 X5pVsmBMYuBSwCdjWDBTmnN8FFbhLuuBZKb0P+ZVT1KMUbupvC8Mm2xZS36WI/FA0IGMCO2CBtLTB
 wIqypqKonuM49jkwWh7T9FcRSsMo3ApfW4NFZ/0+5115WBBMt9q4dNkRpT1EFVaW8mOq+T0/flHyR
 k1iVK9d4VsUhmBRQhT+EqWW9YnQRISoWoDta/BfFpyCv2o546icql/bnjSgRDIXOuAiQiJJWJuqXF
 C7hgqmCSzWnoEnK3hukyGV3jX/CiIfABa77+65ThY=;
Received: from [2a00:23c4:8baf:5f00:c237:5189:8121:f752]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHmC-00033Y-QR; Fri, 29 Sep 2023 18:59:48 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Fri, 29 Sep 2023 18:59:03 +0100
Message-Id: <20230929175917.511133-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929175917.511133-1-mark.cave-ayland@ilande.co.uk>
References: <20230929175917.511133-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:c237:5189:8121:f752
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 06/20] q800: allow accesses to RAM area even if less memory
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


