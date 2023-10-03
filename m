Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C036B7B6451
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:36:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnap8-0003yC-NK; Tue, 03 Oct 2023 04:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoZ-000314-Bj
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoW-0000Nc-JA
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5jMXh0AgvMSbbzSsPF24dLhbhVyf2VnDuH5Ua++icY=;
 b=XWxqW32ydpaaohk8CQBDDNlELFFmu222tH6lYm2CmjsrxJIs3iOgSdmHpfLyBXfrK7raC7
 ZHXBWsbVuprHICqPcnem0WtL/r+D0Re7Y0cp7Nmw/K2ingm2HdrzBaUiAdv7+9zE8OEpvz
 HAC5yJ0FxEYLTFYPml6Egoq5LJVD4DQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-AhUAXkYDPne3x3RBV6QYWA-1; Tue, 03 Oct 2023 04:31:30 -0400
X-MC-Unique: AhUAXkYDPne3x3RBV6QYWA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99bebfada8cso50596466b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321888; x=1696926688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5jMXh0AgvMSbbzSsPF24dLhbhVyf2VnDuH5Ua++icY=;
 b=hg0LNUmJ8gJqC9JG4Eb5xbDuVUQeE7+q9cYgq5QBpO3iuNWgoCHq82z+HksNashZRg
 tlERw8sdhBep8Sx9iKZutg+JbC6Lyzo6sd0V/pAJ1Zgu0xsWYOqkCOY2ZPSLhsKqbw7O
 VnnZKC6ySKFd6jqhvw1HyU94fcYR2dvp1qRtMZjg1rIqZU6xVEpXaB9XNELQTnavuBtS
 zzPaFP2WieH//VgdCCmDuwx7hfdZpqC3ONvMBiqKt2oVzmwrmgw9CtW6/9UrbA3cwX4Q
 dFPQN3vhWZW+aAiiAMF2zSlktFEg3P3KbGA1vFaF96RsZ3UYzEfRyTGrR6LTk1Lhpe9D
 s97A==
X-Gm-Message-State: AOJu0Yy/EdFifyJqUY+oQ2tpZV+67I1YkSLBNW8n/pmm3zd5icsXp3d9
 y/VUVyb4CvP9ZUYLFc8eZp7CJ0/39D4zYY97TLIk9haVYLkkbfaX0rQDaKKSwbOxmWvLlJoa/3x
 tI8/RFBvlC47BrnfkL4D73DxK7ZVavsFzBsEGJJ952++w61i1GwtWqac48WUDsH43PmvUjJFJRC
 M=
X-Received: by 2002:a17:906:7695:b0:9ae:3d7b:6f46 with SMTP id
 o21-20020a170906769500b009ae3d7b6f46mr11298965ejm.46.1696321888657; 
 Tue, 03 Oct 2023 01:31:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgHQznhIS9GgZfwcFvhwJJDni0dFO2xh502EAOKDWQ19ugQg2AshyDiHpbTyvW32Ii5K7hnw==
X-Received: by 2002:a17:906:7695:b0:9ae:3d7b:6f46 with SMTP id
 o21-20020a170906769500b009ae3d7b6f46mr11298951ejm.46.1696321888310; 
 Tue, 03 Oct 2023 01:31:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 r19-20020a170906365300b009a2235ed496sm662717ejb.141.2023.10.03.01.31.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:31:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/24] vt82c686 machines: Support machine-default audiodev with
 fallback
Date: Tue,  3 Oct 2023 10:30:39 +0200
Message-ID: <20231003083042.110065-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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


