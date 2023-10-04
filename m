Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA587B7ABD
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:52:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxXS-0001p8-7t; Wed, 04 Oct 2023 04:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVn-00085Z-0d
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVk-0002KO-Ht
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ox4XVp7cPjoZ2q7tSEzM/GAHifS80JBi3Z8qpCVmbvw=;
 b=b0ehuYtAWYUB14XFqyAeTM+F94SWpBMkus5bmZ+OUGGR9qtyAce5YT8+CbkgGmZUNf3uFE
 vpWfRpLikpCC+pDmtGAUIhCyEhrkg7iZrzjDnWZ+Jyx0jxcuTN6bVHt1bBEMVmifs78DjT
 4134hirJm+F9EJ9FBtz9wI8lkuvAJlI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-gXhUiGRmNPqarjYU8V4hFA-1; Wed, 04 Oct 2023 04:45:22 -0400
X-MC-Unique: gXhUiGRmNPqarjYU8V4hFA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5043353efbdso1757293e87.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409120; x=1697013920;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ox4XVp7cPjoZ2q7tSEzM/GAHifS80JBi3Z8qpCVmbvw=;
 b=k94jcgha0NcCPMgjYszhzJxBNvX1QfWXSL37npxS/9jOJZaWjo0AI1JmQzyAe7S1NI
 fZUdg90d0CZWpB9IqDWmLxG6X08Xt6eqztABNC63Y2G8UiSjGYkwohw7d2ZTggxuYfw8
 GEw2z4Wr5uIlzM5Yil2NWYjtqydLq2nVkZPw6tc0KyzzSLnxDU8PTXLpX/v+cxRlbFyh
 2hbFN9dXd3u/CuT57+UKOg9DszCmKsimZlDzq7TiQVJsEw3ZvkF0E/gy0oWMWeT8V1wT
 tMYAcDlFvsl0lge7gTS6Shh3g/c6h9bV0cpiVtyZyoaGDsyy6vVKCyXnQ8fN93r+qCdx
 BM/g==
X-Gm-Message-State: AOJu0YwZTpEwEm72lpwj++nwEM4HpAgkGlykJ1KtRh27v56/xb/N8rOj
 cmgm2i75s9dpq8GTZmBNm7UBz6vGtPKArwuHMYM3hoNc/CNhDfrmsYFTVvR0WxDMlhgzmlXkA7s
 CVMIV+uukxHQwbiQpdE4ZjpaJZSIkiIaYcpp9qavsUOXaC21x54PY3T0pOA8RirXLF4Ha
X-Received: by 2002:a19:4f4d:0:b0:503:2683:ec7b with SMTP id
 a13-20020a194f4d000000b005032683ec7bmr1121070lfk.33.1696409120319; 
 Wed, 04 Oct 2023 01:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7u8aoYFiSntmAMt1t1bT+psXme5AJkMscc4RW6lqaG/EwcXdSCkX484bvWEUwVzUFB4FGbA==
X-Received: by 2002:a19:4f4d:0:b0:503:2683:ec7b with SMTP id
 a13-20020a194f4d000000b005032683ec7bmr1121048lfk.33.1696409119992; 
 Wed, 04 Oct 2023 01:45:19 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 f23-20020a7bc8d7000000b003fe1c332810sm935860wml.33.2023.10.04.01.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:19 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:16 -0400
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
Subject: [PULL 39/63] hw/i386: Remove now redundant TYPE_ACPI_GED_X86
Message-ID: <99096c2b23cd74bb440ae6433bace3d369f756fe.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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


