Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 768907BC79C
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:39:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6aE-0002pj-4j; Sat, 07 Oct 2023 08:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aD-0002pH-0t
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:01 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aB-0002kC-Cp
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:00 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53447d0241eso5518224a12.3
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682337; x=1697287137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E62xaVnlholKHYeexm9qfp/0DSKJQ1awqntF10iQhp8=;
 b=aDMJ7ElfjHcYx3W5Zltng1cENPuc0kt5Yru0+HNkAJfJgV3RuhrXcMcnS2cH2pjeN1
 NioMEE8+5L3kTqO6k/8ZvW8yi8X16VTEtoKve7GDeq9sNCUmrvEgV1Dh/8YsR4JKgwtZ
 MS3FuX6Uvas6jFROR8tPwx+Z/yLIy61eiiFCMZR0vGNiUaV9tbD0duuJk9FxXJg2X+ZR
 iiiXWzcZuhpo4SWsOLzM4cXQeV3x5muFVKVn1daO2vArYDBteFVC/X+sqXmUBzSWTPBj
 P/+2nEOopNs7QyZZmmmSgi/Z2C0T1BhlCfaHk7bv33wT3RFXbBRvLmKYTtR153AHFkM3
 xHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682337; x=1697287137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E62xaVnlholKHYeexm9qfp/0DSKJQ1awqntF10iQhp8=;
 b=PNHKJlNz4T+4JiPzy8FVWsGdnRTL2gUcaj931xM1DyJWbA3ZUGPKj9aI99ghGMqvgZ
 z5A7OvgY+ydFWhlHMpFW+JNamiDyC5UOTb/0Mc7A+jvAxR90sDBiC++5rR1x4ABSxdx1
 k0ih8srYym6aDhqSfqcF+B+zSvX4n30SpI4u4z2ZZqGLDE2B3C1Ve7FRtglIL/htgIMf
 Ja2Ks++1vab3y6YgmtBWxfo1MYMQ7+Jix0ZMmJ/svuyU4expG2+KLtHRX90k4NdRWKJj
 NJF4uEOt9gCiQtj9WEMSYEc1joiGU29NK/x61F/T0f7vFg7x53ncL0nUhepX36iUQOY8
 98PQ==
X-Gm-Message-State: AOJu0YwuGJkp7BMluJc3X+UGXsxoiQfO10ys3/OqqjzX95d3qNOCkFQp
 ROEAunO66yQi+SlOIQXMc5zRhCxGoPI=
X-Google-Smtp-Source: AGHT+IGDobCav0Aarvg4c5zvbTPSEqlGhiCmpbuqsjZ8/6YEFTIwF/9PNGuCVl7DTuLK4vzgVjxj7Q==
X-Received: by 2002:a17:906:8465:b0:9ae:6bef:4a54 with SMTP id
 hx5-20020a170906846500b009ae6bef4a54mr9411123ejc.3.1696682337594; 
 Sat, 07 Oct 2023 05:38:57 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:38:56 -0700 (PDT)
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
Subject: [PATCH v8 05/29] hw/i386/pc_piix: Wire PIIX3's ISA interrupts by new
 "isa-irqs" property
Date: Sat,  7 Oct 2023 14:38:13 +0200
Message-ID: <20231007123843.127151-6-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
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

Avoid assigning the private member of struct PIIX3State from outside which goes
against best QOM practices. Instead, implement best QOM practice by adding an
"isa-irqs" array property to TYPE_PIIX3_DEVICE and assign it in board code, i.e.
from outside.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/southbridge/piix.h | 2 +-
 hw/i386/pc_piix.c             | 7 ++++++-
 hw/isa/piix3.c                | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 2317bb7974..bb898c6c88 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -46,7 +46,7 @@ struct PIIXState {
 #endif
     uint64_t pic_levels;
 
-    qemu_irq *pic;
+    qemu_irq pic[ISA_NUM_IRQS];
 
     /* This member isn't used. Just for save/load compatibility */
     int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a003923788..4dc7298c15 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -263,10 +263,15 @@ static void pc_init1(MachineState *machine,
     if (pcmc->pci_enabled) {
         PIIX3State *piix3;
         PCIDevice *pci_dev;
+        DeviceState *dev;
+        size_t i;
 
         pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
         piix3 = PIIX3_PCI_DEVICE(pci_dev);
-        piix3->pic = x86ms->gsi;
+        dev = DEVICE(pci_dev);
+        for (i = 0; i < ISA_NUM_IRQS; i++) {
+            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+        }
         pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
 
         if (xen_enabled()) {
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 7240c91440..c17547a2c0 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -312,6 +312,8 @@ static void pci_piix3_init(Object *obj)
 {
     PIIX3State *d = PIIX3_PCI_DEVICE(obj);
 
+    qdev_init_gpio_out_named(DEVICE(obj), d->pic, "isa-irqs", ISA_NUM_IRQS);
+
     object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
 }
 
-- 
2.42.0


