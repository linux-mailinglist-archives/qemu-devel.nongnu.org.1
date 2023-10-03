Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1707B737E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 23:46:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnnCK-0000FX-NE; Tue, 03 Oct 2023 17:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qnnCE-0000FO-Q8
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:44:51 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qnnCD-0000kK-6l
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:44:50 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5345a3dfe3bso2412483a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696369487; x=1696974287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cy5+rg5Vz73McPYlDXpepqQEfWAcSnW8q6WDEzToA9M=;
 b=QD8a9vwmpl6YP8PFYkh9iH+8aduLPvgIZTZM1tmYxAPWWzVp9yWq/JnDHTxJ9yEs7l
 htWOrf/N/ogloUlHFIKWlpV5pMGBYtaG2EpPjaygSIPAbgtcIDgQEjWPSZ0WJwJPvwgV
 cJFmIwW+JSb372GjUnrYFxie0xZ/uyJcxW1f27MuPl0GzYRlm/R7xtxQHm3+bRLZ8/ks
 WGrhXYlOjWIsEKOfZn5audYdrdJlpqLYyrS0X3Lw/0D8HxHT1K6jEXriMwdF1m8FzU94
 nxxa+MSX1lU1U2m0Tx78Ox3QpTua2gz88/GpvHkSXlk9v7W6JRLigMdoDhGx984fYrST
 DvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696369487; x=1696974287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cy5+rg5Vz73McPYlDXpepqQEfWAcSnW8q6WDEzToA9M=;
 b=V4OhvN/yNy+TMwX8tIAW/I99UoG39tvV8FSA4empSUrXo36xA9a6aQm0V2v9ol00bs
 ybjOpZo2Pl77IUhwPWnwRpdiLyAlai+V2zkv3tCYnBz6WO1As17yfAkK69vvWYob+bQ4
 oqg8aAqD1YmvxqYaMgNa0VKbLuee2RHeBI+Gbm0yc1DYdPTzBPVLc82aGIgbdR3kuGdz
 3iNdjeYpzSj13izKBHahR4LdBag8I6/iN3W6b5k8XfxYu4oOEI+nlnjNR3JY8MG/p/tC
 IOSuuVz+vXXo/j1UpoUVyTalWbD8jQ0SH9wi5wSpMlG2Q2vp1MLKtcJ10kb55/7AExcJ
 aJSQ==
X-Gm-Message-State: AOJu0YyW87oNUvmFiezy1yuynYrtsB/Xlbqz7ZdiG5sYdrwjJ+zzyzxL
 daKArOUrdptHihWRLlGKQi7I+/7zZy4=
X-Google-Smtp-Source: AGHT+IFMKiCuiwo7v04oVJ8VDNuCW6rw6lwHPQLQeSQe6ROWlOPcy8IU7w2u707UsJhyKA7t/JCDhQ==
X-Received: by 2002:a17:907:2e19:b0:9a1:bb8f:17d0 with SMTP id
 ig25-20020a1709072e1900b009a1bb8f17d0mr381168ejc.30.1696369486607; 
 Tue, 03 Oct 2023 14:44:46 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a1709064e4600b00991faf3810esm1669523ejw.146.2023.10.03.14.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 14:44:46 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] hw/isa/vt82c686: Respect SCI interrupt assignment
Date: Tue,  3 Oct 2023 23:44:37 +0200
Message-ID: <20231003214437.29302-1-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
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

According to the datasheet, SCI interrupts of the power management function
aren't triggered through the PCI pins but rather directly to the integrated PIC.
The routing is configurable through the ACPI interrupt select register at offset
42 in the PCI configuration space of the ISA function.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/isa/vt82c686.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 57bdfb4e78..2988ad1eda 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -46,6 +46,8 @@ struct ViaPMState {
     ACPIREGS ar;
     APMState apm;
     PMSMBus smb;
+
+    qemu_irq irq;
 };
 
 static void pm_io_space_update(ViaPMState *s)
@@ -148,18 +150,7 @@ static void pm_update_sci(ViaPMState *s)
                    ACPI_BITMASK_POWER_BUTTON_ENABLE |
                    ACPI_BITMASK_GLOBAL_LOCK_ENABLE |
                    ACPI_BITMASK_TIMER_ENABLE)) != 0);
-    if (pci_get_byte(s->dev.config + PCI_INTERRUPT_PIN)) {
-        /*
-         * FIXME:
-         * Fix device model that realizes this PM device and remove
-         * this work around.
-         * The device model should wire SCI and setup
-         * PCI_INTERRUPT_PIN properly.
-         * If PIN# = 0(interrupt pin isn't used), don't raise SCI as
-         * work around.
-         */
-        pci_set_irq(&s->dev, sci_level);
-    }
+    qemu_set_irq(s->irq, sci_level);
     /* schedule a timer interruption if needed */
     acpi_pm_tmr_update(&s->ar, (s->ar.pm1.evt.en & ACPI_BITMASK_TIMER_ENABLE) &&
                        !(pmsts & ACPI_BITMASK_TIMER_STATUS));
@@ -213,6 +204,13 @@ static void via_pm_realize(PCIDevice *dev, Error **errp)
     acpi_pm1_cnt_init(&s->ar, &s->io, false, false, 2, false);
 }
 
+static void via_pm_init(Object *obj)
+{
+    ViaPMState *s = VIA_PM(obj);
+
+    qdev_init_gpio_out(DEVICE(obj), &s->irq, 1);
+}
+
 typedef struct via_pm_init_info {
     uint16_t device_id;
 } ViaPMInitInfo;
@@ -238,6 +236,7 @@ static void via_pm_class_init(ObjectClass *klass, void *data)
 static const TypeInfo via_pm_info = {
     .name          = TYPE_VIA_PM,
     .parent        = TYPE_PCI_DEVICE,
+    .instance_init = via_pm_init,
     .instance_size = sizeof(ViaPMState),
     .abstract      = true,
     .interfaces = (InterfaceInfo[]) {
@@ -568,9 +567,25 @@ static const VMStateDescription vmstate_via = {
     }
 };
 
+static void via_isa_set_pm_irq(void *opaque, int n, int level)
+{
+    ViaISAState *s = opaque;
+    uint8_t irq = pci_get_byte(s->pm.dev.config + 0x42) & 0xf;
+
+    if (irq == 2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "IRQ 2 for PM controller is reserved");
+        return;
+    }
+
+    if (irq != 0) {
+        qemu_set_irq(s->isa_irqs_in[irq], level);
+    }
+}
+
 static void via_isa_init(Object *obj)
 {
     ViaISAState *s = VIA_ISA(obj);
+    DeviceState *dev = DEVICE(s);
 
     object_initialize_child(obj, "rtc", &s->rtc, TYPE_MC146818_RTC);
     object_initialize_child(obj, "ide", &s->ide, TYPE_VIA_IDE);
@@ -578,6 +593,8 @@ static void via_isa_init(Object *obj)
     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B_USB_UHCI);
     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
+
+    qdev_init_gpio_in_named(dev, via_isa_set_pm_irq, "sci", 1);
 }
 
 static const TypeInfo via_isa_info = {
@@ -704,6 +721,8 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     if (!qdev_realize(DEVICE(&s->pm), BUS(pci_bus), errp)) {
         return;
     }
+    qdev_connect_gpio_out(DEVICE(&s->pm), 0,
+                          qdev_get_gpio_in_named(DEVICE(d), "sci", 0));
 
     /* Function 5: AC97 Audio */
     qdev_prop_set_int32(DEVICE(&s->ac97), "addr", d->devfn + 5);
-- 
2.42.0


