Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6926A81CADA
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 14:46:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGfr0-0008EL-FH; Fri, 22 Dec 2023 08:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqX-0007UB-9w
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:45:50 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqV-0004IR-Em
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:45:49 -0500
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-40d2e5e8d1dso20177245e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 05:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703252746; x=1703857546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/NVRSuC8IHU+KhVwHnX0MDCAU1Oyabx6cnBab9zDOA=;
 b=fNeQfB0g9+YvH2/qxPEGM8RQdw/xhC9dDntFaJdMbiu88Jxjaom/RxCM+MZ+QhXrh+
 xeX2A9X4tAVjfOoCgzKvN6fXKpa7i1z4Zx9vqIOB61IZ8uljUJAnDJ/hvBy4965Lgzl3
 9zfRd36jgXtLzoP6xtyGIQDEvad9xq6suTG85qTcehc74pOYTjrQZvO598ED1V9BYtU4
 MNfN5zl8CEoj87EJLKBeeNXU9RXdRHnG5tPZpN7Golk1ss5nW4st7A36WpJTujbi8Fiy
 Om+LHwUUyK9POWl8rBaNFm00cnEeKTWeGp+++e6HGCYHoZNit0JvF4vwafVnMJuUVf81
 eLGg==
X-Gm-Message-State: AOJu0YxY5Bx1zXN5Scfea/JyrqjQVPuoAz0h/YiJwdyt2ARIaXa+b9fD
 Xxthi5To7I0cjCjV4eS/sn4SiNI0i1Y=
X-Google-Smtp-Source: AGHT+IG6zhQjBRE8u24q3U0mFo7z/W6dnwSC+knjh1ZNk4qX+SdF9uu3shalG5tUfI+eyvGOAvWGSw==
X-Received: by 2002:a05:600c:2217:b0:40d:3af0:7b0c with SMTP id
 z23-20020a05600c221700b0040d3af07b0cmr529112wml.13.1703252746005; 
 Fri, 22 Dec 2023 05:45:46 -0800 (PST)
Received: from fedora.. (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm7047333wmq.27.2023.12.22.05.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 05:45:45 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 03/11] next-cube.c: update mmio_ops to properly use modern
 memory API
Date: Fri, 22 Dec 2023 14:45:19 +0100
Message-ID: <20231222134527.15705-4-huth@tuxfamily.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222134527.15705-1-huth@tuxfamily.org>
References: <20231222134527.15705-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.52; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f52.google.com
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

Convert mmio_ops to use the memory API directly renaming it to next_mmio_ops,
marking it as DEVICE_BIG_ENDIAN, and handling any unaligned accesses.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20231220131641.592826-4-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
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
2.43.0


