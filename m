Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5AE7B4076
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 15:26:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmZxc-0007g1-NW; Sat, 30 Sep 2023 09:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qmZxZ-0007eq-SS
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 09:24:41 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qmZxU-0007fV-7u
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 09:24:41 -0400
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so2075075366b.0
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 06:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696080274; x=1696685074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FV40by2+k33RQuk8cLxc2eTRv0prRg7xMGQKqblYwNk=;
 b=V8L8vkVDCWiPwoDvBvEoMlYJhwGE3xI5nQRi9MI+RSiWDAcnMeslzQYbcJRnodehU/
 Tl9vKuEKIxifJ2N6dVrBuV05OPeNAyIRlKl9QU+0Z6nd4jnbcGeSE7OvE9Vxv6sx/3OM
 LhOaLfum6aK7MI8r3PRjaXdHUPbdjGprxY1wpqgvlx7wS7M7NGFVkIXHbaw3vNs1lv+5
 60U6tQS8IyiSuFo/o5hdI68xHcaefUAUG9FV7WrWJHIJ/v/f2GNN1FpVncEBBuM0d6Bm
 OcHenY1ouUb8oSXazHE8Vo9hgZbPKoCEfd52SytYpYBf9Zwv2ftW2O/av20Lzdem3vGL
 WsPA==
X-Gm-Message-State: AOJu0Yzbr1yKF+5TdJpw7H4VeWU+tK4ubJZ+sAR63vx88OrXMwQRZ6tR
 dRGCFvuGVWpmo638yLVTCLT1NEsHo8/5/g==
X-Google-Smtp-Source: AGHT+IGqmRwwyF88zXgFg6XRiyVVZs+AMKTCuoQwrIe4AiccMCabCjDynDaPDvp//GEMmkfnlsk1Ag==
X-Received: by 2002:a17:906:104e:b0:9af:9c4f:b579 with SMTP id
 j14-20020a170906104e00b009af9c4fb579mr6599309ejj.18.1696080273964; 
 Sat, 30 Sep 2023 06:24:33 -0700 (PDT)
Received: from fedora.. (ip-109-43-177-123.web.vodafone.de. [109.43.177.123])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a170906944f00b00993928e4d1bsm13919471ejx.24.2023.09.30.06.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 06:24:33 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 5/5] m68k: Add NeXTcube network controller
Date: Sat, 30 Sep 2023 15:23:51 +0200
Message-ID: <20230930132351.30282-6-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230930132351.30282-1-huth@tuxfamily.org>
References: <20230930132351.30282-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.50; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f50.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The device is based on Bryce's code from GSoC 2011 that can be found here:

 https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-net.c

The network boot unfortunately does not work yet (the firmware
successfully can send out packets, but still have problems receiving
the answer of the BOOTP server), but the code is also required to
avoid that the firmware hangs or crashes during its selftest, so it
makes sense to include this in the current shape already.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c         |  32 ++-
 hw/net/meson.build          |   1 +
 hw/net/next-net.c           | 538 ++++++++++++++++++++++++++++++++++++
 include/hw/m68k/next-cube.h |  10 +
 4 files changed, 579 insertions(+), 2 deletions(-)
 create mode 100644 hw/net/next-net.c

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index d9a0dca07f..bd12007a9f 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -28,6 +28,7 @@
 #include "ui/console.h"
 #include "target/m68k/cpu.h"
 #include "migration/vmstate.h"
+#include "net/net.h"
 
 /* #define DEBUG_NEXT */
 #ifdef DEBUG_NEXT
@@ -908,6 +909,32 @@ static void next_escc_init(DeviceState *pcdev)
     sysbus_mmio_map(s, 0, 0x2118000);
 }
 
