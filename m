Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA6593CBE8
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Jul 2024 02:11:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8KD-0007JN-IW; Thu, 25 Jul 2024 19:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8K8-0006wN-KR; Thu, 25 Jul 2024 19:56:40 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8K5-0001A3-IP; Thu, 25 Jul 2024 19:56:40 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2cd2f89825fso306709a91.1; 
 Thu, 25 Jul 2024 16:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951795; x=1722556595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apdo8KuaRqfanrGEmMNx13cONTGuIjK7JBMaWc5nJeI=;
 b=PeFQIGosYPpiACMmfVVnpOq611vynOwDN47GqqdIuvVBJCgULOVEC7mxck0omawW9U
 pdaudQturvw+XQEo8fs4TKLvwcMDUkPLeEDQtBnCZosS5eOfjfASC0CPay5Q+QkrWg9Z
 P06zhmTJ2c+rIYtKAvrbss/8lqPdOn+SJTLnOTFILCR1dg/8UeEyjNdTxs0oA+319Zp1
 hV3VYiuswo9cFVHB7UGT7z0EF3NCRa+Snb+flEukoVl89mhjt3HMmHaTwcdRO2+QlX/o
 +9ptVL7GEcQGhJEPhPWfIPyGcVNgYzIj2Qx1VoIKjqzSHZWFjdo2CIjKM/tKGLohGOrv
 sDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951795; x=1722556595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=apdo8KuaRqfanrGEmMNx13cONTGuIjK7JBMaWc5nJeI=;
 b=SAm4noHY1Vu3zXGG5VbJeAOf0CeGq7e6nmFm9wUMsjuWz+y0BnFBHm2R9AIy1He0AC
 DCDbzRALMIHOaYfvWLoybEBlmd/xIeJbmGUK7+u/o79yoO+CEaYUFZPq7PbrowrBFAc4
 jFn3Pr1N1l5HUgOOhgW48qoaCro/Nwkk3A0+HvoAewlFx32ZHmbbJ9/JWaiKLSA8QCvW
 UoE5EVqII2K67BZozeC+0ZVbuW9ImBdxs6GzlDgv+/sUbRhY1nuxnLXVRYh1ZYnGYqgZ
 Ql1zE55zmmYrSr63J4mBpHdo/zGO4DHLdHP+tJQ+bccFP9UmYveUYKAlSPq4MKiWhM17
 KO5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8+CCCpfoAt/tZgpGT4s5PLgqwG7lEiJx+EgR5UWWj95alhGG3hokz3olhkrpbRRCdITzsHZJeHjItd5lT+8mRu6NA
X-Gm-Message-State: AOJu0YwtJUZaCyGzOx+VSzu5dtfjdTHQSnGqCgUM1Jz93l+i0jUW5EO9
 9pyCvktFZ0QrW0Ahdb4++TtaweEQ7IoIWR1ipbREmM6PT4gcNBUIzWk/3w==
X-Google-Smtp-Source: AGHT+IHu4fCN6kZ9QgLdazCKjsG6FLm19JRkQ2A5ZIoj5BzwfHZK91MajookthQ0+jPijtK1WkavTQ==
X-Received: by 2002:a17:90a:f104:b0:2c9:5ecd:e3c4 with SMTP id
 98e67ed59e1d1-2cf2ebb9113mr4023111a91.35.1721951794944; 
 Thu, 25 Jul 2024 16:56:34 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:56:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 37/96] hw/ssi: Add SPI model
Date: Fri, 26 Jul 2024 09:53:10 +1000
Message-ID: <20240725235410.451624-38-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

SPI controller device model supports a connection to a single SPI responder.
This provide access to SPI seeproms, TPM, flash device and an ADC controller.

All SPI function control is mapped into the SPI register space to enable full
control by firmware. In this commit SPI configuration component is modelled
which contains all SPI configuration and status registers as well as the hold
registers for data to be sent or having been received.

An existing QEMU SSI framework is used and SSI_BUS is created.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
[np: Fix FDT macro compile for qtest]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/Kconfig                |   3 +
 hw/ssi/Kconfig                |   4 +
 hw/ssi/meson.build            |   1 +
 hw/ssi/pnv_spi.c              | 215 ++++++++++++++++++++++++++++++++++
 hw/ssi/trace-events           |   6 +
 include/hw/ppc/pnv_xscom.h    |   3 +
 include/hw/ssi/pnv_spi.h      |  40 +++++++
 include/hw/ssi/pnv_spi_regs.h |  67 +++++++++++
 8 files changed, 339 insertions(+)
 create mode 100644 hw/ssi/pnv_spi.c
 create mode 100644 include/hw/ssi/pnv_spi.h
 create mode 100644 include/hw/ssi/pnv_spi_regs.h

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 347212f4db..c235519881 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -39,6 +39,9 @@ config POWERNV
     select PCI_POWERNV
     select PCA9552
     select PCA9554
