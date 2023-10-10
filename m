Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA79D7BFA5B
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:52:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBGt-0008OG-HL; Tue, 10 Oct 2023 07:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBGp-0008Jn-Vr
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:51:28 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBGo-00076b-3l
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:51:27 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99357737980so961579266b.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 04:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696938683; x=1697543483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSRMhqRwBJPVwIvAMkL4U25xz5YfzMZvrXzYobWXOds=;
 b=aZwXzcN9K2MmNLQociQV1VDMAOblaU5WmvPoHhovxNiR1Q5MeQg9dfE0ZmLhn4oaoe
 HM8FR+ghRjW1gsXk4ofqHhn/YY1lEqRRIZdKYlDS5TFObpNf48ffviVgxAUwYzEGxavT
 kx7VRU3rnLDq1MiU5KyWpwdcNEdRmzHrnrFm1SatgeXPUBv/qvYYfJ+ArEMIdD4IJbbm
 uAMhRX7cNWSZI+w0k37A9TU5OZ3wVpyGUmT3ExKNNYJEEhgm5sb7kCO28WQ07nOVTi1f
 rcoKDLq/8aOR7nmWgSerGFvcH6J1q1tyQXjx1+hyZFBg+ycjPYn1+kNco6sRNdQDObG5
 k+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696938683; x=1697543483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oSRMhqRwBJPVwIvAMkL4U25xz5YfzMZvrXzYobWXOds=;
 b=hHi9wS0G1nosKQHI3Gic6BrPc0Nh+IREho9QqK/IJj0PWePJRF3Kqg56TEc5S0LDL8
 QmuNcO/vNe4fGDNnfHSTY2FoLYKZUquuKAAS+QFL/xoh8epW02tGN5GpJYTMXW/xzz80
 kOOCAW7wPWstLCuN2IAHZUEk848XqHz1T6Aj4Iy2+Sgae4fguCF/JAlSa8MmsbMjJ2cQ
 J27T14seJ7dX2c3HNHpD7R0InF3EgpUtvG0ivD5oCExSLWHmGmQ2FrsHKFD0ZvP2cQfh
 JKpMs3cWFsEbbzTnUDu7fEG3zhfAqUaM59r6VWVjNU//+WFTBZTjAvzI1WHbBfpYzZDM
 gUVg==
X-Gm-Message-State: AOJu0Yx2RA8gjNyoCmX9RhxljDvfj4SbetzuAJVsZ5qNVnNrgBEchmq4
 3UuxwGLCUQ4K1vaHZaBU+P1XyptKnLcZ/bDoh/LqPQ==
X-Google-Smtp-Source: AGHT+IHE+DpUqN1OLa+Mv0q4MvO8cgQM6Wzsq9qwKzmRHWBD9an6Qrzl/LhrIkvz8mFEIiDpoz/JVw==
X-Received: by 2002:a17:906:53cd:b0:9ba:321b:80e3 with SMTP id
 p13-20020a17090653cd00b009ba321b80e3mr2847412ejo.20.1696938683432; 
 Tue, 10 Oct 2023 04:51:23 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 bq17-20020a170906d0d100b00992b8d56f3asm8405985ejb.105.2023.10.10.04.51.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 04:51:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 5/6] hw/pci: Clean up global variable shadowing of
 address_space_io variable
Date: Tue, 10 Oct 2023 13:50:47 +0200
Message-ID: <20231010115048.11856-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010115048.11856-1-philmd@linaro.org>
References: <20231010115048.11856-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

Fix:

  hw/pci/pci.c:504:54: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
                                         MemoryRegion *address_space_io,
                                                       ^
  hw/pci/pci.c:533:38: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
                         MemoryRegion *address_space_io,
                                       ^
  hw/pci/pci.c:543:40: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
                           MemoryRegion *address_space_io,
                                         ^
  hw/pci/pci.c:590:45: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
                                MemoryRegion *address_space_io,
                                              ^
  include/exec/address-spaces.h:35:21: note: previous declaration is here
  extern AddressSpace address_space_io;
                      ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h |  9 +++------
 hw/pci/pci.c         | 25 +++++++++----------------
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index b70a0b95ff..ea5aff118b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -279,12 +279,10 @@ bool pci_bus_is_express(const PCIBus *bus);
 
 void pci_root_bus_init(PCIBus *bus, size_t bus_size, DeviceState *parent,
                        const char *name,
-                       MemoryRegion *address_space_mem,
-                       MemoryRegion *address_space_io,
+                       MemoryRegion *mem, MemoryRegion *io,
                        uint8_t devfn_min, const char *typename);
 PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
