Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B6274E1DC
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:07:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzvD-0007AC-6T; Mon, 10 Jul 2023 19:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvA-0006v4-SR
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzv9-0004Q8-8j
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rCz2MZwVWTLA7GKiawzVQqAFmBnEDXSLl1/166ddiFk=;
 b=LVmGj3qgnfMVchIdz27I+NQH/dIk9z9hzTmf9ttH/1pzEOZpAf+FbnAvL/WZt5lNr07b68
 FDRCSssz3x8poj56xmorbPPKfVD0Asd1whVwm+86Awy2KJJNtzQ+BUzq9H6+87ppNLRLWI
 SyTv6Cs2FtonGZDTwzb/nzVlybEUicY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-I2VSets6NfKGgPi4NFXAZQ-1; Mon, 10 Jul 2023 19:03:52 -0400
X-MC-Unique: I2VSets6NfKGgPi4NFXAZQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-315926005c9so1351452f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030230; x=1691622230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCz2MZwVWTLA7GKiawzVQqAFmBnEDXSLl1/166ddiFk=;
 b=ENQEkQnDV2mIQNc7bXVZYRssWJOWzahRYusaa3ockjQY+6/Nw3E3M60qqOqQg7ml+o
 Dgd9KON2soZtCK1q7KFCFN18TiiWiXFg/Nur92ismC+EdMwmQNF/fAqKnroKFynGvNCB
 rLdHxIppVZHTVEGSdSsxEFSv6iStKvfVClqDyEQj07GHHrkQ7plbAEwzf/H7cxnlzLfz
 6R2u2akgxTFB1s5yWtMsPyW+F5r8jKD2n1xFpqvcPVhG/rmw7OwQ2HOroU7mmaGaZcPP
 CtaGekqNQERP7U4C2hqQuptGP+zAfKUNJJFLyPmWpuy7/1RhIWniUbBdE8dxySMg34ck
 bOqQ==
X-Gm-Message-State: ABy/qLbZzc5Xa/5KsvNhH+qMd7JzcTm1SHDk6t8w4I0zfQLjXDPEsglI
 r7od7lEz3280Y6rq7ehV2NxXu3P4ygRvOiyfkJ5Kn7vq1Lpowcbaq+q94F7qtZiVeVsZEChHuGD
 NvNvwBYhfxAFxzNSpdt5LOw8qEpT/NpgETRym4/G/khr+0vTk3SvJu59GCUJ7hH3Pq5Yk
X-Received: by 2002:a05:6000:1290:b0:314:55cd:ec6b with SMTP id
 f16-20020a056000129000b0031455cdec6bmr1583609wrx.71.1689030230745; 
 Mon, 10 Jul 2023 16:03:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEvrNBWHreRBukB5O8nYulChbRKy5/+52nkB0G+HYS0zbVRbd1U89dECw//jw+vlUV99DCKSQ==
X-Received: by 2002:a05:6000:1290:b0:314:55cd:ec6b with SMTP id
 f16-20020a056000129000b0031455cdec6bmr1583598wrx.71.1689030230539; 
 Mon, 10 Jul 2023 16:03:50 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 r7-20020a5d6947000000b00313fd294d6csm614942wrw.7.2023.07.10.16.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:50 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 29/66] hw/pci-host/i440fx: Add PCI_HOST_PROP_IO_MEM property
Message-ID: <c84858fd907067dcfb7624083dd44879664cc019.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

Introduce the property in anticipation of QOM'ification; Q35 has the same
property.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20230630073720.21297-14-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


