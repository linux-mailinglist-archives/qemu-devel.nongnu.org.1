Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 601927DA61A
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 11:17:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwfQn-0004bj-55; Sat, 28 Oct 2023 05:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwfQZ-0004Ww-FD
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 05:16:24 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwfQX-0007L2-C4
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 05:16:19 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53f6ccea1eeso4836252a12.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698484575; x=1699089375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ej/0VQgcuhB6At3SliPWrA14nBYtN5eCbtHeKda9dFU=;
 b=fxtXHQvOzQC7y978RbrXAcd4SAtR2BcMYRrfY6W6G8eh1UE86a7sP55Mzn88Yc959v
 40OeaCPh2Yz+j8zdDq2CwFr0MJDUxwmoYrQw9fHtblTAhwNFPIL4UfaZ18AjYWRqQBlb
 mwHdxl73EyLQEwetmtBDeQ3PTZibHjNQYVL77MEHpJtKorCdN+AD6LGcxOM/aNOT/kYb
 uT4LJmoGWdMKkh8ncSdbvB/xNKDYPGpu6/4/h35gA+BXSje0fTipT6wHtCef0Z7R+xGr
 u+K2S/rnlnEn3dvYHEr/I9HXVt6QbLnFN0Ig/gBTQnt0vFUE7UvBa461xoN91Jn53Vci
 NUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698484575; x=1699089375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ej/0VQgcuhB6At3SliPWrA14nBYtN5eCbtHeKda9dFU=;
 b=eo5BLtz/v79ECyH0RHD2T28Y9D+h+PMY3M96DvRDo2NDj2urB7jx+8A4WXaYdnGLN4
 B9/u6ou5qnt0C7oQAQr+83560k7lImLKwdhp2x1NpbsWYNeCG9qqPhLRrLpiStllIKFC
 Q8U3dMeS1/r3IRRgL2F3DFbwsPBFC+ya4lbeYVo970Err7LW1fl7bd8ocwJEXAy/Is0P
 q7O5ZX7Vi+YVGy4EtVgAAZSjkFgiGnUfMYGzcTIVVQ6xL6tC+eylMSKAe/ruB8uJzfkL
 840eorMQSzxRsbujzIdKMBTg5MqYxV2E8oPpW/S/WaFZ4rj3GdsG4xW7sk9AXQnt3w1w
 GwZA==
X-Gm-Message-State: AOJu0YzI5qrxcNLxgnBfcexLj6KKNkel7wOINDaku70jvBAfNj1zt9YX
 VW3iYJKY3d/9Jfg3LwY84W2qCoWzUkg=
X-Google-Smtp-Source: AGHT+IFVTWicPU8YhgsxCDvtOUFHQFrGVO4XwuTdlhOlnV8iVbtLhk3iaM/tL5POsHxYaOcY0Nh+kg==
X-Received: by 2002:a50:8748:0:b0:542:d591:443b with SMTP id
 8-20020a508748000000b00542d591443bmr758786edv.17.1698484574615; 
 Sat, 28 Oct 2023 02:16:14 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-089-012-044-170.89.12.pool.telefonica.de. [89.12.44.170])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a50c357000000b00542df4a03d0sm571444edb.16.2023.10.28.02.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 02:16:13 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 1/5] hw/isa/vt82c686: Respect SCI interrupt assignment
Date: Sat, 28 Oct 2023 11:16:02 +0200
Message-ID: <20231028091606.23700-2-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231028091606.23700-1-shentey@gmail.com>
References: <20231028091606.23700-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
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
0x42 in the PCI configuration space of the power management function.

Note that pm_update_sci() is now redundant to acpi_update_sci() and shall be
removed soon.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