+static void nextnet_init(DeviceState *pcdev)
+{
+    DeviceState *dev;
+    SysBusDevice *sbd;
+    NICInfo *ni = &nd_table[0];
+    int i;
+
+    dev = qdev_new(TYPE_NEXT_NET);
+    if (ni->used) {
+        qemu_check_nic_model(ni, TYPE_NEXT_NET);
+        qdev_set_nic_properties(dev, ni);
+    }
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    sbd = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(sbd, 0, 0x02000110);
+    sysbus_mmio_map(sbd, 1, 0x02004100);
+    sysbus_mmio_map(sbd, 2, 0x02004310);
+    sysbus_mmio_map(sbd, 3, 0x02106000);
+
+    /* Set up TX/RX and DMA irqs */
+    for (i = 0; i < NEXTNET_NUM_IRQS; i++) {
+        sysbus_connect_irq(sbd, i, qdev_get_gpio_in(pcdev, NEXTNET_TX_I_DMA +i));
+    }
+}
+
 static void next_pc_reset(DeviceState *dev)
 {
     NeXTPC *s = NEXT_PC(dev);
@@ -1081,14 +1108,15 @@ static void next_cube_init(MachineState *machine)
     /* Serial */
     next_escc_init(pcdev);
 
-    /* TODO: */
-    /* Network */
     /* SCSI */
     next_scsi_init(pcdev, cpu);
 
     /* DMA */
     memory_region_init_io(dmamem, NULL, &dma_ops, machine, "next.dma", 0x5000);
     memory_region_add_subregion(sysmem, 0x02000000, dmamem);
+
+    /* Network */
+    nextnet_init(pcdev);
 }
 
 static void next_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 2632634df3..8812d62f34 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -42,6 +42,7 @@ system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_emc.c'))
 
 system_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_eth.c'))
 system_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_fec.c'))
+system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-net.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_llan.c'))
 system_ss.add(when: 'CONFIG_XILINX_ETHLITE', if_true: files('xilinx_ethlite.c'))
 
