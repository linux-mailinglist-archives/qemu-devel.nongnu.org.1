Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A18DF7B2E8C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9EI-0006Cx-9l; Fri, 29 Sep 2023 04:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9EC-0005pM-Gv
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9Du-0005nQ-M2
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5jMXh0AgvMSbbzSsPF24dLhbhVyf2VnDuH5Ua++icY=;
 b=DM118fjWh/78Op5dfP2tmetBj7TUS0R4EsVkmC83A4DPsNG3eOFfxYiYhaoVPJTOuzegzm
 rcfVDjt32PQdorJL5WefWP3RQmJuNy4wPDsl8VtDjZx0DzTrw9rx7f4INj3wKSTt4gm/Ku
 NVovfXsq05EvyO4SAmwJmxFNVnd8Wg4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-ABfsF6HGP-ia1bWzet4u0A-1; Fri, 29 Sep 2023 04:51:40 -0400
X-MC-Unique: ABfsF6HGP-ia1bWzet4u0A-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5334e22b2dbso10918893a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 01:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695977498; x=1696582298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5jMXh0AgvMSbbzSsPF24dLhbhVyf2VnDuH5Ua++icY=;
 b=GruHK41IM5b8l84PNxQk+yQnMXjvMp//yiKNmM6jL1Idwo5TnAMumZ9rjHtgiOk78D
 5rXE3rIZbTQ/58A+s29k+TkdZFN39t7TVJelunV76N/oLwshlrTpFMHbWkkWVXUbfZE5
 UID9eD7cQUVc8WFeTVxjzaRT6HCR1eu1Zc3j2UFqMDYTXAuVcHSzg+WUI8eunpauziP9
 3czt53E5GLrckGXPHNq4pvvReUq572GE/lgO5VOZvTgKOtME+dzOrLpHdPT5wYxVLcVL
 DAGIlYosDCxFOJeNVxgGnuytIHcs0+pMxrAZAOP8keZQuAmm9ij9pWCg+c3BJ4JKh1gC
 CoGw==
X-Gm-Message-State: AOJu0Yw4swLPzn0A0tbalhj0JtjjRZefQ35QGroqaKbMJ4QPvRB2F0vd
 6IvohIe6i2cTSkKcKXjHZh6jaZK81fSgnTacMWLVMCKA7xUEPJsXMNoCZU+ibXCNn/jTHwHajc2
 //T0op+5zyz3JehR9JyGzz0+cpMdfLeLODJ09mJqgvX4/m3YA/nIKI78JNVTMw5aLDLhWIpFpFA
 s=
X-Received: by 2002:aa7:d48f:0:b0:530:a61f:ed1 with SMTP id
 b15-20020aa7d48f000000b00530a61f0ed1mr2954593edr.42.1695977498339; 
 Fri, 29 Sep 2023 01:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1rNU9b2o1IizNvAqUoj8xO5RTaWNurb1OOeR5YjpP5MGJYYwA2p3aUqmOBkh45098IfgQmw==
X-Received: by 2002:aa7:d48f:0:b0:530:a61f:ed1 with SMTP id
 b15-20020aa7d48f000000b00530a61f0ed1mr2954580edr.42.1695977498041; 
 Fri, 29 Sep 2023 01:51:38 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a056402174f00b0053631c4958asm1749629edx.22.2023.09.29.01.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 01:51:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 11/14] vt82c686: Support machine-default audiodev with
 fallback
Date: Fri, 29 Sep 2023 10:51:04 +0200
Message-ID: <20230929085112.983957-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929085112.983957-1-pbonzini@redhat.com>
References: <20230929085112.983957-1-pbonzini@redhat.com>
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


