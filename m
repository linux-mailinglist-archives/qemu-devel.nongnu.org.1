Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EA1798457
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:44:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeX4r-0002t6-Nr; Fri, 08 Sep 2023 04:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4o-0002g6-19
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4h-0004nz-ON
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31ad9155414so1592333f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694162566; x=1694767366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HQ5ULawMjaIF8Xnn9+G22V/3KGkbJGhmbMiWHNVPOw=;
 b=UCkSgTiJpUQrXvxHa6qi/fjvy6FxDPXcoSXn/pTh/i2Z2cp0wHuv60QXXDCZQ1YHbA
 M2f9bY6A7wTtUM/Vd4K+vpE7iF7Dje7tDG+PZfAJw17pCaHylfmZyATXqRr0OmkHg3Ty
 nmT8qFKfON+QLoIYH5g7+M2SbikNzcb3ItHPboCkXwbD85Lh3hJUlpoY4qGKfHUOd0DV
 GQarBxmvRvTc6IR8KAQ4lazxBXBW2JyzlLLTM06+kZgszeBp9xLV7V2QC6x/pfoTzacJ
 11DlNOQ8vBC0YXVUpugYxixyJ4K79cWr6xmxVequNs6dzC3WoLTQTBHMXnR3rmwu0rCa
 HeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694162566; x=1694767366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HQ5ULawMjaIF8Xnn9+G22V/3KGkbJGhmbMiWHNVPOw=;
 b=JIgCgWa5bECBVUKvHtjnKd8JT/WBX4zvJTWKPExcwRYc9PbYKlPu5tViDpptxu6lrh
 TSYHCHUHMi8eM8C+0f8WEtN/vkS8ToBMl0ooEQ04nOba2x83MCcS4oPfK8HjjifoCSi+
 I9cesgKIYeTvUK9nW/cSRLQxIUYbuUwPnaDTzWFQzImkDaDR6+bVt2UPMldzTUTNZJTJ
 MF3+lUsInQgY4otW8nmMgpzeqzfF+jmCDmTVhYMawKzxLgU4F3srRKa6Hu6D5b+TohBY
 6UUFMrKma6H3X/KfCGRkdCm19cVEUCk3TWQFwN7w0BhxY8JJQf4KOJGSHICRAznplBcY
 kHaA==
X-Gm-Message-State: AOJu0YzSxaPv2rDncli6hdUsDv7N05cXr96dXLA4AXDT2QXQlUMxUfrL
 WwYVfBPwI/vEw6R0GggwdENxvZtHKUw=
X-Google-Smtp-Source: AGHT+IFyLVQ6D+PWiFxp/gK02JahdU3ycTKPUw/MBY7pDwvpgYejOfrLQ5h2HMnr2pEIUx6bYm+cJw==
X-Received: by 2002:a5d:4b4c:0:b0:317:3deb:a899 with SMTP id
 w12-20020a5d4b4c000000b003173deba899mr1402901wrs.1.1694162566001; 
 Fri, 08 Sep 2023 01:42:46 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-093-170.78.54.pool.telefonica.de. [78.54.93.170])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a056000001100b003197c2316ecsm1462139wrx.112.2023.09.08.01.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 01:42:45 -0700 (PDT)
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
Subject: [PATCH v2 3/8] hw/acpi/acpi_dev_interface: Remove now unused madt_cpu
 virtual method
Date: Fri,  8 Sep 2023 10:42:29 +0200
Message-ID: <20230908084234.17642-4-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908084234.17642-1-shentey@gmail.com>
References: <20230908084234.17642-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x436.google.com
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

This virtual method was always set to the x86-specific pc_madt_cpu_entry(),
even in piix4 which is also used in MIPS. The previous changes use
pc_madt_cpu_entry() otherwise, so madt_cpu can be dropped.

Since pc_madt_cpu_entry() is now only used in x86-specific code, the stub
in hw/acpi/acpi-x86-stub can be removed as well.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/acpi/acpi_dev_interface.h | 2 --
 hw/acpi/acpi-x86-stub.c              | 6 ------
 hw/acpi/piix4.c                      | 2 --
 hw/i386/generic_event_device_x86.c   | 9 ---------
 hw/isa/lpc_ich9.c                    | 1 -
 5 files changed, 20 deletions(-)

diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index a1648220ff..ca92928124 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -52,7 +52,5 @@ struct AcpiDeviceIfClass {
     /* <public> */
     void (*ospm_status)(AcpiDeviceIf *adev, ACPIOSTInfoList ***list);
     void (*send_event)(AcpiDeviceIf *adev, AcpiEventStatusBits ev);
-    void (*madt_cpu)(int uid, const CPUArchIdList *apic_ids, GArray *entry,
-                     bool force_enabled);
 };
 #endif
diff --git a/hw/acpi/acpi-x86-stub.c b/hw/acpi/acpi-x86-stub.c
index d0d399d26b..9662a594ad 100644
--- a/hw/acpi/acpi-x86-stub.c
+++ b/hw/acpi/acpi-x86-stub.c
@@ -1,12 +1,6 @@
 #include "qemu/osdep.h"
-#include "hw/i386/pc.h"
 #include "hw/i386/acpi-build.h"
 
-void pc_madt_cpu_entry(int uid, const CPUArchIdList *apic_ids,
-                       GArray *entry, bool force_enabled)
-{
-}
-
 Object *acpi_get_i386_pci_host(void)
 {
        return NULL;
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 63d2113b86..a7892c444c 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -20,7 +20,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "hw/isa/apm.h"
 #include "hw/i2c/pm_smbus.h"
@@ -654,7 +653,6 @@ static void piix4_pm_class_init(ObjectClass *klass, void *data)
     hc->is_hotpluggable_bus = piix4_is_hotpluggable_bus;
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
-    adevc->madt_cpu = pc_madt_cpu_entry;
 }
 
 static const TypeInfo piix4_pm_info = {
diff --git a/hw/i386/generic_event_device_x86.c b/hw/i386/generic_event_device_x86.c
index e26fb02a2e..8fc233e1f1 100644
--- a/hw/i386/generic_event_device_x86.c
+++ b/hw/i386/generic_event_device_x86.c
@@ -8,19 +8,10 @@
 
 #include "qemu/osdep.h"
 #include "hw/acpi/generic_event_device.h"
-#include "hw/i386/pc.h"
-
-static void acpi_ged_x86_class_init(ObjectClass *class, void *data)
-{
-    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
-
-    adevc->madt_cpu = pc_madt_cpu_entry;
-}
 
 static const TypeInfo acpi_ged_x86_info = {
     .name          = TYPE_ACPI_GED_X86,
     .parent        = TYPE_ACPI_GED,
-    .class_init    = acpi_ged_x86_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_ACPI_DEVICE_IF },
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 9c47a2f6c7..92527f3c75 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -876,7 +876,6 @@ static void ich9_lpc_class_init(ObjectClass *klass, void *data)
     hc->is_hotpluggable_bus = ich9_pm_is_hotpluggable_bus;
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
-    adevc->madt_cpu = pc_madt_cpu_entry;
     amldevc->build_dev_aml = build_ich9_isa_aml;
 }
 
-- 
2.42.0