diff --git a/hw/net/next-net.c b/hw/net/next-net.c
new file mode 100644
index 0000000000..67a7bf580b
--- /dev/null
+++ b/hw/net/next-net.c
@@ -0,0 +1,538 @@
+/*
+ * QEMU NeXT Network (MB8795) emulation
+ *
+ * Copyright (c) 2011 Bryce Lanham
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
+#include "qemu/osdep.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "hw/irq.h"
+#include "hw/m68k/next-cube.h"
+#include "hw/sysbus.h"
+#include "hw/qdev-properties.h"
+#include "net/net.h"
+
+/* debug NeXT ethernet */
+// #define DEBUG_NET
+
+#ifdef DEBUG_NET
+#define DPRINTF(fmt, ...) \
+    do { printf("NET: " fmt , ## __VA_ARGS__); } while (0)
+#else
+#define DPRINTF(fmt, ...) do { } while (0)
+#endif
+
+/* names could be better */
+typedef struct NextDMA {
+    uint32_t csr;
+    uint32_t savedbase;
+    uint32_t savedlimit;
+
+    uint32_t baser;
+    uint32_t base;
+    uint32_t limit;
+    uint32_t chainbase;
+    uint32_t chainlimit;
+    uint32_t basew;
+} NextDMA;
+
+typedef struct NextNetState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mr[4];
+    qemu_irq irq[NEXTNET_NUM_IRQS];
+    uint8_t mac[6];
+
+    NICState *nic;
+    NICConf conf;
+
+    NextDMA tx_dma;
+    uint8_t tx_stat;
+    uint8_t tx_mask;
+    uint8_t tx_mode;
+
+    NextDMA rx_dma;
+    uint8_t rx_stat;
+    uint8_t rx_mask;
+    uint8_t rx_mode;
+
+    uint8_t rst_mode;
+} NextNetState;
+
+#define NEXT_NET(obj) OBJECT_CHECK(NextNetState, (obj), TYPE_NEXT_NET)
+
+static ssize_t nextnet_rx(NetClientState *nc, const uint8_t *buf, size_t size);
+
+
+static uint64_t nextnet_mmio_rd_dma(void *opaque, hwaddr addr, unsigned size)
+{
+    NextNetState *s = (NextNetState *)opaque;
+
+    g_assert(size == 4);
+
+    addr += 0x110;
+    switch (addr) {
+    case 0x110:
+        DPRINTF("TXCSR Read\n");
+        return s->tx_dma.csr;
+    case 0x150:
+        DPRINTF("RXCSR Read %x\n", s->rx_dma.csr);
+        return s->rx_dma.csr;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void nextnet_mmio_wr_dma(void *opaque, hwaddr addr, uint64_t value,
+                                unsigned size)
+{
+    NextNetState *s = (NextNetState *)opaque;
+
+    g_assert(size == 4);
+
+    addr += 0x110;
+    switch (addr) {
+    case 0x110:
+        if (value & DMA_SETENABLE) {
+            size_t len = (0xFFFFFFF & s->tx_dma.limit) - s->tx_dma.base;
+            uint8_t buf[len]; /* needs to be in dma struct? */
+
+            DPRINTF("TXDMA ENABLE: %x len: %zu\n", s->tx_dma.base, len);
+            cpu_physical_memory_read(s->tx_dma.base, buf, len);
+
+            qemu_send_packet(qemu_get_queue(s->nic), buf, len);
+            s->tx_dma.csr |= DMA_COMPLETE | DMA_SUPDATE;
+            s->tx_stat = 0x80;
+
+            qemu_set_irq(s->irq[NEXTNET_TX_I_DMA], true);
+        }
+        if (value & DMA_SETSUPDATE) {
+            s->tx_dma.csr |= DMA_SUPDATE;
+        }
+        if (value & DMA_CLRCOMPLETE) {
+            s->tx_dma.csr &= ~DMA_COMPLETE;
+            qemu_set_irq(s->irq[NEXTNET_TX_I_DMA], false); /* TODO: OK here? */
+        }
+        if (value & DMA_RESET) {
+            s->tx_dma.csr &= ~(DMA_COMPLETE | DMA_SUPDATE | DMA_ENABLE);
+        }
+        break;
+
+    case 0x150:
+        if (value & DMA_DEV2M) {
+            DPRINTF("RX Dev to Memory\n");
+        }
+
+        if (value & DMA_SETENABLE) {
+            s->rx_dma.csr |= DMA_ENABLE;
+        }
+        if (value & DMA_SETSUPDATE) {
+            s->rx_dma.csr |= DMA_SUPDATE;
+        }
+
+        if (value & DMA_CLRCOMPLETE) {
+            s->rx_dma.csr &= ~DMA_COMPLETE;
+            qemu_set_irq(s->irq[NEXTNET_RX_I_DMA], false); /* TODO: OK here? */
+        }
+        if (value & DMA_RESET) {
+            s->rx_dma.csr &= ~(DMA_COMPLETE | DMA_SUPDATE | DMA_ENABLE);
+        }
+
+        DPRINTF("RXCSR \tWrite: %"HWADDR_PRIx"\n", value);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps nextnet_mmio_ops_dma = {
+    .read = nextnet_mmio_rd_dma,
+    .write = nextnet_mmio_wr_dma,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static uint64_t nextnet_mmio_rd_chan1(void *opaque, hwaddr addr, unsigned size)
+{
+    NextNetState *s = (NextNetState *)opaque;
+
+    g_assert(size == 4);
+
+    addr += 0x4100;
+    switch (addr) {
+    case 0x4100:
+        DPRINTF("SAVEDBASE Read\n");
+        return s->tx_dma.savedbase;
+    case 0x4104:
+        DPRINTF("SAVELIMIT Read\n");
+        return s->tx_dma.savedlimit;
+    case 0x4114:
+        DPRINTF("TXLIMIT Read\n");
+        return s->tx_dma.limit;
+    case 0x4140:
+        return s->rx_dma.savedbase;
+    case 0x4144:
+        // DPRINTF("SAVELIMIT %x @ %x\n",s->rx_dma.savedlimit, s->pc);
+        return s->rx_dma.savedlimit;
+    default:
+        DPRINTF("NET Read l @ %x\n", (unsigned int)addr);
+        return 0;
+    }
+}
+
+static void nextnet_mmio_wr_chan1(void *opaque, hwaddr addr, uint64_t val,
+                                  unsigned size)
+{
+    NextNetState *s = (NextNetState *)opaque;
+    uint32_t value = val;
+
+    g_assert(size == 4);
+
+    addr += 0x4100;
+    switch (addr) {
+    case 0x4100:
+        DPRINTF("Write l @ %x with %x\n", (unsigned int)addr, value);
+        s->tx_dma.savedbase = value;
+        break;
+    case 0x4104:
+        DPRINTF("Write l @ %x with %x\n", (unsigned int)addr, value);
+        s->tx_dma.savedlimit = value;
+        break;
+    case 0x4110:
+        DPRINTF("Write l @ %x with %x\n", (unsigned int)addr, value);
+        s->tx_dma.base = value;
+        break;
+    case 0x4114:
+        DPRINTF("Write l @ %x with %x\n", (unsigned int)addr, value);
+        s->tx_dma.limit = value;
+        break;
+    case 0x4150:
+        // DPRINTF("Write l @ %x with %x\n",addr,value);
+        s->rx_dma.base = value;
+        // s->rx_dma.savedbase = value;
+        break;
+    case 0x4154:
+        s->rx_dma.limit = value;
+        // DPRINTF("Write l @ %x with %x\n",addr,value);
+        break;
+    case 0x4158:
+        s->rx_dma.chainbase = value;
+        // DPRINTF("Write l @ %x with %x\n",addr,value);
+        break;
+    case 0x415c:
+        s->rx_dma.chainlimit = value;
+        // DPRINTF("Write l @ %x with %x\n",addr,value);
+        //DPRINTF("Pointer write %x w %x\n",addr,value);
+        break;
+    default:
+        DPRINTF("Write l @ %x with %x\n", (unsigned int)addr, value);
+    }
+}
+
+static const MemoryRegionOps nextnet_mmio_ops_chan1 = {
+    .read = nextnet_mmio_rd_chan1,
+    .write = nextnet_mmio_wr_chan1,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static uint64_t nextnet_mmio_rd_chan2(void *opaque, hwaddr addr, unsigned size)
+{
+    NextNetState *s = (NextNetState *)opaque;
+
+    g_assert(size == 4);
+
+    addr += 0x4310;
+    switch (addr) {
+    case 0x4310:
+        DPRINTF("TXBASE Read\n");
+        /* FUTURE :return nextdma_read(device, addr); */
+        return s->tx_dma.basew;
+    default:
+        DPRINTF("NET Read l @ %x\n", (unsigned int)addr);
+        return 0;
+    }
+}
+
+static void nextnet_mmio_wr_chan2(void *opaque, hwaddr addr, uint64_t val,
+                                  unsigned size)
+{
+    NextNetState *s = (NextNetState *)opaque;
+
+    g_assert(size == 4);
+
+    addr += 0x4310;
+    switch (addr) {
+    case 0x4310:
+        DPRINTF("Write l @ %x with %"HWADDR_PRIx"\n", (unsigned int)addr, val);
+        s->tx_dma.base = val;
+        /* FUTURE :nextdma_write(device, addr, value); */
+        break;
+    default:
+        DPRINTF("Write l @ %x with %"HWADDR_PRIx"\n", (unsigned int)addr, val);
+    }
+}
+
+static const MemoryRegionOps nextnet_mmio_ops_chan2 = {
+    .read = nextnet_mmio_rd_chan2,
+    .write = nextnet_mmio_wr_chan2,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+/* It's likely that all register reads are bytes, while all CSR r/w are longs */
+static uint64_t nextnet_mmio_rd_cnf(void *opaque, hwaddr addr, unsigned size)
+{
+    NextNetState *s = (NextNetState *)opaque;
+
+    g_assert(size == 1);
+
+    addr += 0x6000;
+
+    switch (addr) {
+    case 0x6000: /* TXSTAT */
+        DPRINTF("TXSTAT \tRead\n");
+        return s->tx_stat;
+    case 0x6001:
+        DPRINTF("TXMASK \tRead\n");
+        return s->tx_mask;
+    case 0x6002:
+        DPRINTF("RXSTAT \tRead %x\n", s->rx_stat);
+        return s->rx_stat;
+    case 0x6003:
+        // DPRINTF("RXMASK \tRead\n");
+        return s->rx_mask;
+    case 0x6004:
+        DPRINTF("TXMODE \tRead\n");
+        return s->tx_mode;
+    case 0x6005:
+        // DPRINTF("RXMODE \tRead\n");
+        return s->rx_mode;
+    case 0x6006:
+        DPRINTF("RSTMODE \tRead\n");
+        return s->rst_mode;
+    default:
+        DPRINTF("NET Read B @ %x\n", (unsigned int)addr);
+        return 0;
+    }
+}
+
+#define NET_TXSTAT_CLEAR 0xFF
+#define NET_RXSTAT_CLEAR 0xFF
+static void nextnet_mmio_wr_cnf(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned size)
+{
+    NextNetState *s = (NextNetState *)opaque;
+    uint32_t value = val;
+
+    g_assert(size == 1);
+
+    addr += 0x6000;
+
+    switch (addr) {
+    case 0x6000:
+        DPRINTF("TXSTAT \tWrite: %x\n", value);
+        if (value == NET_TXSTAT_CLEAR) {
+            s->tx_stat = 0x80;
+        } else {
+            s->tx_stat = value;
+        }
+        break;
+    case 0x6001:
+        DPRINTF("TXMASK \tWrite: %x\n", value);
+        s->tx_mask = value;
+        break;
+    case 0x6002:
+        // DPRINTF("RXSTAT \tWrite: %x\n", value);
+        if (value == NET_RXSTAT_CLEAR) {
+            s->rx_stat = 0x80;
+        } else {
+            s->rx_stat = value;
+        }
+        break;
+    case 0x6003:
+        // DPRINTF("RXMASK \tWrite: %x\n", value);
+        s->rx_mask = value;
+        break;
+    case 0x6004:
+        DPRINTF("TXMODE \tWrite: %x\n", value);
+        s->tx_mode = value;
+        break;
+    case 0x6005:
+        // DPRINTF("RXMODE \tWrite: %x\n", value);
+        s->rx_mode = value;
+        break;
+    case 0x6006:
+        DPRINTF("RSTMODE \tWrite: %x\n", value);
+        s->rst_mode = value;
+        break;
+    case 0x600d:
+        s->mac[(addr & 0xF) - 8] = value;
+        DPRINTF("Set MAC ADDR %.2x:%.2x:%.2x:%.2x:%.2x:%.2x\n", s->mac[0],
+                s->mac[1], s->mac[2], s->mac[3], s->mac[4], s->mac[5]);
+        qemu_macaddr_default_if_unset((MACAddr *)&s->mac);
+        break;
+    case 0x6008:
+    case 0x6009:
+    case 0x600a:
+    case 0x600b:
+    case 0x600c:
+        s->mac[(addr & 0xF) - 8] = value;
+        break;
+    case 0x6010:
+    case 0x6011:
+    case 0x6012:
+    case 0x6013:
+    case 0x6014:
+        break;
+    default:
+        DPRINTF(" Write B @ %x with %x\n", (unsigned int)addr, value);
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps nextnet_mmio_ops_cnf = {
+    .read = nextnet_mmio_rd_cnf,
+    .write = nextnet_mmio_wr_cnf,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static bool nextnet_can_rx(NetClientState *nc)
+{
+    NextNetState *s = qemu_get_nic_opaque(nc);
+
+    return (s->rx_mode & 0x3) != 0;
+}
+
+static ssize_t nextnet_rx(NetClientState *nc, const uint8_t *buf, size_t size)
+{
+    NextNetState *s = qemu_get_nic_opaque(nc);
+
+    DPRINTF("received packet %zu\n", size);
+
+    /* Ethernet DMA is supposedly 32 byte aligned */
+    if ((size % 32) != 0) {
+        size -= size % 32;
+        size += 32;
+    }
+
+    /* Write the packet into memory */
+    cpu_physical_memory_write(s->rx_dma.base, buf, size);
+
+    /*
+     * Saved limit is checked to calculate packet size by both the rom
+     * and netbsd
+     */
+    s->rx_dma.savedlimit = (s->rx_dma.base + size);
+    s->rx_dma.savedbase = (s->rx_dma.base);
+
+    /*
+     * 32 bytes under savedbase seems to be some kind of register
+     * of which the purpose is unknown as of yet
+     */
+    //stl_phys(s->rx_dma.base-32, 0xFFFFFFFF);
+
+    if ((s->rx_dma.csr & DMA_SUPDATE)) {
+        s->rx_dma.base = s->rx_dma.chainbase;
+        s->rx_dma.limit = s->rx_dma.chainlimit;
+    }
+    /* we received a packet */
+    s->rx_stat = 0x80;
+
+    /* Set dma registers and raise an irq */
+    s->rx_dma.csr |= DMA_COMPLETE; /* DON'T CHANGE THIS! */
+    qemu_set_irq(s->irq[NEXTNET_RX_I_DMA], true);
+
+    return size;
+}
+
+static NetClientInfo nextnet_info = {
+    .type = NET_CLIENT_DRIVER_NIC,
+    .size = sizeof(NICState),
+    .receive = nextnet_rx,
+    .can_receive = nextnet_can_rx,
+    .receive = nextnet_rx,
+};
+
+static void nextnet_realize(DeviceState *dev, Error **errp)
+{
+    NextNetState *s = NEXT_NET(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    uint8_t mac[6] = { 0x00, 0x00, 0x0f, 0x00, 0xf3, 0x02 };
+    int i;
+
+    memcpy(&s->mac, mac, 6);  
+    s->nic = qemu_new_nic(&nextnet_info, &s->conf, "NeXT MB8795", dev->id, s);
+    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->mac);
+
+    /* Init device register spaces */
+    memory_region_init_io(&s->mr[0], NULL, &nextnet_mmio_ops_dma, s,
+                          "next.net.dma", 0x60);
+    sysbus_init_mmio(sbd, &s->mr[0]);
+    memory_region_init_io(&s->mr[1], NULL, &nextnet_mmio_ops_chan1, s,
+                          "next.net.chan1", 0x80);
+    sysbus_init_mmio(sbd, &s->mr[1]);
+    memory_region_init_io(&s->mr[2], NULL, &nextnet_mmio_ops_chan2, s,
+                          "next.net.chan2", 0x60);
+    sysbus_init_mmio(sbd, &s->mr[2]);
+    memory_region_init_io(&s->mr[3], NULL, &nextnet_mmio_ops_cnf, s,
+                          "next.net.cnf", 0x20);
+    sysbus_init_mmio(sbd, &s->mr[3]);
+
+    for (i = 0; i < NEXTNET_NUM_IRQS; i++) {
+        sysbus_init_irq(sbd, &s->irq[i]);
+    }
+}
+
+static Property nextnet_properties[] = {
+    DEFINE_NIC_PROPERTIES(NextNetState, conf),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void nextnet_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    dc->realize = nextnet_realize;
+    dc->desc = "NeXT Ethernet Controller";
+    device_class_set_props(dc, nextnet_properties);
+}
+
+static const TypeInfo nextnet_typeinfo = {
+    .name          = TYPE_NEXT_NET,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(NextNetState),
+    .class_init    = nextnet_class_init,
+};
+
+static void nextnet_register_types(void)
+{
+    type_register_static(&nextnet_typeinfo);
+}
+
+type_init(nextnet_register_types)
diff --git a/include/hw/m68k/next-cube.h b/include/hw/m68k/next-cube.h
index 43577282d1..710b90e4b2 100644
--- a/include/hw/m68k/next-cube.h
+++ b/include/hw/m68k/next-cube.h
@@ -16,6 +16,16 @@
 
 #define TYPE_NEXTKBD "next-kbd"
 
+#define TYPE_NEXT_NET "next-net"
+
+enum nextnet_irqs {
+    NEXTNET_TX_I_DMA,
+    NEXTNET_RX_I_DMA,
+    NEXTNET_TX_I,
+    NEXTNET_RX_I,
+    NEXTNET_NUM_IRQS
+};
+
 enum next_dma_chan {
     NEXTDMA_FD,
     NEXTDMA_ENRX,
-- 
2.41.0


