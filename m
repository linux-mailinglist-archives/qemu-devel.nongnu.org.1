Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAA87B7B02
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:05:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxWO-0008Od-Mo; Wed, 04 Oct 2023 04:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVT-0007Kp-1g
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVQ-00029W-C1
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twDnxCIZ4gi16W+P0IcrGb7JEdH581l09+veM2VEhWI=;
 b=Ai9IhTzSbLQBa/8QGmOViqW6b5X6t6EighMh7eW0O/9UT0LaCgh90MyI1hs5FFzzOiKKxT
 biTkVTenxIWrUmjJiOMJyS3vRObIQ4uR9BTrOSD34+e8uyCQTPhl/eS4BZe7w3S8vB99T7
 afBisfFhOkbh5rX1+ncZ7NMiFxmVxUI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-i_nAxjDTM0qDUG620A42zw-1; Wed, 04 Oct 2023 04:45:11 -0400
X-MC-Unique: i_nAxjDTM0qDUG620A42zw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4065ca278b3so12549295e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409109; x=1697013909;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=twDnxCIZ4gi16W+P0IcrGb7JEdH581l09+veM2VEhWI=;
 b=QzpJDSsWIBA440pIPG9Zt5/irXWLnRBKryLj/qv1Ek1Qk+LN3RQM4gC5VZ333z2+gX
 YqDA8DhZxfeAsLZxsb9SWA3Jtjq0ofIT2P2tPFmr0j56zqXUHt97FK1+EixkgAIZgC2X
 bLNajpYufxsMXwZ0NqmOdcOF65CYHFBjeHKiIrYWShqWPdh2Yvq6OsKlwDxgyrqRsSIA
 R6d5NKhJrGRKMwvnUFFY7/k7KQWfEsIYN/iw02rnLuJBkfvlkduHjBcGOdmkibGUH7dh
 DhoqOh6egqJr8bGTN7vMo297KuQKHKgqSBhUUeHhR0NAIu03Hw2opZ5IbZysakBP+Ng7
 xWqg==
X-Gm-Message-State: AOJu0YxaIavJlYqF6yOhqhvg5h79ap7HwKNfbZsdelW8FID8NwBXPR7t
 4xnXKFzk4mqojlm5cK8IdfJ9Qn9yWQE20HA4FVECPfbuhMcPLpQjxJIkWNeofe+ixQkz7ppeWLk
 08eUKZoJPLa6qJsc2f8wVK13GTDMVnq+F4dlGn8877/6xhVXBDTwJu3Ri+bZarghAAFtD
X-Received: by 2002:a05:600c:298c:b0:401:b2c7:34a4 with SMTP id
 r12-20020a05600c298c00b00401b2c734a4mr1748326wmd.11.1696409109274; 
 Wed, 04 Oct 2023 01:45:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2SO1nQ+b4oxkdECWWoY3R4TWJxsCoNBAGEdNML1QaQ4f8SNfsw1O5sXHimRenfbGfXbiKkg==
X-Received: by 2002:a05:600c:298c:b0:401:b2c7:34a4 with SMTP id
 r12-20020a05600c298c00b00401b2c734a4mr1748301wmd.11.1696409108942; 
 Wed, 04 Oct 2023 01:45:08 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 r7-20020a5d6c67000000b00327df8fcbd9sm3278476wrz.9.2023.10.04.01.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:08 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 37/63] hw/acpi/acpi_dev_interface: Remove now unused madt_cpu
 virtual method
Message-ID: <b96c47608e42d782811df7fc2ab4e1d51bfdbf8b.1696408966.git.mst@redhat.com>
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

This virtual method was always set to the x86-specific pc_madt_cpu_entry(),
even in piix4 which is also used in MIPS. The previous changes use
pc_madt_cpu_entry() otherwise, so madt_cpu can be dropped.

Since pc_madt_cpu_entry() is now only used in x86-specific code, the stub
in hw/acpi/acpi-x86-stub can be removed as well.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230908084234.17642-4-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
index bce487ac4e..3f59980aa0 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -891,7 +891,6 @@ static void ich9_lpc_class_init(ObjectClass *klass, void *data)
     hc->is_hotpluggable_bus = ich9_pm_is_hotpluggable_bus;
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
-    adevc->madt_cpu = pc_madt_cpu_entry;
     amldevc->build_dev_aml = build_ich9_isa_aml;
 }
 
-- 
MST


