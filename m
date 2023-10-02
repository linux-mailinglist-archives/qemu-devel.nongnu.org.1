Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 230D57B558E
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:59:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKMy-0008F5-JX; Mon, 02 Oct 2023 10:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKMv-0008Eb-U8
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKMu-0003gH-C1
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696258675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YP+oOGV6ceC7IJnxW+LscO32SshzxWHloVeYfLiwIOA=;
 b=BhIusTCKNTGQDS3yXZBuyk4xN3BxUMQyYHs1zGsM2lPUdqAlj+YFzvfnJy/riyCpY6D2DX
 zN+oMZ15Y/VB8Mm+BoP6GPvRjsqNgMBYIps+1z803+L7R9RXWMdmCM3i8GAG4OY1TRxIPV
 75Vgk+ToyiaothMyM8oQChoM/MTAV7o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-i4rN2YA5N86QyCFafTM8Sg-1; Mon, 02 Oct 2023 10:57:53 -0400
X-MC-Unique: i4rN2YA5N86QyCFafTM8Sg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-993d7ca4607so1414562866b.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696258672; x=1696863472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YP+oOGV6ceC7IJnxW+LscO32SshzxWHloVeYfLiwIOA=;
 b=Vtd7DXTs0vKgnn9w6gIJOOXkRYSdL43b7hYLv051QtYwquCVUnvml/HngBhzRPkdeu
 4GjDA2BSfFIr6E5nBh60E4kdbm1jQxHCHV1Q0lvVeXjDRPx7+30mbHYOxYKLc06OzTg6
 WKy/OMWdEY87wLbtl12khH3yoS1xPjk112OSqWT1sWwLRMFTYoidF1IgNp/SnCXq0XTI
 bMztIiptGgyTq9d3tJ/OKI93df7/GtY2AHdDYz62vP0uiIh98jiM6Sdyizkj5/aeEjf+
 4v+58duEGd6OISpfD6nH9a501eTvmYfYk4gwqc97SIWub1Ex0xoUodTHt7j8AeCu5PFw
 O1vQ==
X-Gm-Message-State: AOJu0YysRUFE/+a8B3WLDrf1BF3Pp13aVOpA+hMoagqhTmHbKbvy07Ed
 yVXBdDkB/nGPnPV4uUZEAxb/9H9z4qqRkxnVgTP1uDcuwJ2a/vq8KIebtDdPyKSlL7RTDhqz88m
 aLNE1dBDptWF89iMlO6BMDTdL1hIS3SBEtkdHwTfxiZZlNG99w/vO+Xh9fF6MwT0ebrnhiQC/E2
 Q=
X-Received: by 2002:a17:906:225c:b0:9b2:89eb:79b5 with SMTP id
 28-20020a170906225c00b009b289eb79b5mr10105026ejr.35.1696258672247; 
 Mon, 02 Oct 2023 07:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1KEz+Na519k56zhIRrJReJkRTKk/Bm1N9BezCSeiam+kloPo/1tLRCl5yVxZQXfbfruRAJQ==
X-Received: by 2002:a17:906:225c:b0:9b2:89eb:79b5 with SMTP id
 28-20020a170906225c00b009b289eb79b5mr10105016ejr.35.1696258671973; 
 Mon, 02 Oct 2023 07:57:51 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a1709063ad300b009a1a653770bsm17241210ejd.87.2023.10.02.07.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:57:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
Subject: [PATCH 11/13] vt82c686 machines: Support machine-default audiodev
 with fallback
Date: Mon,  2 Oct 2023 16:57:25 +0200
Message-ID: <20231002145728.87958-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002145728.87958-1-pbonzini@redhat.com>
References: <20231002145728.87958-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mips/fuloong2e.c | 15 ++++++++++++---
 hw/ppc/pegasos2.c   | 12 ++++++++++--
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index c827f615f3b..c6109633fee 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -295,9 +295,17 @@ static void mips_fuloong2e_init(MachineState *machine)
     pci_bus = bonito_init((qemu_irq *)&(env->irq[2]));
 
     /* South bridge -> IP5 */
-    pci_dev = pci_create_simple_multifunction(pci_bus,
-                                              PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
-                                              TYPE_VT82C686B_ISA);
+    pci_dev = pci_new_multifunction(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
+                                    TYPE_VT82C686B_ISA);
+
+    /* Set properties on individual devices before realizing the south bridge */
+    if (machine->audiodev) {
+        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ac97"));
+        qdev_prop_set_string(dev, "audiodev", machine->audiodev);
+    }
+
+    pci_realize_and_unref(pci_dev, pci_bus, &error_abort);
+
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(OBJECT(pci_dev),
                                                             "rtc"),
@@ -337,6 +345,7 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fuloong2e.ram";
     mc->minimum_page_bits = 14;
+    machine_add_audiodev_property(mc);
 }
 
 DEFINE_MACHINE("fuloong2e", mips_fuloong2e_machine_init)
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index bd397cf2b5c..3203a4a7289 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -180,8 +180,15 @@ static void pegasos2_init(MachineState *machine)
     pci_bus_irqs(pci_bus, pegasos2_pci_irq, pm, PCI_NUM_PINS);
 
     /* VIA VT8231 South Bridge (multifunction PCI device) */
-    via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(12, 0),
-                                                 TYPE_VT8231_ISA));
+    via = OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0), TYPE_VT8231_ISA));
+
+    /* Set properties on individual devices before realizing the south bridge */
+    if (machine->audiodev) {
+        dev = PCI_DEVICE(object_resolve_path_component(via, "ac97"));
+        qdev_prop_set_string(DEVICE(dev), "audiodev", machine->audiodev);
+    }
+
+    pci_realize_and_unref(PCI_DEVICE(via), pci_bus, &error_abort);
     for (i = 0; i < PCI_NUM_PINS; i++) {
         pm->via_pirq[i] = qdev_get_gpio_in_named(DEVICE(via), "pirq", i);
     }
@@ -556,6 +563,7 @@ static void pegasos2_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
     mc->default_ram_id = "pegasos2.ram";
     mc->default_ram_size = 512 * MiB;
+    machine_add_audiodev_property(mc);
 
     vhc->cpu_in_nested = pegasos2_cpu_in_nested;
     vhc->hypercall = pegasos2_hypercall;
-- 
2.41.0


