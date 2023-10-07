Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C5E7BC7A8
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:41:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6aq-0003oC-L8; Sat, 07 Oct 2023 08:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aX-000324-S0
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:22 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aU-0002nZ-7W
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:20 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9b98a699f45so512209966b.3
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682356; x=1697287156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PR1OTO+HOAaZgG4LN7ff4+XgGlEjkB8EMde29NVCAx0=;
 b=A6n+fjqXgGZOUylL7GHCI8a9tiAkX4suVE0q0en0SWQ+truMuRnkHzZI9J2CDzmRcs
 iYAmxXw0wmQUI/qhKD0dJzfx1g8D32OyMtML9Dof26YM14FWehjvP/XNhJUEz93Qf7RA
 L82Ue9IfQ2IbhI60Qbw1HFt0+C/Tsl0mOyFCwk6zac4o3ctFLO3asK2udmuxSmd7O3YH
 IP96SvT/LypJRvf8lv8xmVZxJXZfmmUsYQOnuB7S5AQ2f9qQM5G6ZdinaD8GXBJ2Topq
 Asiev+tzlVxisERc/zhUaWGWKBKycUX9rpqnkCKTiN33Xb+dfxlbEyQWcZur7prLE5ZM
 oA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682356; x=1697287156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PR1OTO+HOAaZgG4LN7ff4+XgGlEjkB8EMde29NVCAx0=;
 b=fu9n6X/NarU7S+237RL5dy0DL2i9TLNiRQkSbRApHe6z0ZQ3SKXWSOWtcvADzOJnKv
 TF174zd9ZMuLDvMkxroV0d2qTExPFBmXcSPY+InnVmBpTP2ZBVJqvkdXahbL/vJU7il9
 L+dFze6k7YqqdRCgsY0hwAVJsf6A2bBj44HaCEN2pSUUV7zWMbFlL4A1Rh/nSCylSGZe
 LwEpBUFdYyfHZv9zD6RSrx8Bn1ryNTfir1VfhWq5CvzdKFish/2lnNDYHROvrPsAKdbq
 QI5h8qyC72RODswE5J8BhaoCJH0BCpYLjUNAXuRg16NUQji+f6ysCs0rk0kcCXAaisAu
 iKQw==
X-Gm-Message-State: AOJu0YyIv+w03BpSdX6Z1zF5BShgVCZpnsZ6l0e4qGm5IZnZVh8bedbe
 6fmlDfTictOxoNc6GMZ0fXEZFdEQ2eM=
X-Google-Smtp-Source: AGHT+IEWf3l2e4dbBSlFNmenm3auRQ675su4bstlvF4wUgIosxlTEgkhkAuucYukiLZf3q8H0QAgyw==
X-Received: by 2002:a17:906:220f:b0:9ba:fb9:d334 with SMTP id
 s15-20020a170906220f00b009ba0fb9d334mr869675ejs.13.1696682355859; 
 Sat, 07 Oct 2023 05:39:15 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:15 -0700 (PDT)
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
Subject: [PATCH v8 20/29] hw/isa/piix: Allow for optional PIC creation in PIIX3
Date: Sat,  7 Oct 2023 14:38:28 +0200
Message-ID: <20231007123843.127151-21-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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

In the PC machine, the PIC is created in board code to allow it to be
virtualized with various virtualization techniques. So explicitly disable its
creation in the PC machine via a property which defaults to enabled. Once the
PIIX implementations are consolidated this default will keep Malta working
without further ado.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
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
2.42.0


