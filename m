Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBC37CDC32
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:47:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt5vo-0007MH-Jn; Wed, 18 Oct 2023 08:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick.rudolph@9elements.com>)
 id 1qt56P-0003wG-52
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:52:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <patrick.rudolph@9elements.com>)
 id 1qt56L-0001AJ-HO
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:52:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4081ccf69dcso9740815e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1697629955; x=1698234755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s/EddyLHDuC0hNkEDPB55PVhXXS5gRZHz2sKNyS+fuA=;
 b=O2K0PaZ7D9hmCsS37YFOE+7n632Uhsq7lS0rpvvb3pLlutfRWcyBM6UCTjyZbfWRIP
 hbMpwCU1CUyd1zmMHNo8jiJRrC6qrbkidoYi9OFdMbgKxqIkZmbObfj5Dl7DuDYocjNF
 XnxgEnEdyVWBVncfVRg6eV2576/0JD82pabk5R7kj9efLmmXCx97b9e0HWWKfcCV0O4Z
 ACK+qI01nFiwOBL9794qy/4kHdn9vEJbuvJ6ZpTwRc01f0miSqmf7rkeaC7SdUlnZdwV
 Lmczt0fMVxvHz8G8NoEwQ4isfTJe5BN8fQW4KmZWAdihcMIZ29keMtY3ilwyhnFSmLP3
 1XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697629955; x=1698234755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/EddyLHDuC0hNkEDPB55PVhXXS5gRZHz2sKNyS+fuA=;
 b=P3yxGwgUlLP0YR3yy0IhEMEuLgkeFDUP2IgayKQXQuO9R4dTyweJUfe/7q4bvkKZMA
 gktbtjS+Oww9lc5SN3y9heA/PNp7bfwajk3FAxXbwO3f2khVdu1nLLZuOhaJRgW+vEHH
 Nc44TP1qJFNcHtzxETslAZLzBEkwf+K0IyZ1sb3P5y6GiJu7uoG7KHK/VJc53sUaELel
 E5yfaU+Tjs4bU3nxiKr18Pgru4mwYPl9LIAwyYL6vp7a0dPwbTEgipjZL6YpY+VAdCmh
 C1CZTExiQK/XRJmQ/aO+ULvoBUgcQ1gow2setKWm9q9ttm09UeQR5/8Lb1uhmGrAgvll
 eXoA==
X-Gm-Message-State: AOJu0YzoFhqsNc9u32kqKERYeBTiLCgNPBKB+ngzJ6ej/rMmPznKo3i3
 5/2V0jQM2x5ryu17Kw7G9DGSRIki6aPPHTyQMdicTQ==
X-Google-Smtp-Source: AGHT+IGYdtwunxl+Uffx+MpSEZl0TeqTzRzuXbA7L75fPfD/b/wGl+bqWOlla39qD2TT81K/uIa9Hg==
X-Received: by 2002:adf:b1d1:0:b0:32d:a366:7073 with SMTP id
 r17-20020adfb1d1000000b0032da3667073mr4360072wra.14.1697629955529; 
 Wed, 18 Oct 2023 04:52:35 -0700 (PDT)
Received: from fedora.9e.network
 (ip-078-094-000-052.um19.pools.vodafone-ip.de. [78.94.0.52])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a05600c489100b0040776008abdsm1455303wmp.40.2023.10.18.04.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 04:52:35 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, marcel.apfelbaum@gmail.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 1/3] hw/isa/ich9: Add SPI controller
Date: Wed, 18 Oct 2023 13:52:29 +0200
Message-ID: <20231018115231.3547102-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018115231.3547102-1-patrick.rudolph@9elements.com>
References: <20231018115231.3547102-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=patrick.rudolph@9elements.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Oct 2023 08:45:43 -0400
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

Implement a feature complete SPI controller that resides
in the LPC RCRB-MMIO space as on real ICH9.

Besides having a memory-mapped flash at top of 4GiB, the ICH9
SPI controller allows to work in two modes: HW sequencing and
SW sequencing. In HW sequencing, which only works in "descriptor mode",
the user doesn't need any knowledge of the SPI flash.
The SPI controller issues the correct commands were needed.

This commit introduces SW sequencing, as "descriptor mode" does
require a 4 KiB proprietary data structure at the start of the
SPI flash. In SW sequencing the user must identify the SPI flash
and generate commands the SPI flash understands.

