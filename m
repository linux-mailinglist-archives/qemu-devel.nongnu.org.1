Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C288D74E1DB
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzv4-0006KK-Bj; Mon, 10 Jul 2023 19:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzv2-000665-94
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzv0-0004OB-Ko
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h9s9LINlofROMqq3QpUKiPP8dWTQZ4BuJJSE2ob0izQ=;
 b=GdNrpWnNt5Z1PJyaFgUCSvVBRjwjaHrjNr4HEf0gn1/NzmFNrAgtObD888RnAFoWdQPUYO
 lgCpRj3sfR1K9bdiMEhptJQ0+ijGUZDn/WbOov5omf/eJBcNSfnKxpuYMctAIe34zmNPGL
 vbUnmTsPUCPUWtzluuFGU6kEQpbfvT0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-ImHNmX6NNmS7ot3CF40_Kg-1; Mon, 10 Jul 2023 19:03:43 -0400
X-MC-Unique: ImHNmX6NNmS7ot3CF40_Kg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31444df0fafso2937149f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030222; x=1691622222;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h9s9LINlofROMqq3QpUKiPP8dWTQZ4BuJJSE2ob0izQ=;
 b=LsDjtwpmM7mmaTx0Ntc5D3ThKFk0kpgdTij4PSLJ9Z0vqHcvGwDAwvlv1OyEcwdyYg
 sY+Lkyi8KFfE4AdPunIC9piXLfOdBaHtGmFJ0lXW8WJf1RNJE35/0aOMZ8gPR4w82Dw0
 Gj618SrdbXkRQfcLFsMS7SL+mbVXbR3SCS3Ru+bWUIWRzWe+F75uEhjudPoDv2jRLJ+S
 5Dp0jEWnXccmAEmhQ1xLoYI1kcmrjd0Vsi1PgmLh2R790JvdTt7gt6fb3RsakgUq0ym1
 2BVr/fX/tYf2Mgv+homkFtAjjH1Bz8VtKZNWj/cXVGI8Ub44U5FXwN8ZgdHO18b+YNfD
 aOCQ==
X-Gm-Message-State: ABy/qLbuZIwKAtwdcoXUGml/yXq+v1NlRvm/QvqIbcisT3eDK/WTpUzZ
 4jIzII7mKGcjwemHS5gNLOxG54gxr2giQW40yRK9aTECjeK3qsBl2pzR6eewunElsIP1qTq9tgo
 vQW9MrWaSzGMY1RQs7txefMXbRd0XVE2rmsIJSu/StCHvyJKF36ieHgFnUgcOmgE8kMMn
X-Received: by 2002:a5d:5391:0:b0:315:9d08:9d3b with SMTP id
 d17-20020a5d5391000000b003159d089d3bmr4951915wrv.32.1689030222004; 
 Mon, 10 Jul 2023 16:03:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHwItxCu6dIxbKWYunGmQdaE/4uNN5/Pth9lufiDU95AVrjyAjunL0kUIE5g7aYp2qGSqbf5Q==
X-Received: by 2002:a5d:5391:0:b0:315:9d08:9d3b with SMTP id
 d17-20020a5d5391000000b003159d089d3bmr4951894wrv.32.1689030221766; 
 Mon, 10 Jul 2023 16:03:41 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 l10-20020adffe8a000000b00315995837aesm591126wrr.36.2023.07.10.16.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:41 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 26/66] hw/pci-host/i440fx: Have common names for some local
 variables
Message-ID: <a707466dd62712e4a76e30217a8880e6ab8c7b10.1689030052.git.mst@redhat.com>
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

`PCIHostState` is often referred to as `phb`, own device state usually as `s`.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230630073720.21297-11-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/i440fx.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index b7c24a4e1d..0b76fe71af 100644
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
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     d = pci_create_simple(b, 0, pci_type);
@@ -267,8 +266,7 @@ PCIBus *i440fx_init(const char *pci_type,
     f->pci_address_space = pci_address_space;
     f->ram_memory = ram_memory;
 
-    i440fx = I440FX_PCI_HOST_BRIDGE(dev);
-    range_set_bounds(&i440fx->pci_hole, below_4g_mem_size,
+    range_set_bounds(&s->pci_hole, below_4g_mem_size,
                      IO_APIC_DEFAULT_ADDRESS - 1);
 
     /* setup pci memory mapping */
-- 
MST


