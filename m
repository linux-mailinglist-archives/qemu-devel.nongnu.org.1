Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0720817A1C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:52:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIid-0006DR-9Q; Mon, 18 Dec 2023 13:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiO-00068j-Ih; Mon, 18 Dec 2023 13:51:44 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiF-0008PI-R3; Mon, 18 Dec 2023 13:51:38 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d1bcd93b0so9035365e9.0; 
 Mon, 18 Dec 2023 10:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702925492; x=1703530292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zIi8YOFzybKW8Rq5OqDlw4D+FmT1OGY+fsh09ZFmm7A=;
 b=ghQyLiENFHrYnOx8Ude08DhBkjseivWv1+KjrDOp0vy3eRp0RjVx6ne8ZWQjfxa4Yy
 I0KkPFWakihjpPhnqV/40ZSW+asM05mCugd+Q25CgTTL2b3gRQpp4buXvb/xAEwQxX+C
 5McOJc4RNIqhrRi/acXacVEZ9sdgURSuyU5AZfFYp9tA/ELHzJZTlVE8ZYqWzAMzv8F5
 R7hBZDswEgVO7ui2M7TDKAdYQfTleyJOh95E05v3CuybhgLzJxqymp41AhI8FRV9B4MU
 KlHKRIOAt1hMCB06T1PV//M9TROeoZ7YmN/JGrSidEAhCuCIlfe9cPL5L4VtRy+oCCht
 y6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925492; x=1703530292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zIi8YOFzybKW8Rq5OqDlw4D+FmT1OGY+fsh09ZFmm7A=;
 b=mbo2o2wG26s5YDBZfz6MSMoourqX1YD9GcHIK0lDY/qemdCkZa9QyNnHBp795r1Ge+
 2h1Vehb9xeqaFc3Z+3gHPqWWx0G84kNAngKSW0t/Dlahz2FKz8qt/sNgFPpDJu/7qfO6
 HfJwdKEp0ravbTyUJrl4WgOTmIA7imzyekfi6UbLm88f3U4Xhk1tf7YSxmIoyGLZ2PuS
 ZxT81Zf6tuJyA+ejkMbYsAvpjYUKcbkNev8/xUOWngByWSHwN9v1rEgbsRM1VultjeW1
 Z4mFd5hCocUQqXEIJCncCm1/Va8/zz8jCwu8RmdU/WUNAQULFB3b2tWngj22Oo4V1pOq
 ALAg==
X-Gm-Message-State: AOJu0Yxc5oaripNzpve58WhSvv2gGxObHimrVUY8IGWi13v1DWnHpfEl
 bI/7IhRmISUEZX/rdw2hQCjDMbNSBgc=
X-Google-Smtp-Source: AGHT+IG4kTMbTvX7SAcHRZnFfXBmGHBRdvlT6YE0D9Zb7OmxK2sxnmL8IKnopkXipSQ99wVPdKXpxg==
X-Received: by 2002:a05:600c:458d:b0:40b:33c0:a22 with SMTP id
 r13-20020a05600c458d00b0040b33c00a22mr10089084wmo.28.1702925491867; 
 Mon, 18 Dec 2023 10:51:31 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-092-224-039-156.92.224.pool.telefonica.de. [92.224.39.156])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0040c45071c18sm35134091wmo.39.2023.12.18.10.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:51:30 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 03/12] hw/char/serial: Free struct SerialState from
 MemoryRegion
Date: Mon, 18 Dec 2023 19:51:05 +0100
Message-ID: <20231218185114.119736-4-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218185114.119736-1-shentey@gmail.com>
References: <20231218185114.119736-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
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

SerialState::io isn't used within TYPE_SERIAL directly. Push it to its users to
make them the owner of the MemoryRegion.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/serial.h   | 2 +-
 hw/char/serial-isa.c       | 7 +++++--
 hw/char/serial-pci-multi.c | 7 ++++---
 hw/char/serial-pci.c       | 7 +++++--
 hw/char/serial.c           | 4 ++--
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 8ba7eca3d6..eb4254edde 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -77,7 +77,6 @@ struct SerialState {
     int poll_msl;
 
     QEMUTimer *modem_status_poll;
-    MemoryRegion io;
 };
 typedef struct SerialState SerialState;
 
