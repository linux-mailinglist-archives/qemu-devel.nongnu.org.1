Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DB17D017F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:29:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhP-0000V7-Ld; Thu, 19 Oct 2023 14:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgD-0007Y0-AT
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXg9-0000vA-CK
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NXZETaxS2RqyHqeZK3eUSLD+xTQl4eJ2LtfwIT3r2X0=;
 b=DAPmQq1ws8w5SaJdruum4enlHNU2cjJYk7zWMrH116TFe251IoxS/17DsilXZDSVf8GD0L
 w6fuVlU+6BOpWTVqsggkZw62sFYLA6FjK3m1af/sO/K85osC5hywabY3jwOCZ9hV4qsh+I
 iwZHmNjszpu8kZSiHzt6H6hmMonHaGA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-8mbKvnk8MKGTEHsd8HvesA-1; Thu, 19 Oct 2023 14:23:26 -0400
X-MC-Unique: 8mbKvnk8MKGTEHsd8HvesA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32dd782e2d1so2546f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739804; x=1698344604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXZETaxS2RqyHqeZK3eUSLD+xTQl4eJ2LtfwIT3r2X0=;
 b=a5g03UcXtfkLlOANaU0meLuhbuDZo4wv606MXMpBTQWgNRDaUX8pqGyRrSUzTYR0On
 MaS6UgajSR6gPd3xK9572SnSmoRI9zKXW/QZc7rOkTy8LfJR7z7yzsnR/GMubmhe26Ot
 JhTlOe1PwTVjnH8Zp3oaso5RcuynqfS/y9iARtfuMEUVEhrBaJs2ntPzK6ScZn8NYkGL
 31UblqD5d4JSacVRwmxydqt8OGcmcmfPCBFYZFn+95VPK7ekJkMbXf3kWs8ByvWhQM6A
 ZvaYM5A7u36/fSZ8tmGvBeTkHxaAv3TbNsHBpKql+dIyVcakchY1mLjGobLJYAnVl2T7
 +OMw==
X-Gm-Message-State: AOJu0YxT+bVHQvTXFPjVMAp4GzeM2VoKavLpHaX1nlyLDvM76LpEHiGW
 m2W1hSXZIWKDGyZsOvssCPAiHxTxuNY+MBlA1/fQ0zd9khtrJyQ/ZIXKOyRtEy/O+KPAbyVRlVa
 HWNzrwHqAyc+U+FRJdWJGvNwqkreATvHKAiMqe5JtYEepPaW+10CcuKx7GJ2pGysdIAyZ
X-Received: by 2002:a05:6000:710:b0:32d:a98c:aa24 with SMTP id
 bs16-20020a056000071000b0032da98caa24mr2723607wrb.3.1697739804431; 
 Thu, 19 Oct 2023 11:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR6FQLRWjbPzIaexsflCrXJAi4+f6G2f30W5gOJ+n/yHhKA/hMmvRND2f10uagrzEJSZ+Tug==
X-Received: by 2002:a05:6000:710:b0:32d:a98c:aa24 with SMTP id
 bs16-20020a056000071000b0032da98caa24mr2723586wrb.3.1697739804114; 
 Thu, 19 Oct 2023 11:23:24 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a5d590b000000b003247d3e5d99sm5015535wrd.55.2023.10.19.11.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:23 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:23:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL v2 49/78] hw/isa/piix3: Create USB controller in host device
Message-ID: <155b8d360cf3a12494536147e569c34660f0439e.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Bernhard Beschow <shentey@gmail.com>

The USB controller is an integral part of PIIX3 (function 2). So create
it as part of the south bridge.

Note that the USB function is optional in QEMU. This is why it gets
object_initialize_child()'ed in realize rather than in instance_init.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-13-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/piix.h |  4 ++++
 hw/i386/pc_piix.c             |  7 ++-----
 hw/isa/piix3.c                | 16 ++++++++++++++++
 hw/isa/Kconfig                |  1 +
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 1daeff397c..5cd866f1f2 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -15,6 +15,7 @@
 #include "hw/pci/pci_device.h"
 #include "hw/ide/pci.h"
 #include "hw/rtc/mc146818rtc.h"
+#include "hw/usb/hcd-uhci.h"
 
 /* PIRQRC[A:D]: PIRQx Route Control Registers */
 #define PIIX_PIRQCA 0x60
@@ -54,12 +55,15 @@ struct PIIXState {
 
     MC146818RtcState rtc;
     PCIIDEState ide;
+    UHCIState uhci;
 
     /* Reset Control Register contents */
     uint8_t rcr;
 
     /* IO memory region for Reset Control Register (PIIX_RCR_IOPORT) */
     MemoryRegion rcr_mem;
+
+    bool has_usb;
 };
 typedef struct PIIXState PIIX3State;
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c98a997482..8dcd6851d0 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -51,7 +51,6 @@
 #include "exec/memory.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/piix4.h"
-#include "hw/usb/hcd-uhci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/xen.h"
@@ -265,6 +264,8 @@ static void pc_init1(MachineState *machine,
         size_t i;
 
         pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
+        object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                                 machine_usb(machine), &error_abort);
         dev = DEVICE(pci_dev);
         for (i = 0; i < ISA_NUM_IRQS; i++) {
             qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
@@ -359,10 +360,6 @@ static void pc_init1(MachineState *machine,
     }
 #endif
 
-    if (pcmc->pci_enabled && machine_usb(machine)) {
-        pci_create_simple(pci_bus, piix3_devfn + 2, TYPE_PIIX3_USB_UHCI);
-    }
-
     if (pcmc->pci_enabled && x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
         PCIDevice *piix4_pm;
 
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 3f1dabade0..aebc0da23b 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -298,6 +298,16 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
     if (!qdev_realize(DEVICE(&d->ide), BUS(pci_bus), errp)) {
         return;
     }
+
+    /* USB */
+    if (d->has_usb) {
+        object_initialize_child(OBJECT(dev), "uhci", &d->uhci,
+                                TYPE_PIIX3_USB_UHCI);
+        qdev_prop_set_int32(DEVICE(&d->uhci), "addr", dev->devfn + 2);
+        if (!qdev_realize(DEVICE(&d->uhci), BUS(pci_bus), errp)) {
+            return;
+        }
+    }
 }
 
 static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
@@ -332,6 +342,11 @@ static void pci_piix3_init(Object *obj)
     object_initialize_child(obj, "ide", &d->ide, TYPE_PIIX3_IDE);
 }
 
+static Property pci_piix3_props[] = {
+    DEFINE_PROP_BOOL("has-usb", PIIX3State, has_usb, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pci_piix3_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -352,6 +367,7 @@ static void pci_piix3_class_init(ObjectClass *klass, void *data)
      * pc_piix.c's pc_init1()
      */
     dc->user_creatable = false;
+    device_class_set_props(dc, pci_piix3_props);
     adevc->build_dev_aml = build_pci_isa_aml;
 }
 
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 28345edbb3..1076df69ca 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -37,6 +37,7 @@ config PIIX3
     select IDE_PIIX
     select ISA_BUS
     select MC146818RTC
+    select USB_UHCI
 
 config PIIX4
     bool
-- 
MST


