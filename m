Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 711CF7D224D
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:30:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUhk-0005Cv-79; Sun, 22 Oct 2023 05:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhd-00059B-RG
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhb-0000cZ-AB
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qe9cw8bUuCtqGm/AJ5pwVjkO/Ec49p8b0ZTEQUoDbXo=;
 b=d0yxVGt9bZpDhvARWoLA3yno81c/U72j4txjnQ0/FlTPGEFHfscxY3hpwhcL58wEdcL8BY
 cg9szI3M0J+KuezpuakVtnvSVD1sbAEHZc1t7PC3bK+UFGvWGaSslNrtsa1cGBezH4aSC6
 YUBJrvxUOTBeYAGHzzQGEPpScWlEtm8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-2tOVpoaDPbSp9p3tC_l0tQ-1; Sun, 22 Oct 2023 05:24:52 -0400
X-MC-Unique: 2tOVpoaDPbSp9p3tC_l0tQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c504f93c4eso20050661fa.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966690; x=1698571490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qe9cw8bUuCtqGm/AJ5pwVjkO/Ec49p8b0ZTEQUoDbXo=;
 b=K0Z7Cro9PDm/2V4rXYnn0ZENjIZf82ZwuSpneQseVPYKfUghQky6TQ+8ha03i/XDrT
 EGyuHkpRzm+aCbFF26jA+D+ofxiX17LlR48isgI0TfHAL3qHBR+cP2IltRDdcJG1g3Ke
 0PsfQev7sKyp1O7jQlyqr8Bn0G+dSkDgQ/61HQtUjweAoB4t4HnXp92q4KTGjKtd3GAh
 VZmdt0p4DDTiF0NwyJeK7+vQDwRxxtLNXVY1TjAmWwt7R1gx9//h+JEEugSnaUScGJ5X
 sjTBfhPJ6hqy7y+stV2J+6FQarW/5Y6UCI01RnjURy4gYB7HXZutL8uM4SWQZo4eM2DU
 IPfA==
X-Gm-Message-State: AOJu0YyixwDXAbiMcPIRQh/su4F2t+svmN/CfK1iwVQCSotiMa0EL0ZC
 e+yB1/LIDLZ6mJwo9dzjRIIhc6Hw3FA+5pGY/DjXrKSBFS4WYgfzBH8sM1G1tiirdrLfzvlNYyy
 CBTBPBXNFAnbBvjDbBQB/bhDG/6L6ZU5zypl0bPEisPEHaNhSe1zcyw2lh11RYTQtJaRG
X-Received: by 2002:a2e:be1a:0:b0:2c5:13b1:b450 with SMTP id
 z26-20020a2ebe1a000000b002c513b1b450mr3633905ljq.26.1697966690711; 
 Sun, 22 Oct 2023 02:24:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLl++6xRf2SNaJYIplxkk+k6vR0DPkBV8+eN6skYA19XAFanCWcHiDzbepEWE8P6zCPhQ7rA==
X-Received: by 2002:a2e:be1a:0:b0:2c5:13b1:b450 with SMTP id
 z26-20020a2ebe1a000000b002c513b1b450mr3633891ljq.26.1697966690436; 
 Sun, 22 Oct 2023 02:24:50 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 w11-20020a05600c474b00b00405959469afsm6545535wmo.3.2023.10.22.02.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:24:49 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:24:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL v3 41/62] hw/isa/piix: Allow for optional PIC creation in PIIX3
Message-ID: <2d7630f5c7dbe5ec1fc42082d135eb6e5f159ebd.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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