@@ -85,6 +84,7 @@ struct SerialMM {
     SysBusDevice parent;
 
     SerialState serial;
+    MemoryRegion io;
 
     uint8_t regshift;
     uint8_t endianness;
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 141a6cb168..2be8be980b 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "exec/memory.h"
 #include "sysemu/sysemu.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/char/serial.h"
@@ -43,6 +44,7 @@ struct ISASerialState {
     uint32_t iobase;
     uint32_t isairq;
     SerialState state;
+    MemoryRegion io;
 };
 
 static const int isa_serial_io[MAX_ISA_SERIAL_PORTS] = {
@@ -79,8 +81,9 @@ static void serial_isa_realizefn(DeviceState *dev, Error **errp)
     qdev_realize(DEVICE(s), NULL, errp);
     qdev_set_legacy_instance_id(dev, isa->iobase, 3);
 
-    memory_region_init_io(&s->io, OBJECT(isa), &serial_io_ops, s, "serial", 8);
-    isa_register_ioport(isadev, &s->io, isa->iobase);
+    memory_region_init_io(&isa->io, OBJECT(isa), &serial_io_ops, s, "serial",
+                          8);
+    isa_register_ioport(isadev, &isa->io, isa->iobase);
 }
 
 static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 5d65c534cb..16cb2faad7 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -44,6 +44,7 @@ typedef struct PCIMultiSerialState {
     uint32_t     ports;
     char         *name[PCI_SERIAL_MAX_PORTS];
     SerialState  state[PCI_SERIAL_MAX_PORTS];
+    MemoryRegion io[PCI_SERIAL_MAX_PORTS];
     uint32_t     level[PCI_SERIAL_MAX_PORTS];
     qemu_irq     *irqs;
     uint8_t      prog_if;
@@ -58,7 +59,7 @@ static void multi_serial_pci_exit(PCIDevice *dev)
     for (i = 0; i < pci->ports; i++) {
         s = pci->state + i;
         qdev_unrealize(DEVICE(s));
-        memory_region_del_subregion(&pci->iobar, &s->io);
+        memory_region_del_subregion(&pci->iobar, &pci->io[i]);
         g_free(pci->name[i]);
     }
     qemu_free_irqs(pci->irqs, pci->ports);
@@ -112,9 +113,9 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
         }
         s->irq = pci->irqs[i];
         pci->name[i] = g_strdup_printf("uart #%zu", i + 1);
-        memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
+        memory_region_init_io(&pci->io[i], OBJECT(pci), &serial_io_ops, s,
                               pci->name[i], 8);
-        memory_region_add_subregion(&pci->iobar, 8 * i, &s->io);
+        memory_region_add_subregion(&pci->iobar, 8 * i, &pci->io[i]);
         pci->ports++;
     }
 }
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 087da3059a..ab3d0e56b5 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "exec/memory.h"
 #include "hw/char/serial.h"
 #include "hw/irq.h"
 #include "hw/pci/pci_device.h"
@@ -38,6 +39,7 @@
 struct PCISerialState {
     PCIDevice dev;
     SerialState state;
+    MemoryRegion io;
     uint8_t prog_if;
 };
 
@@ -57,8 +59,9 @@ static void serial_pci_realize(PCIDevice *dev, Error **errp)
     pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
     s->irq = pci_allocate_irq(&pci->dev);
 
-    memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s, "serial", 8);
-    pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
+    memory_region_init_io(&pci->io, OBJECT(pci), &serial_io_ops, s, "serial",
+                          8);
+    pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->io);
 }
 
 static void serial_pci_exit(PCIDevice *dev)
diff --git a/hw/char/serial.c b/hw/char/serial.c
index a32eb25f58..83b642aec3 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1045,10 +1045,10 @@ static void serial_mm_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_init_io(&s->io, OBJECT(dev),
+    memory_region_init_io(&smm->io, OBJECT(dev),
                           &serial_mm_ops[smm->endianness], smm, "serial",
                           8 << smm->regshift);
-    sysbus_init_mmio(SYS_BUS_DEVICE(smm), &s->io);
+    sysbus_init_mmio(SYS_BUS_DEVICE(smm), &smm->io);
     sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
 }
 
-- 
2.43.0


