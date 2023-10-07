Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 351867BC7B9
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:43:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6ao-0003ZX-LC; Sat, 07 Oct 2023 08:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6ac-00036k-CT
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:26 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aa-0002q6-8Y
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:26 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9a645e54806so532333666b.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682362; x=1697287162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPVC6CusdReMTR+Bx+nim29dqNlS7Ej2hd85y0nMUPw=;
 b=nOxJIX/KVapcRU102tSlluI3G3+7AfZQ2gwoZLEfskUXuhoRUG3XkLNqnIzSxvxjdS
 4FRhvi3Pyn9ktLLb8nYE3RIFtLgYGQUF0JoWXwqYYievENmJgXsSlgGIHjaKdRd0eBEv
 Lv20CunFRGtbSPCFBYCrvU/oCeiLxd6G0su7QghgTphNZiDpaoDOi4vN+2jRPNeAQIqi
 qLGWKSb3jdWWJUvUOz+ytpjOVfy6vpSOFiRZhWf4akklja0UfIeABZsaZAYFh1Nx+YJk
 sYambEmVImVETsp29hh/mUhBXNl3vMHUz2GoD0tn3A2iMa6p/BUpGE+jHTbbxkvh2gAl
 SeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682362; x=1697287162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPVC6CusdReMTR+Bx+nim29dqNlS7Ej2hd85y0nMUPw=;
 b=O20JGIAsPO8ju1NW7WxFcILkEWu/GKnLEArK+sIfCUINcDge/EUITJkLwXjQ8eNJBv
 FXwJHSoa5/MzAAv1N3ekSXpdZvTQWsJ/fhcuTzbEZMID9dunSr4P0JT4sx1mpbmqr9iY
 wA7rrZ8oE+7pb5toDO17/lQsVyqxS6HURUw3SK98eZMniy7zoDmpmCFKbJS1CRwpvT6/
 DJd7HfCTQMpXJ7uMIeXv6F8KeQK64fUKBwshdLgbcOWu1mnQakDlbhbr4jgQFAAvIPEG
 mjv5OJVbAdwUQ6lZBm2gi7h5vrKssZizYDj/We2thHmX33jbfWmMIn343+kEwnEmUWWP
 mGsQ==
X-Gm-Message-State: AOJu0YyeKhIEqGxxutMDUVsAHnL63UhSxBQ9hY0rKGPDj7D8BLYcYU4P
 jnW8bede8w2DOdR76gY4mV80WzfvIAI=
X-Google-Smtp-Source: AGHT+IGJ6duLZ0GK7DxR7/QmPE3yPkcS36ykB9zSUKXLGNWTCUDO7eIjc1RH/CzCQfWXuRbAJqcsfg==
X-Received: by 2002:a17:906:8a43:b0:9ad:be8a:a582 with SMTP id
 gx3-20020a1709068a4300b009adbe8aa582mr8891389ejc.21.1696682362518; 
 Sat, 07 Oct 2023 05:39:22 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:21 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chuck Zmudzinski <brchuckz@aol.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v8 26/29] hw/isa/piix: Reuse PIIX3's PCI interrupt triggering
 in PIIX4
Date: Sat,  7 Oct 2023 14:38:34 +0200
Message-ID: <20231007123843.127151-27-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Speeds up PIIX4 which resolves an old TODO. Also makes PIIX4 compatible with Xen
which relies on pci_bus_fire_intx_routing_notifier() to be fired.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 449c1baaab..17677c2126 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -81,27 +81,6 @@ static void piix_set_pci_irq(void *opaque, int pirq, int level)
     piix_set_pci_irq_level(s, pirq, level);
 }
 
-static void piix4_set_irq(void *opaque, int irq_num, int level)
-{
-    int i, pic_irq, pic_level;
-    PIIXState *s = opaque;
-    PCIBus *bus = pci_get_bus(&s->dev);
-
-    /* now we change the pic irq level according to the piix irq mappings */
-    /* XXX: optimize */
-    pic_irq = s->dev.config[PIIX_PIRQCA + irq_num];
-    if (pic_irq < ISA_NUM_IRQS) {
-        /* The pic level is the logical OR of all the PCI irqs mapped to it. */
-        pic_level = 0;
-        for (i = 0; i < PIIX_NUM_PIRQS; i++) {
-            if (pic_irq == s->dev.config[PIIX_PIRQCA + i]) {
-                pic_level |= pci_bus_get_irq_level(bus, i);
-            }
-        }
-        qemu_set_irq(s->isa_irqs_in[pic_irq], pic_level);
-    }
-}
-
 static void piix_request_i8259_irq(void *opaque, int irq, int level)
 {
     PIIXState *s = opaque;
@@ -223,7 +202,7 @@ static int piix4_post_load(void *opaque, int version_id)
         s->rcr = 0;
     }
 
-    return 0;
+    return piix_post_load(opaque, version_id);
 }
 
 static int piix3_pre_save(void *opaque)
@@ -442,6 +421,7 @@ static void pci_piix_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
 
+    k->config_write = piix_write_config;
     dc->reset       = piix_reset;
     dc->desc        = "ISA bridge";
     dc->hotpluggable   = false;
@@ -497,7 +477,6 @@ static void piix3_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->config_write = piix_write_config;
     k->realize = piix3_realize;
     /* 82371SB PIIX3 PCI-to-ISA bridge (Step A1) */
     k->device_id = PCI_DEVICE_ID_INTEL_82371SB_0;
@@ -522,7 +501,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    pci_bus_irqs(pci_bus, piix4_set_irq, s, PIIX_NUM_PIRQS);
+    pci_bus_irqs(pci_bus, piix_set_pci_irq, s, PIIX_NUM_PIRQS);
 }
 
 static void piix4_init(Object *obj)
-- 
2.42.0


