Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C7E81508D
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 21:02:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEEMh-0005rV-DG; Fri, 15 Dec 2023 15:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMI-0005q9-7Z
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:33 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEME-0002T1-0a
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v2qqudKwbwWl/5oI0cwS9BbqS1C4X2UFYRktiuJwoCU=; b=JWa8azEYvi21ZBa9b3B/cubRoo
 ezyUauvXhwCehkOtdm1k+5nV8HnM9m+qm9jqOXFD1XJoUQeF9LOoI5gjzwXA6+RieTAzqTQUBR+Mz
 fyDWSftA2dqSFoM1LwGqHHJbICpDx4wivdBD9MiYK+RiXlo/fAfYFztV/mBh4/etVOrOawR/aEuxa
 OiSenNuUlR3YgqVSNu5ZCPAdHvVRULUBUjO4IucutoYeeOO9u80GPXFV6DskVBPJ+bPlikDPaxzm0
 VOTlvTj8jHhDYUt5vPryiv9bznE4rZLyvcNCYhLALQJEIUYzOHmv5Yxrm32oFm4jC4jVDmpZ3Ef9k
 bK2v0yiEo99jSiq42nSjpQjSiP9Fj0lfdX9kH2zfNXD21LJij6he9cvLYpPbvIWtamdoCEhAJwflj
 3ujiForg0TbyfqJzLyBtKBcr7tSWqASTb2xQv5KB1ytrOP5SakL7R4z+cMkK/Z/B16j4ZHLYSwX0O
 FznGfkbUlHbyDs5AT9RyR1b309WsxZ7u7T18yIzr4E3G5Vntn7sB227snuFGFUOHYh4KEpNlkZiHa
 ilLi/Yx54YVXG9UD/NV1H4VanFOsVj6XZ3S4GQW4IJtcamHHC5bF7F/uC5c9jQXfXbjXxbzrUaYrG
 rMSn9OpU9SCGEaxJiidq8QEqZVNM2/HLTFVTvfB5o=;
Received: from [2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEELq-000AEs-EQ; Fri, 15 Dec 2023 20:00:03 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Fri, 15 Dec 2023 20:00:00 +0000
Message-Id: <20231215200009.346212-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 03/12] next-cube.c: update mmio_ops to properly use modern
 memory API
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

The old QEMU memory accessors used in the original NextCube patch series had
separate functions for 1, 2 and 4 byte accessors. When the series was finally
merged a simple wrapper function was written to dispatch the memory accesses
using the original functions.

Convert mmio_ops to use the memory API directly renaming it to next_mmio_ops,
marking it as DEVICE_BIG_ENDIAN, and handling any unaligned accesses.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 156 +++++++++++++-------------------------------
 1 file changed, 45 insertions(+), 111 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 87ddaf4329..f73f563ac1 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -255,150 +255,84 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
     old_scr2 = scr2_2;
 }
 
-static uint32_t mmio_readb(NeXTPC *s, hwaddr addr)
+static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
 {
-    switch (addr) {
-    case 0xc000:
-        return (s->scr1 >> 24) & 0xFF;
-    case 0xc001:
-        return (s->scr1 >> 16) & 0xFF;
-    case 0xc002:
-        return (s->scr1 >> 8)  & 0xFF;
-    case 0xc003:
-        return (s->scr1 >> 0)  & 0xFF;
-
-    case 0xd000:
-        return (s->scr2 >> 24) & 0xFF;
-    case 0xd001:
-        return (s->scr2 >> 16) & 0xFF;
-    case 0xd002:
-        return (s->scr2 >> 8)  & 0xFF;
-    case 0xd003:
-        return (s->scr2 >> 0)  & 0xFF;
-    case 0x14020:
-        DPRINTF("MMIO Read 0x4020\n");
-        return 0x7f;
-
-    default:
-        DPRINTF("MMIO Read B @ %"HWADDR_PRIx"\n", addr);
-        return 0x0;
-    }
-}
-
-static uint32_t mmio_readw(NeXTPC *s, hwaddr addr)
-{
-    switch (addr) {
-    default:
-        DPRINTF("MMIO Read W @ %"HWADDR_PRIx"\n", addr);
-        return 0x0;
-    }
-}
+    NeXTPC *s = NEXT_PC(opaque);
+    uint64_t val;
 
