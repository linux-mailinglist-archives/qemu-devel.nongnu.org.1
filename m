Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4F77B1515
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 09:38:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qllaa-0004nS-2y; Thu, 28 Sep 2023 03:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaY-0004nG-CV
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaW-00069C-RP
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695886652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vorMlXXWqm9+sRu8PR5rNyx/Cs0unkBXlZ5UKunaMu4=;
 b=dASXNQIp5zazgaeqmGkjfwrq6PvUX20Qwg8ebS4hFeuvAIcEcCK4q3oU8y0YXimVlSXK4K
 EYOsKKIAMhiLoc54aJvWPVnwkmndFtneqkwnvtiNuclA587SCV6C30pwiyUP0nigHiGVkh
 GpOk5aAstymZ5BdR/aNy1KKNQNLwDZI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-A_kaZKfoP72hXqSa2J6sLw-1; Thu, 28 Sep 2023 03:37:30 -0400
X-MC-Unique: A_kaZKfoP72hXqSa2J6sLw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a647551b7dso1231530766b.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 00:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695886649; x=1696491449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vorMlXXWqm9+sRu8PR5rNyx/Cs0unkBXlZ5UKunaMu4=;
 b=lT6rl48649tOVnyRNiRdaSh/NGuXOCEC6Y1573EoqFYYgLNCECvI98DZKq3pNkHS1C
 j8T4BUJR3msYEYdn33Jg2zHAfa2ScZzVVXaA76I8tZB1IAaTDt4iTYZPzp2w1NA+uET+
 Pz98vQgQDiQdJBG3OlNGbC3nawzoEkYH0liJ5tT6Zh1Z7PM0HiYg0NZYlRqIk7SQme9m
 tui2ABi6I070eYqqgFKwxZmlfDQQbc1UhkKWRdpWWDA3eLMuyAMv7xQYdMZvx/95OaKR
 AGJRG8m6sC26H/m4jN+fcF2CEnPew1vpUK2m7s9HvxOeON6HICL9rN1WEMYgClk3IPOc
 poYg==
X-Gm-Message-State: AOJu0Ywpn96jun5qfE3cgrjLSzKIcmA22iTO5gx8lXBkDrCfgFv1cfTw
 SewZZKXt1ph1zbiGDUzKj/h60J2V5K/yKmpWRFhuZoHDDTtk46JVzOEosqFrMQtfKAXEcLYI2Xd
 Y6Pa7WvH7E4RAkZ3+OnXQlMpUjS/NEdSb8KSvX9vGLDVdouhRZsdJIknEBrWfgqalt9Gx2TPSrV
 k=
X-Received: by 2002:a17:907:1c95:b0:9b2:b80d:da87 with SMTP id
 nb21-20020a1709071c9500b009b2b80dda87mr496143ejc.16.1695886649007; 
 Thu, 28 Sep 2023 00:37:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsuvIzZA4Olo2vTeJepar7BNvaznzEIEluJcLJE4BvT/yi/dws0X4+ZHszW2EhFRlzfmnpWA==
X-Received: by 2002:a17:907:1c95:b0:9b2:b80d:da87 with SMTP id
 nb21-20020a1709071c9500b009b2b80dda87mr496130ejc.16.1695886648718; 
 Thu, 28 Sep 2023 00:37:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 h28-20020a056402095c00b0053622a35665sm571156edz.66.2023.09.28.00.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 00:37:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH 11/13] vt82c686: Support machine-default audiodev with fallback
Date: Thu, 28 Sep 2023 09:36:55 +0200
Message-ID: <20230928073705.871327-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928073705.871327-1-pbonzini@redhat.com>
References: <20230928073705.871327-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/vt82c686.c   |  2 ++
 hw/mips/fuloong2e.c | 13 ++++++++++---
 hw/ppc/pegasos2.c   | 10 ++++++++--
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 57bdfb4e78c..3ec8e43708a 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -578,6 +578,8 @@ static void via_isa_init(Object *obj)
     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B_USB_UHCI);
     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
+
+    object_property_add_alias(obj, "audiodev", OBJECT(&s->ac97), "audiodev");
 }
 
 static const TypeInfo via_isa_info = {
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index c827f615f3b..df2be188257 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -41,6 +41,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
+#include "audio/audio.h"
 
 #define ENVP_PADDR              0x2000
 #define ENVP_VADDR              cpu_mips_phys_to_kseg0(NULL, ENVP_PADDR)
@@ -295,9 +296,13 @@ static void mips_fuloong2e_init(MachineState *machine)
     pci_bus = bonito_init((qemu_irq *)&(env->irq[2]));
 
     /* South bridge -> IP5 */
-    pci_dev = pci_create_simple_multifunction(pci_bus,
-                                              PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
-                                              TYPE_VT82C686B_ISA);
+    pci_dev = pci_new_multifunction(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
+                                    TYPE_VT82C686B_ISA);
+    if (machine->audiodev) {
+        qdev_prop_set_string(DEVICE(pci_dev), "audiodev", machine->audiodev);
+    }
+    pci_realize_and_unref(pci_dev, pci_bus, &error_abort);
+
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(OBJECT(pci_dev),
                                                             "rtc"),
@@ -337,6 +342,8 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fuloong2e.ram";
     mc->minimum_page_bits = 14;
+
+    machine_add_audiodev_property(mc);
 }
 
 DEFINE_MACHINE("fuloong2e", mips_fuloong2e_machine_init)
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index bd397cf2b5c..61c302895c9 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -37,6 +37,7 @@
 #include "qemu/datadir.h"
 #include "sysemu/device_tree.h"
 #include "hw/ppc/vof.h"
+#include "audio/audio.h"
 
 #include <libfdt.h>
 
@@ -180,8 +181,11 @@ static void pegasos2_init(MachineState *machine)
     pci_bus_irqs(pci_bus, pegasos2_pci_irq, pm, PCI_NUM_PINS);
 
     /* VIA VT8231 South Bridge (multifunction PCI device) */
-    via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(12, 0),
-                                                 TYPE_VT8231_ISA));
+    via = OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0), TYPE_VT8231_ISA));
+    if (machine->audiodev) {
+        qdev_prop_set_string(DEVICE(via), "audiodev", machine->audiodev);
+    }
+    pci_realize_and_unref(PCI_DEVICE(via), pci_bus, &error_abort);
     for (i = 0; i < PCI_NUM_PINS; i++) {
         pm->via_pirq[i] = qdev_get_gpio_in_named(DEVICE(via), "pirq", i);
     }
@@ -564,6 +568,8 @@ static void pegasos2_machine_class_init(ObjectClass *oc, void *data)
     vhc->encode_hpt_for_kvm_pr = vhyp_encode_hpt_for_kvm_pr;
 
     vmc->setprop = pegasos2_setprop;
+
+    machine_add_audiodev_property(mc);
 }
 
 static const TypeInfo pegasos2_machine_info = {
-- 
2.41.0


