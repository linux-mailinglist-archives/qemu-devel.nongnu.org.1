Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D67427435F6
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:39:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hg-0002J6-BU; Fri, 30 Jun 2023 03:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hO-00026Z-Bt
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:48 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hM-0005R5-9Q
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:46 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51d7f350758so1871977a12.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110662; x=1690702662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICnwSANFXOo5k8r+0EJnW98OLBKlIArKIUzIRe4d5Us=;
 b=liyawD5GiyRz848ZXiIJKA8UeZCS1AWhhywz7ZvHWuDlEWrOlwBtRzxxlZ/60f5ugb
 vXTHVrWawo9T79eYT75Sd7tDx+z6LrqcQde7Sx3WihaV8Djdu/Go5Lten6sR7KXfT8tp
 O5vcpQa1d+LXXMiPuQHRaJBRJOHN/xqT2e0qT9LXeLhozWvdL07R+aPX/J2hO3HgXxwl
 SD5por1xSQhr87/JIt6zdfARUh5YzNr7v3yG/0xgAmI0vemS1gYc0v7Ii22HLc39NoTm
 9KftzjyfdMKKSrZx5WKVGnJpGkMk0z8+hUqc9cJNFOoaLjRgi5Ru6cxPopiTltTr2AE1
 u11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110662; x=1690702662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICnwSANFXOo5k8r+0EJnW98OLBKlIArKIUzIRe4d5Us=;
 b=O8YhLSxwonInDliPyXP+WpxFSidEPHioY66242CEUL7mY/WaPJj8TbX+hjbAoph1S5
 3eHEWI/koRxJYBql24ggvGI6EWbw0bT659bWvSy8GK6leNSkqlACl1klQQT2TWpdF/Ji
 dD/geeX5ze5X5lY+nf4VNvRkBX18A1uBsR7BVvDB4qR7aecNictpjStrazIkr0ZsofFe
 Oys6vjpb4zWlz+aVp2cYz65X0O5Jw2ttUYC0QwsliTnirHPXLzCtvoA5nm+vEKszizAj
 cx5LHlmW0dyWfAOscni0KAKIt/athUkdNlaE5nFPaj3e0+UBHnHFSk4HX4Q7la+CkgFk
 NTjg==
X-Gm-Message-State: ABy/qLYqDqMf/UI9YayCPcgcF8da/T8e1GaN7ZI2fgCMow4P3vhI9sq1
 8mHJ0qmvx0uB2pIgSg+PLp5vWiO+T8k=
X-Google-Smtp-Source: APBJJlEL33s/6ohdH8AHnNlaNemQeTal/uaJj18kFXpKLl7aJthPo/9t3MpWxKhP5DR81p9cdb6fHw==
X-Received: by 2002:a17:906:3650:b0:974:1d8b:ca5f with SMTP id
 r16-20020a170906365000b009741d8bca5fmr1385463ejb.9.1688110662235; 
 Fri, 30 Jun 2023 00:37:42 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:41 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 13/17] hw/pci-host/i440fx: Add PCI_HOST_PROP_IO_MEM property
Date: Fri, 30 Jun 2023 09:37:16 +0200
Message-ID: <20230630073720.21297-14-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
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
index b9530fc3a0..de14c75e95 100644
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
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-- 
2.41.0


