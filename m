Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5187B9CD1
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 13:53:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoMtu-00048A-OL; Thu, 05 Oct 2023 07:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qoMtr-00042Q-PW
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 07:52:15 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qoMtm-0000az-0c
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 07:52:15 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so1574926a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 04:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696506727; x=1697111527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cN4KWEbAGL9Si9m7TYvwpIygqSnqw4TMk3YyNzvKNzc=;
 b=EuMPnwgP8JQwPFU69MhqIuw2PB5qE0cbUr9SqD3liLiHILFXoFxYt2cnGkvCAMSrX/
 0JoGDTSMU38M+ZZhkwJzAETkXz4Y4zoQ2PPIEnyqsg26R5dNmG7D7GfVWqz7CKXa2gbr
 16BY8/GKAUotfStWtTka3ApYTwAugini4pkNRaEHODGTrv6UR7E/Vq72lEU3TGSqZK9h
 1kWP/hgWknEETDNTTmI7CEEBQ7lW8LPRTYyRscIec31SySXK9Arf1fV7M7bxjaXPOiu+
 5igGAhOAghSlnTL4+2jZA5OEHu/pb6SmCPZznYB9Em7uHIPoJtZL0fJ1kWCS/Yhsa1Xp
 1IJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696506727; x=1697111527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cN4KWEbAGL9Si9m7TYvwpIygqSnqw4TMk3YyNzvKNzc=;
 b=Ly0N0gXjoxkDu2YFZ/sOiypb1UG933+TY491TRhAyAO2zX4ixvM/LSl+M9yWtwlZjK
 R0TAc5WJGc4CKFaEBbonZoF+9E9yEuEe5aHOFaNHhQKdSD+2Meq8pNK/1dgEQfUUhWWC
 ouvJvcsPUFsN3GSfUKj+v3SlsD4gFyp7FNnrpj8cAa5yIKGblhX+/25QQHi7rhhcBG1G
 y0oePOnjTpjGiktIfIZ+2tMwjCxgJahdtVgpNQS8ZGWQzgzDvLEhrYsJkmZTECBXN0bG
 5itVjGaOsvIkpVmowlwn5NqZC4giec199KiiRU5+yobJ8BWRzy/ClpMf3XNEGowRKMLk
 sTPg==
X-Gm-Message-State: AOJu0YzUQI7Gdxj3fC/anK8EbmGIM8QIoUAQYgGxFzvFoMDF1nH0zK7+
 FhJzHejaizYr7eByX0VLqPEtloTCJcU=
X-Google-Smtp-Source: AGHT+IGe9UfryJan/CqIleUP6ahVemqI772RMecTQTZRgKbVQqnuvKmhodHC5HkHaVRC4GmuAHoX/w==
X-Received: by 2002:a17:907:7809:b0:9ae:5be8:ff90 with SMTP id
 la9-20020a170907780900b009ae5be8ff90mr4673490ejc.68.1696506727260; 
 Thu, 05 Oct 2023 04:52:07 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a17090680ce00b0099cb1a2cab0sm1070544ejx.28.2023.10.05.04.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 04:52:06 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3] hw/isa/vt82c686: Respect SCI interrupt assignment
Date: Thu,  5 Oct 2023 13:51:59 +0200
Message-ID: <20231005115159.81202-1-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
0x42 in the PCI configuration space of the power management function.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

---

v3:
* Rename SCI irq attribute to sci_irq (Zoltan)
* Fix confusion about location of ACPI interrupt select register (Zoltan)
* Model SCI as named GPIO (Bernhard)
* Perform upcast via macro rather than sub structure selection (Bernhard)

v2:
* Introduce named constants for the ACPI interrupt select register at offset
  0x42 (Phil)
---
 hw/isa/vt82c686.c | 48 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 57bdfb4e78..aeb9434a46 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -40,12 +40,17 @@
 #define TYPE_VIA_PM "via-pm"
 OBJECT_DECLARE_SIMPLE_TYPE(ViaPMState, VIA_PM)
 
+#define VIA_PM_SCI_SELECT_OFS 0x42
+#define VIA_PM_SCI_SELECT_MASK 0xf
+
 struct ViaPMState {
     PCIDevice dev;
     MemoryRegion io;
     ACPIREGS ar;
     APMState apm;
     PMSMBus smb;
+
+    qemu_irq sci_irq;
 };
 
 static void pm_io_space_update(ViaPMState *s)
@@ -148,18 +153,7 @@ static void pm_update_sci(ViaPMState *s)
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
+    qemu_set_irq(s->sci_irq, sci_level);
     /* schedule a timer interruption if needed */
     acpi_pm_tmr_update(&s->ar, (s->ar.pm1.evt.en & ACPI_BITMASK_TIMER_ENABLE) &&
                        !(pmsts & ACPI_BITMASK_TIMER_STATUS));
@@ -213,6 +207,13 @@ static void via_pm_realize(PCIDevice *dev, Error **errp)
     acpi_pm1_cnt_init(&s->ar, &s->io, false, false, 2, false);
 }
 
+static void via_pm_init(Object *obj)
+{
+    ViaPMState *s = VIA_PM(obj);
+
+    qdev_init_gpio_out_named(DEVICE(obj), &s->sci_irq, "sci", 1);
+}
+
 typedef struct via_pm_init_info {
     uint16_t device_id;
 } ViaPMInitInfo;
@@ -238,6 +239,7 @@ static void via_pm_class_init(ObjectClass *klass, void *data)
 static const TypeInfo via_pm_info = {
     .name          = TYPE_VIA_PM,
     .parent        = TYPE_PCI_DEVICE,
+    .instance_init = via_pm_init,
     .instance_size = sizeof(ViaPMState),
     .abstract      = true,
     .interfaces = (InterfaceInfo[]) {
@@ -568,9 +570,27 @@ static const VMStateDescription vmstate_via = {
     }
 };
 
+static void via_isa_set_pm_irq(void *opaque, int n, int level)
+{
+    ViaISAState *s = opaque;
+    PCIDevice *pci_dev = PCI_DEVICE(&s->pm);
+    uint8_t irq = pci_get_byte(pci_dev->config + VIA_PM_SCI_SELECT_OFS)
+                  & VIA_PM_SCI_SELECT_MASK;
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
@@ -578,6 +598,8 @@ static void via_isa_init(Object *obj)
     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B_USB_UHCI);
     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
+
+    qdev_init_gpio_in_named(dev, via_isa_set_pm_irq, "sci", 1);
 }
 
 static const TypeInfo via_isa_info = {
@@ -704,6 +726,8 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     if (!qdev_realize(DEVICE(&s->pm), BUS(pci_bus), errp)) {
         return;
     }
+    qdev_connect_gpio_out_named(DEVICE(&s->pm), "sci", 0,
+                                qdev_get_gpio_in_named(DEVICE(d), "sci", 0));
 
     /* Function 5: AC97 Audio */
     qdev_prop_set_int32(DEVICE(&s->ac97), "addr", d->devfn + 5);
-- 
2.42.0


