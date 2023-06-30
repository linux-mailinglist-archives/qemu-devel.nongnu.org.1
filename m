Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5957435EF
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:39:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hl-0002YV-SP; Fri, 30 Jun 2023 03:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hL-00024b-EA
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:44 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hJ-0005QW-IM
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:43 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-98e39784a85so269555266b.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110659; x=1690702659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELMLBs1OW9Di44cgpdfhOSCdcVBvjTZJizwS8W5LbOQ=;
 b=np4CIWaaMZb8vaoNdfRlOr12Bxwqa3yb7XDZZv7Xop6QwS0fByO5iBiqKFu/wfIy0A
 gdIDVuSfjOtCAu4dWyJBlt/lc0Nf0oMT0rtbB0YR4kSNNQTKFlev2ZZePquRYQ3EbRbv
 c39IrCund+r/ZROX/Geh2W8Ni6wEWfQwlNbzf3VP4cb9Fxj1mIid+cru64MTVHn3cbZ1
 WnNjVVMCBuomOyFAolNnL9nJ+mk5lCVoIqj2+XWq41sGiC2yNjeDkRlOx16xrPuR+C6D
 iADJ3FvZikGuwp7WbPmrOSajxNsEtuYMuuogxAKKXoQkNDMBR13xazae/IDpezPDpB/K
 +L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110659; x=1690702659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELMLBs1OW9Di44cgpdfhOSCdcVBvjTZJizwS8W5LbOQ=;
 b=cBI0FoecsaKquw0zQUTzkuw+WeKV7kNVua0l8QP0hhiToXv49VLQM9+1oodxdujrnc
 GkEM0AaSI7/Mlfdue1Z1Kfd+lWBX9/D2Bgr45omjqZc2vot0KCcpROB0mRGDeCRTWnDZ
 Pieb4hiSWEmNol2vNPU/McMqY90urXkavpjxerjmvG6S4cPQQPE8dnNOPD4FAoA8Y+Ep
 f8VL5TN0zvgts7eGwRqQ0ehGNursYAfr0mWPSW+F9xlhxAE0UIwN5V4R7TWjdYnzsPOX
 eP191PQGNuJEnE+W//LcwuIdEZzFOm1eQAly2aPRxakY5cszM8AbdW7YxIcFHJTuUFbj
 kmqA==
X-Gm-Message-State: ABy/qLaPJIVrKulJABb6LNeOzMumZfwgNOxp15v1grrjqmY4bBNnGEFI
 tVsF73XTOa7zfJpB0r6Nw49YnQrsi4g=
X-Google-Smtp-Source: APBJJlHd+O+EjTWgHqGX/+x7Q/xZKzVCoB/VcqYW2/IhCsfiZCyRoxd1WpQI7l0ejs75YZpNtw+qXA==
X-Received: by 2002:a17:906:3453:b0:98f:8481:24b3 with SMTP id
 d19-20020a170906345300b0098f848124b3mr1876765ejb.37.1688110659250; 
 Fri, 30 Jun 2023 00:37:39 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:38 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/17] hw/pci-host/i440fx: Have common names for some local
 variables
Date: Fri, 30 Jun 2023 09:37:13 +0200
Message-ID: <20230630073720.21297-11-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.41.0


