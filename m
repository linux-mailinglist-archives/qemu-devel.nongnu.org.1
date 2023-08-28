Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB5778A6A0
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 09:38:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaWnY-0006Ur-U7; Mon, 28 Aug 2023 03:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnS-0006Td-S6
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnQ-0004J9-I5
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401b5516104so26331425e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 00:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693208182; x=1693812982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKq8BOH9tAPeBWGcEvkFYeZLCjPKRsCheapynaM2kEk=;
 b=fr520EBpAJlzD1B3reRYQQKqp8v1AhhJUvGUX9FfHV+2tC39FUSfuV83JwmxyvRPhn
 0X5js9TD4aOWBCigswuQsYON6agrbkwbjD98hD16/NpfdAzshM+U/BcAqgDYRB2IERsu
 zr8jvhl+JN1404bqx20FbcL0rQfuqeMshQ4DvHwI94zzP1exboPZm5NVOFv5M5htXrjo
 pcIuy1oprBU5c+JPIyYbNlLJ+GTGk9cK7Sdj2OrBY7WGW5UuXh9r2vczVbTSxuxQDCLQ
 dGibW3+0nfYMzuND2lkrcqczQimJX7GBkNhXFWoLjDDkueqMV8diBEhDCK3RjU8TN9m9
 9fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693208182; x=1693812982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKq8BOH9tAPeBWGcEvkFYeZLCjPKRsCheapynaM2kEk=;
 b=E1lam/MNUJcaMPOo8Bassxgf7XtDz/Qa2ZbzdzkAzy8k3ta+OzCpfwGJXlxfKaiSei
 lYXm/Wo/NceZi5JIgsqNBtddjVcELpMiotwalSW2owOZOVlcPCphvkThsbRBFxSwmIJU
 3CPa1LSS6qVGvYQxnpCaDS7KOn1BaYMsaWz/3jg6I+NszRsLt6GF+Rc4v7BjCnCh5mQT
 heZ4pNAJJ+UCPdlUq9pVikPMg+w2BbXXWQ0gkkzZZYdWWAKKqC8NyGKluBPIrVx21ZoU
 iQGjFSgmj6RZFFw34JObg/aRyjvuJhsPC3cxiDDgsZu1XgYhKTmhxRX+6ooieg+kLiR+
 7Cbg==
X-Gm-Message-State: AOJu0YwLQmV+mGRjIMCHSdgBNAkXUwYH0z+/GTAKU8CYHyM0C3VF+wCv
 juRF91TK8n4VBVw7TzBMM5JTnKLKB0yBsg==
X-Google-Smtp-Source: AGHT+IEVPXMS8NAJZt0BVrAy7vmlG5+in+ns1TsUe3kDCbSDK2CRg3h+97VrsaNCFKdr3jeBJFhdbQ==
X-Received: by 2002:a7b:c38b:0:b0:3fe:2463:2614 with SMTP id
 s11-20020a7bc38b000000b003fe24632614mr17943895wmj.24.1693208182333; 
 Mon, 28 Aug 2023 00:36:22 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-055-055-138.78.55.pool.telefonica.de. [78.55.55.138])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c281100b003fef19bb55csm9795285wmb.34.2023.08.28.00.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 00:36:21 -0700 (PDT)
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
Subject: [PATCH 3/8] hw/acpi/acpi_dev_interface: Remove now unused madt_cpu
 virtual method
Date: Mon, 28 Aug 2023 09:36:04 +0200
Message-ID: <20230828073609.5710-4-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828073609.5710-1-shentey@gmail.com>
References: <20230828073609.5710-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
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


