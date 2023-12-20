Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C90F819FAE
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:18:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwSI-0007yG-K5; Wed, 20 Dec 2023 08:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRh-0007oD-Ff
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:09 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRf-0002MD-Fm
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zHQc7MpTe38WYcKVMtTi+B9+NqJxQtns6H2CrAk5GKw=; b=oCD292QdVTda8UptvuZWgvull4
 jPyNk0GLQgYyeLrfgtHEm2VpMoGhQTDvK+EbE0JlIWEgIBwdA4F6ItuxaC+GRQS40oASR0Udaxrcy
 sQpQ/vWjHMFc9tvLnwIK64M4/Y6E0po50ym/k90JSgTKqQqAA4LVjw/EK1t4jAooLqXOYdoAcF4Qs
 C0rvnGJVqV2stFy6tqfgncvAPhJkxAKHbD4JQvidJJxh+i0ClnH7aR5CWUSZ9P9Yf4uNKEztyzc7m
 8pd/8ejPm6pCB3ohB5uU8PdI1wX5wkXhBRGDDPLv7nCk3eAfY1PGb3RGAhVGdou0wqA7okPltCXCt
 NxAN6Ev4nTrWCF9tNRIHdzrCwuCjAu/w/CK6d0apCq0bxrJRQ7uCEs7nnb7hmvA4lALTHRvs6oIgz
 LEpPrZx90HjILa/ZUNMKzWB4HdKrAD4g3gKLFmfGwsgS+VxFXzf+pf/eQzxhpUh33te3mQLe4LNQB
 QkSgkQ6cBZLdLO6bfBWifqxTc5Tg4F+Adx3MsDFSoADiB2Rzv502inTueKIOspsV/vfv1kLZr7T7c
 tnMOL+tVLgSiRm5nlSYGF1KgY253x6KxyyVUMxmVNIEfsU/kq1AdhkBQuWpFBHNBJIDGFO2bTWP2k
 3koaJODJqBm5ehf3mgYnu3I9wUic20S2CGuVhAuF8=;
Received: from host86-147-134-9.range86-147.btcentralplus.com ([86.147.134.9]
 helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRD-0001qt-5g; Wed, 20 Dec 2023 13:16:43 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 20 Dec 2023 13:16:34 +0000
Message-Id: <20231220131641.592826-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.147.134.9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 04/11] next-cube.c: update scr_ops to properly use modern
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

Convert scr_ops to use the memory API directly renaming it to next_scr_ops,
marking it as DEVICE_BIG_ENDIAN, and handling any unaligned accesses.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 155 ++++++++++++++++----------------------------
 1 file changed, 55 insertions(+), 100 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index f73f563ac1..8ed9bac26d 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -335,81 +335,80 @@ static const MemoryRegionOps next_mmio_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static uint32_t scr_readb(NeXTPC *s, hwaddr addr)
