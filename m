Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3A67638A0
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWr-00033h-Dh; Wed, 26 Jul 2023 09:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWU-0002nO-QY; Wed, 26 Jul 2023 09:25:52 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWS-0003Jj-4V; Wed, 26 Jul 2023 09:25:50 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fb7dc16ff0so10518516e87.2; 
 Wed, 26 Jul 2023 06:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377946; x=1690982746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CimlNgqbaYOd6f4C8XL3jP8enyv36EsDPq7etJDIdiw=;
 b=eOTvKuAWUuaBTGaGuQXEGKlgiH2bwPIamMqO3UVTepJwm8JZ6hD7eSbXDw3q9oVLxe
 sT0QQhEHU4EEGsDuS1Br52kz0nbty/cWzL8Bm0CivmHT5hTqx5jNNf5VIpvepkLGhwD0
 JOU4zpjwvJh75HzqX7agDp3w+j7ROfhqQxUoITIX+O3of8mTRdyzhG2EcvCFVKpqC6sp
 cz53DrM7Tc2kIHM2Ly0kzZE2X5ZUiPUzcXQM+A3qPcXqYt8/Iz/openxNE+nRzlj6KGk
 1yWNHey6c5RrV0YL3LdM3/RVTTNbvX3KQ4Tak8Agxswt7Y6RL9ZmQiw8LAnpliVfBTXn
 G7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377946; x=1690982746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CimlNgqbaYOd6f4C8XL3jP8enyv36EsDPq7etJDIdiw=;
 b=ITnTpCmS3nm4uAlWRcayWRbDPdST81mIlQxhC5jKLkbIQMiVfbSEnGfuvKrSx7KJzG
 LdWuRBtV+GNV8T/iCPdkmsDTX9sGw14T4ig4jFt9PqE3t441VA0n5iLRg4AeIiy+Gjxu
 SAD04kB1QaJV4jOR9Q4FQNkYM21+gzsgrb5/kdfYHVlSv+jWp0I3AFnETRVwZ5oFgRC6
 C+C6a3R3g3GsBnxQCMqYCrakfyMzEJi9sCsaDKjKi2I3NJGkelCKLXIDccrG49l+GgA8
 l4BIYHEyHCtaPe1FCnPLPhLSkNL8iLa2pxhUiTy7YEwN3BvVxjZJL16dKMs9oCiZPG6B
 LQMw==
X-Gm-Message-State: ABy/qLZd6J2w92WVVyGciAVzjtEpKReGSP+KblW1lilgcndOrUpC1PlS
 xL6h9NNsAGL3nk/lzHIynJ4GFYZSUAc=
X-Google-Smtp-Source: APBJJlFZebetcCR1pWJXYoE9rx+7kwV+MP4GapxRJTMp3fXarjcvxxxcGwB9aouUmcizpEbV/o9LeA==
X-Received: by 2002:a05:6512:2521:b0:4fa:ad2d:6c58 with SMTP id
 be33-20020a056512252100b004faad2d6c58mr2038990lfb.61.1690377944765; 
 Wed, 26 Jul 2023 06:25:44 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:44 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 22/44] Add GENET stub
