Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B438AFD911
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Jul 2025 23:01:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFJi-0008Ok-6d; Tue, 08 Jul 2025 16:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZEDZ-0002Nt-DJ
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZEDW-0006J4-D6
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752003781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/5nu6NuITo203ftGtrA2lpVLlTccJCwkIpBLYxqRRHk=;
 b=TbDsidClYqKZR1HIWXokGKx4wSW4XTgzOdgQSW4QQh8mf/YaU12/VuHFR5db1oUXCFfftl
 rYHO03JGSx73L9+URGsitBs9/rzchneuVEx/R3re//17YOSwE8MHsJHRTk9aJiXZNmVFxE
 Hu2gxuNGoar+PKQF1wty+QeqxUijb6Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-TYsKp-QiMTeaf3yTHuWPJQ-1; Tue,
 08 Jul 2025 10:27:22 -0400
X-MC-Unique: TYsKp-QiMTeaf3yTHuWPJQ-1
X-Mimecast-MFC-AGG-ID: TYsKp-QiMTeaf3yTHuWPJQ_1751984840
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1645D193585F; Tue,  8 Jul 2025 14:27:20 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.187])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6582F30001B9; Tue,  8 Jul 2025 14:27:14 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v6 23/36] hw/arm/virt-acpi-build: Modify the DSDT ACPI table
 to enable ACPI PCI hotplug
Date: Tue,  8 Jul 2025 16:23:05 +0200
Message-ID: <20250708142437.1344644-24-eric.auger@redhat.com>
In-Reply-To: <20250708142437.1344644-1-eric.auger@redhat.com>
References: <20250708142437.1344644-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Modify the DSDT ACPI table to enable ACPI PCI hotplug.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

---
v4 -> v5:
- protect the access to the ged property by an acpi_dev check

v3 -> v4:
- use property accessor
- removed ACPI_PCIHP_SIZE which is already in the header
- make addition of EDSM unconditional

v2 -> v3:
- use ACPI_PCIHP_SIZE instead of 0x1000 (Igor)
- use cihp_state->use_acpi_hotplug_bridge
---
 include/hw/acpi/pcihp.h  |  2 ++
 include/hw/arm/virt.h    |  1 +
 hw/acpi/pcihp.c          |  1 -
 hw/arm/virt-acpi-build.c | 17 +++++++++++++++++
 hw/arm/virt.c            |  2 ++
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 5506a58862..9ff548650b 100644
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
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9a1b0f53d2..0ed2e6b732 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -79,6 +79,7 @@ enum {
     VIRT_ACPI_GED,
     VIRT_NVDIMM_ACPI,
     VIRT_PVTIME,
+    VIRT_ACPI_PCIHP,
     VIRT_LOWMEMMAP_LAST,
 };
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 2db2f16940..f1594e664a 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -43,7 +43,6 @@
 #include "qobject/qnum.h"
 #include "trace.h"
 
-#define ACPI_PCIHP_SIZE 0x0018
 #define PCI_UP_BASE 0x0000
 #define PCI_DOWN_BASE 0x0004
 #define PCI_EJ_BASE 0x0008
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 1f936516b3..14eb775b0c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -946,6 +946,23 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_pcihp_slots(pci0_scope, vms->bus);
     }
 
+    if (vms->acpi_dev) {
+        bool acpi_pcihp;
+
+        acpi_pcihp = object_property_get_bool(OBJECT(vms->acpi_dev),
+                                              ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
+                                              NULL);
+
+        if (acpi_pcihp) {
+            build_acpi_pci_hotplug(dsdt, AML_SYSTEM_MEMORY,
+                                   memmap[VIRT_ACPI_PCIHP].base);
+            build_append_pcihp_resources(pci0_scope,
+                                         memmap[VIRT_ACPI_PCIHP].base,
+                                         memmap[VIRT_ACPI_PCIHP].size);
+
+            build_append_notification_callback(pci0_scope, vms->bus);
+        }
+    }
     aml_append(dsdt, pci0_scope);
 
     /* copy AML table into ACPI tables blob */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3bcdf92e2f..8024a0b6b3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -75,6 +75,7 @@
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/pcihp.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
@@ -183,6 +184,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
     [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
     [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
+    [VIRT_ACPI_PCIHP] =         { 0x090c0000, ACPI_PCIHP_SIZE },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
-- 
2.49.0


