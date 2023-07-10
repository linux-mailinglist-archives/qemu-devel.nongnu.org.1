Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF0D74E1BB
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:04:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzud-0004N2-TC; Mon, 10 Jul 2023 19:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuc-0004Mg-La
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzub-0004DQ-7D
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XqJdx6u6jXF5O2Iy5NnoNS2DM0M40RdaAyjvqgM48CU=;
 b=bMBg+m8vzy43ux5reJUb82hPDl8nAV/qQZQboaSd4M8xa65U7YVYqQ/1Wnl2BavWTmLdEA
 7eMK8Bj4FxoODLBRdnLctyHK1TLunofD61vqyiv5IK4chorNnZgGYQ8a7MLJEfndyGwcTU
 ZiVrY2tuKsXfX6pgWYkbodS0wgpvRpY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-0VuYW9NrMCegFhAyv90Szw-1; Mon, 10 Jul 2023 19:03:18 -0400
X-MC-Unique: 0VuYW9NrMCegFhAyv90Szw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fc0627eafbso12520945e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030195; x=1691622195;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XqJdx6u6jXF5O2Iy5NnoNS2DM0M40RdaAyjvqgM48CU=;
 b=ieKu5nNfbaHdNR/MzBCVuZcCKYcHOBhKiUeys4kq5jI/bDQk5tBWZyrUB3NkvRCwbK
 VvQljewMutCbD4qucUUvuyVY9e6t7NxT07oQm0/J5JCSyDs8OQidfEj6+Qw+Z62iWqkC
 rkJHTsgxWGT3XZ/9gasUZQSjFe2u1ILAUPSWYu1QFEC6o+tx0iWMK5GHLDLoelHm4Czq
 ZRHHCwZMDZ2oPaVN2B9vCTZAuN9T4CtaUnJwNuOjMGbMhvZi4RkrPoAx0hiQIf4pPIGb
 Ej7y6Vn0WITvT2iRFzXbJZRnrDZYtorMQRY85z+/hegyQIo478mw6TYDXa2HonS4cMLu
 mNdQ==
X-Gm-Message-State: ABy/qLakM14EPGhEjVX+fkitogJbqjklP2+fNy3oAko9zXGFARtR+1h4
 GTuRX2k73S/E9ml7GFzj2/SLjSh09KSWaCK3Mp5pDFneVcGdvMdQo5S0soz1lNi4IzXaFKNrHJT
 tlJNASs8UqqH1bl0qNgdlrpdtLSC90rdfmBudUMIoUx9wcLq0tBPoqY1AQubDkll26S7+
X-Received: by 2002:a05:600c:b52:b0:3fb:c060:9698 with SMTP id
 k18-20020a05600c0b5200b003fbc0609698mr13782172wmr.5.1689030195596; 
 Mon, 10 Jul 2023 16:03:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHMxBAf5tcKimAL4BFUDvcU0x9keWIcARX9+UrPGi5NEqNKvP31zy0rqJ58PIty5Cg+p1CuCA==
X-Received: by 2002:a05:600c:b52:b0:3fb:c060:9698 with SMTP id
 k18-20020a05600c0b5200b003fbc0609698mr13782154wmr.5.1689030195214; 
 Mon, 10 Jul 2023 16:03:15 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 m8-20020a7bca48000000b003fbdd9c72aasm939153wml.21.2023.07.10.16.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:14 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 17/66] hw/i386/pc_q35: Resolve redundant q35_host variable
Message-ID: <00f52e77d742c788ade7d713a7bf558481a89eec.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

The variable is redundant to "phb" and is never used by its real type.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230630073720.21297-2-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_q35.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 11a7084ea1..d9f3764184 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -120,8 +120,7 @@ static void pc_q35_init(MachineState *machine)
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
-    Q35PCIHost *q35_host;
-    PCIHostState *phb;
+    Object *phb;
     PCIBus *host_bus;
     PCIDevice *lpc;
     DeviceState *lpc_dev;
@@ -207,10 +206,10 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* create pci host bus */
-    q35_host = Q35_HOST_DEVICE(qdev_new(TYPE_Q35_HOST_DEVICE));
+    phb = OBJECT(qdev_new(TYPE_Q35_HOST_DEVICE));
 
     if (pcmc->pci_enabled) {
-        pci_hole64_size = object_property_get_uint(OBJECT(q35_host),
+        pci_hole64_size = object_property_get_uint(phb,
                                                    PCI_HOST_PROP_PCI_HOLE64_SIZE,
                                                    &error_abort);
     }
@@ -218,23 +217,23 @@ static void pc_q35_init(MachineState *machine)
     /* allocate ram and load rom/bios */
     pc_memory_init(pcms, system_memory, rom_memory, pci_hole64_size);
 
-    object_property_add_child(OBJECT(machine), "q35", OBJECT(q35_host));
-    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_RAM_MEM,
+    object_property_add_child(OBJECT(machine), "q35", phb);
+    object_property_set_link(phb, MCH_HOST_PROP_RAM_MEM,
                              OBJECT(machine->ram), NULL);
-    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_PCI_MEM,
+    object_property_set_link(phb, MCH_HOST_PROP_PCI_MEM,
                              OBJECT(pci_memory), NULL);
-    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_SYSTEM_MEM,
+    object_property_set_link(phb, MCH_HOST_PROP_SYSTEM_MEM,
                              OBJECT(system_memory), NULL);
-    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_IO_MEM,
+    object_property_set_link(phb, MCH_HOST_PROP_IO_MEM,
                              OBJECT(system_io), NULL);
-    object_property_set_int(OBJECT(q35_host), PCI_HOST_BELOW_4G_MEM_SIZE,
+    object_property_set_int(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
                             x86ms->below_4g_mem_size, NULL);
-    object_property_set_int(OBJECT(q35_host), PCI_HOST_ABOVE_4G_MEM_SIZE,
+    object_property_set_int(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
                             x86ms->above_4g_mem_size, NULL);
+
     /* pci */
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(q35_host), &error_fatal);
-    phb = PCI_HOST_BRIDGE(q35_host);
-    host_bus = phb->bus;
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+    host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
     /* create ISA bus */
     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC), true,
                                 TYPE_ICH9_LPC_DEVICE);
-- 
MST


