Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD0F7B9A65
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFI6-0006dm-Tu; Wed, 04 Oct 2023 23:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHy-0006JN-KU
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHw-0000JI-Rm
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ox4XVp7cPjoZ2q7tSEzM/GAHifS80JBi3Z8qpCVmbvw=;
 b=JXl2cTCFWtzySfug4FXCCxV4q7jsucPDl1XsN2xnyX1556lrr7YGahIZAkr/8kJlDHUcy/
 b3zi1zrM1sTJyw0i7N2ymiJJgYMuI77ovfe4VToKl04eTT6NQXwkZdfk5KXXli8ZUCm4W0
 l85dS3BmGVgwYKtGAa2M0PTHIZa2Ftc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-xmp8NbszMEuudVRW3Ah7Jg-1; Wed, 04 Oct 2023 23:44:29 -0400
X-MC-Unique: xmp8NbszMEuudVRW3Ah7Jg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40570ccc497so3911265e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477468; x=1697082268;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ox4XVp7cPjoZ2q7tSEzM/GAHifS80JBi3Z8qpCVmbvw=;
 b=ID0dUk/c49+UrFS9ORKXLzD8PJ7j8vyxEb1V6Tx6mrqsp3AhrT//MBNcckb+HRowyv
 k7eGORY8VXW1wREfh3kHDcRoTnuLikCKmE5laHs0XcDAA0zbnFdt6SIPDT8uosrvZtHK
 E57PbQaVjthWH6yN+f2RBM5iNqhdc3cGJLx5ogEhNMXwIfzylHZcCHptD/EQNRobRMh7
 5YNGKsD8S4j0AmsAQk/Bt7Fu0ep/qdU686Hyz56jKIiAhtHB3KKBYL+uM/iHfufQHlX3
 RDLJBDINeV/GQyYGPtiqf64Q/zisC6LyaFzzOUzEtyyw8A2CnJwOUDyPrmpwMYRfUuHR
 x5FA==
X-Gm-Message-State: AOJu0YwCd80+TCHU9ytMAQ7dIi7g5uYNyFTvAvqziiSdXgXhX/ZAPQr3
 FRu0gICNmDV9NQry6uaNJtiCbX5h+WNmVZzK8uzQ4Hzp0HVQzkO2TJTDrebxhL1A0REWaqBzFCQ
 l0UYoxlQtv5BtXyzAuicarX668ZrzU42T0vYq713xvF2PZPYbPnxxNlqfMyPAiGDz2HBy
X-Received: by 2002:a05:600c:cc:b0:405:3955:5872 with SMTP id
 u12-20020a05600c00cc00b0040539555872mr3913228wmm.18.1696477468165; 
 Wed, 04 Oct 2023 20:44:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG33QvSzF3H4j/hKKvUSfmQm2+lQat9w6diZA6xnmdTTE/fBx6q7JffGedkfkooT4oDjHG0ag==
X-Received: by 2002:a05:600c:cc:b0:405:3955:5872 with SMTP id
 u12-20020a05600c00cc00b0040539555872mr3913211wmm.18.1696477467889; 
 Wed, 04 Oct 2023 20:44:27 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 e17-20020a05600c219100b0040646a708dasm546662wme.15.2023.10.04.20.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:44:27 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:44:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sergio Lopez <slp@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 29/53] hw/i386: Remove now redundant TYPE_ACPI_GED_X86
Message-ID: <c9c8ba69d5dbe5c1c6370e1f09ebd7531509d075.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Bernhard Beschow <shentey@gmail.com>

Now that TYPE_ACPI_GED_X86 doesn't assign AcpiDeviceIfClass::madt_cpu any more
it is the same as TYPE_ACPI_GED.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230908084234.17642-6-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
index 8deeb62774..b9c93039e2 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -204,7 +204,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
 
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
MST