Date: Wed, 26 Jul 2023 16:24:50 +0300
Message-Id: <20230726132512.149618-23-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/net/bcm2838_genet.c         | 100 +++++++++++++++++++++++++++++++++
 hw/net/meson.build             |   2 +
 hw/net/trace-events            |  17 ++++++
 include/hw/net/bcm2838_genet.h |  40 +++++++++++++
 4 files changed, 159 insertions(+)
 create mode 100644 hw/net/bcm2838_genet.c
 create mode 100644 include/hw/net/bcm2838_genet.h

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
new file mode 100644
index 0000000000..c3e7d90451
--- /dev/null
+++ b/hw/net/bcm2838_genet.c
@@ -0,0 +1,100 @@
+/*
+ * BCM2838 Gigabit Ethernet emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "net/eth.h"
+#include "qapi/error.h"
+#include "hw/irq.h"
+#include "net/checksum.h"
+#include "sysemu/dma.h"
+#include "hw/net/bcm2838_genet.h"
+#include "trace.h"
+
+
+static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint64_t value = ~0;
+
+    qemu_log_mask(
+        LOG_GUEST_ERROR,
+        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+        __func__, size, offset);
+
+    trace_bcm2838_genet_read(size, offset, value);
+    return value;
+}
+
+static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
+                                unsigned size) {
+    qemu_log_mask(
+        LOG_GUEST_ERROR,
+        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+        __func__, size, offset);
+}
+
+static const MemoryRegionOps bcm2838_genet_ops = {
+    .read = bcm2838_genet_read,
+    .write = bcm2838_genet_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {.max_access_size = sizeof(uint32_t)},
+    .valid = {.min_access_size = sizeof(uint32_t)},
+};
+
+
+static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
+{
+    BCM2838GenetState *s = BCM2838_GENET(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    /* Controller registers */
+    memory_region_init_io(&s->regs_mr, OBJECT(s), &bcm2838_genet_ops, s,
+                          "bcm2838_genet_regs", sizeof(s->regs));
+    sysbus_init_mmio(sbd, &s->regs_mr);
+}
+
+static void bcm2838_genet_phy_reset(BCM2838GenetState *s)
+{
+    /* Temporary unimplemented */
+    trace_bcm2838_genet_phy_reset("done");
+}
+
+static void bcm2838_genet_reset(DeviceState *d)
+{
+    BCM2838GenetState *s = BCM2838_GENET(d);
+
+    memset(&s->regs, 0x00, sizeof(s->regs));
+
+    trace_bcm2838_genet_reset("done");
+
+    bcm2838_genet_phy_reset(s);
+}
+
+static void bcm2838_genet_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+
+    dc->realize = bcm2838_genet_realize;
+    dc->reset = bcm2838_genet_reset;
+}
+
+static const TypeInfo bcm2838_genet_info = {
+    .name       = TYPE_BCM2838_GENET,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2838GenetState),
+    .class_init = bcm2838_genet_class_init,
+};
+
+static void bcm2838_genet_register(void)
+{
+    type_register_static(&bcm2838_genet_info);
+}
+
+type_init(bcm2838_genet_register)
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 2632634df3..9bb01f45e2 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -72,4 +72,6 @@ system_ss.add(when: 'CONFIG_ROCKER', if_true: files(
 system_ss.add(when: 'CONFIG_ALL', if_true: files('rocker/qmp-norocker.c'))
 system_ss.add(files('rocker/rocker-hmp-cmds.c'))
 
+system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_genet.c'))
+
 subdir('can')
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 6b5ba669a2..f9e4f76776 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -480,3 +480,20 @@ dp8393x_receive_oversize(int size) "oversize packet, pkt_size is %d"
 dp8393x_receive_not_netcard(void) "packet not for netcard"
 dp8393x_receive_packet(int crba) "Receive packet at 0x%"PRIx32
 dp8393x_receive_write_status(int crba) "Write status at 0x%"PRIx32
+
+# bcm2838_genet.c
+bcm2838_genet_read(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04" PRIx64 ": 0x%016" PRIx64
+bcm2838_genet_write(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04" PRIx64 ": 0x%016" PRIx64
+bcm2838_genet_can_receive(const char *state) "receive is %s"
+bcm2838_genet_receive(ssize_t bytes_received) "%ld bytes received"
+bcm2838_genet_phy_update_link(const char *link_state) "link is %s"
+bcm2838_genet_phy_reset(const char *status) "PHY reset %s"
+bcm2838_genet_reset(const char *status) "MAC reset %s"
+bcm2838_genet_mac_address(const char *info) "%s"
+bcm2838_genet_tx_dma(const char *dma_state) "TX DMA %s"
+bcm2838_genet_tx_dma_ring(uint32_t ring_en) "TX DMA enabled rings: 0x%05x"
+bcm2838_genet_tx_dma_ring_buf(uint32_t ring_buf_en) "TX DMA enabled ring buffers: 0x%05x"
+bcm2838_genet_tx_dma_ring_active(unsigned int ring, const char *ring_state) "ring %u is %s"
+bcm2838_genet_tx_request(unsigned int ring_idx, uint32_t prod_idx, uint32_t cons_idx) "ring %u, PROD_INDEX %u, CONS_INDEX %u"
+bcm2838_genet_tx(unsigned int ring_idx, uint64_t desc_idx, uint32_t desc_status, uint64_t data_addr) "ring %u, descriptor %" PRIu64 ": 0x%08x, data @ 0x%08" PRIx64
+bcm2838_genet_rx_dma_ring_active(unsigned int ring, const char *ring_state) "ring %u is %s"
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
new file mode 100644
index 0000000000..f62b24fa2f
--- /dev/null
+++ b/include/hw/net/bcm2838_genet.h
@@ -0,0 +1,40 @@
+/*
+ * BCM2838 Gigabit Ethernet emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_GENET_H
+#define BCM2838_GENET_H
+
+#include "net/net.h"
+#include "hw/sysbus.h"
+
+#define TYPE_BCM2838_GENET "bcm2838-genet"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
+
+#define BCM2838_GENET_REV_MAJOR         6
+#define BCM2838_GENET_REV_MINOR         0
+
+typedef struct {
+    uint8_t stub_area[0x10000]; /* temporary stub */
+} __attribute__((__packed__)) BCM2838GenetRegs;
+
+struct BCM2838GenetState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+
+    MemoryRegion regs_mr;
+    AddressSpace dma_as;
+
+    BCM2838GenetRegs regs;
+
+    qemu_irq irq_default;
+    qemu_irq irq_prio;
+};
+
+#endif /* BCM2838_GENET_H */
-- 
2.34.1