+#define SCSICSR_ENABLE  0x01
+#define SCSICSR_RESET   0x02  /* reset scsi dma */
+#define SCSICSR_FIFOFL  0x04
+#define SCSICSR_DMADIR  0x08  /* if set, scsi to mem */
+#define SCSICSR_CPUDMA  0x10  /* if set, dma enabled */
+#define SCSICSR_INTMASK 0x20  /* if set, interrupt enabled */
+
+static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
 {
+    NeXTPC *s = NEXT_PC(opaque);
+    uint64_t val;
+
     switch (addr) {
     case 0x14108:
         DPRINTF("FD read @ %x\n", (unsigned int)addr);
-        return 0x40 | 0x04 | 0x2 | 0x1;
+        val = 0x40 | 0x04 | 0x2 | 0x1;
+        break;
+
     case 0x14020:
         DPRINTF("SCSI 4020  STATUS READ %X\n", s->scsi_csr_1);
-        return s->scsi_csr_1;
+        val = s->scsi_csr_1;
+        break;
 
     case 0x14021:
         DPRINTF("SCSI 4021 STATUS READ %X\n", s->scsi_csr_2);
-        return 0x40;
+        val = 0x40;
+        break;
 
     /*
      * These 4 registers are the hardware timer, not sure which register
-     * is the latch instead of data, but no problems so far
+     * is the latch instead of data, but no problems so far.
+     *
+     * Hack: We need to have the LSB change consistently to make it work
      */
-    case 0x1a000:
-        return 0xff & (clock() >> 24);
-    case 0x1a001:
-        return 0xff & (clock() >> 16);
-    case 0x1a002:
-        return 0xff & (clock() >> 8);
-    case 0x1a003:
-        /* Hack: We need to have this change consistently to make it work */
-        return 0xFF & clock();
+    case 0x1a000 ... 0x1a003:
+        val = extract32(clock(), (4 - (addr - 0x1a000) - size) << 3,
+                        size << 3);
+        break;
 
     /* For now return dummy byte to allow the Ethernet test to timeout */
     case 0x6000:
-        return 0xff;
+        val = 0xff;
+        break;
 
     default:
-        DPRINTF("BMAP Read B @ %x\n", (unsigned int)addr);
-        return 0;
+        DPRINTF("BMAP Read @ 0x%x size %u\n", (unsigned int)addr, size);
+        val = 0;
+        break;
     }
-}
 
-static uint32_t scr_readw(NeXTPC *s, hwaddr addr)
-{
-    DPRINTF("BMAP Read W @ %x\n", (unsigned int)addr);
-    return 0;
+    return val;
 }
 
-static uint32_t scr_readl(NeXTPC *s, hwaddr addr)
+static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
+                             unsigned size)
 {
-    DPRINTF("BMAP Read L @ %x\n", (unsigned int)addr);
-    return 0;
-}
-
-#define SCSICSR_ENABLE  0x01
-#define SCSICSR_RESET   0x02  /* reset scsi dma */
-#define SCSICSR_FIFOFL  0x04
-#define SCSICSR_DMADIR  0x08  /* if set, scsi to mem */
-#define SCSICSR_CPUDMA  0x10  /* if set, dma enabled */
-#define SCSICSR_INTMASK 0x20  /* if set, interrupt enabled */
+    NeXTPC *s = NEXT_PC(opaque);
 
