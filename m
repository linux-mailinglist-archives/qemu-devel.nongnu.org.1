Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E618AC0E1C
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 16:30:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI6vB-0002OZ-0u; Thu, 22 May 2025 10:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uI6v2-0002Mx-MO
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:29:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uI6uv-0000Jo-Of
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:29:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442ec3ce724so67844315e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747924142; x=1748528942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ID6MMH7Np3nTzbT9CidYzYjWeLu2+8P9RMxspVrhJOg=;
 b=wbRu11j3z4SMWZm7s8fwQqlPgQTcpbbWS6FkgsdWg+YLwCXj7mqAGYyNpOWnyOh1oh
 DnIK2ZA19hOtKZCx5JO+pQAPMM1w3s9qLjHhOq1RnizAoBXlcsU+6owOqoUL6nBD2Yae
 IUK2LCKKYzaesGL6UkEcp+lxi/XE9fZK+e1iVgUgYQ/fWDODst++FRKq4b6SRUnL+yBq
 dvOXc7d1STqRGFCSZdKTtvd70gcNSxJNpt9uhP7mkdIciIq6ObNlXtQrGq7qK0vIJKf8
 6kLdXk+bp3yfFCIeDcfcYzLfxzWaVDsWMFERTLRjRQyIM6zoD8UXN4+EqZIVjB/xpQBi
 WRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747924142; x=1748528942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ID6MMH7Np3nTzbT9CidYzYjWeLu2+8P9RMxspVrhJOg=;
 b=uuoefv/V1AfkBAOQsnOJcbzmK9ahETgE9f/SZsgBm869hN9JWtIoXVHd6YMDqp2t77
 IqASPlVM1IcET/cSi0BjdTIH33io+ybVhjhevFAIe3h5iuFa8RV5GTR3PfU1VnbdDztD
 XJ9/iUb0i69veRinZpDXedsn5Tk5x758PiYz/37vkCLbhQxOAPZiZUtZHQgVFWs/X7Xs
 mnzA2GKsNKvKm2cIpZo7liuH6O+sUEZo9j49r+fMCUkWHH4CTTFiIceoODEGuDsvAblS
 zLdbSyTwA9KbYzvKNP3OvUYrQQf+98yNOURqFeLPXDkcVGi9W7iZs92gUwf/PPy8W2rQ
 fTLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHMv4ozb7pMHalcMNk11NGVKRcCQVXPEcqZtXxTs6TPJPaTxOy3aVv5WSH+aVMhX4kaCglRyh0GCT9@nongnu.org
X-Gm-Message-State: AOJu0Yyvk7ocxb68dvyMms0+jh1hk4BCi9EOHMufo2oe9bCY4N4jPsMt
 JGvRdoj809Pv1p6/oJ8orbuBW/33CVKycVPNuwBr3uTCkRNf1K4U8Wart2gW8Y4FnTo=
X-Gm-Gg: ASbGncvdigk9oboon8rkGEiw0D6x3fKhZ7p+FrW18KrfzkIoaC/uzKWfOOdt9gvOsuj
 pHSbBu7pF+ceJ/qByOPfAEUHtcaafVmUofjBOiPU8vGqefo4foklBuIkD/AMdJ3H/9OJGFjlnAn
 own7fOCNYDR/DiQQ7iutg9Li6voGDEMrPoGnODcH1RrNGqVTRy+iaoxPrnvbkm9JhxiWDVhmWl3
 rbp+SMcOJUyZ+daP7r4B/Tk0LzcSrcBu876S0S24aHJ64duP7sYV9LrEENla6Hfv0NC/xFn/i+8
 EJWr8mz2ZESKCbJb8mGGnCmOTIKcYY96LLZHclK//UpgnMTvE08PhB1IYBFkbz6DFK+J
X-Google-Smtp-Source: AGHT+IG32BHEhGLE70SrpXp3ZrehiGhMVxASE0qFToQ3zFF1HSWJ4nwyOd4F8F8Y5Q5GrJwVbVeRkg==
X-Received: by 2002:a05:600c:46cc:b0:442:d9fc:7de with SMTP id
 5b1f17b1804b1-442fd672025mr187008325e9.22.1747924141680; 
 Thu, 22 May 2025 07:29:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d305sm23761227f8f.16.2025.05.22.07.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 07:29:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Subject: [PATCH] hw/block: Drop unused nand.c
Date: Thu, 22 May 2025 15:28:59 +0100
Message-ID: <20250522142859.3122389-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The nand.c device (TYPE_NAND) is an emulation of a NAND flash memory
chip which was used by the old OMAP boards.  No current QEMU board
uses it, and although techically "-device nand,chip-id=0x6b" doesn't
error out, it's not possible to usefully use it from the command
line because the only interface it has is via calling C functions
like nand_setpins() and nand_setio().

The "config OMAP" stanza (used only by the SX1 board) is the only
thing that does "select NAND" to compile in this code, but the SX1
board doesn't actually use the NAND device.

Remove the NAND device code entirely; this is effectively leftover
cleanup from when we dropped the PXA boards and the OMAP boards
other than the sx1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/block/flash.h |  18 -
 hw/block/nand.c          | 835 ---------------------------------------
 hw/arm/Kconfig           |   1 -
 hw/block/Kconfig         |   3 -
 hw/block/meson.build     |   1 -
 5 files changed, 858 deletions(-)
 delete mode 100644 hw/block/nand.c

diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 5fd67f5bb79..3671f0174d0 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -44,24 +44,6 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
                                    uint16_t unlock_addr1,
                                    int be);
 
-/* nand.c */
-DeviceState *nand_init(BlockBackend *blk, int manf_id, int chip_id);
-void nand_setpins(DeviceState *dev, uint8_t cle, uint8_t ale,
-                  uint8_t ce, uint8_t wp, uint8_t gnd);
-void nand_getpins(DeviceState *dev, int *rb);
-void nand_setio(DeviceState *dev, uint32_t value);
-uint32_t nand_getio(DeviceState *dev);
-uint32_t nand_getbuswidth(DeviceState *dev);
-
-#define NAND_MFR_TOSHIBA    0x98
-#define NAND_MFR_SAMSUNG    0xec
-#define NAND_MFR_FUJITSU    0x04
-#define NAND_MFR_NATIONAL   0x8f
-#define NAND_MFR_RENESAS    0x07
-#define NAND_MFR_STMICRO    0x20
-#define NAND_MFR_HYNIX      0xad
-#define NAND_MFR_MICRON     0x2c
-
 /* m25p80.c */
 
 #define TYPE_M25P80 "m25p80-generic"
diff --git a/hw/block/nand.c b/hw/block/nand.c
deleted file mode 100644
index c80bf78fe58..00000000000
--- a/hw/block/nand.c
+++ /dev/null
@@ -1,835 +0,0 @@
-/*
- * Flash NAND memory emulation.  Based on "16M x 8 Bit NAND Flash
- * Memory" datasheet for the KM29U128AT / K9F2808U0A chips from
- * Samsung Electronic.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * Support for additional features based on "MT29F2G16ABCWP 2Gx16"
- * datasheet from Micron Technology and "NAND02G-B2C" datasheet
- * from ST Microelectronics.
- *
- * This code is licensed under the GNU GPL v2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#ifndef NAND_IO
-
-#include "qemu/osdep.h"
-#include "hw/hw.h"
-#include "hw/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
-#include "hw/block/flash.h"
-#include "system/block-backend.h"
-#include "migration/vmstate.h"
-#include "qapi/error.h"
-#include "qemu/error-report.h"
-#include "qemu/module.h"
-#include "qom/object.h"
-
-# define NAND_CMD_READ0         0x00
-# define NAND_CMD_READ1         0x01
-# define NAND_CMD_READ2         0x50
-# define NAND_CMD_LPREAD2       0x30
-# define NAND_CMD_NOSERIALREAD2 0x35
-# define NAND_CMD_RANDOMREAD1   0x05
-# define NAND_CMD_RANDOMREAD2   0xe0
-# define NAND_CMD_READID        0x90
-# define NAND_CMD_RESET         0xff
-# define NAND_CMD_PAGEPROGRAM1  0x80
-# define NAND_CMD_PAGEPROGRAM2  0x10
-# define NAND_CMD_CACHEPROGRAM2 0x15
-# define NAND_CMD_BLOCKERASE1   0x60
-# define NAND_CMD_BLOCKERASE2   0xd0
-# define NAND_CMD_READSTATUS    0x70
-# define NAND_CMD_COPYBACKPRG1  0x85
-
-# define NAND_IOSTATUS_ERROR    (1 << 0)
-# define NAND_IOSTATUS_PLANE0   (1 << 1)
-# define NAND_IOSTATUS_PLANE1   (1 << 2)
-# define NAND_IOSTATUS_PLANE2   (1 << 3)
-# define NAND_IOSTATUS_PLANE3   (1 << 4)
-# define NAND_IOSTATUS_READY    (1 << 6)
-# define NAND_IOSTATUS_UNPROTCT (1 << 7)
-
-# define MAX_PAGE       0x800
-# define MAX_OOB        0x40
-
-typedef struct NANDFlashState NANDFlashState;
-struct NANDFlashState {
-    DeviceState parent_obj;
-
-    uint8_t manf_id, chip_id;
-    uint8_t buswidth; /* in BYTES */
-    int size, pages;
-    int page_shift, oob_shift, erase_shift, addr_shift;
-    uint8_t *storage;
-    BlockBackend *blk;
-    int mem_oob;
-
-    uint8_t cle, ale, ce, wp, gnd;
-
-    uint8_t io[MAX_PAGE + MAX_OOB + 0x400];
-    uint8_t *ioaddr;
-    int iolen;
-
-    uint32_t cmd;
-    uint64_t addr;
-    int addrlen;
-    int status;
-    int offset;
-
-    void (*blk_write)(NANDFlashState *s);
-    void (*blk_erase)(NANDFlashState *s);
-    /*
-     * Returns %true when block containing (@addr + @offset) is
-     * successfully loaded, otherwise %false.
-     */
-    bool (*blk_load)(NANDFlashState *s, uint64_t addr, unsigned offset);
-
-    uint32_t ioaddr_vmstate;
-};
-
-#define TYPE_NAND "nand"
-
-OBJECT_DECLARE_SIMPLE_TYPE(NANDFlashState, NAND)
-
-static void mem_and(uint8_t *dest, const uint8_t *src, size_t n)
-{
-    /* Like memcpy() but we logical-AND the data into the destination */
-    int i;
-    for (i = 0; i < n; i++) {
-        dest[i] &= src[i];
-    }
-}
-
-# define NAND_NO_AUTOINCR   0x00000001
-# define NAND_BUSWIDTH_16   0x00000002
-# define NAND_NO_PADDING    0x00000004
-# define NAND_CACHEPRG      0x00000008
-# define NAND_COPYBACK      0x00000010
-# define NAND_IS_AND        0x00000020
-# define NAND_4PAGE_ARRAY   0x00000040
-# define NAND_NO_READRDY    0x00000100
-# define NAND_SAMSUNG_LP    (NAND_NO_PADDING | NAND_COPYBACK)
-
-# define NAND_IO
-
-# define PAGE(addr)          ((addr) >> ADDR_SHIFT)
-# define PAGE_START(page)    (PAGE(page) * (NAND_PAGE_SIZE + OOB_SIZE))
-# define PAGE_MASK           ((1 << ADDR_SHIFT) - 1)
-# define OOB_SHIFT           (PAGE_SHIFT - 5)
-# define OOB_SIZE            (1 << OOB_SHIFT)
-# define SECTOR(addr)        ((addr) >> (9 + ADDR_SHIFT - PAGE_SHIFT))
-# define SECTOR_OFFSET(addr) ((addr) & ((511 >> PAGE_SHIFT) << 8))
-
-# define NAND_PAGE_SIZE     256
-# define PAGE_SHIFT         8
-# define PAGE_SECTORS       1
-# define ADDR_SHIFT         8
-# include "nand.c"
-# define NAND_PAGE_SIZE     512
-# define PAGE_SHIFT         9
-# define PAGE_SECTORS       1
-# define ADDR_SHIFT         8
-# include "nand.c"
-# define NAND_PAGE_SIZE     2048
-# define PAGE_SHIFT         11
-# define PAGE_SECTORS       4
-# define ADDR_SHIFT         16
-# include "nand.c"
-
-/* Information based on Linux drivers/mtd/nand/raw/nand_ids.c */
-static const struct {
-    int size;
-    int width;
-    int page_shift;
-    int erase_shift;
-    uint32_t options;
-} nand_flash_ids[0x100] = {
-    [0 ... 0xff] = { 0 },
-
-    [0x6b] = { 4,   8,  9, 4, 0 },
-    [0xe3] = { 4,   8,  9, 4, 0 },
-    [0xe5] = { 4,   8,  9, 4, 0 },
-    [0xd6] = { 8,   8,  9, 4, 0 },
-    [0xe6] = { 8,   8,  9, 4, 0 },
-
-    [0x33] = { 16,  8,  9, 5, 0 },
-    [0x73] = { 16,  8,  9, 5, 0 },
-    [0x43] = { 16,  16, 9, 5, NAND_BUSWIDTH_16 },
-    [0x53] = { 16,  16, 9, 5, NAND_BUSWIDTH_16 },
-
-    [0x35] = { 32,  8,  9, 5, 0 },
-    [0x75] = { 32,  8,  9, 5, 0 },
-    [0x45] = { 32,  16, 9, 5, NAND_BUSWIDTH_16 },
-    [0x55] = { 32,  16, 9, 5, NAND_BUSWIDTH_16 },
-
-    [0x36] = { 64,  8,  9, 5, 0 },
-    [0x76] = { 64,  8,  9, 5, 0 },
-    [0x46] = { 64,  16, 9, 5, NAND_BUSWIDTH_16 },
-    [0x56] = { 64,  16, 9, 5, NAND_BUSWIDTH_16 },
-
-    [0x78] = { 128, 8,  9, 5, 0 },
-    [0x39] = { 128, 8,  9, 5, 0 },
-    [0x79] = { 128, 8,  9, 5, 0 },
-    [0x72] = { 128, 16, 9, 5, NAND_BUSWIDTH_16 },
-    [0x49] = { 128, 16, 9, 5, NAND_BUSWIDTH_16 },
-    [0x74] = { 128, 16, 9, 5, NAND_BUSWIDTH_16 },
-    [0x59] = { 128, 16, 9, 5, NAND_BUSWIDTH_16 },
-
-    [0x71] = { 256, 8,  9, 5, 0 },
-
-    /*
-     * These are the new chips with large page size. The pagesize and the
-     * erasesize is determined from the extended id bytes
-     */
-# define LP_OPTIONS (NAND_SAMSUNG_LP | NAND_NO_READRDY | NAND_NO_AUTOINCR)
-# define LP_OPTIONS16 (LP_OPTIONS | NAND_BUSWIDTH_16)
-
-    /* 512 Megabit */
-    [0xa2] = { 64,   8,  0, 0, LP_OPTIONS },
-    [0xf2] = { 64,   8,  0, 0, LP_OPTIONS },
-    [0xb2] = { 64,   16, 0, 0, LP_OPTIONS16 },
-    [0xc2] = { 64,   16, 0, 0, LP_OPTIONS16 },
-
-    /* 1 Gigabit */
-    [0xa1] = { 128,  8,  0, 0, LP_OPTIONS },
-    [0xf1] = { 128,  8,  0, 0, LP_OPTIONS },
-    [0xb1] = { 128,  16, 0, 0, LP_OPTIONS16 },
-    [0xc1] = { 128,  16, 0, 0, LP_OPTIONS16 },
-
-    /* 2 Gigabit */
-    [0xaa] = { 256,  8,  0, 0, LP_OPTIONS },
-    [0xda] = { 256,  8,  0, 0, LP_OPTIONS },
-    [0xba] = { 256,  16, 0, 0, LP_OPTIONS16 },
-    [0xca] = { 256,  16, 0, 0, LP_OPTIONS16 },
-
-    /* 4 Gigabit */
-    [0xac] = { 512,  8,  0, 0, LP_OPTIONS },
-    [0xdc] = { 512,  8,  0, 0, LP_OPTIONS },
-    [0xbc] = { 512,  16, 0, 0, LP_OPTIONS16 },
-    [0xcc] = { 512,  16, 0, 0, LP_OPTIONS16 },
-
-    /* 8 Gigabit */
-    [0xa3] = { 1024, 8,  0, 0, LP_OPTIONS },
-    [0xd3] = { 1024, 8,  0, 0, LP_OPTIONS },
-    [0xb3] = { 1024, 16, 0, 0, LP_OPTIONS16 },
-    [0xc3] = { 1024, 16, 0, 0, LP_OPTIONS16 },
-
-    /* 16 Gigabit */
-    [0xa5] = { 2048, 8,  0, 0, LP_OPTIONS },
-    [0xd5] = { 2048, 8,  0, 0, LP_OPTIONS },
-    [0xb5] = { 2048, 16, 0, 0, LP_OPTIONS16 },
-    [0xc5] = { 2048, 16, 0, 0, LP_OPTIONS16 },
-};
-
-static void nand_reset(DeviceState *dev)
-{
-    NANDFlashState *s = NAND(dev);
-    s->cmd = NAND_CMD_READ0;
-    s->addr = 0;
-    s->addrlen = 0;
-    s->iolen = 0;
-    s->offset = 0;
-    s->status &= NAND_IOSTATUS_UNPROTCT;
-    s->status |= NAND_IOSTATUS_READY;
-}
-
-static inline void nand_pushio_byte(NANDFlashState *s, uint8_t value)
-{
-    s->ioaddr[s->iolen++] = value;
-    for (value = s->buswidth; --value;) {
-        s->ioaddr[s->iolen++] = 0;
-    }
-}
-
-/*
- * nand_load_block: Load block containing (s->addr + @offset).
- * Returns length of data available at @offset in this block.
- */
-static unsigned nand_load_block(NANDFlashState *s, unsigned offset)
-{
-    unsigned iolen;
-
-    if (!s->blk_load(s, s->addr, offset)) {
-        return 0;
-    }
-
-    iolen = (1 << s->page_shift);
-    if (s->gnd) {
-        iolen += 1 << s->oob_shift;
-    }
-    assert(offset <= iolen);
-    iolen -= offset;
-
-    return iolen;
-}
-
-static void nand_command(NANDFlashState *s)
-{
-    switch (s->cmd) {
-    case NAND_CMD_READ0:
-        s->iolen = 0;
-        break;
-
-    case NAND_CMD_READID:
-        s->ioaddr = s->io;
-        s->iolen = 0;
-        nand_pushio_byte(s, s->manf_id);
-        nand_pushio_byte(s, s->chip_id);
-        nand_pushio_byte(s, 'Q'); /* Don't-care byte (often 0xa5) */
-        if (nand_flash_ids[s->chip_id].options & NAND_SAMSUNG_LP) {
-            /* Page Size, Block Size, Spare Size; bit 6 indicates
-             * 8 vs 16 bit width NAND.
-             */
-            nand_pushio_byte(s, (s->buswidth == 2) ? 0x55 : 0x15);
-        } else {
-            nand_pushio_byte(s, 0xc0); /* Multi-plane */
-        }
-        break;
-
-    case NAND_CMD_RANDOMREAD2:
-    case NAND_CMD_NOSERIALREAD2:
-        if (!(nand_flash_ids[s->chip_id].options & NAND_SAMSUNG_LP))
-            break;
-        s->iolen = nand_load_block(s, s->addr & ((1 << s->addr_shift) - 1));
-        break;
-
-    case NAND_CMD_RESET:
-        nand_reset(DEVICE(s));
-        break;
-
-    case NAND_CMD_PAGEPROGRAM1:
-        s->ioaddr = s->io;
-        s->iolen = 0;
-        break;
-
-    case NAND_CMD_PAGEPROGRAM2:
-        if (s->wp) {
-            s->blk_write(s);
-        }
-        break;
-
-    case NAND_CMD_BLOCKERASE1:
-        break;
-
-    case NAND_CMD_BLOCKERASE2:
-        s->addr &= (1ull << s->addrlen * 8) - 1;
-        s->addr <<= nand_flash_ids[s->chip_id].options & NAND_SAMSUNG_LP ?
-                                                                    16 : 8;
-
-        if (s->wp) {
-            s->blk_erase(s);
-        }
-        break;
-
-    case NAND_CMD_READSTATUS:
-        s->ioaddr = s->io;
-        s->iolen = 0;
-        nand_pushio_byte(s, s->status);
-        break;
-
-    default:
-        printf("%s: Unknown NAND command 0x%02x\n", __func__, s->cmd);
-    }
-}
-
-static int nand_pre_save(void *opaque)
-{
-    NANDFlashState *s = NAND(opaque);
-
-    s->ioaddr_vmstate = s->ioaddr - s->io;
-
-    return 0;
-}
-
-static int nand_post_load(void *opaque, int version_id)
-{
-    NANDFlashState *s = NAND(opaque);
-
-    if (s->ioaddr_vmstate > sizeof(s->io)) {
-        return -EINVAL;
-    }
-    s->ioaddr = s->io + s->ioaddr_vmstate;
-
-    return 0;
-}
-
-static const VMStateDescription vmstate_nand = {
-    .name = "nand",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .pre_save = nand_pre_save,
-    .post_load = nand_post_load,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(cle, NANDFlashState),
-        VMSTATE_UINT8(ale, NANDFlashState),
-        VMSTATE_UINT8(ce, NANDFlashState),
-        VMSTATE_UINT8(wp, NANDFlashState),
-        VMSTATE_UINT8(gnd, NANDFlashState),
-        VMSTATE_BUFFER(io, NANDFlashState),
-        VMSTATE_UINT32(ioaddr_vmstate, NANDFlashState),
-        VMSTATE_INT32(iolen, NANDFlashState),
-        VMSTATE_UINT32(cmd, NANDFlashState),
-        VMSTATE_UINT64(addr, NANDFlashState),
-        VMSTATE_INT32(addrlen, NANDFlashState),
-        VMSTATE_INT32(status, NANDFlashState),
-        VMSTATE_INT32(offset, NANDFlashState),
-        /* XXX: do we want to save s->storage too? */
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void nand_realize(DeviceState *dev, Error **errp)
-{
-    int pagesize;
-    NANDFlashState *s = NAND(dev);
-    int ret;
-
-
-    s->buswidth = nand_flash_ids[s->chip_id].width >> 3;
-    s->size = nand_flash_ids[s->chip_id].size << 20;
-    if (nand_flash_ids[s->chip_id].options & NAND_SAMSUNG_LP) {
-        s->page_shift = 11;
-        s->erase_shift = 6;
-    } else {
-        s->page_shift = nand_flash_ids[s->chip_id].page_shift;
-        s->erase_shift = nand_flash_ids[s->chip_id].erase_shift;
-    }
-
-    switch (1 << s->page_shift) {
-    case 256:
-        nand_init_256(s);
-        break;
-    case 512:
-        nand_init_512(s);
-        break;
-    case 2048:
-        nand_init_2048(s);
-        break;
-    default:
-        error_setg(errp, "Unsupported NAND block size %#x",
-                   1 << s->page_shift);
-        return;
-    }
-
-    pagesize = 1 << s->oob_shift;
-    s->mem_oob = 1;
-    if (s->blk) {
-        if (!blk_supports_write_perm(s->blk)) {
-            error_setg(errp, "Can't use a read-only drive");
-            return;
-        }
-        ret = blk_set_perm(s->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
-                           BLK_PERM_ALL, errp);
-        if (ret < 0) {
-            return;
-        }
-        if (blk_getlength(s->blk) >=
-                (s->pages << s->page_shift) + (s->pages << s->oob_shift)) {
-            pagesize = 0;
-            s->mem_oob = 0;
-        }
-    } else {
-        pagesize += 1 << s->page_shift;
-    }
-    if (pagesize) {
-        s->storage = (uint8_t *) memset(g_malloc(s->pages * pagesize),
-                        0xff, s->pages * pagesize);
-    }
-    /* Give s->ioaddr a sane value in case we save state before it is used. */
-    s->ioaddr = s->io;
-}
-
-static const Property nand_properties[] = {
-    DEFINE_PROP_UINT8("manufacturer_id", NANDFlashState, manf_id, 0),
-    DEFINE_PROP_UINT8("chip_id", NANDFlashState, chip_id, 0),
-    DEFINE_PROP_DRIVE("drive", NANDFlashState, blk),
-};
-
-static void nand_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = nand_realize;
-    device_class_set_legacy_reset(dc, nand_reset);
-    dc->vmsd = &vmstate_nand;
-    device_class_set_props(dc, nand_properties);
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-}
-
-static const TypeInfo nand_info = {
-    .name          = TYPE_NAND,
-    .parent        = TYPE_DEVICE,
-    .instance_size = sizeof(NANDFlashState),
-    .class_init    = nand_class_init,
-};
-
-static void nand_register_types(void)
-{
-    type_register_static(&nand_info);
-}
-
-/*
- * Chip inputs are CLE, ALE, CE, WP, GND and eight I/O pins.  Chip
- * outputs are R/B and eight I/O pins.
- *
- * CE, WP and R/B are active low.
- */
-void nand_setpins(DeviceState *dev, uint8_t cle, uint8_t ale,
-                  uint8_t ce, uint8_t wp, uint8_t gnd)
-{
-    NANDFlashState *s = NAND(dev);
-
-    s->cle = cle;
-    s->ale = ale;
-    s->ce = ce;
-    s->wp = wp;
-    s->gnd = gnd;
-    if (wp) {
-        s->status |= NAND_IOSTATUS_UNPROTCT;
-    } else {
-        s->status &= ~NAND_IOSTATUS_UNPROTCT;
-    }
-}
-
-void nand_getpins(DeviceState *dev, int *rb)
-{
-    *rb = 1;
-}
-
-void nand_setio(DeviceState *dev, uint32_t value)
-{
-    int i;
-    NANDFlashState *s = NAND(dev);
-
-    if (!s->ce && s->cle) {
-        if (nand_flash_ids[s->chip_id].options & NAND_SAMSUNG_LP) {
-            if (s->cmd == NAND_CMD_READ0 && value == NAND_CMD_LPREAD2)
-                return;
-            if (value == NAND_CMD_RANDOMREAD1) {
-                s->addr &= ~((1 << s->addr_shift) - 1);
-                s->addrlen = 0;
-                return;
-            }
-        }
-        if (value == NAND_CMD_READ0) {
-            s->offset = 0;
-        } else if (value == NAND_CMD_READ1) {
-            s->offset = 0x100;
-            value = NAND_CMD_READ0;
-        } else if (value == NAND_CMD_READ2) {
-            s->offset = 1 << s->page_shift;
-            value = NAND_CMD_READ0;
-        }
-
-        s->cmd = value;
-
-        if (s->cmd == NAND_CMD_READSTATUS ||
-                s->cmd == NAND_CMD_PAGEPROGRAM2 ||
-                s->cmd == NAND_CMD_BLOCKERASE1 ||
-                s->cmd == NAND_CMD_BLOCKERASE2 ||
-                s->cmd == NAND_CMD_NOSERIALREAD2 ||
-                s->cmd == NAND_CMD_RANDOMREAD2 ||
-                s->cmd == NAND_CMD_RESET) {
-            nand_command(s);
-        }
-
-        if (s->cmd != NAND_CMD_RANDOMREAD2) {
-            s->addrlen = 0;
-        }
-    }
-
-    if (s->ale) {
-        unsigned int shift = s->addrlen * 8;
-        uint64_t mask = ~(0xffull << shift);
-        uint64_t v = (uint64_t)value << shift;
-
-        s->addr = (s->addr & mask) | v;
-        s->addrlen ++;
-
-        switch (s->addrlen) {
-        case 1:
-            if (s->cmd == NAND_CMD_READID) {
-                nand_command(s);
-            }
-            break;
-        case 2: /* fix cache address as a byte address */
-            s->addr <<= (s->buswidth - 1);
-            break;
-        case 3:
-            if (!(nand_flash_ids[s->chip_id].options & NAND_SAMSUNG_LP) &&
-                    (s->cmd == NAND_CMD_READ0 ||
-                     s->cmd == NAND_CMD_PAGEPROGRAM1)) {
-                nand_command(s);
-            }
-            break;
-        case 4:
-            if ((nand_flash_ids[s->chip_id].options & NAND_SAMSUNG_LP) &&
-                    nand_flash_ids[s->chip_id].size < 256 && /* 1Gb or less */
-                    (s->cmd == NAND_CMD_READ0 ||
-                     s->cmd == NAND_CMD_PAGEPROGRAM1)) {
-                nand_command(s);
-            }
-            break;
-        case 5:
-            if ((nand_flash_ids[s->chip_id].options & NAND_SAMSUNG_LP) &&
-                    nand_flash_ids[s->chip_id].size >= 256 && /* 2Gb or more */
-                    (s->cmd == NAND_CMD_READ0 ||
-                     s->cmd == NAND_CMD_PAGEPROGRAM1)) {
-                nand_command(s);
-            }
-            break;
-        default:
-            break;
-        }
-    }
-
-    if (!s->cle && !s->ale && s->cmd == NAND_CMD_PAGEPROGRAM1) {
-        if (s->iolen < (1 << s->page_shift) + (1 << s->oob_shift)) {
-            for (i = s->buswidth; i--; value >>= 8) {
-                s->io[s->iolen ++] = (uint8_t) (value & 0xff);
-            }
-        }
-    } else if (!s->cle && !s->ale && s->cmd == NAND_CMD_COPYBACKPRG1) {
-        if ((s->addr & ((1 << s->addr_shift) - 1)) <
-                (1 << s->page_shift) + (1 << s->oob_shift)) {
-            for (i = s->buswidth; i--; s->addr++, value >>= 8) {
-                s->io[s->iolen + (s->addr & ((1 << s->addr_shift) - 1))] =
-                    (uint8_t) (value & 0xff);
-            }
-        }
-    }
-}
-
-uint32_t nand_getio(DeviceState *dev)
-{
-    int offset;
-    uint32_t x = 0;
-    NANDFlashState *s = NAND(dev);
-
-    /* Allow sequential reading */
-    if (!s->iolen && s->cmd == NAND_CMD_READ0) {
-        offset = (int) (s->addr & ((1 << s->addr_shift) - 1)) + s->offset;
-        s->offset = 0;
-        s->iolen = nand_load_block(s, offset);
-    }
-
-    if (s->ce || s->iolen <= 0) {
-        return 0;
-    }
-
-    for (offset = s->buswidth; offset--;) {
-        x |= s->ioaddr[offset] << (offset << 3);
-    }
-    /* after receiving READ STATUS command all subsequent reads will
-     * return the status register value until another command is issued
-     */
-    if (s->cmd != NAND_CMD_READSTATUS) {
-        s->addr   += s->buswidth;
-        s->ioaddr += s->buswidth;
-        s->iolen  -= s->buswidth;
-    }
-    return x;
-}
-
-uint32_t nand_getbuswidth(DeviceState *dev)
-{
-    NANDFlashState *s = (NANDFlashState *) dev;
-    return s->buswidth << 3;
-}
-
-DeviceState *nand_init(BlockBackend *blk, int manf_id, int chip_id)
-{
-    DeviceState *dev;
-
-    if (nand_flash_ids[chip_id].size == 0) {
-        hw_error("%s: Unsupported NAND chip ID.\n", __func__);
-    }
-    dev = qdev_new(TYPE_NAND);
-    qdev_prop_set_uint8(dev, "manufacturer_id", manf_id);
-    qdev_prop_set_uint8(dev, "chip_id", chip_id);
-    if (blk) {
-        qdev_prop_set_drive_err(dev, "drive", blk, &error_fatal);
-    }
-
-    qdev_realize(dev, NULL, &error_fatal);
-    return dev;
-}
-
-type_init(nand_register_types)
-
-#else
-
-/* Program a single page */
-static void glue(nand_blk_write_, NAND_PAGE_SIZE)(NANDFlashState *s)
-{
-    uint64_t off, page, sector, soff;
-    uint8_t iobuf[(PAGE_SECTORS + 2) * 0x200];
-    if (PAGE(s->addr) >= s->pages)
-        return;
-
-    if (!s->blk) {
-        mem_and(s->storage + PAGE_START(s->addr) + (s->addr & PAGE_MASK) +
-                        s->offset, s->io, s->iolen);
-    } else if (s->mem_oob) {
-        sector = SECTOR(s->addr);
-        off = (s->addr & PAGE_MASK) + s->offset;
-        soff = SECTOR_OFFSET(s->addr);
-        if (blk_pread(s->blk, sector << BDRV_SECTOR_BITS,
-                      PAGE_SECTORS << BDRV_SECTOR_BITS, iobuf, 0) < 0) {
-            printf("%s: read error in sector %" PRIu64 "\n", __func__, sector);
-            return;
-        }
-
-        mem_and(iobuf + (soff | off), s->io, MIN(s->iolen, NAND_PAGE_SIZE - off));
-        if (off + s->iolen > NAND_PAGE_SIZE) {
-            page = PAGE(s->addr);
-            mem_and(s->storage + (page << OOB_SHIFT), s->io + NAND_PAGE_SIZE - off,
-                            MIN(OOB_SIZE, off + s->iolen - NAND_PAGE_SIZE));
-        }
-
-        if (blk_pwrite(s->blk, sector << BDRV_SECTOR_BITS,
-                       PAGE_SECTORS << BDRV_SECTOR_BITS, iobuf, 0) < 0) {
-            printf("%s: write error in sector %" PRIu64 "\n", __func__, sector);
-        }
-    } else {
-        off = PAGE_START(s->addr) + (s->addr & PAGE_MASK) + s->offset;
-        sector = off >> 9;
-        soff = off & 0x1ff;
-        if (blk_pread(s->blk, sector << BDRV_SECTOR_BITS,
-                      (PAGE_SECTORS + 2) << BDRV_SECTOR_BITS, iobuf, 0) < 0) {
-            printf("%s: read error in sector %" PRIu64 "\n", __func__, sector);
-            return;
-        }
-
-        mem_and(iobuf + soff, s->io, s->iolen);
-
-        if (blk_pwrite(s->blk, sector << BDRV_SECTOR_BITS,
-                       (PAGE_SECTORS + 2) << BDRV_SECTOR_BITS, iobuf, 0) < 0) {
-            printf("%s: write error in sector %" PRIu64 "\n", __func__, sector);
-        }
-    }
-    s->offset = 0;
-}
-
-/* Erase a single block */
-static void glue(nand_blk_erase_, NAND_PAGE_SIZE)(NANDFlashState *s)
-{
-    uint64_t i, page, addr;
-    uint8_t iobuf[0x200] = { [0 ... 0x1ff] = 0xff, };
-    addr = s->addr & ~((1 << (ADDR_SHIFT + s->erase_shift)) - 1);
-
-    if (PAGE(addr) >= s->pages) {
-        return;
-    }
-
-    if (!s->blk) {
-        memset(s->storage + PAGE_START(addr),
-                        0xff, (NAND_PAGE_SIZE + OOB_SIZE) << s->erase_shift);
-    } else if (s->mem_oob) {
-        memset(s->storage + (PAGE(addr) << OOB_SHIFT),
-                        0xff, OOB_SIZE << s->erase_shift);
-        i = SECTOR(addr);
-        page = SECTOR(addr + (1 << (ADDR_SHIFT + s->erase_shift)));
-        for (; i < page; i ++)
-            if (blk_pwrite(s->blk, i << BDRV_SECTOR_BITS,
-                           BDRV_SECTOR_SIZE, iobuf, 0) < 0) {
-                printf("%s: write error in sector %" PRIu64 "\n", __func__, i);
-            }
-    } else {
-        addr = PAGE_START(addr);
-        page = addr >> 9;
-        if (blk_pread(s->blk, page << BDRV_SECTOR_BITS,
-                      BDRV_SECTOR_SIZE, iobuf, 0) < 0) {
-            printf("%s: read error in sector %" PRIu64 "\n", __func__, page);
-        }
-        memset(iobuf + (addr & 0x1ff), 0xff, (~addr & 0x1ff) + 1);
-        if (blk_pwrite(s->blk, page << BDRV_SECTOR_BITS,
-                       BDRV_SECTOR_SIZE, iobuf, 0) < 0) {
-            printf("%s: write error in sector %" PRIu64 "\n", __func__, page);
-        }
-
-        memset(iobuf, 0xff, 0x200);
-        i = (addr & ~0x1ff) + 0x200;
-        for (addr += ((NAND_PAGE_SIZE + OOB_SIZE) << s->erase_shift) - 0x200;
-                        i < addr; i += 0x200) {
-            if (blk_pwrite(s->blk, i, BDRV_SECTOR_SIZE, iobuf, 0) < 0) {
-                printf("%s: write error in sector %" PRIu64 "\n",
-                       __func__, i >> 9);
-            }
-        }
-
-        page = i >> 9;
-        if (blk_pread(s->blk, page << BDRV_SECTOR_BITS,
-                      BDRV_SECTOR_SIZE, iobuf, 0) < 0) {
-            printf("%s: read error in sector %" PRIu64 "\n", __func__, page);
-        }
-        memset(iobuf, 0xff, ((addr - 1) & 0x1ff) + 1);
-        if (blk_pwrite(s->blk, page << BDRV_SECTOR_BITS,
-                       BDRV_SECTOR_SIZE, iobuf, 0) < 0) {
-            printf("%s: write error in sector %" PRIu64 "\n", __func__, page);
-        }
-    }
-}
-
-static bool glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
-                                                 uint64_t addr, unsigned offset)
-{
-    if (PAGE(addr) >= s->pages) {
-        return false;
-    }
-
-    if (offset > NAND_PAGE_SIZE + OOB_SIZE) {
-        return false;
-    }
-
-    if (s->blk) {
-        if (s->mem_oob) {
-            if (blk_pread(s->blk, SECTOR(addr) << BDRV_SECTOR_BITS,
-                          PAGE_SECTORS << BDRV_SECTOR_BITS, s->io, 0) < 0) {
-                printf("%s: read error in sector %" PRIu64 "\n",
-                                __func__, SECTOR(addr));
-            }
-            memcpy(s->io + SECTOR_OFFSET(s->addr) + NAND_PAGE_SIZE,
-                            s->storage + (PAGE(s->addr) << OOB_SHIFT),
-                            OOB_SIZE);
-            s->ioaddr = s->io + SECTOR_OFFSET(s->addr) + offset;
-        } else {
-            if (blk_pread(s->blk, PAGE_START(addr),
-                          (PAGE_SECTORS + 2) << BDRV_SECTOR_BITS, s->io, 0)
-                < 0) {
-                printf("%s: read error in sector %" PRIu64 "\n",
-                                __func__, PAGE_START(addr) >> 9);
-            }
-            s->ioaddr = s->io + (PAGE_START(addr) & 0x1ff) + offset;
-        }
-    } else {
-        memcpy(s->io, s->storage + PAGE_START(s->addr) +
-                        offset, NAND_PAGE_SIZE + OOB_SIZE - offset);
-        s->ioaddr = s->io;
-    }
-
-    return true;
-}
-
-static void glue(nand_init_, NAND_PAGE_SIZE)(NANDFlashState *s)
-{
-    s->oob_shift = PAGE_SHIFT - 5;
-    s->pages = s->size >> PAGE_SHIFT;
-    s->addr_shift = ADDR_SHIFT;
-
-    s->blk_erase = glue(nand_blk_erase_, NAND_PAGE_SIZE);
-    s->blk_write = glue(nand_blk_write_, NAND_PAGE_SIZE);
-    s->blk_load = glue(nand_blk_load_, NAND_PAGE_SIZE);
-}
-
-# undef NAND_PAGE_SIZE
-# undef PAGE_SHIFT
-# undef PAGE_SECTORS
-# undef ADDR_SHIFT
-#endif /* NAND_IO */
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index a55b44d7bde..f543d944c30 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -147,7 +147,6 @@ config OMAP
     bool
     select FRAMEBUFFER
     select I2C
-    select NAND
     select PFLASH_CFI01
     select SD
     select SERIAL_MM
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index a898e04f03b..737dbcdb3e9 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -13,9 +13,6 @@ config FDC_SYSBUS
 config SSI_M25P80
     bool
 
-config NAND
-    bool
-
 config PFLASH_CFI01
     bool
 
diff --git a/hw/block/meson.build b/hw/block/meson.build
index 16a51bf8e21..655704471a5 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -6,7 +6,6 @@ system_ss.add(files(
 system_ss.add(when: 'CONFIG_FDC', if_true: files('fdc.c'))
 system_ss.add(when: 'CONFIG_FDC_ISA', if_true: files('fdc-isa.c'))
 system_ss.add(when: 'CONFIG_FDC_SYSBUS', if_true: files('fdc-sysbus.c'))
-system_ss.add(when: 'CONFIG_NAND', if_true: files('nand.c'))
 system_ss.add(when: 'CONFIG_PFLASH_CFI01', if_true: files('pflash_cfi01.c'))
 system_ss.add(when: 'CONFIG_PFLASH_CFI02', if_true: files('pflash_cfi02.c'))
 system_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80.c'))
-- 
2.43.0


