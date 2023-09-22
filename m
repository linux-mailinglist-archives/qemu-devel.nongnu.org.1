Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B75507AAE87
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:45:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcj8-000241-0c; Fri, 22 Sep 2023 05:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcj6-00023s-Fo
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjciq-00067I-Rx
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbDMyVOF+Ye0W0SxcmrxeQBRDTfkxy+h8RSyp7R+k7s=;
 b=AonPqEF9mo6fHtF22vQeNq+g1kJOLVeaF+9Wg/EI9J1o/KSew4bwa6JJwpcOKRGzuMUyss
 WvpldqhMtfElVrMzqr5geAbxn/cKP8P9IKOusmUVBKMsdfdxvBXRr+GfJgqapKlKUsDiVz
 pVhK/7WSzfIgCpAJVFRHijVOutNfkWc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-RfdQx5cbNkiW5rtUHSb_Vg-1; Fri, 22 Sep 2023 05:45:14 -0400
X-MC-Unique: RfdQx5cbNkiW5rtUHSb_Vg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5043eb2c436so394080e87.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375912; x=1695980712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbDMyVOF+Ye0W0SxcmrxeQBRDTfkxy+h8RSyp7R+k7s=;
 b=M1P9qOE5vr6uOsb3nCDXMNC7yZendGYqu39uVyu22AMegYyb5B6F/O9/gFRT5Ru7v0
 gFl/azkewztqkxMTXT4e/9rya8jwZB3ZbaFd7PWN+vuhDrflUdQRLLKMFdetjrmqQCxm
 hMibAw74vxD++8BiAyDguOwgHVqTk+q0aFHPIIBGtBmWJ4otBKrFjUcCV8TcW3q3Xs+p
 rU1O89PkuxdU3JKEchVxE8sHcDj2hiFe1BBa8AQZcAS8LogBOf0BW3VOkOR2sHdV2axn
 byhVv+LivLkEOCwQIyrcrpcwgszrpjI7IbGu2Dfg8D4RezfcuOoaK0NGI+tnCGEgyLvb
 kc3g==
X-Gm-Message-State: AOJu0YyME3V5rZH3f/URNcj37cIH84E8D3qXhBlnpl4qM9+2t3urkBmy
 RAjv0MyekBXg2fOlxKPRvZJ8+IhzZEB68tCuK3gkqbPIn+msCdafYeECk+nNn4D+y5TIUy3W0A9
 nW7bYq8Xo/nw7LNEFl4eSrfLKGl8MNMOFo7cspn1g3Ts+527FdwbOaB3FWv7Z1ZhwQHdUbziuAa
 k=
X-Received: by 2002:a05:6512:e86:b0:500:7e64:cff1 with SMTP id
 bi6-20020a0565120e8600b005007e64cff1mr9747345lfb.14.1695375912415; 
 Fri, 22 Sep 2023 02:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcJKPzUGiOeTF0u23loOkyLMTC9VoF1BTig4uNaaak9AbGdJyaMKVS/kTuPyUTWd2iRxunMg==
X-Received: by 2002:a05:6512:e86:b0:500:7e64:cff1 with SMTP id
 bi6-20020a0565120e8600b005007e64cff1mr9747326lfb.14.1695375912042; 
 Fri, 22 Sep 2023 02:45:12 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a05600c3b8300b004053a6b8c41sm2329390wms.12.2023.09.22.02.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:45:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com
Subject: [PATCH 6/9] vt82c686: Support machine-default audiodev with fallback
Date: Fri, 22 Sep 2023 11:44:56 +0200
Message-ID: <20230922094459.265509-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922094459.265509-1-pbonzini@redhat.com>
References: <20230922094459.265509-1-pbonzini@redhat.com>
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
 hw/mips/fuloong2e.c | 12 +++++++++---
 hw/ppc/pegasos2.c   | 10 ++++++++--
 hw/ppc/sam460ex.c   |  2 ++
 4 files changed, 21 insertions(+), 5 deletions(-)

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
index c827f615f3b..d0671824f94 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -41,6 +41,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
+#include "audio/audio.h"
 
 #define ENVP_PADDR              0x2000
 #define ENVP_VADDR              cpu_mips_phys_to_kseg0(NULL, ENVP_PADDR)
@@ -295,9 +296,12 @@ static void mips_fuloong2e_init(MachineState *machine)
     pci_bus = bonito_init((qemu_irq *)&(env->irq[2]));
 
     /* South bridge -> IP5 */
-    pci_dev = pci_create_simple_multifunction(pci_bus,
-                                              PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
-                                              TYPE_VT82C686B_ISA);
+    pci_dev = pci_new_multifunction(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
+                                    TYPE_VT82C686B_ISA);
+    qdev_prop_set_string(DEVICE(pci_dev), "audiodev",
+                         audio_maybe_init_dummy("fuloong2e.defaudio"));
+    pci_realize_and_unref(pci_dev, pci_bus, &error_abort);
+
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(OBJECT(pci_dev),
                                                             "rtc"),
@@ -337,6 +341,8 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fuloong2e.ram";
     mc->minimum_page_bits = 14;
+
+    machine_add_audiodev_property(mc);
 }
 
 DEFINE_MACHINE("fuloong2e", mips_fuloong2e_machine_init)
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index bd397cf2b5c..45b94cab73a 100644
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
+    qdev_prop_set_string(DEVICE(via), "audiodev",
+                         audio_maybe_init_dummy("pegasos2.defaudio"));
+    pci_realize_and_unref(PCI_DEVICE(via), pci_bus, &error_abort);
+
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
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 1e615b8d355..8c3abc67131 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -530,6 +530,8 @@ static void sam460ex_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("460exb");
     mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "ppc4xx.sdram";
+
+    machine_add_audiodev_property(mc);
 }
 
 DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
-- 
2.41.0


