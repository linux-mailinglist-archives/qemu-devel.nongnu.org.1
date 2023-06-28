Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4FE74191E
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:54:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDG-0004hy-9N; Wed, 28 Jun 2023 15:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDE-0004hR-5X
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:24 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbDC-0005iq-JC
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:23 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so21926966b.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981941; x=1690573941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnZDOSHqQBsSWteDv2G+9LZmJ/COR2eO+dhEfWcuy58=;
 b=UmQPuAyif+TAhSqc0Y8ENy9wQ1MCfLs4xxfoGKvWwNLAvEKyDB/ryEBChaOaWeUjvp
 cqYMmSdCM9qIhXZTueQjMJwrI3LJEtrUo0p6ifBwI/gcvMfu/mxLNXciuUrCNJVVdOBe
 Vgoab3FW8VMnfXBRYM0KFAafktcqkIRB1PAHb4vawy2PDm+uVx4O95UKL96PVg4CJV5n
 f6hUphznarhJZ2ulQoSCeSdnZvZcisTC5j4Yh4xOvM2c3vijsctwbBk+UimjCLpF4ft7
 rfaMBVOSAh8UmQOrAebNBtBY+yYepBzknqI9xSHB60huK3Qu7MUi/b9y/D0jYnsp9chY
 YgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981941; x=1690573941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnZDOSHqQBsSWteDv2G+9LZmJ/COR2eO+dhEfWcuy58=;
 b=TeOUU1lqNGikmxNKdinsYVktZwXz5ptIwjWFCeL04z710gpAe+YRltZiUAc7duwo76
 Y0E2clDFeHYTudcLAD3DQZOP/vNq915XrT892YyhYvIa+0fw+OIHo7mphvN5BTrAyc8/
 VYeX4dEAjOj6UgZQ206YCo2LfEyl7wO+WBCn4O54SUkSTzzrvZpoJta8qf5o9YC99vNV
 R+lHfmLQ0xn4aXQd3O1sSKBlQIHnyp5D8FnWV0DDH1SJXhFxlJhzFHR4UhkPr+WzCnSK
 mJXxfWaTiuY7Tn2cjgTYEDFFInwrYQhZxnx6PGJgr9aqKqJFAfcPQ73GywX4t9QxHWrl
 yEWQ==
X-Gm-Message-State: AC+VfDxOqFmW8aPKKxe6l2rJnwvq5sPDNBWYrVBYw97dPXcSZdp0kUNS
 /mBYpMNyTqcPLnkB7+dBlzTbylLty9s=
X-Google-Smtp-Source: ACHHUZ4pZ82+kJrjkO+6KW4z9PtdPZ35M4HiBsQaNcKcWxkLnbYqkY9TRsAwRgEm31Zn5Ba2Fzzh/A==
X-Received: by 2002:a17:907:3f87:b0:982:84c9:96c4 with SMTP id
 hr7-20020a1709073f8700b0098284c996c4mr31371989ejc.10.1687981940966; 
 Wed, 28 Jun 2023 12:52:20 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:20 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/16] hw/pci-host/i440fx: Have common names for some local
 variables
Date: Wed, 28 Jun 2023 21:51:56 +0200
Message-ID: <20230628195204.1241-9-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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


