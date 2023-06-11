Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7117F72B165
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:35:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IP5-0006Te-2Q; Sun, 11 Jun 2023 06:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP1-0006SZ-IL
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:31 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOz-0008J4-Pp
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:31 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5149e65c218so5826882a12.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479668; x=1689071668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GO1bxN8p/9grFQqQiwlhNcOUSYerxDVkUtz0Q8ydNk=;
 b=pzZf6EkJfjHw0Ot0XlC07hrx0AAmYiAVFTrrBpVjgAzTA6Jhjf49LT/aKzMu+JLtTX
 3Cbfu3JwDy14hAd8JBtz9H/HEwxTV+a7CEqgo3GIldrpbgSjlnxttPJzRpRtSSXSYWOD
 xmbS8UfHRVXatLq6s6J2BCO6VjxcXxXu59M4EcXrKk6QNelUX4lNLuMG2scLUYwdulAi
 bUDDgbTLEaL6lOesShtSfouNLCukWt4V6YA/7jNg7iCOK/PjA1GeSuWp/jLMb3Zk7kPj
 MwuMCeXf0aiAvId2RkFTyIWJU4YIqUwpFvyQHQ2wDpK6UULatY5sO75Q22hrSkzX4uUy
 BQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479668; x=1689071668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9GO1bxN8p/9grFQqQiwlhNcOUSYerxDVkUtz0Q8ydNk=;
 b=Mh7IUWAa2lTV9rLWd57rwJ5Zt5NzYr6AXmhW1tAwFHdexi3HxlW7aWOO8WJVUpUXte
 eEjdxoBQE+BuU1k0UrpSk1jj9RBm645BW1uGsZUpUFYcL6RrBgPnYt0Wdz7UKGpU0HiL
 GmWWUAJWVuYjwHs6u2Jk1Kw0RRfm+FKPB0ysOWGByuG8UTQ6lBr2eAP0K5uRloa8yEI9
 rKFodkfsTYPDEPeqQbZoa9jZ0cK7VL7TjnZolfuI6dsUy8rF2CgsHPIG1aMFNyASj3/I
 50XTwXqqyEe0ITzeKKtgBF7MSknYWKMsoPF/mn4YwasutxXcGaiMHO0z9G9yT+LnHanU
 VA1g==
X-Gm-Message-State: AC+VfDyfQ7ARDQdbnOPAM/GWgxF21AODCG/sKKu2kIGE/xtCKkL412j7
 uqxLNx3eOwbneCVNcS+rfC6vbkiACvY=
X-Google-Smtp-Source: ACHHUZ440aF/6Vt1n4NcUH02auTE3W0SOKTDXlfSY7PTGl/UIeVNosiz/6GWVxflwIuIyK8FWYxq1w==
X-Received: by 2002:aa7:d70a:0:b0:50d:b92e:d1dc with SMTP id
 t10-20020aa7d70a000000b0050db92ed1dcmr2929429edq.14.1686479668089; 
 Sun, 11 Jun 2023 03:34:28 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:27 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 08/15] hw/pci-host/i440fx: Have common names for some local
 variables
Date: Sun, 11 Jun 2023 12:34:05 +0200
Message-ID: <20230611103412.12109-9-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611103412.12109-1-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
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

`PCIHostState` is often referred to as `phb`, own device state usually as `s`.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/i440fx.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index daa4d11104..88beaf99c4 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -205,28 +205,28 @@ static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
 
 static void i440fx_pcihost_initfn(Object *obj)
 {
-    PCIHostState *s = PCI_HOST_BRIDGE(obj);
+    PCIHostState *phb = PCI_HOST_BRIDGE(obj);
 
-    memory_region_init_io(&s->conf_mem, obj, &pci_host_conf_le_ops, s,
+    memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops, phb,
                           "pci-conf-idx", 4);
-    memory_region_init_io(&s->data_mem, obj, &pci_host_data_le_ops, s,
+    memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops, phb,
                           "pci-conf-data", 4);
 }
 
 static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
 {
-    PCIHostState *s = PCI_HOST_BRIDGE(dev);
+    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    memory_region_add_subregion(s->bus->address_space_io, 0xcf8, &s->conf_mem);
+    memory_region_add_subregion(phb->bus->address_space_io, 0xcf8, &phb->conf_mem);
     sysbus_init_ioports(sbd, 0xcf8, 4);
 
-    memory_region_add_subregion(s->bus->address_space_io, 0xcfc, &s->data_mem);
+    memory_region_add_subregion(phb->bus->address_space_io, 0xcfc, &phb->data_mem);
     sysbus_init_ioports(sbd, 0xcfc, 4);
 
     /* register i440fx 0xcf8 port as coalesced pio */
-    memory_region_set_flush_coalesced(&s->data_mem);
-    memory_region_add_coalescing(&s->conf_mem, 0, 4);
+    memory_region_set_flush_coalesced(&phb->data_mem);
+    memory_region_add_coalescing(&phb->conf_mem, 0, 4);
 }
 
 static void i440fx_realize(PCIDevice *dev, Error **errp)
@@ -248,17 +248,16 @@ PCIBus *i440fx_init(const char *pci_type,
                     MemoryRegion *pci_address_space,
                     MemoryRegion *ram_memory)
 {
+    I440FXState *s = I440FX_PCI_HOST_BRIDGE(dev);
+    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     PCIBus *b;
     PCIDevice *d;
-    PCIHostState *s;
     PCII440FXState *f;
     unsigned i;
-    I440FXState *i440fx;
 
-    s = PCI_HOST_BRIDGE(dev);
     b = pci_root_bus_new(dev, NULL, pci_address_space,
                          address_space_io, 0, TYPE_PCI_BUS);
-    s->bus = b;
+    phb->bus = b;
     object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -268,8 +267,7 @@ PCIBus *i440fx_init(const char *pci_type,
     f->pci_address_space = pci_address_space;
     f->ram_memory = ram_memory;
 
-    i440fx = I440FX_PCI_HOST_BRIDGE(dev);
-    range_set_bounds(&i440fx->pci_hole, below_4g_mem_size,
+    range_set_bounds(&s->pci_hole, below_4g_mem_size,
                      IO_APIC_DEFAULT_ADDRESS - 1);
 
     /* setup pci memory mapping */
-- 
2.41.0


