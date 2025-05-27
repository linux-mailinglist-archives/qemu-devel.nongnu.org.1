Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC89AC49A8
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 09:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJp10-0005TU-I0; Tue, 27 May 2025 03:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJoyq-0002IS-Oh
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJoyn-0000Ox-TZ
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748331848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFhqWhBFjPenL8cIKlsppJlVb9XVWvtWT9w2gOpDYII=;
 b=EGqt3WPgBA+RFOM0yOww98jfmvG4puBQTg/3KypHM80PFZuBtXm8znPl5jPzojH2QvD1XJ
 dt7C4RRZM87UOYtwPz//85CL4owzS5TbZVCU3Bz2xxiMNrRXQKVqiW02ct83ImvS6yjTwl
 5AzACBBni0prsLGllQyZG5epn8wOXH8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-806enJsmP5S2L0eJbxViUw-1; Tue,
 27 May 2025 03:44:05 -0400
X-MC-Unique: 806enJsmP5S2L0eJbxViUw-1
X-Mimecast-MFC-AGG-ID: 806enJsmP5S2L0eJbxViUw_1748331843
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9A461800366; Tue, 27 May 2025 07:44:03 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.201])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61F0D19560AA; Tue, 27 May 2025 07:43:59 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v2 18/25] hw/acpi/ged: Prepare the device to react to PCI
 hotplug events
Date: Tue, 27 May 2025 09:40:20 +0200
Message-ID: <20250527074224.1197793-19-eric.auger@redhat.com>
In-Reply-To: <20250527074224.1197793-1-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

QEMU will notify the OS about PCI hotplug/hotunplug events through
GED interrupts. Let the GED device handle a new PCI hotplug event.
On its occurrence it calls the \\_SB.PCI0.PCNT method with the BLCK
mutex held.

The GED device uses a dedicated MMIO region that will be mapped
by the machine code.

At this point the GED still does not support PCI device hotplug in
its TYPE_HOTPLUG_HANDLER implementation. This will come in a
subsequent patch.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- Introduce ACPI_PCIHP_REGION_NAME
---
 include/hw/acpi/generic_event_device.h |  7 +++++++
 include/hw/acpi/pcihp.h                |  2 ++
 hw/acpi/generic_event_device.c         | 14 ++++++++++++++
 hw/acpi/pcihp.c                        |  1 -
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index d2dac87b4a..9042448f77 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -63,6 +63,7 @@
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/cpu.h"
+#include "hw/acpi/pcihp.h"
 #include "qom/object.h"
 
 #define ACPI_POWER_BUTTON_DEVICE "PWRB"
@@ -101,6 +102,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define ACPI_GED_PWR_DOWN_EVT      0x2
 #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
 #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
+#define ACPI_GED_PCI_HOTPLUG_EVT    0x10
 
 typedef struct GEDState {
     MemoryRegion evt;
@@ -108,12 +110,17 @@ typedef struct GEDState {
     uint32_t     sel;
 } GEDState;
 
+#define ACPI_PCIHP_REGION_NAME "pcihp container"
+
 struct AcpiGedState {
     SysBusDevice parent_obj;
     MemHotplugState memhp_state;
     MemoryRegion container_memhp;
     CPUHotplugState cpuhp_state;
     MemoryRegion container_cpuhp;
+    AcpiPciHpState pcihp_state;
+    MemoryRegion container_pcihp;
+
     GEDState ged_state;
     uint32_t ged_event_bitmap;
     qemu_irq irq;
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index f2c3558654..6191b81ef2 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -38,6 +38,8 @@
 #define ACPI_PCIHP_SEJ_BASE 0x8
 #define ACPI_PCIHP_BNMR_BASE 0x10
 
+#define ACPI_PCIHP_SIZE 0x0018
+
 typedef struct AcpiPciHpPciStatus {
     uint32_t up;
     uint32_t down;
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 7a62f8d5bc..f84216a85f 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/pcihp.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/irq.h"
 #include "hw/mem/pc-dimm.h"
@@ -26,6 +27,7 @@ static const uint32_t ged_supported_events[] = {
     ACPI_GED_PWR_DOWN_EVT,
     ACPI_GED_NVDIMM_HOTPLUG_EVT,
     ACPI_GED_CPU_HOTPLUG_EVT,
+    ACPI_GED_PCI_HOTPLUG_EVT,
 };
 
 /*
@@ -121,6 +123,12 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
                            aml_notify(aml_name("\\_SB.NVDR"),
                                       aml_int(0x80)));
                 break;
+            case ACPI_GED_PCI_HOTPLUG_EVT:
+                aml_append(if_ctx,
+                           aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
+                aml_append(if_ctx, aml_call0("\\_SB.PCI0.PCNT"));
+                aml_append(if_ctx, aml_release(aml_name("\\_SB.PCI0.BLCK")));
+                break;
             default:
                 /*
                  * Please make sure all the events in ged_supported_events[]
@@ -299,6 +307,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
         sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
     } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
         sel = ACPI_GED_CPU_HOTPLUG_EVT;
+    } else if (ev & ACPI_PCI_HOTPLUG_STATUS) {
+        sel = ACPI_GED_PCI_HOTPLUG_EVT;
     } else {
         /* Unknown event. Return without generating interrupt. */
         warn_report("GED: Unsupported event %d. No irq injected", ev);
@@ -428,6 +438,10 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
             cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
                                 &s->cpuhp_state, 0);
             break;
+        case ACPI_GED_PCI_HOTPLUG_EVT:
+            memory_region_init(&s->container_pcihp, OBJECT(dev),
+                               ACPI_PCIHP_REGION_NAME, ACPI_PCIHP_SIZE);
+            sysbus_init_mmio(sbd, &s->container_pcihp);
         }
         ged_events--;
     }
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 57fe8938b1..e87846a1fa 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -44,7 +44,6 @@
 #include "qobject/qnum.h"
 #include "trace.h"
 
-#define ACPI_PCIHP_SIZE 0x0018
 #define PCI_UP_BASE 0x0000
 #define PCI_DOWN_BASE 0x0004
 #define PCI_EJ_BASE 0x0008
-- 
2.49.0