-                         MemoryRegion *address_space_mem,
-                         MemoryRegion *address_space_io,
+                         MemoryRegion *mem, MemoryRegion *io,
                          uint8_t devfn_min, const char *typename);
 void pci_root_bus_cleanup(PCIBus *bus);
 void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq,
@@ -304,8 +302,7 @@ int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
 PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
                               pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
                               void *irq_opaque,
-                              MemoryRegion *address_space_mem,
-                              MemoryRegion *address_space_io,
+                              MemoryRegion *mem, MemoryRegion *io,
                               uint8_t devfn_min, int nirq,
                               const char *typename);
 void pci_unregister_root_bus(PCIBus *bus);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b0d21bf43a..7d09e1a39d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -500,15 +500,14 @@ bool pci_bus_bypass_iommu(PCIBus *bus)
 }
 
 static void pci_root_bus_internal_init(PCIBus *bus, DeviceState *parent,
-                                       MemoryRegion *address_space_mem,
-                                       MemoryRegion *address_space_io,
+                                       MemoryRegion *mem, MemoryRegion *io,
                                        uint8_t devfn_min)
 {
     assert(PCI_FUNC(devfn_min) == 0);
     bus->devfn_min = devfn_min;
     bus->slot_reserved_mask = 0x0;
-    bus->address_space_mem = address_space_mem;
-    bus->address_space_io = address_space_io;
+    bus->address_space_mem = mem;
+    bus->address_space_io = io;
     bus->flags |= PCI_BUS_IS_ROOT;
 
     /* host bridge */
@@ -529,25 +528,21 @@ bool pci_bus_is_express(const PCIBus *bus)
 
 void pci_root_bus_init(PCIBus *bus, size_t bus_size, DeviceState *parent,
                        const char *name,
-                       MemoryRegion *address_space_mem,
-                       MemoryRegion *address_space_io,
+                       MemoryRegion *mem, MemoryRegion *io,
                        uint8_t devfn_min, const char *typename)
 {
     qbus_init(bus, bus_size, typename, parent, name);
-    pci_root_bus_internal_init(bus, parent, address_space_mem,
-                               address_space_io, devfn_min);
+    pci_root_bus_internal_init(bus, parent, mem, io, devfn_min);
 }
 
 PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
-                         MemoryRegion *address_space_mem,
-                         MemoryRegion *address_space_io,
+                         MemoryRegion *mem, MemoryRegion *io,
                          uint8_t devfn_min, const char *typename)
 {
     PCIBus *bus;
 
     bus = PCI_BUS(qbus_new(typename, parent, name));
-    pci_root_bus_internal_init(bus, parent, address_space_mem,
-                               address_space_io, devfn_min);
+    pci_root_bus_internal_init(bus, parent, mem, io, devfn_min);
     return bus;
 }
 
@@ -586,15 +581,13 @@ void pci_bus_irqs_cleanup(PCIBus *bus)
 PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
                               pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
                               void *irq_opaque,
-                              MemoryRegion *address_space_mem,
-                              MemoryRegion *address_space_io,
+                              MemoryRegion *mem, MemoryRegion *io,
                               uint8_t devfn_min, int nirq,
                               const char *typename)
 {
     PCIBus *bus;
 
-    bus = pci_root_bus_new(parent, name, address_space_mem,
-                           address_space_io, devfn_min, typename);
+    bus = pci_root_bus_new(parent, name, mem, io, devfn_min, typename);
     pci_bus_irqs(bus, set_irq, irq_opaque, nirq);
     pci_bus_map_irqs(bus, map_irq);
     return bus;
-- 
2.41.0


