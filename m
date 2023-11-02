Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C79147DEF7C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:07:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUaU-0001r4-Qs; Thu, 02 Nov 2023 06:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaS-0001qD-78
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:06:04 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaQ-0003J8-AU
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:06:03 -0400
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-53de0d1dc46so1239744a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698919561; x=1699524361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ASHtxluhaVhtFc7n5h7nYhCC1cwMC+yLnt4Qk5lMQkU=;
 b=A8WLFxA7lUHud1uSxWTDigrea8u54y8a4tSGwXtyjKQuyg4Ao5v97kZ/0uKMekITCu
 lcbQXN4MpyF1NNAjlhGdbS1f4o0QAc6Q5Y8CSWMDOANjcEkQKe7wePIMf6dvjm3cfWG7
 o1zGwy56TUNw35Br11ErfkQoto8IMSovd/rjfpM53rpd9axPNjmohIbhxW8/4bDRwyLJ
 VEWtvD333/MlfMreh2zwjfBuS/TL4gyJUiDjZxPY9n4N3Md6VMuk47uQMjygo1sqGD59
 g8qprh/gn1LsvgFU4+Jcg3J1hjgLRDD3C2tnztYUHctZu8s6o9Z0dNDwyf3RUDqYngT5
 zzLg==
X-Gm-Message-State: AOJu0YyHrKtuMx5eeioDmat1lwtoj6PipyJUl9mvVYTcPR5vj53ok4o3
 WpjWidYadcrUfYvrTxTfiZdwlB0felw=
X-Google-Smtp-Source: AGHT+IH4n2DrnNpNTHpaUUNLrMtZ0ghppxFEVHbNzixjXv++h02cLLphL4klUQ2oCswxmJFKGASqiQ==
X-Received: by 2002:a17:906:e86:b0:9c1:edd8:43c2 with SMTP id
 p6-20020a1709060e8600b009c1edd843c2mr3158931ejf.42.1698919560436; 
 Thu, 02 Nov 2023 03:06:00 -0700 (PDT)
Received: from localhost.localdomain (ip-109-42-115-39.web.vodafone.de.
 [109.42.115.39]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906359500b009b97d9ae329sm927236ejb.198.2023.11.02.03.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:06:00 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/10] m68k: Instantiate the ESP SCSI controller for the
 NeXTcube machine
Date: Thu,  2 Nov 2023 11:05:42 +0100
Message-ID: <20231102100543.4875-10-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102100543.4875-1-huth@tuxfamily.org>
References: <20231102100543.4875-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.42; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f42.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The NeXTcube uses a NCR 53C90 SCSI interface for its disks, so we should
be able to use the ESP controller from QEMU here. The code here has been
basically taken from Bryce Lanham's GSoC 2011 contribution, except for
the next_scsi_init() function which has been rewritte as a replacement
for the esp_init() function (that has been removed quite a while ago).

Note that SCSI is not working yet. The ESP code likely needs some more
fixes first and there still might be some bugs left in they way we wire
it up for the NeXT-Cube machine.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20230930132351.30282-4-huth@tuxfamily.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 117 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 110 insertions(+), 7 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 2c94c6a9c2..fabd861941 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -90,10 +90,13 @@ struct NeXTPC {
 
     uint32_t scr1;
     uint32_t scr2;
-    uint8_t scsi_csr_1;
-    uint8_t scsi_csr_2;
     uint32_t int_mask;
     uint32_t int_status;
+    uint8_t scsi_csr_1;
+    uint8_t scsi_csr_2;
+
+    qemu_irq scsi_reset;
+    qemu_irq scsi_dma;
 
     NextRtc rtc;
 };
@@ -466,7 +469,7 @@ static void scr_writeb(NeXTPC *s, hwaddr addr, uint32_t value)
             DPRINTF("SCSICSR FIFO Flush\n");
             /* will have to add another irq to the esp if this is needed */
             /* esp_puflush_fifo(esp_g); */