+    select SSI
+    select SSI_M25P80
+    select PNV_SPI
 
 config PPC405
     bool
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 83ee53c1d0..8d180de7cf 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -24,3 +24,7 @@ config STM32F2XX_SPI
 config BCM2835_SPI
     bool
     select SSI
+
+config PNV_SPI
+    bool
+    select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index b999aeb027..b7ad7fca3b 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -12,3 +12,4 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
+system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
new file mode 100644
index 0000000000..468afdad07
--- /dev/null
+++ b/hw/ssi/pnv_spi.c
@@ -0,0 +1,215 @@
+/*
+ * QEMU PowerPC SPI model
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ssi/pnv_spi.h"
+#include "hw/ssi/pnv_spi_regs.h"
+#include "hw/ssi/ssi.h"
+#include <libfdt.h>
+#include "hw/irq.h"
+#include "trace.h"
+
+/*
+ * Macro from include/hw/ppc/fdt.h
+ * fdt.h cannot be included here as it contain ppc target specific dependency.
+ */
+#define _FDT(exp)                                                  \
+    do {                                                           \
+        int _ret = (exp);                                          \
+        if (_ret < 0) {                                            \
+            qemu_log_mask(LOG_GUEST_ERROR,                         \
+                    "error creating device tree: %s: %s",          \
+                    #exp, fdt_strerror(_ret));                     \
+            exit(1);                                               \
+        }                                                          \
+    } while (0)
+
+static uint64_t pnv_spi_xscom_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PnvSpi *s = PNV_SPI(opaque);
+    uint32_t reg = addr >> 3;
+    uint64_t val = ~0ull;
+
+    switch (reg) {
+    case ERROR_REG:
+    case SPI_CTR_CFG_REG:
+    case CONFIG_REG1:
+    case SPI_CLK_CFG_REG:
+    case SPI_MM_REG:
+    case SPI_XMIT_DATA_REG:
+        val = s->regs[reg];
+        break;
+    case SPI_RCV_DATA_REG:
+        val = s->regs[reg];
+        trace_pnv_spi_read_RDR(val);
+        s->status = SETFIELD(SPI_STS_RDR_FULL, s->status, 0);
+        break;
+    case SPI_SEQ_OP_REG:
+        val = 0;
+        for (int i = 0; i < PNV_SPI_REG_SIZE; i++) {
+            val = (val << 8) | s->seq_op[i];
+        }
+        break;
+    case SPI_STS_REG:
+        val = s->status;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi_regs: Invalid xscom "
+                 "read at 0x%" PRIx32 "\n", reg);
+    }
+
+    trace_pnv_spi_read(addr, val);
+    return val;
+}
+
+static void pnv_spi_xscom_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    PnvSpi *s = PNV_SPI(opaque);
+    uint32_t reg = addr >> 3;
+
+    trace_pnv_spi_write(addr, val);
+
+    switch (reg) {
+    case ERROR_REG:
+    case SPI_CTR_CFG_REG:
+    case CONFIG_REG1:
+    case SPI_MM_REG:
+    case SPI_RCV_DATA_REG:
+        s->regs[reg] = val;
+        break;
+    case SPI_CLK_CFG_REG:
+        /*
+         * To reset the SPI controller write the sequence 0x5 0xA to
+         * reset_control field
+         */
+        if ((GETFIELD(SPI_CLK_CFG_RST_CTRL, s->regs[SPI_CLK_CFG_REG]) == 0x5)
+             && (GETFIELD(SPI_CLK_CFG_RST_CTRL, val) == 0xA)) {
+                /* SPI controller reset sequence completed, resetting */
+            s->regs[reg] = SPI_CLK_CFG_HARD_RST;
+        } else {
+            s->regs[reg] = val;
+        }
+        break;
+    case SPI_XMIT_DATA_REG:
+        /*
+         * Writing to the transmit data register causes the transmit data
+         * register full status bit in the status register to be set.  Writing
+         * when the transmit data register full status bit is already set
+         * causes a "Resource Not Available" condition.  This is not possible
+         * in the model since writes to this register are not asynchronous to
+         * the operation sequence like it would be in hardware.
+         */
+        s->regs[reg] = val;
+        trace_pnv_spi_write_TDR(val);
+        s->status = SETFIELD(SPI_STS_TDR_FULL, s->status, 1);
+        s->status = SETFIELD(SPI_STS_TDR_UNDERRUN, s->status, 0);
+        break;
+    case SPI_SEQ_OP_REG:
+        for (int i = 0; i < PNV_SPI_REG_SIZE; i++) {
+            s->seq_op[i] = (val >> (56 - i * 8)) & 0xFF;
+        }
+        break;
+    case SPI_STS_REG:
+        /* other fields are ignore_write */
+        s->status = SETFIELD(SPI_STS_RDR_OVERRUN, s->status,
+                                  GETFIELD(SPI_STS_RDR, val));
+        s->status = SETFIELD(SPI_STS_TDR_OVERRUN, s->status,
+                                  GETFIELD(SPI_STS_TDR, val));
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi_regs: Invalid xscom "
+                 "write at 0x%" PRIx32 "\n", reg);
+    }
+    return;
+}
+
+static const MemoryRegionOps pnv_spi_xscom_ops = {
+    .read = pnv_spi_xscom_read,
+    .write = pnv_spi_xscom_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static Property pnv_spi_properties[] = {
+    DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_spi_realize(DeviceState *dev, Error **errp)
+{
+    PnvSpi *s = PNV_SPI(dev);
+    g_autofree char *name = g_strdup_printf(TYPE_PNV_SPI_BUS ".%d",
+                    s->spic_num);
+    s->ssi_bus = ssi_create_bus(dev, name);
+    s->cs_line = g_new0(qemu_irq, 1);
+    qdev_init_gpio_out_named(DEVICE(s), s->cs_line, "cs", 1);
+
+    /* spi scoms */
+    pnv_xscom_region_init(&s->xscom_spic_regs, OBJECT(s), &pnv_spi_xscom_ops,
+                          s, "xscom-spi", PNV10_XSCOM_PIB_SPIC_SIZE);
+}
+
+static int pnv_spi_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int offset)
+{
+    PnvSpi *s = PNV_SPI(dev);
+    g_autofree char *name;
+    int s_offset;
+    const char compat[] = "ibm,power10-spi";
+    uint32_t spic_pcba = PNV10_XSCOM_PIB_SPIC_BASE +
+        s->spic_num * PNV10_XSCOM_PIB_SPIC_SIZE;
+    uint32_t reg[] = {
+        cpu_to_be32(spic_pcba),
+        cpu_to_be32(PNV10_XSCOM_PIB_SPIC_SIZE)
+    };
+    name = g_strdup_printf("pnv_spi@%x", spic_pcba);
+    s_offset = fdt_add_subnode(fdt, offset, name);
+    _FDT(s_offset);
+
+    _FDT(fdt_setprop(fdt, s_offset, "reg", reg, sizeof(reg)));
+    _FDT(fdt_setprop(fdt, s_offset, "compatible", compat, sizeof(compat)));
+    _FDT((fdt_setprop_cell(fdt, s_offset, "spic_num#", s->spic_num)));
+    return 0;
+}
+
+static void pnv_spi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
+
+    xscomc->dt_xscom = pnv_spi_dt_xscom;
+
+    dc->desc = "PowerNV SPI";
+    dc->realize = pnv_spi_realize;
+    device_class_set_props(dc, pnv_spi_properties);
+}
+
+static const TypeInfo pnv_spi_info = {
+    .name          = TYPE_PNV_SPI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PnvSpi),
+    .class_init    = pnv_spi_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_spi_register_types(void)
+{
+    type_register_static(&pnv_spi_info);
+}
+
+type_init(pnv_spi_register_types);
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 7b5ad6a939..2cc29e1284 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -32,3 +32,9 @@ ibex_spi_host_reset(const char *msg) "%s"
 ibex_spi_host_transfer(uint32_t tx_data, uint32_t rx_data) "tx_data: 0x%" PRIx32 " rx_data: @0x%" PRIx32
 ibex_spi_host_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
 ibex_spi_host_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size %u:"
