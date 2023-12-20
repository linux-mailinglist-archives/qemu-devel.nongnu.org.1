Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF90819FB1
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:19:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwSG-0007qJ-MD; Wed, 20 Dec 2023 08:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRe-0007nf-9L
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:07 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRb-0002Jo-6R
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q3diASCzD2NEBvExrn6AkuPeQBnj32QkxYcxPM9tTXQ=; b=iLa9xT4bUpvQyGSTJMxIftn8aG
 odbMT2RMZPPyxHUebktE/0utGr4GPC2xkTkb9UflcI+KhiBBydE5D1ps2yVD7GI4A5jFWZeBmNFPl
 UWRDQjsoSwSqt8P0+oycawaGu41CZoi1keSj8JHDbPTW07E640bf28/xKO19LSVQknu8guBzrCc81
 uLq1v9dB1X6RWA3VyGBmU/WAyJbY0GAnAWKynE49gYsEvS7mxB3V0d/W23mtT17l97O4cgCopzkyA
 6AicInb9TsgPYNJoPbAfbbOkKI/utDF95bkxCVpQe4B9jt2fjhtxbc+x4R2aANFTdYK0OAzKgZO6M
 lor0QXnkCcpTBfh5ABaGj7hUmQ4+RDN8P1nPM+IfQ8iX+TamW0ydnqap6iji/k5LE2/clPG3mb5Wy
 oE69kKCdGlH6Y35If5OJUnEx1/bEa6hY0bobckihRVyzbJLi++PNx1Ya8C5hWVBZKUnsNbpogMak2
 N471OkNGq8iP6K+1hWeZOfww/JnKT9P9eXwC1megmI7PKeqtREaK+bxNy3BBTZK3fgqWhcGDS43kr
 X/a5ok2CEbT+3q3Mzc9D03II9QfcHzwn46M9IhpY6OnjeoyNhi51gizAJsj7ljyZwZs5ADbLfQp2x
 CWUZSIsFK9mfG7Jsev0jdglK+xYSH18GMxnjG3NhI=;
Received: from host86-147-134-9.range86-147.btcentralplus.com ([86.147.134.9]
 helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwR8-0001qt-RA; Wed, 20 Dec 2023 13:16:38 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 20 Dec 2023 13:16:33 +0000
Message-Id: <20231220131641.592826-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.147.134.9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 03/11] next-cube.c: update mmio_ops to properly use modern
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
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
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