The SPIBAR is placed at offset 0x3800 on RCRB-MMIO space on the
LPC PCI device.

As BIOS is mmaped on ICH9 enable BIOS emulation and synchronization
when the SPI flash was modified. This is required for UEFI variable
store operating on the newly introduced SPI controller.

When no MTD device is given a empty SPI flash is emulated that is
not MMAPed, thus the existing mechanisms all continue to work.

To enable BIOS MMAP and use the SPI flash as boot device add the argument:
-drive if=mtd,format=raw,file=...

TEST: Run "flashrom -p internal" inside the VM.
      flashrom is able to read the virtual flash.

TEST: Boot coreboot build for real ICH9 and be able to use UEFI
      variable store on top of the implemented ICH9 SPI controller.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 hw/isa/Kconfig                    |   2 +
 hw/isa/lpc_ich9.c                 |   3 +
 hw/isa/meson.build                |   2 +-
 hw/isa/spi_ich9.c                 | 448 ++++++++++++++++++++++++++++++
 include/hw/southbridge/ich9.h     |   4 +
 include/hw/southbridge/ich9_spi.h |  80 ++++++
 6 files changed, 538 insertions(+), 1 deletion(-)
 create mode 100644 hw/isa/spi_ich9.c
 create mode 100644 include/hw/southbridge/ich9_spi.h

diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index c10cbc5fc1..92f6dd5e5d 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -81,3 +81,5 @@ config LPC_ICH9
     select ISA_BUS
     select ACPI_ICH9
     select MC146818RTC
+    select SSI
+    select SSI_M25P80
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 3f59980aa0..01d6a46c3d 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -41,6 +41,7 @@
 #include "hw/isa/apm.h"
 #include "hw/pci/pci.h"
 #include "hw/southbridge/ich9.h"
+#include "hw/southbridge/ich9_spi.h"
 #include "hw/i386/pc.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ich9.h"
@@ -751,6 +752,7 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
     pci_bus_set_route_irq_fn(pci_bus, ich9_route_intx_pin_to_irq);
 
     ich9_lpc_pm_init(lpc);
+    ich9_spi_init(PCI_DEVICE(lpc), &lpc->spi, &lpc->rcrb_mem);
 }
 
 static bool ich9_rst_cnt_needed(void *opaque)
