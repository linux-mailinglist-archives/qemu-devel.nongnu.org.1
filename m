Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 238ED70FFB3
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:12:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vmA-0001ua-3T; Wed, 24 May 2023 17:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vm1-0001n4-Vu
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:58 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vm0-000250-2u
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6aML2WGpeCVXnlZ44aLvkE6+dZ7w5IDnEmwQGAZDfNU=; b=aPXfBIInDVY0U7m4wrjB5kg+gk
 HKmnKwQFFwAJbL26Woxs2YjL3JKs2XkpdQjekKJAhHgSXwwu5iPo0MMGLh2fJTzXRWuc2Xtq9Gaoe
 JthBH/neDeiTqf4H/FWNXckPppcRN0qHAcVSq5KP0RETsMUgAdBCoFa5kagPkK5cvf8KIjLSzXY81
 J0g6+ixx9KIFRGxjmRmtMdNjsjyLps98yXEkum1PLylybtJhDnvLGV+cMk5ozx4Hqs/Oxj6dV9dwg
 bBRngfdMK2w0pXVe6eNBFzDfYeihG7do6zVNKQlBv8mVW2Y/3Il4YbtKSqBOY8rZ4mCEx9cIDi53P
 mqWxxr0a4AxTBiPjhVaDyEZSruvxfOJjS6YosRDA6bfAdFJMysItzbabz6BH8sPseV+2jaCVCzxoG
 fGlr52IeQQrW/itueeW74Z0NCFDOsSjSKKz0IbJIYPEczhgQ5rubmFG7U8pC4vTmyWl6H5SDS4q7G
 1Y8g1HsFwFjvi9lTulYLghUasiSUlBqDfxG7Ty3yXGQo+SlR4XfqdkgchZRhlbOl0XcqdwI22EvO6
 LQFbpvuSByxgj1uKU2yDsFuzjzUbtoO53LkqHTm3538m6HaBjYkip1OOZdSmP9WgOgjVfkspMkDW3
 Zis/PYqICtFC/7lKLk8utp6hlv48zGStDbKChewrs=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vls-0005XR-CL; Wed, 24 May 2023 22:11:52 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:44 +0100
Message-Id: <20230524211104.686087-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 10/30] q800: add machine id register
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

MacOS reads this address to identify the hardware.

This is a basic implementation returning the ID of Quadra 800.

Details:

  http://mess.redump.net/mess/driver_info/mac_technical_notes

"There are 3 ID schemes [...]
 The third and most scalable is a machine ID register at 0x5ffffffc.
 The top word must be 0xa55a to be valid. Then bits 15-11 are 0 for
 consumer Macs, 1 for portables, 2 for high-end 68k, and 3 for high-end
 PowerPC. Bit 10 is 1 if additional ID bits appear elsewhere (e.g. in VIA1).
 The rest of the bits are a per-model identifier.

 Model                          Lower 16 bits of ID
...
 Quadra/Centris 610/650/800     0x2BAD"

Co-developed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 29 +++++++++++++++++++++++++++++
 include/hw/m68k/q800.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 456407898e..c1d4b98cc0 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -91,6 +91,9 @@
 #define Q800_NUBUS_SLOTS_AVAILABLE    (BIT(0x9) | BIT(0xc) | BIT(0xd) | \
                                        BIT(0xe))
 
+/* Quadra 800 machine ID */
+#define Q800_MACHINE_ID    0xa55a2bad
+
 /*
  * The GLUE (General Logic Unit) is an Apple custom integrated circuit chip
  * that performs a variety of functions (RAM management, clock generation, ...).
@@ -426,6 +429,27 @@ static const MemoryRegionOps macio_alias_ops = {
     },
 };
 
+static uint64_t machine_id_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return Q800_MACHINE_ID;
+}
+
+static void machine_id_write(void *opaque, hwaddr addr, uint64_t val,
+                             unsigned size)
+{
+    return;
+}
+
+static const MemoryRegionOps machine_id_ops = {
+    .read = machine_id_read,
+    .write = machine_id_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static void q800_machine_init(MachineState *machine)
 {
     Q800MachineState *m = Q800_MACHINE(machine);
@@ -488,6 +512,11 @@ static void q800_machine_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), IO_BASE + IO_SLICE,
                                 &m->macio_alias);
 
+    memory_region_init_io(&m->machine_id, NULL, &machine_id_ops, NULL,
+                          "Machine ID", 4);
+    memory_region_add_subregion(get_system_memory(), 0x5ffffffc,
+                                &m->machine_id);
+
     /* IRQ Glue */
     m->glue = qdev_new(TYPE_GLUE);
     object_property_set_link(OBJECT(m->glue), "cpu", OBJECT(m->cpu),
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index d0e37cc665..e57aec849a 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -37,6 +37,7 @@ struct Q800MachineState {
 
     MemoryRegion macio;
     MemoryRegion macio_alias;
+    MemoryRegion machine_id;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.30.2


