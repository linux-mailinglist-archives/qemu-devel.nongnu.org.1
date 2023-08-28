Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2D578A69F
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 09:38:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaWnb-0006Xw-R1; Mon, 28 Aug 2023 03:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnV-0006U4-V5
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnT-0004JW-KF
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fee600dce6so27182255e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693208185; x=1693812985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYYQ7lw1jAZ/eBJOaSdtRHZgaPVGYm3aKDK2fm6mjko=;
 b=cMOr6Y7WjUNp/voojFLbfpcT7+08hee0snIDEudHeZ8zUtMoIzesyYcecO2MZimUL4
 IA7auf7h9dQIQPD288Vlt6MRvvoiqWeR0Kr88IOiSG6YGEq4Z/RaWiA9X7jd/c5Jjq2I
 XyFaMh7q5LhBLA9hVoa4fJrVrGhNtmPALQhmk9vJRlfc9JpkXTa8aJVCY8C9qaQPoN3A
 z9TBlsTIVY+yyX1wV2O7Ln4OdHdq0tHUps8ZZnyZ1whIU7beeUniXZuHFaDHdqrna+Eo
 zsVimmq49QS3Pso096REogazzbtDpNmA+17tvJKlrt6ZYp3zoU3BdfeCkYy9bhkqc2pM
 5YbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693208185; x=1693812985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SYYQ7lw1jAZ/eBJOaSdtRHZgaPVGYm3aKDK2fm6mjko=;
 b=JfjmVy6sQGxBbrFzmg0+afHd31LMXCsvoou1m35FHPU5juRBsXz1Og25F6uh1/pPVq
 Umx7GD3XoEZY8d/6L1k9y8LN4TfRlF+p3K6oq6Uez3I53pQ7WZ/GEXwKFeejP/Lj3anL
 g6Qe/eALt8iBrRCwELMUXu6H7ephhjN8drpCGKqvSX2zOapAIIv/nYzdTUvedFuFizh5
 AouOWX8QHaH9A1B+KqCi0D+0RXn2IZ8g/HIIWXiTFi9ieFupB8ogttiJlPzPJ0jFI48t
 Ukpsh7GDnLfqmiDdR6X4eNs7lAvYUCtM2WoewjCLFrBl82/fWcjcczQmj/hUdwWy/9X/
 DBtw==
X-Gm-Message-State: AOJu0YynQRZ7KlrBxIejAVHwbsoKXHU5VPpvduy6zB1uyDQATaItHqDy
 eAmekOQpE3WNX86QTOOdFihoevO7yR9cyw==
X-Google-Smtp-Source: AGHT+IHWN4Mk4ZFoVGmxZ+M0xJWd6i/vAx/iqkc2HQMFe7dpIVES5RW84XPt+ipgu9FC8w3t9C6zWg==
X-Received: by 2002:a7b:cd14:0:b0:3fc:f9c:a3e6 with SMTP id
 f20-20020a7bcd14000000b003fc0f9ca3e6mr18691851wmj.9.1693208185482; 
 Mon, 28 Aug 2023 00:36:25 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-055-055-138.78.55.pool.telefonica.de. [78.55.55.138])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c281100b003fef19bb55csm9795285wmb.34.2023.08.28.00.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 00:36:24 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 5/8] hw/i386: Remove now redundant TYPE_ACPI_GED_X86
Date: Mon, 28 Aug 2023 09:36:06 +0200
Message-ID: <20230828073609.5710-6-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828073609.5710-1-shentey@gmail.com>
References: <20230828073609.5710-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
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

Now that TYPE_ACPI_GED_X86 doesn't assign AcpiDeviceIfClass::madt_cpu any more
it is the same as TYPE_ACPI_GED.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/acpi/generic_event_device.h |  2 --
 hw/i386/generic_event_device_x86.c     | 27 --------------------------
 hw/i386/microvm.c                      |  2 +-
 hw/i386/meson.build                    |  1 -
 4 files changed, 1 insertion(+), 31 deletions(-)
 delete mode 100644 hw/i386/generic_event_device_x86.c

diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index d831bbd889..ba84ce0214 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -69,8 +69,6 @@
 #define TYPE_ACPI_GED "acpi-ged"
 OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 
-#define TYPE_ACPI_GED_X86 "acpi-ged-x86"
-
 #define ACPI_GED_EVT_SEL_OFFSET    0x0
 #define ACPI_GED_EVT_SEL_LEN       0x4
 
diff --git a/hw/i386/generic_event_device_x86.c b/hw/i386/generic_event_device_x86.c
deleted file mode 100644
index 8fc233e1f1..0000000000
--- a/hw/i386/generic_event_device_x86.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * x86 variant of the generic event device for hw reduced acpi
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2 or later, as published by the Free Software Foundation.
- */
-
-#include "qemu/osdep.h"
-#include "hw/acpi/generic_event_device.h"
-
-static const TypeInfo acpi_ged_x86_info = {
-    .name          = TYPE_ACPI_GED_X86,
-    .parent        = TYPE_ACPI_GED,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_HOTPLUG_HANDLER },
-        { TYPE_ACPI_DEVICE_IF },
-        { }
-    }
-};
-
-static void acpi_ged_x86_register_types(void)
-{
-    type_register_static(&acpi_ged_x86_info);
-}
-
-type_init(acpi_ged_x86_register_types)
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 7227a2156c..d5cde2f075 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -202,7 +202,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
 
     /* Optional and legacy devices */
     if (x86_machine_is_acpi_enabled(x86ms)) {
-        DeviceState *dev = qdev_new(TYPE_ACPI_GED_X86);
+        DeviceState *dev = qdev_new(TYPE_ACPI_GED);
         qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
         /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEMHP); */
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index cfdbfdcbcb..ff879069c9 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -20,7 +20,6 @@ i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
                                 if_false: files('sgx-stub.c'))
 
 i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
-i386_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device_x86.c'))
 i386_ss.add(when: 'CONFIG_PC', if_true: files(
   'pc.c',
   'pc_sysfw.c',
-- 
2.42.0


