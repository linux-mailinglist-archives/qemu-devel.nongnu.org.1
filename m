Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6B681CADF
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 14:47:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGfr0-0008Cj-0O; Fri, 22 Dec 2023 08:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqa-0007XD-Jc
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:45:59 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqY-0004J2-2Y
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:45:51 -0500
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-40c6736d10fso22746305e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 05:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703252748; x=1703857548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MuaH3nTcp1lkH2knDw+i0gLPzkfnZkEdo5KVAaTg7Xk=;
 b=lB5acuGpHJRthBPydzYLqNjP1vxc/MJhVDViTXz+0U1L1LxAvyWTMPymyj18XMEG3C
 KPlm7ba6jdPbx81iO97n+bGm/bXyDl/x+EKS88yS9jdxcgetGha+BvhCnTz8HTAiXSqN
 zsCrcovA/eIua5mg16BW0LSDtZyRDik6vR3Q6cO0BXOGsziMcCuUPROE6auyp0h35cAm
 1ehjkvs6oGIQQRzl5btZCaRleGrZtnuCJtdNKTUfwlObsL52r8xilHxRSOWkKKvOfijk
 a8g/k5H4OlpVTXIuXLfy+wHFQtg05oT67iCDlcLxc5MsFCKqPLdOSc0pVJXfCASbPXM9
 9a/Q==
X-Gm-Message-State: AOJu0Yy8usvqCSTrIvH6RltqY2DEjRSdNsT14fZlE3sL8XDQ3djCBsKz
 uoNWKKhi1V+LF3clVc6bzJkR2Dru4jY=
X-Google-Smtp-Source: AGHT+IE15c/+eYgxXpNZ3q0ZY9yHlGQuQi+lgaE2IgAppMTP0PTQhNZRO74dZth6/RxZ8E9rjen0ZA==
X-Received: by 2002:a05:600c:358e:b0:40d:3dac:f3ec with SMTP id
 p14-20020a05600c358e00b0040d3dacf3ecmr925090wmq.96.1703252748194; 
 Fri, 22 Dec 2023 05:45:48 -0800 (PST)
Received: from fedora.. (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm7047333wmq.27.2023.12.22.05.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 05:45:47 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 04/11] next-cube.c: update scr_ops to properly use modern
 memory API
Date: Fri, 22 Dec 2023 14:45:20 +0100
Message-ID: <20231222134527.15705-5-huth@tuxfamily.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222134527.15705-1-huth@tuxfamily.org>
References: <20231222134527.15705-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.53; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f53.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The old QEMU memory accessors used in the original NextCube patch series had
separate functions for 1, 2 and 4 byte accessors. When the series was finally
merged a simple wrapper function was written to dispatch the memory accesses
using the original functions.

Convert scr_ops to use the memory API directly renaming it to next_scr_ops,
marking it as DEVICE_BIG_ENDIAN, and handling any unaligned accesses.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20231220131641.592826-5-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
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
2.43.0