@@ -803,6 +805,7 @@ static const VMStateDescription vmstate_ich9_lpc = {
         VMSTATE_PCI_DEVICE(d, ICH9LPCState),
         VMSTATE_STRUCT(apm, ICH9LPCState, 0, vmstate_apm, APMState),
         VMSTATE_STRUCT(pm, ICH9LPCState, 0, vmstate_ich9_pm, ICH9LPCPMRegs),
+        VMSTATE_STRUCT(spi, ICH9LPCState, 0, vmstate_ich9_spi, ICH9SPIState),
         VMSTATE_UINT8_ARRAY(chip_config, ICH9LPCState, ICH9_CC_SIZE),
         VMSTATE_UINT32(sci_level, ICH9LPCState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/isa/meson.build b/hw/isa/meson.build
index b855e81276..d27289a693 100644
--- a/hw/isa/meson.build
+++ b/hw/isa/meson.build
@@ -8,4 +8,4 @@ system_ss.add(when: 'CONFIG_PIIX4', if_true: files('piix4.c'))
 system_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
 
-specific_ss.add(when: 'CONFIG_LPC_ICH9', if_true: files('lpc_ich9.c'))
+specific_ss.add(when: 'CONFIG_LPC_ICH9', if_true: files('lpc_ich9.c', 'spi_ich9.c'))
diff --git a/hw/isa/spi_ich9.c b/hw/isa/spi_ich9.c
new file mode 100644
index 0000000000..7d0adaaaab
--- /dev/null
+++ b/hw/isa/spi_ich9.c
@@ -0,0 +1,448 @@
+/*
+ * ICH9 SPI Emulation
+ *
+ * Copyright (c) 2023 9elements GmbH
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+#include "hw/southbridge/ich9.h"
+#include "hw/southbridge/ich9_spi.h"
+#include "hw/acpi/ich9.h"
+#include "hw/qdev-properties.h"
+#include "sysemu/block-backend-io.h"
+#include "sysemu/runstate.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/reset.h"
+#include "hw/core/cpu.h"
+#include "hw/ssi/ssi.h"
+#include "hw/sysbus.h"
+
+/*****************************************************************************/
+/* ICH9 SPIBAR 3800h to 39FFh in RCBA */
+
+#define ERASE_SECTOR_SIZE 0x10000
+
+typedef enum {
+    /* Prefix */
+    WREN = 0x6,
+    /* Read */
+    RDSFDP = 0x5a,
+    RDSR = 0x5,
+    READ = 0x03,
+    JEDEC_READ = 0x9f,
+    /* Write/Erase */
+    PP = 0x02,
+    ERASE_SECTOR = 0xd8,
+    WRSR = 0x1,
+} FlashCMD;
+
+/* Helper function to programm allowed commands */
+static void ich9_set_supported_command(ICH9SPIState *spi, uint8_t idx,
+                                       uint8_t op, bool is_write,
+                                       bool has_address)
+{
+    uint8_t *c = spi->regs;
+    pci_set_byte(c + ICH9_SPI_OPMENU + idx, op);
+
+    uint16_t type = pci_get_word(c + ICH9_SPI_OPTYPE);
+    type &= ~((ICH9_SPI_TYPE_WRITE | ICH9_SPI_TYPE_ADDRESS_REQ) << (idx * 2));
+
+    if (is_write) {
+        type |= ICH9_SPI_TYPE_WRITE << (idx * 2);
+    }
+    if (has_address) {
+        type |= ICH9_SPI_TYPE_ADDRESS_REQ << (idx * 2);
+    }
+
+    pci_set_word(c + ICH9_SPI_OPTYPE, type);
+}
+
+static void ich9_spi_reset(void *opaque)
+{
+    ICH9SPIState *spi = opaque;
+    uint8_t *c = spi->regs;
+
+    memset(c, 0, ICH9_SPI_SIZE);
+
+    /* Program allowable opcodes. The client must select one of those. */
+    pci_set_byte(c + ICH9_SPI_PREOP, WREN);
+    ich9_set_supported_command(spi, 0, RDSFDP,       false, true);
+    ich9_set_supported_command(spi, 1, RDSR,         false, false);
+    ich9_set_supported_command(spi, 2, READ,         false, true);
+    ich9_set_supported_command(spi, 3, JEDEC_READ,   false, false);
+    ich9_set_supported_command(spi, 4, PP,           true,  true);
+    ich9_set_supported_command(spi, 5, ERASE_SECTOR, true,  true);
+    ich9_set_supported_command(spi, 6, WRSR,         false, false);
+    /* Lock registers */
+    pci_set_long(c + ICH9_SPI_HSFS, ICH9_SPI_HSFS_FLOCKDN);
+}
+
+static bool ich9_spi_busy(ICH9SPIState *spi)
+{
+    uint8_t *c = spi->regs;
+
+    return !!(pci_get_long(c + ICH9_SPI_SSFS_FC) & ICH9_SPI_SSFS_FC_SCIP);
+}
+
+static bool ich9_spi_locked(ICH9SPIState *spi)
+{
+    uint8_t *c = spi->regs;
+
+    return !!(pci_get_long(c + ICH9_SPI_HSFS) & ICH9_SPI_HSFS_FLOCKDN);
+}
+
+static void ich9_spi_setbusy(ICH9SPIState *spi, bool state)
+{
+    uint8_t *c = spi->regs;
+    uint32_t ssfs = pci_get_long(c + ICH9_SPI_SSFS_FC);
+
+    qemu_set_irq(spi->cs_line, !state);
+
+    if (state) {
+        ssfs |= ICH9_SPI_SSFS_FC_SCIP;
+    } else {
+        ssfs &= ~ICH9_SPI_SSFS_FC_SCIP;
+    }
+    pci_set_long(c + ICH9_SPI_SSFS_FC, ssfs);
+}
+
+static void ich9_set_error(ICH9SPIState *spi, bool state)
+{
+    uint8_t *c = spi->regs;
+    uint32_t ssfs = pci_get_long(c + ICH9_SPI_SSFS_FC);
+
+    if (state) {
+        ssfs |= ICH9_SPI_SSFS_FC_FCERR;
+    } else {
+        ssfs &= ~ICH9_SPI_SSFS_FC_FCERR;
+    }
+    pci_set_long(c + ICH9_SPI_SSFS_FC, ssfs);
+}
+
+static void ich9_set_done(ICH9SPIState *spi, bool state)
+{
+    uint8_t *c = spi->regs;
+    uint32_t ssfs = pci_get_long(c + ICH9_SPI_SSFS_FC);
+
+    if (state) {
+        ssfs |= ICH9_SPI_SSFS_FC_CDONE;
+    } else {
+        ssfs &= ~ICH9_SPI_SSFS_FC_CDONE;
+    }
+    pci_set_long(c + ICH9_SPI_SSFS_FC, ssfs);
+
+    if (state && (ssfs & ICH9_SPI_SSFS_FC_SME)) {
+        ich9_generate_smi();
+    }
+}
+
+/* Execute one SPI transfer */
+static void ich9_spi_transfer(ICH9SPIState *s)
+{
+    uint8_t *c = s->regs;
+    uint32_t ssfs = pci_get_long(c + ICH9_SPI_SSFS_FC);
+    uint8_t cnt = ICH9_SPI_SSFS_FC_DBC(ssfs);
+    uint8_t cop = ICH9_SPI_SSFS_FC_COP(ssfs);
+    uint8_t spop = !!(ssfs & ICH9_SPI_SSFS_FC_SPOP);
+    bool atomic = !!(ssfs & ICH9_SPI_SSFS_FC_ACS);
+    uint8_t cmd = pci_get_byte(c + ICH9_SPI_OPMENU + cop);
+    uint8_t type = (pci_get_word(c + ICH9_SPI_OPTYPE) >> (cop * 2)) & 0x3;
+    uint32_t addr = pci_get_long(c + ICH9_SPI_FADDR);
+    uint8_t *rom = memory_region_get_ram_ptr(&s->bios);
+
+    ich9_spi_setbusy(s, true);
+
+    if (atomic) {
+        /* Transfer a single command before the real command executes */
+        ssi_transfer(s->spi, pci_get_byte(c + ICH9_SPI_PREOP + spop));
+        qemu_set_irq(s->cs_line, true);
+        qemu_set_irq(s->cs_line, false);
+    }
+
+    ssi_transfer(s->spi, cmd);
+
+    if (type & ICH9_SPI_TYPE_ADDRESS_REQ) {
+        for (int i = 2; i >= 0; i--) {
+            ssi_transfer(s->spi, (addr >> (8 * i)) & 0xff);
+        }
+    }
+
+    if (!(ssfs & ICH9_SPI_SSFS_FC_DS)) {
+        cnt = 0;
+    } else {
+        cnt++;
+    }
+
+    for (size_t i = 0; i < cnt; i++) {
+        if (type & ICH9_SPI_TYPE_WRITE) {
+            ssi_transfer(s->spi, pci_get_byte(c + ICH9_SPI_FDATA0 + i));
+        } else {
+            pci_set_byte(c + ICH9_SPI_FDATA0 + i, ssi_transfer(s->spi, 0));
+        }
+    }
+
+    /*
+     * Fix MMAPed BIOS ROM after modifying flash backend.
+     * The client can only run pre-defined commands, thus it's safe
+     * to only check for those two commands here.
+     */
+    if (cmd == ERASE_SECTOR) {
+        for (size_t i = 0; i < ERASE_SECTOR_SIZE; i += 4) {
+            pci_set_long(rom + i + addr, ~0);
+        }
+        memory_region_set_dirty(&s->bios, addr, ERASE_SECTOR_SIZE);
+    } else if (cmd == PP) {
+        for (size_t i = 0; i < cnt; i++) {
+            pci_set_byte(rom + i + addr, pci_get_byte(c + ICH9_SPI_FDATA0 + i));
+        }
+        memory_region_set_dirty(&s->bios, addr, cnt);
+    }
+
+    ich9_spi_setbusy(s, false);
+
+    ich9_set_done(s, true);
+}
+
+/* Return true if the register is writeable */
+static bool ich9_spi_writeable(ICH9SPIState *spi, hwaddr addr)
+{
+    switch (addr & ~3) {
+    case ICH9_SPI_SSFS_FC:
+    case ICH9_SPI_FADDR:
+    case ICH9_SPI_FDATA0...ICH9_SPI_FDATA16:
+        return true;
+    case ICH9_SPI_PREOP:
+    case ICH9_SPI_OPTYPE:
+    case ICH9_SPI_OPMENU...ICH9_SPI_OPMENU2:
+    case ICH9_SPI_PR0...ICH9_SPI_PR4:
+        return !ich9_spi_locked(spi);
+    }
+    return false;
+}
+
+/* val: little endian */
+static void ich9_spi_write(void *opaque, hwaddr addr,
+                           uint64_t val, unsigned len)
+{
+    ICH9SPIState *spi = (ICH9SPIState *)opaque;
+    uint8_t *c = spi->regs;
+    bool fire_transfer = false;
+    uint64_t mask;
+
+    if (!ich9_spi_writeable(spi, addr)) {
+        return;
+    }
+
+    /* Read/writeable registers */
+    switch (addr & ~3) {
+    case ICH9_SPI_PREOP:
+    case ICH9_SPI_OPTYPE:
+    case ICH9_SPI_OPMENU...ICH9_SPI_OPMENU2:
+    case ICH9_SPI_FADDR:
+    case ICH9_SPI_FDATA0...ICH9_SPI_FDATA16:
+    case ICH9_SPI_PR0...ICH9_SPI_PR4:
+        if (ich9_spi_busy(spi)) {
+            ich9_set_error(spi, true);
+            return;
+        }
+        memcpy(spi->regs + addr, &val, len);
+        return;
+    }
+
+    uint8_t ssfs = pci_get_long(c + ICH9_SPI_SSFS_FC);
+
+    /* Software sequencing flash status and flash control */
+    switch (addr) {
+    case ICH9_SPI_SSFS_FC:
+        /* RO bits */
+        val &= ~ICH9_SPI_SSFS_FC_SCIP;
+        val |= ssfs & ICH9_SPI_SSFS_FC_SCIP;
+
+        /* R/WC bits */
+        mask = ~val & ssfs & (ICH9_SPI_SSFS_FC_AEL | ICH9_SPI_SSFS_FC_FCERR |
+                 ICH9_SPI_SSFS_FC_CDONE);
+        val &= ~(ICH9_SPI_SSFS_FC_AEL | ICH9_SPI_SSFS_FC_FCERR |
+                 ICH9_SPI_SSFS_FC_CDONE);
+        val |= mask;
+        /* R/WS bits */
+        if (val & ICH9_SPI_SSFS_FC_SCGO) {
+            val &= ~ICH9_SPI_SSFS_FC_SCGO;
+            fire_transfer = true;
+        }
+
+        memcpy(spi->regs + addr, &val, len);
+        break;
+    case ICH9_SPI_SSFS_FC + 1:
+        /* R/WS bits */
+        if (val & (ICH9_SPI_SSFS_FC_SCGO >> 8)) {
+            val &= ~(ICH9_SPI_SSFS_FC_SCGO >> 8);
+            fire_transfer = true;
+        }
+
+        memcpy(spi->regs + addr, &val, len);
+        break;
+    default:
+        memcpy(spi->regs + addr, &val, len);
+        return;
+    }
+    if (fire_transfer) {
+        if (!ich9_spi_busy(spi)) {
+            ich9_spi_transfer(spi);
+        } else {
+            ich9_set_error(spi, true);
+        }
+    }
+}
+
+/* return value: little endian */
+static uint64_t ich9_spi_read(void *opaque, hwaddr addr,
+                              unsigned len)
+{
+    ICH9SPIState *spi = (ICH9SPIState *)opaque;
+    uint8_t *c = spi->regs;
+    uint32_t val = 0;
+
+    memcpy(&val, c + addr, len);
+    return val;
+}
+
+static const MemoryRegionOps spi_ops = {
+    .read = ich9_spi_read,
+    .write = ich9_spi_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = true,
+    },
+};
+
+const VMStateDescription vmstate_ich9_spi = {
+    .name = "ICH9SPI",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(regs, ICH9SPIState, ICH9_SPI_SIZE),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+void ich9_spi_init(PCIDevice *lpc_pci, ICH9SPIState *s, MemoryRegion *rcrb_mem)
+{
+    DeviceState *spi_flash;
+    DriveInfo *dinfo = drive_get(IF_MTD, 0, 0);
+    qemu_irq cs_line;
+    BusState *spi_bus;
+    const char *name = "s25sl12801";
+
+    /* SPIBAR resides in RCBR MMIO */
+    memory_region_init_io(&s->mmio, OBJECT(lpc_pci), &spi_ops, s,
+                          "ich9-spi", ICH9_SPI_SIZE);
+
+    memory_region_add_subregion_overlap(rcrb_mem,
+                                        ICH9_LPC_RCBA_SPIBAR,
+                                        &s->mmio,
+                                        2);
+
+    /* Create a bus to connect a SPI flash */
+    s->spi = ssi_create_bus(DEVICE(lpc_pci), "spi");
+    qdev_init_gpio_out_named(DEVICE(lpc_pci), &s->cs_line, "cs", 1);
+    spi_bus = qdev_get_child_bus(DEVICE(lpc_pci), "spi");
+
+    if (dinfo) {
+        BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
+        g_autofree void *storage = NULL;
+        int bios_size = blk_getlength(blk);
+        int isa_bios_size;
+
+        /* Select matching flash based on BIOS size */
+        switch (bios_size) {
+        case 512 * KiB:
+            name = "s25sl004a";
+            break;
+        case 1 * MiB:
+            name = "s25sl008a";
+            break;
+        case 2 * MiB:
+            name = "s25sl016a";
+            break;
+        case 4 * MiB:
+            name = "s25sl032a";
+            break;
+        case 8 * MiB:
+            name = "s25sl064a";
+            break;
+        default:
+            bios_size = 16 * MiB;
+            break;
+        }
+
+        /*
+         * Should use memory_region_init_io here, but KVM doesn't like to
+         * execute from MMIO...
+         */
+        memory_region_init_rom(&s->bios, NULL, "ich9.bios", bios_size,
+                               &error_abort);
+
+        /* map the last 128KB of the BIOS in ISA space */
+        isa_bios_size = MIN(bios_size, 128 * KiB);
+        memory_region_init_alias(&s->isa_bios, NULL, "ich9.isa-bios", &s->bios,
+                                 bios_size - isa_bios_size, isa_bios_size);
+        memory_region_add_subregion_overlap(get_system_memory(),
+                                                0x100000 - isa_bios_size,
+                                                &s->isa_bios,
+                                                1);
+
+        memory_region_add_subregion(get_system_memory(),
+                                    (uint32_t)(-bios_size), &s->bios);
+
+        storage = g_malloc0(bios_size);
+        if (blk_pread(blk, 0, bios_size, storage, 0) < 0) {
+            error_setg(&error_abort,
+                       "failed to read the initial flash content");
+            return;
+        }
+        /* TODO: find a better way to install the ROM */
+        memcpy(memory_region_get_ram_ptr(&s->bios), storage, bios_size);
+    }
+
+    spi_flash = qdev_new(name);
+
+    object_property_add_child(OBJECT(lpc_pci), "system.spi-flash",
+                              OBJECT(spi_flash));
+    object_property_add_alias(OBJECT(lpc_pci), "flash",
+                              OBJECT(spi_flash), "drive");
+    if (dinfo) {
+        qdev_prop_set_drive_err(spi_flash, "drive",
+                                blk_by_legacy_dinfo(dinfo), &error_fatal);
+    }
+    /* Attach SPI flash to SPI controller */
+    qdev_realize_and_unref(spi_flash, spi_bus, &error_fatal);
+    cs_line = qdev_get_gpio_in_named(spi_flash, SSI_GPIO_CS, 0);
+    qdev_connect_gpio_out_named(DEVICE(lpc_pci), "cs", 0, cs_line);
+
+    qemu_register_reset(ich9_spi_reset, s);
+}
+
diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index fd01649d04..1281eb654c 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -7,6 +7,8 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_device.h"
 #include "hw/rtc/mc146818rtc.h"
+#include "hw/sysbus.h"
+#include "hw/southbridge/ich9_spi.h"
 #include "exec/memory.h"
 #include "qemu/notify.h"
 #include "qom/object.h"
@@ -34,6 +36,7 @@ struct ICH9LPCState {
     MC146818RtcState rtc;
     APMState apm;
     ICH9LPCPMRegs pm;
+    ICH9SPIState spi;
     uint32_t sci_level; /* track sci level */
     uint8_t sci_gsi;
 
@@ -97,6 +100,7 @@ struct ICH9LPCState {
 #define ICH9_CC_GCS                             0x3410
 #define ICH9_CC_GCS_DEFAULT                     0x00000020
 #define ICH9_CC_GCS_NO_REBOOT                   (1 << 5)
+#define ICH9_LPC_RCBA_SPIBAR                    0x3800
 
 /* D28:F[0-5] */
 #define ICH9_PCIE_DEV                           28
diff --git a/include/hw/southbridge/ich9_spi.h b/include/hw/southbridge/ich9_spi.h
new file mode 100644
index 0000000000..a5926e7782
--- /dev/null
+++ b/include/hw/southbridge/ich9_spi.h
@@ -0,0 +1,80 @@
+#ifndef HW_SOUTHBRIDGE_ICH9_SPI_H
+#define HW_SOUTHBRIDGE_ICH9_SPI_H
+
+#include "hw/acpi/ich9.h"
+#include "hw/sysbus.h"
+#include "exec/memory.h"
+#include "qemu/notify.h"
+#include "qom/object.h"
+
+#define ICH9_SPI_SIZE 0x200 /* 512 bytes SPI configuration registers */
+
+#define TYPE_ICH9_SPI_DEVICE "ICH9-SPI"
+OBJECT_DECLARE_SIMPLE_TYPE(ICH9SPIState, ICH9_SPI_DEVICE)
+
+extern const VMStateDescription vmstate_ich9_spi;
+
+struct ICH9SPIState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+     /* <public> */
+    MemoryRegion mmio;
+    MemoryRegion bios;
+    MemoryRegion isa_bios;
+
+    qemu_irq cs_line;
+    SSIBus *spi;
+    uint8_t regs[ICH9_SPI_SIZE];
+};
+
+void ich9_spi_init(PCIDevice *lpc_pci, ICH9SPIState *s, MemoryRegion *rcrb_mem);
+
+/* ICH9: Chipset Configuration Registers Offset 3800h */
+
+#define ICH9_SPI_BFPREG             0x00
+
+#define ICH9_SPI_HSFS               0x04
+#define ICH9_SPI_HSFS_FLOCKDN       BIT(15)
+
+#define ICH9_SPI_FADDR              0x08
+#define ICH9_SPI_FDATA0             0x10
+#define ICH9_SPI_FDATA16            0x4C
+
+#define ICH9_SPI_PR0                0x78
+#define ICH9_SPI_PR4                0x84
+#define ICH9_SPI_PR_WR_PROT         BIT(31)
+#define ICH9_SPI_PR_RD_PROT         BIT(15)
+#define ICH9_SPI_PR_LIMIT(x)        (((x) >> 4) | 0xfff)
+#define ICH9_SPI_PR_BASE(x)         (((x) & 0x1fff) << 12)
+
+#define ICH9_SPI_SSFS_FC            0x90
+#define ICH9_SPI_SSFS_FC_FREQ_SHIFT 24
+#define ICH9_SPI_SSFS_FC_FREQ_MASK  (0x3 << SSFS_FC_FREQ_SHIFT)
+#define ICH9_SPI_SSFS_FC_SME        BIT(23)
+#define ICH9_SPI_SSFS_FC_DS         BIT(22)
+#define ICH9_SPI_SSFS_FC_DBC_SHIFT  16
+#define ICH9_SPI_SSFS_FC_DBC_MASK   0x3f
+#define ICH9_SPI_SSFS_FC_DBC(x)     (((x) >> ICH9_SPI_SSFS_FC_DBC_SHIFT) & \
+                                     ICH9_SPI_SSFS_FC_DBC_MASK)
+#define ICH9_SPI_SSFS_FC_COP_SHIFT  12
+#define ICH9_SPI_SSFS_FC_COP_MASK   0x7
+#define ICH9_SPI_SSFS_FC_COP(x)     (((x) >> ICH9_SPI_SSFS_FC_COP_SHIFT) & \
+                                     ICH9_SPI_SSFS_FC_COP_MASK)
+#define ICH9_SPI_SSFS_FC_SPOP       BIT(11)
+#define ICH9_SPI_SSFS_FC_ACS        BIT(10)
+#define ICH9_SPI_SSFS_FC_SCGO       BIT(9)
+#define ICH9_SPI_SSFS_FC_AEL        BIT(4)
+#define ICH9_SPI_SSFS_FC_FCERR      BIT(3)
+#define ICH9_SPI_SSFS_FC_CDONE      BIT(2)
+#define ICH9_SPI_SSFS_FC_SCIP       BIT(0)
+
+#define ICH9_SPI_PREOP              0x94
+#define ICH9_SPI_OPTYPE             0x96
+#define ICH9_SPI_TYPE_WRITE         BIT(0)
+#define ICH9_SPI_TYPE_ADDRESS_REQ   BIT(1)
+
+#define ICH9_SPI_OPMENU             0x98
+#define ICH9_SPI_OPMENU2            0x9C
+
+#endif
-- 
2.41.0


