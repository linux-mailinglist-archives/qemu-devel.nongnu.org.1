Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6A696A3F4
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Sep 2024 18:14:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5a-0001P7-FM; Tue, 03 Sep 2024 12:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5Y-0001El-1h
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:04 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5T-0002x4-Rx
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:03 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42bbbff40bbso37453495e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379738; x=1725984538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fOfef+JkPcTbeQrgH3GrXKLVyKFTqxllcvWZvuS9QLo=;
 b=iiqJ70zBrNWXRVWGU2ADE9eLipjpe6KmDoQEh693yW27ijWz57U6O9pQ+kQM/YrSk7
 HkjVkybLqfuRR1uK1P29B5pg6QGsINU64zx83gKM/C/EAUUvIfGAzzq0V5ct9vaIq3Vb
 IShtPoiR2hmsP9QQuhgmCofM0tsBOnRgo5lWUl8NdCDWn7zzz6+U+GxIdRGo9Mn3mxPB
 YGxz/vwfYr8NpaPOoWIHJttRl9IIkwIejXJhW4Q8Ogryi/XDOY79iJ8y5hT+5DslUsvK
 AlLB4zo+2m9ZqI4XN05m7/783dSslbDgrwCZos31Q1FiSqlM+BeKRqgjYqLoytGg5u6q
 UVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379738; x=1725984538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOfef+JkPcTbeQrgH3GrXKLVyKFTqxllcvWZvuS9QLo=;
 b=YCA7xKtnkRGF7N1mwdQNUHtxHTjjSAf9Jry7nZQV5QD6ZfrUtchWS5aaPHDNuG0EOU
 PH1XJmb8e/8SuxI+AfhM4/WG+lJS75ShgNuhO96kEsYO4/BqW/9ByyF+qMaoe8+9IKfD
 sO4rSNkhxdYzX291UGPbCn+Vpss/5mjVW2IX7lhz9vst8vYm2Z+mE1+ipGKu4UPYxoDZ
 w5vFZeTOYQ4hht7rHl1XC2liNBMA8Jb1BPF1jhOdczzf9RkTYJANk2ez5t7iQE23Tus6
 o3cR4sgzNptMFAZWdtola4fTzgiJd5YPHn/GHnFupKvYJ2E6RP3ihaDtZ4E5vVx+wn2E
 egVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzZEmGyusns/oxAFsjYbEAz6LANQCQ4XcA2uEcqoEpyvf6kWO4+hW9m6vY7PnYe0AB+8YQG3cRYNfm@nongnu.org
X-Gm-Message-State: AOJu0YxP/OEwcs+TbWDAF7FsiQ9cPqatuWh0rNZDMn7ZrZIHZK1LoXX+
 PGrgftGI5dSkHxitoyIGDR7jYIzTDNcF4+Kl2YVPGAIPtR17RiY546rVmel+Ez0=
X-Google-Smtp-Source: AGHT+IFTSMnzsSZgkuph2JBbKk55HKzV9Vi2f8PjTlN2Y6JLmifXHklOS5vFLCf5AaI7oonGbDFyew==
X-Received: by 2002:a05:600c:3c9e:b0:426:627e:37af with SMTP id
 5b1f17b1804b1-42bbb10d2d5mr98685375e9.3.1725379738076; 
 Tue, 03 Sep 2024 09:08:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 43/53] hw/misc: Remove omap_gpmc
