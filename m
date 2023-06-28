Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F555741920
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:55:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDI-0004j7-VZ; Wed, 28 Jun 2023 15:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDH-0004iy-IM
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:27 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDG-0005jM-0m
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:27 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-98e1ccc6673so23179166b.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981944; x=1690573944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKD6DSHKY/sOvXmo5WfDcFMeb6GuFh7TX7kHJMrdslc=;
 b=rj5RKPkLxz9iPfmkmZ6wu+hrkhdIXqIMzOtKOvFc0vN4EJHmS0wrGZeDVI9nnCXwdu
 dm2F/AqxLKKXJGb2eZOCHtZPYDGCn3hyk34sehiArc/fsmsVU7huymdSjIVjItgabXCi
 ADfIjDvgi1mElKspCdAGSix371yUHIPxpCZwaf+TbIx6Jo2svVCiWUNbqG1qTrOxteFF
 ocLBfUcH+VQB3+hPLOQLVGYcdxXC3zg4KIBeO6wXMtgwFJSsbsTPYFfVApSruFwh9aL+
 xybzJPD7YUBfCULbh0FEemMja+S61tTOBC5AhO+nxTNR2GaVtcAgz3t6aGDn8WUyA1ZM
 JwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981944; x=1690573944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gKD6DSHKY/sOvXmo5WfDcFMeb6GuFh7TX7kHJMrdslc=;
 b=RENDfkNq/zGiBcE7i+Hc06FCbb+rQW9OlQNuxmTCBRIikHLCFCX7O5nkM7Zxx7S7Eg
 IV3VNJuOMK3xuKmm/Jgsc+nlURAiF9+42VJU55nTwsBZQZ9ihR9LnyA0czHstHh/nVJ+
 K+hr0R8XJPgU4jAxZwxo5t94+MbpAYKMynPQ9ZJNhMl7eT9d8mtrCAwKCzAHe5tR3shT
 vZ8BfUGuUvLcpvyw4k42wUoaA7cP3UzDW+jL+v3OCz4Ia0X6EPZNHstIdJO1blpz1OeJ
 28APE4g/UNofqqjeQIt6pF1rCTVzGaYi4eSRL7HEiKhvU9LflqFcTM+i6diCS9uQ3YrY
 nCHQ==
X-Gm-Message-State: AC+VfDzpTh47vvUcZkWHWAuqI+a02yOGUX8B0SediXiyimvadM4GogyX
 01azLEwaChvqHqTddOAnyAWxe2y98Qk=
X-Google-Smtp-Source: ACHHUZ7I78F4kraS2Haup/mqkjf7BVTf+fqE3deww6zuwzBlg3Fke4bQE47f2tYmSMPLFGMUNRklPg==
X-Received: by 2002:a17:906:a245:b0:96f:45cd:6c24 with SMTP id
 bi5-20020a170906a24500b0096f45cd6c24mr27805663ejb.23.1687981944397; 
 Wed, 28 Jun 2023 12:52:24 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:23 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 11/16] hw/pci-host/i440fx: Add PCI_HOST_PROP_IO_MEM property
Date: Wed, 28 Jun 2023 21:51:59 +0200
Message-ID: <20230628195204.1241-12-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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

Introduce the property in anticipation of QOM'ification; Q35 has the same
property.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/i440fx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index efc940ba12..a740d1762b 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -27,7 +27,6 @@
 #include "qemu/range.h"
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci-host/i440fx.h"
 #include "hw/qdev-properties.h"
@@ -49,6 +48,7 @@ struct I440FXState {
     PCIHostState parent_obj;
 
     MemoryRegion *system_memory;
+    MemoryRegion *io_memory;
     MemoryRegion *pci_address_space;
     MemoryRegion *ram_memory;
     Range pci_hole;
@@ -237,17 +237,22 @@ static void i440fx_pcihost_initfn(Object *obj)
     object_property_add_link(obj, PCI_HOST_PROP_SYSTEM_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->system_memory,
                              qdev_prop_allow_set_link_before_realize, 0);
+
+    object_property_add_link(obj, PCI_HOST_PROP_IO_MEM, TYPE_MEMORY_REGION,
+                             (Object **) &s->io_memory,
+                             qdev_prop_allow_set_link_before_realize, 0);
 }
 
 static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
 {
+    I440FXState *s = I440FX_PCI_HOST_BRIDGE(dev);
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    memory_region_add_subregion(phb->bus->address_space_io, 0xcf8, &phb->conf_mem);
+    memory_region_add_subregion(s->io_memory, 0xcf8, &phb->conf_mem);
     sysbus_init_ioports(sbd, 0xcf8, 4);
 
-    memory_region_add_subregion(phb->bus->address_space_io, 0xcfc, &phb->data_mem);
+    memory_region_add_subregion(s->io_memory, 0xcfc, &phb->data_mem);
     sysbus_init_ioports(sbd, 0xcfc, 4);
 
     /* register i440fx 0xcf8 port as coalesced pio */
@@ -273,11 +278,12 @@ PCIBus *i440fx_init(const char *pci_type,
     unsigned i;
 
     s->system_memory = address_space_mem;
+    s->io_memory = address_space_io;
     s->pci_address_space = pci_address_space;
     s->ram_memory = ram_memory;
 
     b = pci_root_bus_new(dev, NULL, s->pci_address_space,
-                         address_space_io, 0, TYPE_PCI_BUS);
+                         s->io_memory, 0, TYPE_PCI_BUS);
     phb->bus = b;
     object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-- 
2.41.0