-static void scr_writeb(NeXTPC *s, hwaddr addr, uint32_t value)
-{
     switch (addr) {
     case 0x14108:
         DPRINTF("FDCSR Write: %x\n", value);
-
-        if (value == 0x0) {
+        if (val == 0x0) {
             /* qemu_irq_raise(s->fd_irq[0]); */
         }
         break;
+
     case 0x14020: /* SCSI Control Register */
-        if (value & SCSICSR_FIFOFL) {
+        if (val & SCSICSR_FIFOFL) {
             DPRINTF("SCSICSR FIFO Flush\n");
             /* will have to add another irq to the esp if this is needed */
             /* esp_puflush_fifo(esp_g); */
         }
 
-        if (value & SCSICSR_ENABLE) {
+        if (val & SCSICSR_ENABLE) {
             DPRINTF("SCSICSR Enable\n");
             /*
              * qemu_irq_raise(s->scsi_dma);
@@ -423,17 +422,17 @@ static void scr_writeb(NeXTPC *s, hwaddr addr, uint32_t value)
          *     s->scsi_csr_1 &= ~SCSICSR_ENABLE;
          */
 
-        if (value & SCSICSR_RESET) {
+        if (val & SCSICSR_RESET) {
             DPRINTF("SCSICSR Reset\n");
             /* I think this should set DMADIR. CPUDMA and INTMASK to 0 */
             qemu_irq_raise(s->scsi_reset);
             s->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
             qemu_irq_lower(s->scsi_reset);
         }
-        if (value & SCSICSR_DMADIR) {
+        if (val & SCSICSR_DMADIR) {
             DPRINTF("SCSICSR DMAdir\n");
         }
-        if (value & SCSICSR_CPUDMA) {
+        if (val & SCSICSR_CPUDMA) {
             DPRINTF("SCSICSR CPUDMA\n");
             /* qemu_irq_raise(s->scsi_dma); */
             s->int_status |= 0x4000000;
@@ -442,11 +441,11 @@ static void scr_writeb(NeXTPC *s, hwaddr addr, uint32_t value)
             s->int_status &= ~(0x4000000);
             /* qemu_irq_lower(s->scsi_dma); */
         }
-        if (value & SCSICSR_INTMASK) {
+        if (val & SCSICSR_INTMASK) {
             DPRINTF("SCSICSR INTMASK\n");
             /*
              * int_mask &= ~0x1000;
-             * s->scsi_csr_1 |= value;
+             * s->scsi_csr_1 |= val;
              * s->scsi_csr_1 &= ~SCSICSR_INTMASK;
              * if (s->scsi_queued) {
              *     s->scsi_queued = 0;
@@ -456,72 +455,28 @@ static void scr_writeb(NeXTPC *s, hwaddr addr, uint32_t value)
         } else {
             /* int_mask |= 0x1000; */
         }
-        if (value & 0x80) {
+        if (val & 0x80) {
             /* int_mask |= 0x1000; */
             /* s->scsi_csr_1 |= 0x80; */
         }
-        DPRINTF("SCSICSR Write: %x\n", value);
-        /* s->scsi_csr_1 = value; */
-        return;
+        DPRINTF("SCSICSR Write: %x\n", val);
+        /* s->scsi_csr_1 = val; */
+        break;
+
     /* Hardware timer latch - not implemented yet */
     case 0x1a000:
     default:
-        DPRINTF("BMAP Write B @ %x with %x\n", (unsigned int)addr, value);
+        DPRINTF("BMAP Write @ 0x%x with 0x%x size %u\n", (unsigned int)addr,
+                val, size);
     }
 }
 
-static void scr_writew(NeXTPC *s, hwaddr addr, uint32_t value)
-{
-    DPRINTF("BMAP Write W @ %x with %x\n", (unsigned int)addr, value);
-}
-
-static void scr_writel(NeXTPC *s, hwaddr addr, uint32_t value)
-{
-    DPRINTF("BMAP Write L @ %x with %x\n", (unsigned int)addr, value);
-}
-
-static uint64_t scr_readfn(void *opaque, hwaddr addr, unsigned size)
-{
-    NeXTPC *s = NEXT_PC(opaque);
-
-    switch (size) {
-    case 1:
-        return scr_readb(s, addr);
-    case 2:
-        return scr_readw(s, addr);
-    case 4:
-        return scr_readl(s, addr);
-    default:
-        g_assert_not_reached();
-    }
-}
-
-static void scr_writefn(void *opaque, hwaddr addr, uint64_t value,
-                        unsigned size)
-{
-    NeXTPC *s = NEXT_PC(opaque);
-
-    switch (size) {
-    case 1:
-        scr_writeb(s, addr, value);
-        break;
-    case 2:
-        scr_writew(s, addr, value);
-        break;
-    case 4:
-        scr_writel(s, addr, value);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-static const MemoryRegionOps scr_ops = {
-    .read = scr_readfn,
-    .write = scr_writefn,
+static const MemoryRegionOps next_scr_ops = {
+    .read = next_scr_readfn,
+    .write = next_scr_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 #define NEXTDMA_SCSI(x)      (0x10 + x)
@@ -912,7 +867,7 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
 
     memory_region_init_io(&s->mmiomem, OBJECT(s), &next_mmio_ops, s,
                           "next.mmio", 0xd0000);
-    memory_region_init_io(&s->scrmem, OBJECT(s), &scr_ops, s,
+    memory_region_init_io(&s->scrmem, OBJECT(s), &next_scr_ops, s,
                           "next.scr", 0x20000);
     sysbus_init_mmio(sbd, &s->mmiomem);
     sysbus_init_mmio(sbd, &s->scrmem);
-- 
2.39.2


