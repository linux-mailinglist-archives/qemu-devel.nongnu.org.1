Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A327ABF09
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 10:57:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjyQN-0002x4-Lb; Sat, 23 Sep 2023 04:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQK-0002w7-Jh
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQH-0000YM-TT
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695459333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vorMlXXWqm9+sRu8PR5rNyx/Cs0unkBXlZ5UKunaMu4=;
 b=AxuwXFSjTMhC4vvZbulqr2ywQLk43+TEQ83WCuet8NnqJOph2hQ1XwXH5eX8KjQLIH/1jf
 gXrZ493LsZsfKIWlEUSqkygJXD5AhY9XOS6V3HINNXpQH8i/fY8M1TdY2zASZCRSQCJQ+3
 QdQYDrlc9P/wAfnQKIKqacv+4JXDdpQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-afRqk72GM0WoGVIX795tWg-1; Sat, 23 Sep 2023 04:55:31 -0400
X-MC-Unique: afRqk72GM0WoGVIX795tWg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-405629826ccso2999065e9.0
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 01:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695459330; x=1696064130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vorMlXXWqm9+sRu8PR5rNyx/Cs0unkBXlZ5UKunaMu4=;
 b=WFQ3ZJ6RYIw+q42LDBCc8stlwjKhOsIqfTUbPfmHV6u1c/nhKvQkrt9CTxe3EuYs1E
 tS3Dc4F0DtApI1LhW2b01JhlN9w7EdhIgw93l922/2Z9ca0hH8ROZS6h2A00jIAakCYT
 4G69YuyUQWpJX3E6K5Xrx8/wPbTTTyugLH4jglq41R7I4Q5eGp9AgRlQaH9QNCUrHccd
 D8eZm1rSlFkM+4u7YSH9FKnPrV8zhQGi/iF/Cb7m9eIvAaqIvLVgB7VCmxLG4XIVz5Lx
 16t9Nzl0HcZ7Mekad8Oz4hvFsx7JvvMcC5+4YUd1Xy3/m+pxS7UX3UH1vCVBiPsBFIWx
 axgg==
X-Gm-Message-State: AOJu0YyjrP0/K2Pz7kvJcEkKab/+A2hC9BTdjf0kt2LT+pmT0sJZY7Hd
 j9+tjNeW1HmWla5O/66+URTB9G0Onaoz769POMwmKLE8mZmx4yuOSwrqqDXrobeer3Dckk2yHlb
 CQD18RF4MTJbxWTV8aN16xgizbtrsFboufYo1Epxp099VGCSyaL+D08G0gNq0E6RxFWXlDPhoso
 s=
X-Received: by 2002:a05:600c:240a:b0:3f9:255e:ee3b with SMTP id
 10-20020a05600c240a00b003f9255eee3bmr1293337wmp.30.1695459330291; 
 Sat, 23 Sep 2023 01:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1jy3mz7jMWfrHFSipw/I9Q968tGq6M0rlA/l4Yt/2k6FDmLofvOW+GZ6UBPi/d8SBmiAvhw==
X-Received: by 2002:a05:600c:240a:b0:3f9:255e:ee3b with SMTP id
 10-20020a05600c240a00b003f9255eee3bmr1293327wmp.30.1695459330030; 
 Sat, 23 Sep 2023 01:55:30 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a05600c0ac900b003fbb25da65bsm6701341wmr.30.2023.09.23.01.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 01:55:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com,
	vr_qemu@t-online.de,
	balaton@eik.bme.hu
Subject: [PATCH 11/13] vt82c686: Support machine-default audiodev with fallback
Date: Sat, 23 Sep 2023 10:55:04 +0200
Message-ID: <20230923085507.399260-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230923085507.399260-1-pbonzini@redhat.com>
References: <20230923085507.399260-1-pbonzini@redhat.com>
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


