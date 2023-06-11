Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9558A72B163
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:35:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IPF-0006Wo-IO; Sun, 11 Jun 2023 06:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP4-0006TL-Ea
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:34 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IP2-0008L1-Rc
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:34 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51491b87565so5830592a12.1
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479671; x=1689071671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rASvAqQQU/4SvVLFnL2/99OHgODgEr0JAnZJ6TnfxZc=;
 b=rE4EhJBsqFszZYJK6cKBzCU4wsJ4hYyJe7M1xj2f+nvB5wWc6XpJ/z2L7SATZqPXtP
 QONKhO8GLKmsTZTyY6gjQhZdpt14OvM31cfq5ChiBWqwE3qit4hPrIRCMXDOhZnJ0/pr
 9YcQTAGnedwNNog5vXmLDADb4Uhnb03OAUqh8BdeS0kmvFjaSMt3YwhVNlFzrr+QoNf1
 UWaNrVuALS+HjZU/IqzUygl7FPVtyiD95Y84gz0bJ9Ya7nm73BmJw0xQRaglunJc6OeJ
 +xM9NJEBcNPwOUgia1t6SV8WAgwnAb2xF+5ibwj9n9mrCgiiOo1Ul9mHHdt1tJmc9l17
 PGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479671; x=1689071671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rASvAqQQU/4SvVLFnL2/99OHgODgEr0JAnZJ6TnfxZc=;
 b=ezl4LOpgYpkDo7POq/kqHRPyJ9v92HzWXTDYIyaUR28i/leF4WOX3+lYuio2Z9BA1X
 2KkM/ieMfcVZlCHBwThTf3Ug2rrLOaF3HfLBBCJmUdz80FeNMBfgtzDpK7x+B/xj2VCX
 jM1HpigjTViS5A+nYapBYQj/QHGIChA9mQHxGEnTWISbSUX5YS2MLywMLvJ9CaKLESHQ
 X7AN9CiDbhm2c+RivtD0d0P9REDbzX1HJZ890k0qtvo9JZHZyiVqsFEsoXMk1Erl4zZv
 qvxhi/Htivg2wlMP6f/ykl2+U2bjjY/o90/ZuyF/bHzRjaDNZbJwZcjN+Y/kw4lLj0SN
 W3VQ==
X-Gm-Message-State: AC+VfDyvawoW+gqAgDk2zPLM3QCUOTPwXEDl7DxzJqYBioWLOqoB2FEV
 MSubV9gZmG1+UKI3VWXWZmQYlJdb+Jk=
X-Google-Smtp-Source: ACHHUZ76AlGjfXcaoQ3jwQadOKRhhTxlLy3BkZRnH2+NLo/chbksu6GYGBuycGFmB7aZ2brmLKqPsA==
X-Received: by 2002:aa7:c40a:0:b0:514:9422:37dc with SMTP id
 j10-20020aa7c40a000000b00514942237dcmr3088573edq.6.1686479671225; 
 Sun, 11 Jun 2023 03:34:31 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:30 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 11/15] hw/pci-host/i440fx: Add PCI_HOST_PROP_IO_MEM property
Date: Sun, 11 Jun 2023 12:34:08 +0200
Message-ID: <20230611103412.12109-12-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611103412.12109-1-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
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
index 050200cc46..67eeffb421 100644
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
@@ -51,6 +50,7 @@ struct I440FXState {
     /*< public >*/
 
     MemoryRegion *system_memory;
+    MemoryRegion *address_space_io;
     MemoryRegion *pci_address_space;
     MemoryRegion *ram_memory;
     Range pci_hole;
@@ -239,17 +239,22 @@ static void i440fx_pcihost_initfn(Object *obj)
     object_property_add_link(obj, PCI_HOST_PROP_SYSTEM_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->system_memory,
                              qdev_prop_allow_set_link_before_realize, 0);
+
+    object_property_add_link(obj, PCI_HOST_PROP_IO_MEM, TYPE_MEMORY_REGION,
+                             (Object **) &s->address_space_io,
+                             qdev_prop_allow_set_link_before_realize, 0);
 }
 
 static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
 {
+    I440FXState *s = I440FX_PCI_HOST_BRIDGE(dev);
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    memory_region_add_subregion(phb->bus->address_space_io, 0xcf8, &phb->conf_mem);
+    memory_region_add_subregion(s->address_space_io, 0xcf8, &phb->conf_mem);
     sysbus_init_ioports(sbd, 0xcf8, 4);
 
-    memory_region_add_subregion(phb->bus->address_space_io, 0xcfc, &phb->data_mem);
+    memory_region_add_subregion(s->address_space_io, 0xcfc, &phb->data_mem);
     sysbus_init_ioports(sbd, 0xcfc, 4);
 
     /* register i440fx 0xcf8 port as coalesced pio */
@@ -275,11 +280,12 @@ PCIBus *i440fx_init(const char *pci_type,
     unsigned i;
 
     s->system_memory = address_space_mem;
+    s->address_space_io = address_space_io;
     s->pci_address_space = pci_address_space;
     s->ram_memory = ram_memory;
 
     b = pci_root_bus_new(dev, NULL, s->pci_address_space,
-                         address_space_io, 0, TYPE_PCI_BUS);
+                         s->address_space_io, 0, TYPE_PCI_BUS);
     phb->bus = b;
     object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-- 
2.41.0


