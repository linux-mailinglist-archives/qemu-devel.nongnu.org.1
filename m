Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E571C7CE263
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:11:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8xC-0001pI-Ll; Wed, 18 Oct 2023 11:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8w4-0000OH-1c
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8w2-0007O3-D7
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qe9cw8bUuCtqGm/AJ5pwVjkO/Ec49p8b0ZTEQUoDbXo=;
 b=HD99zhg5Q6JrkLBOOtK8NAOtAe3iw1NGiDYmz5tDGykYjdehyhEcZRwAMDM5dfIvl0kPwq
 hmUIeWcPnSBkaRFONHMHxZF6Suj0egPmx7V09MWY1As1CNlB86UkOHa+1m07LfwauHc9HH
 YfD11QwO1CNuKDN6IrAe77hldJQV6Lc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-i8rNFe3UOhiSYnyQikk6jw-1; Wed, 18 Oct 2023 11:58:11 -0400
X-MC-Unique: i8rNFe3UOhiSYnyQikk6jw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4084001846eso3587245e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644688; x=1698249488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qe9cw8bUuCtqGm/AJ5pwVjkO/Ec49p8b0ZTEQUoDbXo=;
 b=OC8cmnJStEgnX4iwWJF7zgVcxMHL4sDptAxFl/qhhsarLIvWpoeSIwzctmX3XbQBIg
 Jen8x4XxWl3QxTfKKgfKT7r+er6HM2kNa1+hl2aREEbvSoHvwDbxo6kyX0JrgZK2UV9M
 nfSF4vOFdTI3hZY3iyeG0Js3OHb/kL178EgMKFdQ7yhHJ6IBeWkpHuKhamV4d5bSx0CA
 lV9r0EBk38t2Uu2MrClnOY6NW63XxYs5JeICWj0zWxlEEO0ai1mM6WCBXmeMHLUEh7JL
 gC8P8hVVDDke/54WI44ezR3f3+IKKflOI24rcp72J8UYeqSKVBmOazUZD4Z2ExTolOzq
 CTKw==
X-Gm-Message-State: AOJu0Yy0F1KEexfcREUY4OEuOzJ5vEQoUyX9txWc6wuiIWbKv89l4i5P
 IA7iiCC67K+2QR8C75Fyq+HzBJa7JShJQE6Zkd9dMmdEnEEaoC5L/h1gBZUDUYqcIos61D17ZI/
 dhVHsbLKYKIPWmLkDg6ioDTyiKkh3HvRRk7+jSfKMxphOWlyuOvgLDkZeW5LmDvgV8byGy+w=
X-Received: by 2002:a05:600c:1c26:b0:407:5b7c:2f6a with SMTP id
 j38-20020a05600c1c2600b004075b7c2f6amr4392058wms.0.1697644688686; 
 Wed, 18 Oct 2023 08:58:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyk0T0gV4WNQ8ThxlQwSBRJOOsPasWHsf8uwWOsgsy8gEdcYpXjzkNn3F7SssvdlpqnhphQw==
X-Received: by 2002:a05:600c:1c26:b0:407:5b7c:2f6a with SMTP id
 j38-20020a05600c1c2600b004075b7c2f6amr4392040wms.0.1697644688433; 
 Wed, 18 Oct 2023 08:58:08 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a05600c445200b004063c9f68f2sm2025466wmn.26.2023.10.18.08.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:58:07 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:58:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL 62/83] hw/isa/piix: Allow for optional PIC creation in PIIX3
Message-ID: <051f087d67fb7cede89f091501187f773a99cd99.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In the PC machine, the PIC is created in board code to allow it to be
virtualized with various virtualization techniques. So explicitly disable its
creation in the PC machine via a property which defaults to enabled. Once the
PIIX implementations are consolidated this default will keep Malta working
without further ado.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-21-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/piix.h |  1 +
 hw/i386/pc_piix.c             |  2 ++
 hw/isa/piix.c                 | 21 +++++++++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index dd5f7b31c0..08491693b4 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -69,6 +69,7 @@ struct PIIXState {
     MemoryRegion rcr_mem;
 
     bool has_acpi;
+    bool has_pic;
     bool has_usb;
     bool smm_enabled;
 };
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 70cffcfe4f..fa39afd891 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -268,6 +268,8 @@ static void pc_init1(MachineState *machine,
         object_property_set_bool(OBJECT(pci_dev), "has-acpi",
                                  x86_machine_is_acpi_enabled(x86ms),
                                  &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
+                                 &error_abort);
         qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
         object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
                                  x86_machine_is_smm_enabled(x86ms),
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index f6da334c6f..d6d9ac6473 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -106,7 +106,7 @@ static void piix4_set_irq(void *opaque, int irq_num, int level)
     }
 }
 
-static void piix4_request_i8259_irq(void *opaque, int irq, int level)
+static void piix_request_i8259_irq(void *opaque, int irq, int level)
 {
     PIIX4State *s = opaque;
     qemu_set_irq(s->cpu_intr, level);
@@ -343,6 +343,22 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
     memory_region_add_subregion_overlap(pci_address_space_io(dev),
                                         PIIX_RCR_IOPORT, &d->rcr_mem, 1);
 
+    /* PIC */
+    if (d->has_pic) {
+        qemu_irq *i8259_out_irq = qemu_allocate_irqs(piix_request_i8259_irq, d,
+                                                     1);
+        qemu_irq *i8259 = i8259_init(isa_bus, *i8259_out_irq);
+        size_t i;
+
+        for (i = 0; i < ISA_NUM_IRQS; i++) {
+            d->isa_irqs_in[i] = i8259[i];
+        }
+
+        g_free(i8259);
+
+        qdev_init_gpio_out_named(DEVICE(dev), &d->cpu_intr, "intr", 1);
+    }
+
     isa_bus_register_input_irqs(isa_bus, d->isa_irqs_in);
 
     i8257_dma_init(isa_bus, 0);
@@ -419,6 +435,7 @@ static void pci_piix3_init(Object *obj)
 static Property pci_piix3_props[] = {
     DEFINE_PROP_UINT32("smb_io_base", PIIXState, smb_io_base, 0),
     DEFINE_PROP_BOOL("has-acpi", PIIXState, has_acpi, true),
+    DEFINE_PROP_BOOL("has-pic", PIIXState, has_pic, true),
     DEFINE_PROP_BOOL("has-usb", PIIXState, has_usb, true),
     DEFINE_PROP_BOOL("smm-enabled", PIIXState, smm_enabled, false),
     DEFINE_PROP_END_OF_LIST(),
@@ -514,7 +531,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
                                         PIIX_RCR_IOPORT, &s->rcr_mem, 1);
 
     /* initialize i8259 pic */
-    i8259_out_irq = qemu_allocate_irqs(piix4_request_i8259_irq, s, 1);
+    i8259_out_irq = qemu_allocate_irqs(piix_request_i8259_irq, s, 1);
     i8259 = i8259_init(isa_bus, *i8259_out_irq);
 
     for (i = 0; i < ISA_NUM_IRQS; i++) {
-- 
MST