-            /* qemu_irq_pulse(s->scsi_dma); */
+            qemu_irq_pulse(s->scsi_dma);
         }
 
         if (value & SCSICSR_ENABLE) {
@@ -486,9 +489,9 @@ static void scr_writeb(NeXTPC *s, hwaddr addr, uint32_t value)
         if (value & SCSICSR_RESET) {
             DPRINTF("SCSICSR Reset\n");
             /* I think this should set DMADIR. CPUDMA and INTMASK to 0 */
-            /* qemu_irq_raise(s->scsi_reset); */
-            /* s->scsi_csr_1 &= ~(SCSICSR_INTMASK |0x80|0x1); */
-
+            qemu_irq_raise(s->scsi_reset);
+            s->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
+            qemu_irq_lower(s->scsi_reset);
         }
         if (value & SCSICSR_DMADIR) {
             DPRINTF("SCSICSR DMAdir\n");
@@ -496,10 +499,11 @@ static void scr_writeb(NeXTPC *s, hwaddr addr, uint32_t value)
         if (value & SCSICSR_CPUDMA) {
             DPRINTF("SCSICSR CPUDMA\n");
             /* qemu_irq_raise(s->scsi_dma); */
-
             s->int_status |= 0x4000000;
         } else {
+            /* fprintf(stderr,"SCSICSR CPUDMA disabled\n"); */
             s->int_status &= ~(0x4000000);
+            /* qemu_irq_lower(s->scsi_dma); */
         }
         if (value & SCSICSR_INTMASK) {
             DPRINTF("SCSICSR INTMASK\n");
@@ -828,6 +832,103 @@ static void next_irq(void *opaque, int number, int level)
     }
 }
 
+static void nextdma_write(void *opaque, uint8_t *buf, int size, int type)
+{
+    uint32_t base_addr;
+    int irq = 0;
+    uint8_t align = 16;
+    NeXTState *next_state = NEXT_MACHINE(qdev_get_machine());
+
+    if (type == NEXTDMA_ENRX || type == NEXTDMA_ENTX) {
+        align = 32;
+    }
+    /* Most DMA is supposedly 16 byte aligned */
+    if ((size % align) != 0) {
+        size -= size % align;
+        size += align;
+    }
+
+    /*
+     * prom sets the dma start using initbuf while the bootloader uses next
+     * so we check to see if initbuf is 0
+     */
+    if (next_state->dma[type].next_initbuf == 0) {
+        base_addr = next_state->dma[type].next;
+    } else {
+        base_addr = next_state->dma[type].next_initbuf;
+    }
+
+    cpu_physical_memory_write(base_addr, buf, size);
+
+    next_state->dma[type].next_initbuf = 0;
+
+    /* saved limit is checked to calculate packet size by both, rom and netbsd */
+    next_state->dma[type].saved_limit = (next_state->dma[type].next + size);
+    next_state->dma[type].saved_next  = (next_state->dma[type].next);
+
+    /*
+     * 32 bytes under savedbase seems to be some kind of register
+     * of which the purpose is unknown as of yet
+     */
+    /* stl_phys(s->rx_dma.base-32,0xFFFFFFFF); */
+
+    if (!(next_state->dma[type].csr & DMA_SUPDATE)) {
+        next_state->dma[type].next  = next_state->dma[type].start;
+        next_state->dma[type].limit = next_state->dma[type].stop;
+    }
+
+    /* Set dma registers and raise an irq */
+    next_state->dma[type].csr |= DMA_COMPLETE; /* DON'T CHANGE THIS! */
+
+    switch (type) {
+    case NEXTDMA_SCSI:
+        irq = NEXT_SCSI_DMA_I;
+        break;
+    }
+
+    next_irq(opaque, irq, 1);
+    next_irq(opaque, irq, 0);
+}
+
+static void nextscsi_read(void *opaque, uint8_t *buf, int len)
+{
+    DPRINTF("SCSI READ: %x\n", len);
+    abort();
+}
+
+static void nextscsi_write(void *opaque, uint8_t *buf, int size)
+{
+    DPRINTF("SCSI WRITE: %i\n", size);
+    nextdma_write(opaque, buf, size, NEXTDMA_SCSI);
+}
+
+static void next_scsi_init(DeviceState *pcdev, M68kCPU *cpu)
+{
+    struct NeXTPC *next_pc = NEXT_PC(pcdev);
+    DeviceState *dev;
+    SysBusDevice *sysbusdev;
+    SysBusESPState *sysbus_esp;
+    ESPState *esp;
+
+    dev = qdev_new(TYPE_SYSBUS_ESP);
+    sysbus_esp = SYSBUS_ESP(dev);
+    esp = &sysbus_esp->esp;
+    esp->dma_memory_read = nextscsi_read;
+    esp->dma_memory_write = nextscsi_write;
+    esp->dma_opaque = pcdev;
+    sysbus_esp->it_shift = 0;
+    esp->dma_enabled = 1;
+    sysbusdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sysbusdev, &error_fatal);
+    sysbus_connect_irq(sysbusdev, 0, qdev_get_gpio_in(pcdev, NEXT_SCSI_I));
+    sysbus_mmio_map(sysbusdev, 0, 0x2114000);
+
+    next_pc->scsi_reset = qdev_get_gpio_in(dev, 0);
+    next_pc->scsi_dma = qdev_get_gpio_in(dev, 1);
+
+    scsi_bus_legacy_handle_cmdline(&esp->bus);
+}
+
 static void next_escc_init(DeviceState *pcdev)
 {
     DeviceState *dev;
@@ -1021,6 +1122,7 @@ static void next_cube_init(MachineState *machine)
     /* TODO: */
     /* Network */
     /* SCSI */
+    next_scsi_init(pcdev, cpu);
 
     /* DMA */
     memory_region_init_io(dmamem, NULL, &dma_ops, machine, "next.dma", 0x5000);
@@ -1033,6 +1135,7 @@ static void next_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "NeXT Cube";
     mc->init = next_cube_init;
+    mc->block_default_type = IF_SCSI;
     mc->default_ram_size = RAM_SIZE;
     mc->default_ram_id = "next.ram";
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
-- 
2.41.0


