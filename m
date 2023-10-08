Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 804AC7BCCA4
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:27:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCs-00085j-J6; Sun, 08 Oct 2023 02:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCo-000833-1C
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:23:58 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCl-0007k6-K6
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:23:57 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N1gac-1rZfDl0wvo-011yFc; Sun, 08
 Oct 2023 08:23:53 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/20] q800: add machine id register
Date: Sun,  8 Oct 2023 08:23:32 +0200
Message-ID: <20231008062349.2733552-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DE9WfMoSSpA1M6CzN4zlKPubll018lr+XkwM7z4ADtZO575TWgz
 jXjcU2uPYdwU/2doWF6hM8JA8ofEp5deY9hVOSbjh6d0VYnQrnUrxeWuHZnnGarQWjD1Yeb
 YojGl/Ic8+NyZnczEMB6bF/gMFRRd/Isa8GiiXs1f7kziFH3zdtua5k0Cn+xjNsSqzL7OxC
 iAiHMTAyq+JcFOYzbIcJQ==
UI-OutboundReport: notjunk:1;M01:P0:C0pjHAxsZlw=;lPnXTV0XIQP5Myl3mntmLOHJjXC
 y0HC0LCYvzrCl3lYXg5BbF2Z8DZbmYWzuS39Dj0owGyaqNu2mRMFyYiGm5vog/r0rpvWsT2pv
 DihwvgpgU4mKa8YU3GZdMBmdECSfSqI1zUCj60Vz5jQbDSTFwlH/y6Srl5w+yLnUZjTrO6oxf
 u1V28d4CDSdJ5R5H3XBS4ilYFU3NevqQpFrgcxICt8dj2TSsv1R20PpKE3kQ/k6vybhOYGnrr
 MlsJq40eld4E+ssaupvwSqNj1bgJH3XudJ6EEMWMoj4IG5P+bSiT75I4Q31Ahkdv991i8sS69
 prsXuRG7DpRoqwRiWsqHO4sw7vXfs42HMzz5qArpXtT6gGw7G/odqcY62nAOsnrykiflZ50VU
 SI3IdbwASlfT29GweJipEm4+FVJV+sD7nIpevTN86e3KFmaeLm9gCGLAcrK6RMv6JKKKEuytR
 FrFB21CtLgHnQXGfRBjfac80Q1E9H2BKrHlIaatEZZxNBuVf7eVRETfXFnVX/Sm08lpCTR4yN
 XbWTxdol7Gi1gZYpRZmklCPTxHWl2T7bsZEqZQfy72ZPrr2szGdmimpb1yFECahi5qLM7wCt4
 9poYz0Ks0GvdfCdBhmsB7DxRIGLmmv44n1Y+FX0JqR3PguIgomqzGM+DeGEYajdTBG4e/7wVL
 0P4rIe0aKKmhgQfKm8kifPKjOTPcir34P63kEDRjCm6ua5o1S5Cv/1XL6y5GAP3dU02UzPWug
 GBi4raxVJ+WRSep2JMjtQnsvVodPZTH7wqbhibgWRAC5MIaKZhnVcfL66va7labWekgawwnkC
 oXnlmfsWc4a19n0y2gWn3ofPyYRq+f6hZs1XYje+LKvT1N0DLKI0txIUoFhnugmN+w/rLPDbi
 GQA/u1Enh/gejQA==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.376, SPF_HELO_NONE=0.001,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004083806.757242-4-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h |  1 +
 hw/m68k/q800.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index f6ae4c1c4fd5..dd7d7a6f2c48 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -60,6 +60,7 @@ struct Q800MachineState {
     DJMEMCState djmemc;
     MemoryRegion macio;
     MemoryRegion macio_alias;
+    MemoryRegion machine_id;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index f9ecc1fbb094..ac8509ba6f7e 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -91,6 +91,9 @@
 #define Q800_NUBUS_SLOTS_AVAILABLE    (BIT(0x9) | BIT(0xc) | BIT(0xd) | \
                                        BIT(0xe))
 
+/* Quadra 800 machine ID */
+#define Q800_MACHINE_ID    0xa55a2bad
+
 
 static void main_cpu_reset(void *opaque)
 {
@@ -192,6 +195,27 @@ static const MemoryRegionOps macio_alias_ops = {
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
@@ -253,6 +277,11 @@ static void q800_machine_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), IO_BASE + IO_SLICE,
                                 &m->macio_alias);
 
+    memory_region_init_io(&m->machine_id, NULL, &machine_id_ops, NULL,
+                          "Machine ID", 4);
+    memory_region_add_subregion(get_system_memory(), 0x5ffffffc,
+                                &m->machine_id);
+
     /* IRQ Glue */
     object_initialize_child(OBJECT(machine), "glue", &m->glue, TYPE_GLUE);
     object_property_set_link(OBJECT(&m->glue), "cpu", OBJECT(&m->cpu),
-- 
2.41.0


