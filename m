Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F087B7D9B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 12:58:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnzZT-0006Ez-DC; Wed, 04 Oct 2023 06:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qnzZD-0006Ds-Sk
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:57:24 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qnzZC-0006pE-61
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:57:23 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-991c786369cso330406466b.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696417036; x=1697021836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fUzzHOV1tZNzbrwqXoOhuNU8xd7Ol4hOAnxR6gBjDng=;
 b=NUtDIwH6VyR9AFk1tkKu2bdIP5RLOO5c5PYw6MXXsif6RWLRwhHOgY7fo86Smo3bXq
 JwrPXersBrwDPmiVvmjfDZyfMmfe25I3WxRlsxaLp0bJFV11dZQw56RLxFZrQwp37OBj
 VoZl5eET5/+Jkv4VuxB9MaGBBaDpuVU3ZI89MTqlxuBYtlTteurcHHXFVjYK93/RmOYu
 mPlA+U+TpkYFs2cYl6XyfXju3OOmCAAKVLIbyfxRvCUBxBPelgcTBaae+9krtBUSiduf
 v1ZszW2u9ADBPmvf8iGh7qVv52sNNaPocf7Dpb8EOmCNnd2MG3Kygp/2giRl5acWWiMx
 XBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696417036; x=1697021836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fUzzHOV1tZNzbrwqXoOhuNU8xd7Ol4hOAnxR6gBjDng=;
 b=JBAh2v5HmvwWLLfNvveJHKg2OrNgV26amnJs7QfTL6dGYlU8Bf4EcYGKwo6y8MF6OM
 vpVTTpYGII2eo6FJDx/9JShPgmF1S6zNePZ02k5IWZWMZ2VIq5SIuz3pyU0n4qVqIxTv
 jvY4HMXrSGNTNu9J2080u5SW8LY0czoHEarvpFx7zLYO/rZkfeaOmSpr7SZJX4XtzqFY
 aBNRo0lBHXDhZ+qMW9TMARpvSkKX3tKtTezHpQWBLAdFban/XNNPH6e1li1jXdt9dfjC
 rCfJvrVmBacc2pkddTXDnh/P9XENZR0D2A9slHFKyoQ/6fDD7IRdUnwv+OHXz4iJT5db
 QUEQ==
X-Gm-Message-State: AOJu0Yz758563IMNU7OjQkgdH4dvaAKaJilmCelXLy8/yHsYFy4gA7u8
 M3C4M/CHJLZqfG8pX1KZFlnDqSm32/g=
X-Google-Smtp-Source: AGHT+IFludQFWRKDz3Hjd2DfwO5+XEYsLGoYZltJNmiTA1yesTyGe7ucIUb8y6Ko/BVDR9J93/bMNg==
X-Received: by 2002:a17:906:ef90:b0:9ad:786d:72ae with SMTP id
 ze16-20020a170906ef9000b009ad786d72aemr1322207ejb.75.1696417036233; 
 Wed, 04 Oct 2023 03:57:16 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 g10-20020a170906348a00b0099bd0b5a2bcsm2596866ejb.101.2023.10.04.03.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 03:57:15 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2] hw/isa/vt82c686: Respect SCI interrupt assignment
Date: Wed,  4 Oct 2023 12:57:09 +0200
Message-ID: <20231004105709.16994-1-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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
aren't routed through the PCI pins but rather directly to the integrated PIC.
The routing is configurable through the ACPI interrupt select register at offset
0x42 in the PCI configuration space of the ISA function.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>

---

v2:
* Introduce named constants for the ACPI interrupt select register at offset
  0x42 (Phil)
---
 hw/isa/vt82c686.c | 47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 57bdfb4e78..93ffaaf706 100644
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
@@ -545,6 +544,9 @@ static const TypeInfo vt8231_superio_info = {
 #define TYPE_VIA_ISA "via-isa"
 OBJECT_DECLARE_SIMPLE_TYPE(ViaISAState, VIA_ISA)
 
+#define VIA_ISA_SCI_SELECT_OFS 0x42
+#define VIA_ISA_SCI_SELECT_MASK 0xf
+
 struct ViaISAState {
     PCIDevice dev;
     qemu_irq cpu_intr;
@@ -568,9 +570,26 @@ static const VMStateDescription vmstate_via = {
     }
 };
 
+static void via_isa_set_pm_irq(void *opaque, int n, int level)
+{
+    ViaISAState *s = opaque;
+    uint8_t irq = pci_get_byte(s->pm.dev.config + VIA_ISA_SCI_SELECT_OFS)
+                  & VIA_ISA_SCI_SELECT_MASK;
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
@@ -578,6 +597,8 @@ static void via_isa_init(Object *obj)
     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B_USB_UHCI);
     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
+
+    qdev_init_gpio_in_named(dev, via_isa_set_pm_irq, "sci", 1);
 }
 
 static const TypeInfo via_isa_info = {
@@ -704,6 +725,8 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     if (!qdev_realize(DEVICE(&s->pm), BUS(pci_bus), errp)) {
         return;
     }
+    qdev_connect_gpio_out(DEVICE(&s->pm), 0,
+                          qdev_get_gpio_in_named(DEVICE(d), "sci", 0));
 
     /* Function 5: AC97 Audio */
     qdev_prop_set_int32(DEVICE(&s->ac97), "addr", d->devfn + 5);
-- 
2.42.0


