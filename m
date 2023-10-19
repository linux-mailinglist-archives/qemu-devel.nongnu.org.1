Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FBC7D03FA
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:26:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaRb-0008Tg-LU; Thu, 19 Oct 2023 17:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRV-0008DN-Cr
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRS-0005a0-Bu
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:33 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32daeed7771so97581f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750429; x=1698355229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JphZjrzTl79mhHMgBe5a65MwYyuf+BAarrB+apkBPKc=;
 b=MwQnKa1Y/utQNk7vldVnonkqUAtxaNBs1E5KOc10G3rCcg5oa8OFN+fPGXP5B0Ic90
 HEWxPaHcigYlqvRjStCEQF0pGsJNnzBEBZK6LVOjDkKQy0i3swC+8amq/pP4pl5fOBuQ
 rP3Y68qyEl/gRBBL/1DwOTXXMD66SPnkmd1Mj1bzS6g4nH5TrFa5B0Sd5nXaNhc20giX
 7ifJjBQu1zYanDmVdtwM+eDLo1Oa/kvKKeFpdAwd+TZhYxxTw+I5j/5fqnajfltcIhid
 /gBHEuuAE8sh3gajHNaSXnzRzFRpWLX6TXGtMZ/OpwRZRGEX7pkrQZsJKEY4oNwv8qey
 lFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750429; x=1698355229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JphZjrzTl79mhHMgBe5a65MwYyuf+BAarrB+apkBPKc=;
 b=uDfzm8NAbSwvphcLqbLvvho15jm+7ZGEmW1Dmtpfr2T6i/wPMf94iTL/r7xqQQlwOb
 ZLhCjg9yGXnzRsIZYkU+sf1Br3mgOz+kRUDQ1Llxnn81ObyWOS2ddFi6KGxVZ7HNX99d
 vyEULvPiRqAxQJdDElIuHPLL1jPYksraSssUJDREIV6Kc5o+Zmjc+oDP0F07qcQp5rzt
 0gYy6CI2O0PhgxMTpH6r5mN4PLWT3MhIyqhF4m5hm3zjAZ49+C0npokxIIXujU+g98Zt
 DtRsw6HUfRBEAytTEY7UTpM4pNJQ3YDQrqslXdZ59Yy34z4oPbSUczT4RB42pq4XDFBg
 Q21g==
X-Gm-Message-State: AOJu0YyZdcmazyqDed3vgZ6hU67Hk8i8EKchxyeZpC6YY+shLRnGePgZ
 OVZIgF2qQKPmMjiibV+aih3f6PkcLUHosMjy7kCgtg==
X-Google-Smtp-Source: AGHT+IFnBmL8I3yZdaReHFnRbwfYcaXGV8Lbb4Cyk39XmQ4sTlyi7WXdPbNlg8N9fXPsIXSWhZem+g==
X-Received: by 2002:adf:e802:0:b0:32d:b55c:41fa with SMTP id
 o2-20020adfe802000000b0032db55c41famr2277786wrm.28.1697750428731; 
 Thu, 19 Oct 2023 14:20:28 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 o22-20020a5d58d6000000b003143867d2ebsm220609wrf.63.2023.10.19.14.20.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:20:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 20/46] hw/pci: Clean up global variable shadowing of
 address_space_io variable
Date: Thu, 19 Oct 2023 23:17:45 +0200
Message-ID: <20231019211814.30576-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
Message-Id: <20231010115048.11856-6-philmd@linaro.org>
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