+
+#pnv_spi.c
+pnv_spi_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
+pnv_spi_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
+pnv_spi_read_RDR(uint64_t val) "data extracted = 0x%" PRIx64
+pnv_spi_write_TDR(uint64_t val) "being written, data written = 0x%" PRIx64
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 764b324a00..648388a599 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -200,6 +200,9 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_PEC_PCI_BASE   0x8010800 /* index goes upwards ... */
 #define PNV10_XSCOM_PEC_PCI_SIZE   0x200
 
+#define PNV10_XSCOM_PIB_SPIC_BASE 0xc0000
+#define PNV10_XSCOM_PIB_SPIC_SIZE 0x20
+
 void pnv_xscom_init(PnvChip *chip, uint64_t size, hwaddr addr);
 int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
                  uint64_t xscom_base, uint64_t xscom_size,
diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
new file mode 100644
index 0000000000..833042b74b
--- /dev/null
+++ b/include/hw/ssi/pnv_spi.h
@@ -0,0 +1,40 @@
+/*
+ * QEMU PowerPC SPI model
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This model Supports a connection to a single SPI responder.
+ * Introduced for P10 to provide access to SPI seeproms, TPM, flash device
+ * and an ADC controller.
+ */
+
+#ifndef PPC_PNV_SPI_H
+#define PPC_PNV_SPI_H
+
+#include "hw/ssi/ssi.h"
+#include "hw/sysbus.h"
+
+#define TYPE_PNV_SPI "pnv-spi"
+OBJECT_DECLARE_SIMPLE_TYPE(PnvSpi, PNV_SPI)
+
+#define PNV_SPI_REG_SIZE 8
+#define PNV_SPI_REGS 7
+
+#define TYPE_PNV_SPI_BUS "pnv-spi-bus"
+typedef struct PnvSpi {
+    SysBusDevice parent_obj;
+
+    SSIBus *ssi_bus;
+    qemu_irq *cs_line;
+    MemoryRegion    xscom_spic_regs;
+    /* SPI object number */
+    uint32_t        spic_num;
+
+    /* SPI registers */
+    uint64_t        regs[PNV_SPI_REGS];
+    uint8_t         seq_op[PNV_SPI_REG_SIZE];
+    uint64_t        status;
+} PnvSpi;
+#endif /* PPC_PNV_SPI_H */
diff --git a/include/hw/ssi/pnv_spi_regs.h b/include/hw/ssi/pnv_spi_regs.h
new file mode 100644
index 0000000000..5b6ff72d02
--- /dev/null
+++ b/include/hw/ssi/pnv_spi_regs.h
@@ -0,0 +1,67 @@
+/*
+ * QEMU PowerPC SPI model
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PNV_SPI_CONTROLLER_REGS_H
+#define PNV_SPI_CONTROLLER_REGS_H
+
+/*
+ * Macros from target/ppc/cpu.h
+ * These macros are copied from ppc target specific file target/ppc/cpu.h
+ * as target/ppc/cpu.h cannot be included here.
+ */
+#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
+#define PPC_BIT8(bit)           (0x80 >> (bit))
+#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
+#define PPC_BITMASK8(bs, be)    ((PPC_BIT8(bs) - PPC_BIT8(be)) | PPC_BIT8(bs))
+#define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
+#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
+#define SETFIELD(m, v, val) \
+        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
+
+/* Error Register */
+#define ERROR_REG               0x00
+
+/* counter_config_reg */
+#define SPI_CTR_CFG_REG         0x01
+
+/* config_reg */
+#define CONFIG_REG1             0x02
+
+/* clock_config_reset_control_ecc_enable_reg */
+#define SPI_CLK_CFG_REG         0x03
+#define SPI_CLK_CFG_HARD_RST    0x0084000000000000;
+#define SPI_CLK_CFG_RST_CTRL    PPC_BITMASK(24, 27)
+
+/* memory_mapping_reg */
+#define SPI_MM_REG              0x04
+
+/* transmit_data_reg */
+#define SPI_XMIT_DATA_REG       0x05
+
+/* receive_data_reg */
+#define SPI_RCV_DATA_REG        0x06
+
+/* sequencer_operation_reg */
+#define SPI_SEQ_OP_REG          0x07
+
+/* status_reg */
+#define SPI_STS_REG             0x08
+#define SPI_STS_RDR_FULL        PPC_BIT(0)
+#define SPI_STS_RDR_OVERRUN     PPC_BIT(1)
+#define SPI_STS_RDR_UNDERRUN    PPC_BIT(2)
+#define SPI_STS_TDR_FULL        PPC_BIT(4)
+#define SPI_STS_TDR_OVERRUN     PPC_BIT(5)
+#define SPI_STS_TDR_UNDERRUN    PPC_BIT(6)
+#define SPI_STS_SEQ_FSM         PPC_BITMASK(8, 15)
+#define SPI_STS_SHIFTER_FSM     PPC_BITMASK(16, 27)
+#define SPI_STS_SEQ_INDEX       PPC_BITMASK(28, 31)
+#define SPI_STS_GEN_STATUS      PPC_BITMASK(32, 63)
+#define SPI_STS_RDR             PPC_BITMASK(1, 3)
+#define SPI_STS_TDR             PPC_BITMASK(5, 7)
+
+#endif
-- 
2.45.2