Date: Tue,  3 Sep 2024 17:07:41 +0100
Message-Id: <20240903160751.4100218-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The omap_gpmc device is only in OMAP2, which we are removing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h |  11 -
 hw/misc/omap_gpmc.c   | 898 ------------------------------------------
 hw/misc/meson.build   |   1 -
 3 files changed, 910 deletions(-)
 delete mode 100644 hw/misc/omap_gpmc.c

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index dcd338c7c49..0cbbf2fecb5 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -147,15 +147,6 @@ hwaddr omap_l4_region_base(struct omap_target_agent_s *ta,
 hwaddr omap_l4_region_size(struct omap_target_agent_s *ta,
                                        int region);
 
-/* OMAP2 general purpose memory controller */
-struct omap_gpmc_s;
-struct omap_gpmc_s *omap_gpmc_init(struct omap_mpu_state_s *mpu,
-                                   hwaddr base,
-                                   qemu_irq irq, qemu_irq drq);
-void omap_gpmc_reset(struct omap_gpmc_s *s);
-void omap_gpmc_attach(struct omap_gpmc_s *s, int cs, MemoryRegion *iomem);
-void omap_gpmc_attach_nand(struct omap_gpmc_s *s, int cs, DeviceState *nand);
-
 /*
  * Common IRQ numbers for level 1 interrupt handler
  * See /usr/include/asm-arm/arch-omap/irqs.h in Linux.
@@ -948,8 +939,6 @@ struct omap_mpu_state_s {
     struct omap_gp_timer_s *gptimer[12];
     struct omap_synctimer_s *synctimer;
 
-    struct omap_gpmc_s *gpmc;
-
     struct omap_mcspi_s *mcspi[2];
 
     struct omap_dss_s *dss;
diff --git a/hw/misc/omap_gpmc.c b/hw/misc/omap_gpmc.c
deleted file mode 100644
index 67158eb1649..00000000000
--- a/hw/misc/omap_gpmc.c
+++ /dev/null
@@ -1,898 +0,0 @@
-/*
- * TI OMAP general purpose memory controller emulation.
- *
- * Copyright (C) 2007-2009 Nokia Corporation
- * Original code written by Andrzej Zaborowski <andrew@openedhand.com>
- * Enhancements for OMAP3 and NAND support written by Juha Riihimäki
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 or
- * (at your option) any later version of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "hw/irq.h"
-#include "hw/block/flash.h"
-#include "hw/arm/omap.h"
-#include "exec/memory.h"
-#include "exec/address-spaces.h"
-
-/* General-Purpose Memory Controller */
-struct omap_gpmc_s {
-    qemu_irq irq;
-    qemu_irq drq;
-    MemoryRegion iomem;
-    int accept_256;
-
-    uint8_t revision;
-    uint8_t sysconfig;
-    uint16_t irqst;
-    uint16_t irqen;
-    uint16_t lastirq;
-    uint16_t timeout;
-    uint16_t config;
-    struct omap_gpmc_cs_file_s {
-        uint32_t config[7];
-        MemoryRegion *iomem;
-        MemoryRegion container;
-        MemoryRegion nandiomem;
-        DeviceState *dev;
-    } cs_file[8];
-    int ecc_cs;
-    int ecc_ptr;
-    uint32_t ecc_cfg;
-    ECCState ecc[9];
-    struct prefetch {
-        uint32_t config1; /* GPMC_PREFETCH_CONFIG1 */
-        uint32_t transfercount; /* GPMC_PREFETCH_CONFIG2:TRANSFERCOUNT */
-        int startengine; /* GPMC_PREFETCH_CONTROL:STARTENGINE */
-        int fifopointer; /* GPMC_PREFETCH_STATUS:FIFOPOINTER */
-        int count; /* GPMC_PREFETCH_STATUS:COUNTVALUE */
-        MemoryRegion iomem;
-        uint8_t fifo[64];
-    } prefetch;
-};
-
-#define OMAP_GPMC_8BIT 0
-#define OMAP_GPMC_16BIT 1
-#define OMAP_GPMC_NOR 0
-#define OMAP_GPMC_NAND 2
-
-static int omap_gpmc_devtype(struct omap_gpmc_cs_file_s *f)
-{
-    return (f->config[0] >> 10) & 3;
-}
-
-static int omap_gpmc_devsize(struct omap_gpmc_cs_file_s *f)
-{
-    /* devsize field is really 2 bits but we ignore the high
-     * bit to ensure consistent behaviour if the guest sets
-     * it (values 2 and 3 are reserved in the TRM)
-     */
-    return (f->config[0] >> 12) & 1;
-}
-
-/* Extract the chip-select value from the prefetch config1 register */
-static int prefetch_cs(uint32_t config1)
-{
-    return (config1 >> 24) & 7;
-}
-
-static int prefetch_threshold(uint32_t config1)
-{
-    return (config1 >> 8) & 0x7f;
-}
-
-static void omap_gpmc_int_update(struct omap_gpmc_s *s)
-{
-    /* The TRM is a bit unclear, but it seems to say that
-     * the TERMINALCOUNTSTATUS bit is set only on the
-     * transition when the prefetch engine goes from
-     * active to inactive, whereas the FIFOEVENTSTATUS
-     * bit is held high as long as the fifo has at
-     * least THRESHOLD bytes available.
-     * So we do the latter here, but TERMINALCOUNTSTATUS
-     * is set elsewhere.
-     */
-    if (s->prefetch.fifopointer >= prefetch_threshold(s->prefetch.config1)) {
-        s->irqst |= 1;
-    }
-    if ((s->irqen & s->irqst) != s->lastirq) {
-        s->lastirq = s->irqen & s->irqst;
-        qemu_set_irq(s->irq, s->lastirq);
-    }
-}
-
-static void omap_gpmc_dma_update(struct omap_gpmc_s *s, int value)
-{
-    if (s->prefetch.config1 & 4) {
-        qemu_set_irq(s->drq, value);
-    }
-}
-
-/* Access functions for when a NAND-like device is mapped into memory:
- * all addresses in the region behave like accesses to the relevant
- * GPMC_NAND_DATA_i register (which is actually implemented to call these)
- */
-static uint64_t omap_nand_read(void *opaque, hwaddr addr,
-                               unsigned size)
-{
-    struct omap_gpmc_cs_file_s *f = opaque;
-    uint64_t v;
-    nand_setpins(f->dev, 0, 0, 0, 1, 0);
-    switch (omap_gpmc_devsize(f)) {
-    case OMAP_GPMC_8BIT:
-        v = nand_getio(f->dev);
-        if (size == 1) {
-            return v;
-        }
-        v |= (nand_getio(f->dev) << 8);
-        if (size == 2) {
-            return v;
-        }
-        v |= (nand_getio(f->dev) << 16);
-        v |= (nand_getio(f->dev) << 24);
-        return v;
-    case OMAP_GPMC_16BIT:
-        v = nand_getio(f->dev);
-        if (size == 1) {
-            /* 8 bit read from 16 bit device : probably a guest bug */
-            return v & 0xff;
-        }
-        if (size == 2) {
-            return v;
-        }
-        v |= (nand_getio(f->dev) << 16);
-        return v;
-    default:
-        abort();
-    }
-}
-
-static void omap_nand_setio(DeviceState *dev, uint64_t value,
-                            int nandsize, int size)
-{
-    /* Write the specified value to the NAND device, respecting
-     * both size of the NAND device and size of the write access.
-     */
-    switch (nandsize) {
-    case OMAP_GPMC_8BIT:
-        switch (size) {
-        case 1:
-            nand_setio(dev, value & 0xff);
-            break;
-        case 2:
-            nand_setio(dev, value & 0xff);
-            nand_setio(dev, (value >> 8) & 0xff);
-            break;
-        case 4:
-        default:
-            nand_setio(dev, value & 0xff);
-            nand_setio(dev, (value >> 8) & 0xff);
-            nand_setio(dev, (value >> 16) & 0xff);
-            nand_setio(dev, (value >> 24) & 0xff);
-            break;
-        }
-        break;
-    case OMAP_GPMC_16BIT:
-        switch (size) {
-        case 1:
-            /* writing to a 16bit device with 8bit access is probably a guest
-             * bug; pass the value through anyway.
-             */
-        case 2:
-            nand_setio(dev, value & 0xffff);
-            break;
-        case 4:
-        default:
-            nand_setio(dev, value & 0xffff);
-            nand_setio(dev, (value >> 16) & 0xffff);
-            break;
-        }
-        break;
-    }
-}
-
-static void omap_nand_write(void *opaque, hwaddr addr,
-                            uint64_t value, unsigned size)
-{
-    struct omap_gpmc_cs_file_s *f = opaque;
-    nand_setpins(f->dev, 0, 0, 0, 1, 0);
-    omap_nand_setio(f->dev, value, omap_gpmc_devsize(f), size);
-}
-
-static const MemoryRegionOps omap_nand_ops = {
-    .read = omap_nand_read,
-    .write = omap_nand_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static void fill_prefetch_fifo(struct omap_gpmc_s *s)
-{
-    /* Fill the prefetch FIFO by reading data from NAND.
-     * We do this synchronously, unlike the hardware which
-     * will do this asynchronously. We refill when the
-     * FIFO has THRESHOLD bytes free, and we always refill
-     * as much data as possible starting at the top end
-     * of the FIFO.
-     * (We have to refill at THRESHOLD rather than waiting
-     * for the FIFO to empty to allow for the case where
-     * the FIFO size isn't an exact multiple of THRESHOLD
-     * and we're doing DMA transfers.)
-     * This means we never need to handle wrap-around in
-     * the fifo-reading code, and the next byte of data
-     * to read is always fifo[63 - fifopointer].
-     */
-    int fptr;
-    int cs = prefetch_cs(s->prefetch.config1);
-    int is16bit = (((s->cs_file[cs].config[0] >> 12) & 3) != 0);
-    int bytes;
-    /* Don't believe the bit of the OMAP TRM that says that COUNTVALUE
-     * and TRANSFERCOUNT are in units of 16 bit words for 16 bit NAND.
-     * Instead believe the bit that says it is always a byte count.
-     */
-    bytes = 64 - s->prefetch.fifopointer;
-    if (bytes > s->prefetch.count) {
-        bytes = s->prefetch.count;
-    }
-    if (is16bit) {
-        bytes &= ~1;
-    }
-
-    s->prefetch.count -= bytes;
-    s->prefetch.fifopointer += bytes;
-    fptr = 64 - s->prefetch.fifopointer;
-    /* Move the existing data in the FIFO so it sits just
-     * before what we're about to read in
-     */
-    while (fptr < (64 - bytes)) {
-        s->prefetch.fifo[fptr] = s->prefetch.fifo[fptr + bytes];
-        fptr++;
-    }
-    while (fptr < 64) {
-        if (is16bit) {
-            uint32_t v = omap_nand_read(&s->cs_file[cs], 0, 2);
-            s->prefetch.fifo[fptr++] = v & 0xff;
-            s->prefetch.fifo[fptr++] = (v >> 8) & 0xff;
-        } else {
-            s->prefetch.fifo[fptr++] = omap_nand_read(&s->cs_file[cs], 0, 1);
-        }
-    }
-    if (s->prefetch.startengine && (s->prefetch.count == 0)) {
-        /* This was the final transfer: raise TERMINALCOUNTSTATUS */
-        s->irqst |= 2;
-        s->prefetch.startengine = 0;
-    }
-    /* If there are any bytes in the FIFO at this point then
-     * we must raise a DMA request (either this is a final part
-     * transfer, or we filled the FIFO in which case we certainly
-     * have THRESHOLD bytes available)
-     */
-    if (s->prefetch.fifopointer != 0) {
-        omap_gpmc_dma_update(s, 1);
-    }
-    omap_gpmc_int_update(s);
-}
-
-/* Access functions for a NAND-like device when the prefetch/postwrite
- * engine is enabled -- all addresses in the region behave alike:
- * data is read or written to the FIFO.
- */
-static uint64_t omap_gpmc_prefetch_read(void *opaque, hwaddr addr,
-                                        unsigned size)
-{
-    struct omap_gpmc_s *s = opaque;
-    uint32_t data;
-    if (s->prefetch.config1 & 1) {
-        /* The TRM doesn't define the behaviour if you read from the
-         * FIFO when the prefetch engine is in write mode. We choose
-         * to always return zero.
-         */
-        return 0;
-    }
-    /* Note that trying to read an empty fifo repeats the last byte */
-    if (s->prefetch.fifopointer) {
-        s->prefetch.fifopointer--;
-    }
-    data = s->prefetch.fifo[63 - s->prefetch.fifopointer];
-    if (s->prefetch.fifopointer ==
-        (64 - prefetch_threshold(s->prefetch.config1))) {
-        /* We've drained THRESHOLD bytes now. So deassert the
-         * DMA request, then refill the FIFO (which will probably
-         * assert it again.)
-         */
-        omap_gpmc_dma_update(s, 0);
-        fill_prefetch_fifo(s);
-    }
-    omap_gpmc_int_update(s);
-    return data;
-}
-
-static void omap_gpmc_prefetch_write(void *opaque, hwaddr addr,
-                                     uint64_t value, unsigned size)
-{
-    struct omap_gpmc_s *s = opaque;
-    int cs = prefetch_cs(s->prefetch.config1);
-    if ((s->prefetch.config1 & 1) == 0) {
-        /* The TRM doesn't define the behaviour of writing to the
-         * FIFO when the prefetch engine is in read mode. We
-         * choose to ignore the write.
-         */
-        return;
-    }
-    if (s->prefetch.count == 0) {
-        /* The TRM doesn't define the behaviour of writing to the
-         * FIFO if the transfer is complete. We choose to ignore.
-         */
-        return;
-    }
-    /* The only reason we do any data buffering in postwrite
-     * mode is if we are talking to a 16 bit NAND device, in
-     * which case we need to buffer the first byte of the
-     * 16 bit word until the other byte arrives.
-     */
-    int is16bit = (((s->cs_file[cs].config[0] >> 12) & 3) != 0);
-    if (is16bit) {
-        /* fifopointer alternates between 64 (waiting for first
-         * byte of word) and 63 (waiting for second byte)
-         */
-        if (s->prefetch.fifopointer == 64) {
-            s->prefetch.fifo[0] = value;
-            s->prefetch.fifopointer--;
-        } else {
-            value = (value << 8) | s->prefetch.fifo[0];
-            omap_nand_write(&s->cs_file[cs], 0, value, 2);
-            s->prefetch.count--;
-            s->prefetch.fifopointer = 64;
-        }
-    } else {
-        /* Just write the byte : fifopointer remains 64 at all times */
-        omap_nand_write(&s->cs_file[cs], 0, value, 1);
-        s->prefetch.count--;
-    }
-    if (s->prefetch.count == 0) {
-        /* Final transfer: raise TERMINALCOUNTSTATUS */
-        s->irqst |= 2;
-        s->prefetch.startengine = 0;
-    }
-    omap_gpmc_int_update(s);
-}
-
-static const MemoryRegionOps omap_prefetch_ops = {
-    .read = omap_gpmc_prefetch_read,
-    .write = omap_gpmc_prefetch_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .impl.min_access_size = 1,
-    .impl.max_access_size = 1,
-};
-
-static MemoryRegion *omap_gpmc_cs_memregion(struct omap_gpmc_s *s, int cs)
-{
-    /* Return the MemoryRegion* to map/unmap for this chipselect */
-    struct omap_gpmc_cs_file_s *f = &s->cs_file[cs];
-    if (omap_gpmc_devtype(f) == OMAP_GPMC_NOR) {
-        return f->iomem;
-    }
-    if ((s->prefetch.config1 & 0x80) &&
-        (prefetch_cs(s->prefetch.config1) == cs)) {
-        /* The prefetch engine is enabled for this CS: map the FIFO */
-        return &s->prefetch.iomem;
-    }
-    return &f->nandiomem;
-}
-
-static void omap_gpmc_cs_map(struct omap_gpmc_s *s, int cs)
-{
-    struct omap_gpmc_cs_file_s *f = &s->cs_file[cs];
-    uint32_t mask = (f->config[6] >> 8) & 0xf;
-    uint32_t base = f->config[6] & 0x3f;
-    uint32_t size;
-
-    if (!f->iomem && !f->dev) {
-        return;
-    }
-
-    if (!(f->config[6] & (1 << 6))) {
-        /* Do nothing unless CSVALID */
-        return;
-    }
-
-    /* TODO: check for overlapping regions and report access errors */
-    if (mask != 0x8 && mask != 0xc && mask != 0xe && mask != 0xf
-         && !(s->accept_256 && !mask)) {
-        fprintf(stderr, "%s: invalid chip-select mask address (0x%x)\n",
-                 __func__, mask);
-    }
-
-    base <<= 24;
-    size = (0x0fffffff & ~(mask << 24)) + 1;
-    /* TODO: rather than setting the size of the mapping (which should be
-     * constant), the mask should cause wrapping of the address space, so
-     * that the same memory becomes accessible at every <i>size</i> bytes
-     * starting from <i>base</i>.  */
-    memory_region_init(&f->container, NULL, "omap-gpmc-file", size);
-    memory_region_add_subregion(&f->container, 0,
-                                omap_gpmc_cs_memregion(s, cs));
-    memory_region_add_subregion(get_system_memory(), base,
-                                &f->container);
-}
-
-static void omap_gpmc_cs_unmap(struct omap_gpmc_s *s, int cs)
-{
-    struct omap_gpmc_cs_file_s *f = &s->cs_file[cs];
-    if (!(f->config[6] & (1 << 6))) {
-        /* Do nothing unless CSVALID */
-        return;
-    }
-    if (!f->iomem && !f->dev) {
-        return;
-    }
-    memory_region_del_subregion(get_system_memory(), &f->container);
-    memory_region_del_subregion(&f->container, omap_gpmc_cs_memregion(s, cs));
-    object_unparent(OBJECT(&f->container));
-}
-
-void omap_gpmc_reset(struct omap_gpmc_s *s)
-{
-    int i;
-
-    s->sysconfig = 0;
-    s->irqst = 0;
-    s->irqen = 0;
-    omap_gpmc_int_update(s);
-    for (i = 0; i < 8; i++) {
-        /* This has to happen before we change any of the config
-         * used to determine which memory regions are mapped or unmapped.
-         */
-        omap_gpmc_cs_unmap(s, i);
-    }
-    s->timeout = 0;
-    s->config = 0xa00;
-    s->prefetch.config1 = 0x00004000;
-    s->prefetch.transfercount = 0x00000000;
-    s->prefetch.startengine = 0;
-    s->prefetch.fifopointer = 0;
-    s->prefetch.count = 0;
-    for (i = 0; i < 8; i ++) {
-        s->cs_file[i].config[1] = 0x101001;
-        s->cs_file[i].config[2] = 0x020201;
-        s->cs_file[i].config[3] = 0x10031003;
-        s->cs_file[i].config[4] = 0x10f1111;
-        s->cs_file[i].config[5] = 0;
-        s->cs_file[i].config[6] = 0xf00;
-        /* In theory we could probe attached devices for some CFG1
-         * bits here, but we just retain them across resets as they
-         * were set initially by omap_gpmc_attach().
-         */
-        if (i == 0) {
-            s->cs_file[i].config[0] &= 0x00433e00;
-            s->cs_file[i].config[6] |= 1 << 6; /* CSVALID */
-            omap_gpmc_cs_map(s, i);
-        } else {
-            s->cs_file[i].config[0] &= 0x00403c00;
-        }
-    }
-    s->ecc_cs = 0;
-    s->ecc_ptr = 0;
-    s->ecc_cfg = 0x3fcff000;
-    for (i = 0; i < 9; i ++)
-        ecc_reset(&s->ecc[i]);
-}
-
-static int gpmc_wordaccess_only(hwaddr addr)
-{
-    /* Return true if the register offset is to a register that
-     * only permits word width accesses.
-     * Non-word accesses are only OK for GPMC_NAND_DATA/ADDRESS/COMMAND
-     * for any chipselect.
-     */
-    if (addr >= 0x60 && addr <= 0x1d4) {
-        int cs = (addr - 0x60) / 0x30;
-        addr -= cs * 0x30;
-        if (addr >= 0x7c && addr < 0x88) {
-            /* GPMC_NAND_COMMAND, GPMC_NAND_ADDRESS, GPMC_NAND_DATA */
-            return 0;
-        }
-    }
-    return 1;
-}
-
-static uint64_t omap_gpmc_read(void *opaque, hwaddr addr,
-                               unsigned size)
-{
-    struct omap_gpmc_s *s = opaque;
-    int cs;
-    struct omap_gpmc_cs_file_s *f;
-
-    if (size != 4 && gpmc_wordaccess_only(addr)) {
-        return omap_badwidth_read32(opaque, addr);
-    }
-
-    switch (addr) {
-    case 0x000:	/* GPMC_REVISION */
-        return s->revision;
-
-    case 0x010:	/* GPMC_SYSCONFIG */
-        return s->sysconfig;
-
-    case 0x014:	/* GPMC_SYSSTATUS */
-        return 1;						/* RESETDONE */
-
-    case 0x018:	/* GPMC_IRQSTATUS */
-        return s->irqst;
-
-    case 0x01c:	/* GPMC_IRQENABLE */
-        return s->irqen;
-
-    case 0x040:	/* GPMC_TIMEOUT_CONTROL */
-        return s->timeout;
-
-    case 0x044:	/* GPMC_ERR_ADDRESS */
-    case 0x048:	/* GPMC_ERR_TYPE */
-        return 0;
-
-    case 0x050:	/* GPMC_CONFIG */
-        return s->config;
-
-    case 0x054:	/* GPMC_STATUS */
-        return 0x001;
-
-    case 0x060 ... 0x1d4:
-        cs = (addr - 0x060) / 0x30;
-        addr -= cs * 0x30;
-        f = s->cs_file + cs;
-        switch (addr) {
-        case 0x60:      /* GPMC_CONFIG1 */
-            return f->config[0];
-        case 0x64:      /* GPMC_CONFIG2 */
-            return f->config[1];
-        case 0x68:      /* GPMC_CONFIG3 */
-            return f->config[2];
-        case 0x6c:      /* GPMC_CONFIG4 */
-            return f->config[3];
-        case 0x70:      /* GPMC_CONFIG5 */
-            return f->config[4];
-        case 0x74:      /* GPMC_CONFIG6 */
-            return f->config[5];
-        case 0x78:      /* GPMC_CONFIG7 */
-            return f->config[6];
-        case 0x84 ... 0x87: /* GPMC_NAND_DATA */
-            if (omap_gpmc_devtype(f) == OMAP_GPMC_NAND) {
-                return omap_nand_read(f, 0, size);
-            }
-            return 0;
-        }
-        break;
-
-    case 0x1e0:	/* GPMC_PREFETCH_CONFIG1 */
-        return s->prefetch.config1;
-    case 0x1e4:	/* GPMC_PREFETCH_CONFIG2 */
-        return s->prefetch.transfercount;
-    case 0x1ec:	/* GPMC_PREFETCH_CONTROL */
-        return s->prefetch.startengine;
-    case 0x1f0:	/* GPMC_PREFETCH_STATUS */
-        /* NB: The OMAP3 TRM is inconsistent about whether the GPMC
-         * FIFOTHRESHOLDSTATUS bit should be set when
-         * FIFOPOINTER > FIFOTHRESHOLD or when it is >= FIFOTHRESHOLD.
-         * Apparently the underlying functional spec from which the TRM was
-         * created states that the behaviour is ">=", and this also
-         * makes more conceptual sense.
-         */
-        return (s->prefetch.fifopointer << 24) |
-                ((s->prefetch.fifopointer >=
-                  ((s->prefetch.config1 >> 8) & 0x7f) ? 1 : 0) << 16) |
-                s->prefetch.count;
-
-    case 0x1f4:	/* GPMC_ECC_CONFIG */
-        return s->ecc_cs;
-    case 0x1f8:	/* GPMC_ECC_CONTROL */
-        return s->ecc_ptr;
-    case 0x1fc:	/* GPMC_ECC_SIZE_CONFIG */
-        return s->ecc_cfg;
-    case 0x200 ... 0x220:	/* GPMC_ECC_RESULT */
-        cs = (addr & 0x1f) >> 2;
-        /* TODO: check correctness */
-        return
-                ((s->ecc[cs].cp    &  0x07) <<  0) |
-                ((s->ecc[cs].cp    &  0x38) << 13) |
-                ((s->ecc[cs].lp[0] & 0x1ff) <<  3) |
-                ((s->ecc[cs].lp[1] & 0x1ff) << 19);
-
-    case 0x230:	/* GPMC_TESTMODE_CTRL */
-        return 0;
-    case 0x234:	/* GPMC_PSA_LSB */
-    case 0x238:	/* GPMC_PSA_MSB */
-        return 0x00000000;
-    }
-
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static void omap_gpmc_write(void *opaque, hwaddr addr,
-                            uint64_t value, unsigned size)
-{
-    struct omap_gpmc_s *s = opaque;
-    int cs;
-    struct omap_gpmc_cs_file_s *f;
-
-    if (size != 4 && gpmc_wordaccess_only(addr)) {
-        omap_badwidth_write32(opaque, addr, value);
-        return;
-    }
-
-    switch (addr) {
-    case 0x000:	/* GPMC_REVISION */
-    case 0x014:	/* GPMC_SYSSTATUS */
-    case 0x054:	/* GPMC_STATUS */
-    case 0x1f0:	/* GPMC_PREFETCH_STATUS */
-    case 0x200 ... 0x220:	/* GPMC_ECC_RESULT */
-    case 0x234:	/* GPMC_PSA_LSB */
-    case 0x238:	/* GPMC_PSA_MSB */
-        OMAP_RO_REG(addr);
-        break;
-
-    case 0x010:	/* GPMC_SYSCONFIG */
-        if ((value >> 3) == 0x3)
-            fprintf(stderr, "%s: bad SDRAM idle mode %"PRIi64"\n",
-                            __func__, value >> 3);
-        if (value & 2)
-            omap_gpmc_reset(s);
-        s->sysconfig = value & 0x19;
-        break;
-
-    case 0x018:	/* GPMC_IRQSTATUS */
-        s->irqst &= ~value;
-        omap_gpmc_int_update(s);
-        break;
-
-    case 0x01c:	/* GPMC_IRQENABLE */
-        s->irqen = value & 0xf03;
-        omap_gpmc_int_update(s);
-        break;
-
-    case 0x040:	/* GPMC_TIMEOUT_CONTROL */
-        s->timeout = value & 0x1ff1;
-        break;
-
-    case 0x044:	/* GPMC_ERR_ADDRESS */
-    case 0x048:	/* GPMC_ERR_TYPE */
-        break;
-
-    case 0x050:	/* GPMC_CONFIG */
-        s->config = value & 0xf13;
-        break;
-
-    case 0x060 ... 0x1d4:
-        cs = (addr - 0x060) / 0x30;
-        addr -= cs * 0x30;
-        f = s->cs_file + cs;
-        switch (addr) {
-        case 0x60:      /* GPMC_CONFIG1 */
-            f->config[0] = value & 0xffef3e13;
-            break;
-        case 0x64:      /* GPMC_CONFIG2 */
-            f->config[1] = value & 0x001f1f8f;
-            break;
-        case 0x68:      /* GPMC_CONFIG3 */
-            f->config[2] = value & 0x001f1f8f;
-            break;
-        case 0x6c:      /* GPMC_CONFIG4 */
-            f->config[3] = value & 0x1f8f1f8f;
-            break;
-        case 0x70:      /* GPMC_CONFIG5 */
-            f->config[4] = value & 0x0f1f1f1f;
-            break;
-        case 0x74:      /* GPMC_CONFIG6 */
-            f->config[5] = value & 0x00000fcf;
-            break;
-        case 0x78:      /* GPMC_CONFIG7 */
-            if ((f->config[6] ^ value) & 0xf7f) {
-                omap_gpmc_cs_unmap(s, cs);
-                f->config[6] = value & 0x00000f7f;
-                omap_gpmc_cs_map(s, cs);
-            }
-            break;
-        case 0x7c ... 0x7f: /* GPMC_NAND_COMMAND */
-            if (omap_gpmc_devtype(f) == OMAP_GPMC_NAND) {
-                nand_setpins(f->dev, 1, 0, 0, 1, 0); /* CLE */
-                omap_nand_setio(f->dev, value, omap_gpmc_devsize(f), size);
-            }
-            break;
-        case 0x80 ... 0x83: /* GPMC_NAND_ADDRESS */
-            if (omap_gpmc_devtype(f) == OMAP_GPMC_NAND) {
-                nand_setpins(f->dev, 0, 1, 0, 1, 0); /* ALE */
-                omap_nand_setio(f->dev, value, omap_gpmc_devsize(f), size);
-            }
-            break;
-        case 0x84 ... 0x87: /* GPMC_NAND_DATA */
-            if (omap_gpmc_devtype(f) == OMAP_GPMC_NAND) {
-                omap_nand_write(f, 0, value, size);
-            }
-            break;
-        default:
-            goto bad_reg;
-        }
-        break;
-
-    case 0x1e0:	/* GPMC_PREFETCH_CONFIG1 */
-        if (!s->prefetch.startengine) {
-            uint32_t newconfig1 = value & 0x7f8f7fbf;
-            uint32_t changed;
-            changed = newconfig1 ^ s->prefetch.config1;
-            if (changed & (0x80 | 0x7000000)) {
-                /* Turning the engine on or off, or mapping it somewhere else.
-                 * cs_map() and cs_unmap() check the prefetch config and
-                 * overall CSVALID bits, so it is sufficient to unmap-and-map
-                 * both the old cs and the new one. Note that we adhere to
-                 * the "unmap/change config/map" order (and not unmap twice
-                 * if newcs == oldcs), otherwise we'll try to delete the wrong
-                 * memory region.
-                 */
-                int oldcs = prefetch_cs(s->prefetch.config1);
-                int newcs = prefetch_cs(newconfig1);
-                omap_gpmc_cs_unmap(s, oldcs);
-                if (oldcs != newcs) {
-                    omap_gpmc_cs_unmap(s, newcs);
-                }
-                s->prefetch.config1 = newconfig1;
-                omap_gpmc_cs_map(s, oldcs);
-                if (oldcs != newcs) {
-                    omap_gpmc_cs_map(s, newcs);
-                }
-            } else {
-                s->prefetch.config1 = newconfig1;
-            }
-        }
-        break;
-
-    case 0x1e4:	/* GPMC_PREFETCH_CONFIG2 */
-        if (!s->prefetch.startengine) {
-            s->prefetch.transfercount = value & 0x3fff;
-        }
-        break;
-
-    case 0x1ec:	/* GPMC_PREFETCH_CONTROL */
-        if (s->prefetch.startengine != (value & 1)) {
-            s->prefetch.startengine = value & 1;
-            if (s->prefetch.startengine) {
-                /* Prefetch engine start */
-                s->prefetch.count = s->prefetch.transfercount;
-                if (s->prefetch.config1 & 1) {
-                    /* Write */
-                    s->prefetch.fifopointer = 64;
-                } else {
-                    /* Read */
-                    s->prefetch.fifopointer = 0;
-                    fill_prefetch_fifo(s);
-                }
-            } else {
-                /* Prefetch engine forcibly stopped. The TRM
-                 * doesn't define the behaviour if you do this.
-                 * We clear the prefetch count, which means that
-                 * we permit no more writes, and don't read any
-                 * more data from NAND. The CPU can still drain
-                 * the FIFO of unread data.
-                 */
-                s->prefetch.count = 0;
-            }
-            omap_gpmc_int_update(s);
-        }
-        break;
-
-    case 0x1f4:	/* GPMC_ECC_CONFIG */
-        s->ecc_cs = 0x8f;
-        break;
-    case 0x1f8:	/* GPMC_ECC_CONTROL */
-        if (value & (1 << 8))
-            for (cs = 0; cs < 9; cs ++)
-                ecc_reset(&s->ecc[cs]);
-        s->ecc_ptr = value & 0xf;
-        if (s->ecc_ptr == 0 || s->ecc_ptr > 9) {
-            s->ecc_ptr = 0;
-            s->ecc_cs &= ~1;
-        }
-        break;
-    case 0x1fc:	/* GPMC_ECC_SIZE_CONFIG */
-        s->ecc_cfg = value & 0x3fcff1ff;
-        break;
-    case 0x230:	/* GPMC_TESTMODE_CTRL */
-        if (value & 7)
-            fprintf(stderr, "%s: test mode enable attempt\n", __func__);
-        break;
-
-    default:
-    bad_reg:
-        OMAP_BAD_REG(addr);
-        return;
-    }
-}
-
-static const MemoryRegionOps omap_gpmc_ops = {
-    .read = omap_gpmc_read,
-    .write = omap_gpmc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-struct omap_gpmc_s *omap_gpmc_init(struct omap_mpu_state_s *mpu,
-                                   hwaddr base,
-                                   qemu_irq irq, qemu_irq drq)
-{
-    int cs;
-    struct omap_gpmc_s *s = g_new0(struct omap_gpmc_s, 1);
-
-    memory_region_init_io(&s->iomem, NULL, &omap_gpmc_ops, s, "omap-gpmc", 0x1000);
-    memory_region_add_subregion(get_system_memory(), base, &s->iomem);
-
-    s->irq = irq;
-    s->drq = drq;
-    s->accept_256 = cpu_is_omap3630(mpu);
-    s->revision = cpu_class_omap3(mpu) ? 0x50 : 0x20;
-    s->lastirq = 0;
-    omap_gpmc_reset(s);
-
-    /* We have to register a different IO memory handler for each
-     * chip select region in case a NAND device is mapped there. We
-     * make the region the worst-case size of 256MB and rely on the
-     * container memory region in cs_map to chop it down to the actual
-     * guest-requested size.
-     */
-    for (cs = 0; cs < 8; cs++) {
-        memory_region_init_io(&s->cs_file[cs].nandiomem, NULL,
-                              &omap_nand_ops,
-                              &s->cs_file[cs],
-                              "omap-nand",
-                              256 * 1024 * 1024);
-    }
-
-    memory_region_init_io(&s->prefetch.iomem, NULL, &omap_prefetch_ops, s,
-                          "omap-gpmc-prefetch", 256 * 1024 * 1024);
-    return s;
-}
-
-void omap_gpmc_attach(struct omap_gpmc_s *s, int cs, MemoryRegion *iomem)
-{
-    struct omap_gpmc_cs_file_s *f;
-    assert(iomem);
-
-    if (cs < 0 || cs >= 8) {
-        fprintf(stderr, "%s: bad chip-select %i\n", __func__, cs);
-        exit(-1);
-    }
-    f = &s->cs_file[cs];
-
-    omap_gpmc_cs_unmap(s, cs);
-    f->config[0] &= ~(0xf << 10);
-    f->iomem = iomem;
-    omap_gpmc_cs_map(s, cs);
-}
-
-void omap_gpmc_attach_nand(struct omap_gpmc_s *s, int cs, DeviceState *nand)
-{
-    struct omap_gpmc_cs_file_s *f;
-    assert(nand);
-
-    if (cs < 0 || cs >= 8) {
-        fprintf(stderr, "%s: bad chip-select %i\n", __func__, cs);
-        exit(-1);
-    }
-    f = &s->cs_file[cs];
-
-    omap_gpmc_cs_unmap(s, cs);
-    f->config[0] &= ~(0xf << 10);
-    f->config[0] |= (OMAP_GPMC_NAND << 10);
-    f->dev = nand;
-    if (nand_getbuswidth(f->dev) == 16) {
-        f->config[0] |= OMAP_GPMC_16BIT << 12;
-    }
-    omap_gpmc_cs_map(s, cs);
-}
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 7c9addbe68f..122084b1694 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -75,7 +75,6 @@ system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files(
   'omap_clk.c',
-  'omap_gpmc.c',
   'omap_l4.c',
   'omap_tap.c',
 ))
-- 
2.34.1


