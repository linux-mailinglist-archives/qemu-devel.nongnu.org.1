Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F7B798455
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:44:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeX4s-00030R-R1; Fri, 08 Sep 2023 04:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4o-0002g9-El
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:54 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4l-0004qJ-0O
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:54 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so1644577f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 01:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694162569; x=1694767369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVPi+XLqooUcPliHkqB9JAmi5SFQguHf0Z0djyuv1cg=;
 b=SzyKRLFbONsFdyiAnNYS4zzNjtNaXDTdaxuBi3qxMt0GlaJXw8ZiJhOe6TottbPujJ
 agO6PE/YXhspeL7EAc5onU14y7KbPdXOTdqZu7IzLvh14Qemb9uFo2Q/EUyf0f4eqPVy
 PIIqmD4byVDl6UnG6dj/L5/43bKVXCyDioJJ/5FraqAqpqalopE+EGygLCrNOAcjPTWW
 TRIvfKr3s7RxyEdx46rhUzuskD0ELPiKjIOIRDt1GsVODlyT5KSz36G0WQ56ZYWRQDow
 zfHPCL2NxIbOECrEMXbdGGt00Db9Fbme8O6/0EhP453SWQNdLYyi6azyGasf2zi0TIMr
 Ba8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694162569; x=1694767369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVPi+XLqooUcPliHkqB9JAmi5SFQguHf0Z0djyuv1cg=;
 b=AuuG3h/DBRF7H8fQ6AA1iFSPHbO7SDU463a5Q86DTxGSpmp4HNX1/cBFhYPGxvQgZx
 ZCqMKZvAUV9C6CP9lgExKPvsgAZmEPV0PMB5yXuAaIHMIVv/elZwo5HyLAhCpF03ndqx
 MHpSOK419pIS0zDFLZi+gsk1aLWHfgHd6WvRupIUro4EjVAh6Iw1fVFlE86T4mEEnt+t
 NBc5NXO6XGr1WhykcqFotppr6oNlYNWz4G4s3oJElSg2UELfB0M09Z/+vGqGwrwWdulT
 zjjME0G7iZiRlucalu4OWtorJ0zAvTRAJsyKAWk5JI/saEK35o6uWj/XLPqdJSbXgYP8
 DloA==
X-Gm-Message-State: AOJu0YxVvdevYD8CEcvsRPVf9UmUo90IOkNM1ooOvR3Imh7U829vtapA
 2ICIclELum7T12bzype/5hlDSrT05a0=
X-Google-Smtp-Source: AGHT+IHM/rmZxr/5Iq4Bh2uczoHfQM/wmyNXyKw3s3C/Wx/8Jj3+FklxVXHJA7U8Fmnd9kXSxXsYjw==
X-Received: by 2002:adf:f044:0:b0:319:8bb3:ab83 with SMTP id
 t4-20020adff044000000b003198bb3ab83mr1338622wro.66.1694162568693; 
 Fri, 08 Sep 2023 01:42:48 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-093-170.78.54.pool.telefonica.de. [78.54.93.170])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a056000001100b003197c2316ecsm1462139wrx.112.2023.09.08.01.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 01:42:48 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 5/8] hw/i386: Remove now redundant TYPE_ACPI_GED_X86
Date: Fri,  8 Sep 2023 10:42:31 +0200
Message-ID: <20230908084234.17642-6-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908084234.17642-1-shentey@gmail.com>
References: <20230908084234.17642-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42a.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.42.0