-static uint32_t mmio_readl(NeXTPC *s, hwaddr addr)
-{
     switch (addr) {
     case 0x7000:
         /* DPRINTF("Read INT status: %x\n", s->int_status); */
-        return s->int_status;
+        val = s->int_status;
+        break;
 
     case 0x7800:
         DPRINTF("MMIO Read INT mask: %x\n", s->int_mask);
-        return s->int_mask;
-
-    case 0xc000:
-        return s->scr1;
+        val = s->int_mask;
+        break;
 
-    case 0xd000:
-        return s->scr2;
+    case 0xc000 ... 0xc003:
+        val = extract32(s->scr1, (4 - (addr - 0xc000) - size) << 3,
+                        size << 3);
+        break;
 
-    default:
-        DPRINTF("MMIO Read L @ %"HWADDR_PRIx"\n", addr);
-        return 0x0;
-    }
-}
+    case 0xd000 ... 0xd003:
+        val = extract32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
+                        size << 3);
+        break;
 
-static void mmio_writeb(NeXTPC *s, hwaddr addr, uint32_t val)
-{
-    switch (addr) {
-    case 0xd003:
-        nextscr2_write(s, val, 1);
+    case 0x14020:
+        val = 0x7f;
         break;
+
     default:
-        DPRINTF("MMIO Write B @ %x with %x\n", (unsigned int)addr, val);
+        val = 0;
+        DPRINTF("MMIO Read @ 0x%"HWADDR_PRIx" size %d\n", addr, size);
+        break;
     }
 
+    return val;
 }
 
-static void mmio_writew(NeXTPC *s, hwaddr addr, uint32_t val)
+static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
+                            unsigned size)
 {
-    DPRINTF("MMIO Write W\n");
-}
+    NeXTPC *s = NEXT_PC(opaque);
 
-static void mmio_writel(NeXTPC *s, hwaddr addr, uint32_t val)
-{
     switch (addr) {
     case 0x7000:
-        DPRINTF("INT Status old: %x new: %x\n", s->int_status, val);
+        DPRINTF("INT Status old: %x new: %x\n", s->int_status,
+                (unsigned int)val);
         s->int_status = val;
         break;
+
     case 0x7800:
-        DPRINTF("INT Mask old: %x new: %x\n", s->int_mask, val);
+        DPRINTF("INT Mask old: %x new: %x\n", s->int_mask, (unsigned int)val);
         s->int_mask  = val;
         break;
-    case 0xc000:
-        DPRINTF("SCR1 Write: %x\n", val);
-        break;
-    case 0xd000:
-        nextscr2_write(s, val, 4);
-        break;
-
-    default:
-        DPRINTF("MMIO Write l @ %x with %x\n", (unsigned int)addr, val);
-    }
-}
-
-static uint64_t mmio_readfn(void *opaque, hwaddr addr, unsigned size)
-{
-    NeXTPC *s = NEXT_PC(opaque);
-
-    switch (size) {
-    case 1:
-        return mmio_readb(s, addr);
-    case 2:
-        return mmio_readw(s, addr);
-    case 4:
-        return mmio_readl(s, addr);
-    default:
-        g_assert_not_reached();
-    }
-}
-
-static void mmio_writefn(void *opaque, hwaddr addr, uint64_t value,
-                         unsigned size)
-{
-    NeXTPC *s = NEXT_PC(opaque);
 
-    switch (size) {
-    case 1:
-        mmio_writeb(s, addr, value);
+    case 0xc000 ... 0xc003:
+        DPRINTF("SCR1 Write: %x\n", (unsigned int)val);
+        s->scr1 = deposit32(s->scr1, (4 - (addr - 0xc000) - size) << 3,
+                            size << 3, val);
         break;
-    case 2:
-        mmio_writew(s, addr, value);
-        break;
-    case 4:
-        mmio_writel(s, addr, value);
+
+    case 0xd000 ... 0xd003:
+        nextscr2_write(s, val, size);
         break;
+
     default:
-        g_assert_not_reached();
+        DPRINTF("MMIO Write @ 0x%"HWADDR_PRIx " with 0x%x size %u\n", addr,
+                (unsigned int)val, size);
     }
 }
 
-static const MemoryRegionOps mmio_ops = {
-    .read = mmio_readfn,
-    .write = mmio_writefn,
+static const MemoryRegionOps next_mmio_ops = {
+    .read = next_mmio_read,
+    .write = next_mmio_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static uint32_t scr_readb(NeXTPC *s, hwaddr addr)
@@ -976,8 +910,8 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
 
     qdev_init_gpio_in(dev, next_irq, NEXT_NUM_IRQS);
 
-    memory_region_init_io(&s->mmiomem, OBJECT(s), &mmio_ops, s,
-                          "next.mmio", 0xD0000);
+    memory_region_init_io(&s->mmiomem, OBJECT(s), &next_mmio_ops, s,
+                          "next.mmio", 0xd0000);
     memory_region_init_io(&s->scrmem, OBJECT(s), &scr_ops, s,
                           "next.scr", 0x20000);
     sysbus_init_mmio(sbd, &s->mmiomem);
-- 
2.39.2


