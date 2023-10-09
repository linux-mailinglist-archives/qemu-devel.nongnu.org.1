Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F477BD7A1
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmtH-0003Mm-FD; Mon, 09 Oct 2023 05:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmsI-00020u-0G
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:48:35 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmsE-0005zy-CW
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:48:29 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-538575a38ffso7036266a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696844902; x=1697449702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6g+UtAuD0hn4kXVa1P2Z0NMjoM/q10pvTRR7Cvby2qs=;
 b=yJ1R9jO8t++tvLIFJ98ns3Xx95BRh4AqQE9yr2wKo35pbKD7aEQyAP69/eC8FWCXFW
 yAyFWjcBIbGGcdRzsNL2RJOpunKZUZgnNcy1M+7aHPxhACLT+7OEs9ttiWX6Gqbg/CX7
 i4jZLyF6M0eEEo609NhnrWwyi2ZIc39fHSu1emmTBln4fuVFw5sUsz45YVYodWnIdg07
 yAVel2eV271/0liKZa/7wuk805a41JJqahP1GQTpG5NonZ09C7gV6WATS4Axc1F4EnR4
 6k+Rw1UhfiFu7D3S/Fqjyxs3+WeZy7CmeeFuJFgGVh901L+rFs/8RgVOPWNZBPQ+QMGO
 ZlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696844902; x=1697449702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6g+UtAuD0hn4kXVa1P2Z0NMjoM/q10pvTRR7Cvby2qs=;
 b=YAwm79rEKUJSFmT/srIEWUVQlnb8c6vsmmm6ZNDfQOl++WokZzHa4gFlqJTcSuIGrm
 oDCXhzmR7SfHPnYt01diXzrHvIw8478YbL7vfOPSv7gz52BnAp+Egtm8XnenKWkwDHPC
 1O38O1NNDb8Ok87KXyi7AVMzJX15LgXK4/w5SZyntEZMxA7djS30NUZMj8VNP2owaf/j
 2xPuEx7ETI7m1jfLF4EjbWDWt29INb53mZK+ZDdgpuTlfhdtrUtXsODL/HKa8JfbBMq8
 2Bvx3+pVHtOS18DJMnVVx3p/v+ZIBt+TqWtb4M/Jw2vScxCxh1SmAmA18Ew9gJeqjXUd
 b+JA==
X-Gm-Message-State: AOJu0YyUS2bW+d5L7Xn5Yt6AREaeWJvL9DO8lDZlXXMVQMXHGMd8Ls7R
 +XLDS0JNQyILAQ+HwWxRTw6cYFwAGMIsvLmA778=
X-Google-Smtp-Source: AGHT+IH6gdktoec8jRRarWcKLLEUW0IJt8aYXKXUqiSzFHml4qE+IyVOeersyPZZSr0anMwMwYiXTw==
X-Received: by 2002:a17:907:2cf6:b0:9ba:1d08:ad4a with SMTP id
 hz22-20020a1709072cf600b009ba1d08ad4amr2491208ejc.29.1696844902291; 
 Mon, 09 Oct 2023 02:48:22 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 i11-20020a170906a28b00b009737b8d47b6sm6499905ejz.203.2023.10.09.02.48.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 02:48:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, David Hildenbrand <david@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 5/6] hw/pci: Clean up global variable shadowing of
 address_space_io variable
Date: Mon,  9 Oct 2023 11:47:45 +0200
Message-ID: <20231009094747.54240-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009094747.54240-1-philmd@linaro.org>
References: <20231009094747.54240-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


