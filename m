Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73562AFD9D5
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Jul 2025 23:27:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFIl-00068n-Tk; Tue, 08 Jul 2025 16:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZEDF-0005PU-WF
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZEDB-0006Aw-Hi
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752003760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJI7GzV1IaW31YhlivvQAx1uPl3s388KcZnwzjfrHbQ=;
 b=T8kkWDhaXyz5wGVDdA6cnV8busilJBv0YRAIY0VR3J4wTmPSKlRr7lIAtUErSbTkj4whSC
 wipMRWzYO8s26qOTSV7AU6H9WDPuopOIqycVbImes83yPOSJBAS8zHZsQAPdrGfFggqMT0
 57EjTJuhKvwYqdwsuZTcDhjqp18/o9c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-UCWNc9WnO6GYMqiIyBwUdw-1; Tue,
 08 Jul 2025 10:26:26 -0400
X-MC-Unique: UCWNc9WnO6GYMqiIyBwUdw-1
X-Mimecast-MFC-AGG-ID: UCWNc9WnO6GYMqiIyBwUdw_1751984785
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5371A19560A6; Tue,  8 Jul 2025 14:26:25 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.187])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45E5530001B1; Tue,  8 Jul 2025 14:26:15 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v6 14/36] hw/i386/acpi-build: Move
 build_append_pci_bus_devices/pcihp_slots to pcihp
Date: Tue,  8 Jul 2025 16:22:56 +0200
Message-ID: <20250708142437.1344644-15-eric.auger@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We intend to reuse build_append_pci_bus_devices and build_append_pcihp_slots
on ARM. So let's move them to hw/acpi/pcihp.c as well as all static
helpers they use.

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

---

v2 -> v3:
- changed the layout of the commit message
- reordered the moved functions to match the original ordering
  (Jonathan)
---
 include/hw/acpi/pci.h   |   1 -
 include/hw/acpi/pcihp.h |   2 +
 hw/acpi/pcihp.c         | 173 ++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c    | 172 ---------------------------------------
 4 files changed, 175 insertions(+), 173 deletions(-)

diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
index 8a328b580c..69bae95eac 100644
--- a/include/hw/acpi/pci.h
+++ b/include/hw/acpi/pci.h
@@ -37,7 +37,6 @@ typedef struct AcpiMcfgInfo {
 void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info,
                 const char *oem_id, const char *oem_table_id);
 
-void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
 void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
 
 void build_srat_generic_affinity_structures(GArray *table_data);
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index f4fd44cb32..5506a58862 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -80,6 +80,8 @@ void build_append_pcihp_resources(Aml *table,
                                   uint64_t io_addr, uint64_t io_len);
 bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus);
 
+void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
+
 /* Called on reset */
 void acpi_pcihp_reset(AcpiPciHpState *s);
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index b64d06afc9..2c76edeb15 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -27,6 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/acpi_aml_interface.h"
 #include "hw/pci-host/i440fx.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
@@ -761,6 +762,178 @@ bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus)
     return !!nr_notifiers;
 }
 
+static Aml *aml_pci_device_dsm(void)
+{
+    Aml *method;
+
+    method = aml_method("_DSM", 4, AML_SERIALIZED);
+    {
+        Aml *params = aml_local(0);
+        Aml *pkg = aml_package(2);
+        aml_append(pkg, aml_int(0));
+        aml_append(pkg, aml_int(0));
+        aml_append(method, aml_store(pkg, params));
+        aml_append(method,
+            aml_store(aml_name("BSEL"), aml_index(params, aml_int(0))));
+        aml_append(method,
+            aml_store(aml_name("ASUN"), aml_index(params, aml_int(1))));
+        aml_append(method,
+            aml_return(aml_call5("PDSM", aml_arg(0), aml_arg(1),
+                                 aml_arg(2), aml_arg(3), params))
+        );
+    }
+    return method;
+}
+
+static Aml *aml_pci_static_endpoint_dsm(PCIDevice *pdev)
+{
+    Aml *method;
+
+    g_assert(pdev->acpi_index != 0);
+    method = aml_method("_DSM", 4, AML_SERIALIZED);
+    {
+        Aml *params = aml_local(0);
+        Aml *pkg = aml_package(1);
+        aml_append(pkg, aml_int(pdev->acpi_index));
+        aml_append(method, aml_store(pkg, params));
+        aml_append(method,
+            aml_return(aml_call5("EDSM", aml_arg(0), aml_arg(1),
+                                 aml_arg(2), aml_arg(3), params))
+        );
+    }
+    return method;
+}
+
+static void build_append_pcihp_notify_entry(Aml *method, int slot)
+{
+    Aml *if_ctx;
+    int32_t devfn = PCI_DEVFN(slot, 0);
+
+    if_ctx = aml_if(aml_and(aml_arg(0), aml_int(0x1U << slot), NULL));
+    aml_append(if_ctx, aml_notify(aml_name("S%.02X", devfn), aml_arg(1)));
+    aml_append(method, if_ctx);
+}
+
+static bool is_devfn_ignored_generic(const int devfn, const PCIBus *bus)
+{
+    const PCIDevice *pdev = bus->devices[devfn];
+
+    if (PCI_FUNC(devfn)) {
+        if (IS_PCI_BRIDGE(pdev)) {
+            /*
+             * Ignore only hotplugged PCI bridges on !0 functions, but
+             * allow describing cold plugged bridges on all functions
+             */
+            if (DEVICE(pdev)->hotplugged) {
+                return true;
+            }
+        }
+    }
+    return false;
+}
+
+static bool is_devfn_ignored_hotplug(const int devfn, const PCIBus *bus)
+{
+    PCIDevice *pdev = bus->devices[devfn];
+    if (pdev) {
+        return is_devfn_ignored_generic(devfn, bus) ||
+               !DEVICE_GET_CLASS(pdev)->hotpluggable ||
+               /* Cold plugged bridges aren't themselves hot-pluggable */
+               (IS_PCI_BRIDGE(pdev) && !DEVICE(pdev)->hotplugged);
+    } else { /* non populated slots */
+         /*
+          * hotplug is supported only for non-multifunction device
+          * so generate device description only for function 0
+          */
+        if (PCI_FUNC(devfn) ||
+            (pci_bus_is_express(bus) && PCI_SLOT(devfn) > 0)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus)
+{
+    int devfn;
+    Aml *dev, *notify_method = NULL, *method;
+    QObject *bsel = object_property_get_qobject(OBJECT(bus),
+                        ACPI_PCIHP_PROP_BSEL, NULL);
+    uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
+    qobject_unref(bsel);
+
+    aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
+    notify_method = aml_method("DVNT", 2, AML_NOTSERIALIZED);
+
+    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        int slot = PCI_SLOT(devfn);
+        int adr = slot << 16 | PCI_FUNC(devfn);
+
+        if (is_devfn_ignored_hotplug(devfn, bus)) {
+            continue;
+        }
+
+        if (bus->devices[devfn]) {
+            dev = aml_scope("S%.02X", devfn);
+        } else {
+            dev = aml_device("S%.02X", devfn);
+            aml_append(dev, aml_name_decl("_ADR", aml_int(adr)));
+        }
+
+        /*
+         * Can't declare _SUN here for every device as it changes 'slot'
+         * enumeration order in linux kernel, so use another variable for it
+         */
+        aml_append(dev, aml_name_decl("ASUN", aml_int(slot)));
+        aml_append(dev, aml_pci_device_dsm());
+
+        aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
+        /* add _EJ0 to make slot hotpluggable  */
+        method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
+        aml_append(method,
+            aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
+        );
+        aml_append(dev, method);
+
+        build_append_pcihp_notify_entry(notify_method, slot);
+
+        /* device descriptor has been composed, add it into parent context */
+        aml_append(parent_scope, dev);
+    }
+    aml_append(parent_scope, notify_method);
+}
+
+void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
+{
+    int devfn;
+    Aml *dev;
+
+    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        /* ACPI spec: 1.0b: Table 6-2 _ADR Object Bus Types, PCI type */
+        int adr = PCI_SLOT(devfn) << 16 | PCI_FUNC(devfn);
+        PCIDevice *pdev = bus->devices[devfn];
+
+        if (!pdev || is_devfn_ignored_generic(devfn, bus)) {
+            continue;
+        }
+
+        /* start to compose PCI device descriptor */
+        dev = aml_device("S%.02X", devfn);
+        aml_append(dev, aml_name_decl("_ADR", aml_int(adr)));
+
+        call_dev_aml_func(DEVICE(bus->devices[devfn]), dev);
+        /* add _DSM if device has acpi-index set */
+        if (pdev->acpi_index &&
+            !object_property_get_bool(OBJECT(pdev), "hotpluggable",
+                                      &error_abort)) {
+            aml_append(dev, aml_pci_static_endpoint_dsm(pdev));
+        }
+
+        /* device descriptor has been composed, add it into parent context */
+        aml_append(parent_scope, dev);
+    }
+}
+
 const VMStateDescription vmstate_acpi_pcihp_pci_status = {
     .name = "acpi_pcihp_pci_status",
     .version_id = 1,
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3275675e60..fe8bc62c03 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -338,29 +338,6 @@ build_facs(GArray *table_data)
     g_array_append_vals(table_data, reserved, 40); /* Reserved */
 }
 
-static Aml *aml_pci_device_dsm(void)
-{
-    Aml *method;
-
-    method = aml_method("_DSM", 4, AML_SERIALIZED);
-    {
-        Aml *params = aml_local(0);
-        Aml *pkg = aml_package(2);
-        aml_append(pkg, aml_int(0));
-        aml_append(pkg, aml_int(0));
-        aml_append(method, aml_store(pkg, params));
-        aml_append(method,
-            aml_store(aml_name("BSEL"), aml_index(params, aml_int(0))));
-        aml_append(method,
-            aml_store(aml_name("ASUN"), aml_index(params, aml_int(1))));
-        aml_append(method,
-            aml_return(aml_call5("PDSM", aml_arg(0), aml_arg(1),
-                                 aml_arg(2), aml_arg(3), params))
-        );
-    }
-    return method;
-}
-
 static Aml *aml_pci_edsm(void)
 {
     Aml *method, *ifctx;
@@ -414,155 +391,6 @@ static Aml *aml_pci_edsm(void)
     return method;
 }
 
-static Aml *aml_pci_static_endpoint_dsm(PCIDevice *pdev)
-{
-    Aml *method;
-
-    g_assert(pdev->acpi_index != 0);
-    method = aml_method("_DSM", 4, AML_SERIALIZED);
-    {
-        Aml *params = aml_local(0);
-        Aml *pkg = aml_package(1);
-        aml_append(pkg, aml_int(pdev->acpi_index));
-        aml_append(method, aml_store(pkg, params));
-        aml_append(method,
-            aml_return(aml_call5("EDSM", aml_arg(0), aml_arg(1),
-                                 aml_arg(2), aml_arg(3), params))
-        );
-    }
-    return method;
-}
-
-static void build_append_pcihp_notify_entry(Aml *method, int slot)
-{
-    Aml *if_ctx;
-    int32_t devfn = PCI_DEVFN(slot, 0);
-
-    if_ctx = aml_if(aml_and(aml_arg(0), aml_int(0x1U << slot), NULL));
-    aml_append(if_ctx, aml_notify(aml_name("S%.02X", devfn), aml_arg(1)));
-    aml_append(method, if_ctx);
-}
-
-static bool is_devfn_ignored_generic(const int devfn, const PCIBus *bus)
-{
-    const PCIDevice *pdev = bus->devices[devfn];
-
-    if (PCI_FUNC(devfn)) {
-        if (IS_PCI_BRIDGE(pdev)) {
-            /*
-             * Ignore only hotplugged PCI bridges on !0 functions, but
-             * allow describing cold plugged bridges on all functions
-             */
-            if (DEVICE(pdev)->hotplugged) {
-                return true;
-            }
-        }
-    }
-    return false;
-}
-
-static bool is_devfn_ignored_hotplug(const int devfn, const PCIBus *bus)
-{
-    PCIDevice *pdev = bus->devices[devfn];
-    if (pdev) {
-        return is_devfn_ignored_generic(devfn, bus) ||
-               !DEVICE_GET_CLASS(pdev)->hotpluggable ||
-               /* Cold plugged bridges aren't themselves hot-pluggable */
-               (IS_PCI_BRIDGE(pdev) && !DEVICE(pdev)->hotplugged);
-    } else { /* non populated slots */
-         /*
-         * hotplug is supported only for non-multifunction device
-         * so generate device description only for function 0
-         */
-        if (PCI_FUNC(devfn) ||
-            (pci_bus_is_express(bus) && PCI_SLOT(devfn) > 0)) {
-            return true;
-        }
-    }
-    return false;
-}
-
-void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus)
-{
-    int devfn;
-    Aml *dev, *notify_method = NULL, *method;
-    QObject *bsel = object_property_get_qobject(OBJECT(bus),
-                        ACPI_PCIHP_PROP_BSEL, NULL);
-    uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
-    qobject_unref(bsel);
-
-    aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
-    notify_method = aml_method("DVNT", 2, AML_NOTSERIALIZED);
-
-    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
-        int slot = PCI_SLOT(devfn);
-        int adr = slot << 16 | PCI_FUNC(devfn);
-
-        if (is_devfn_ignored_hotplug(devfn, bus)) {
-            continue;
-        }
-
-        if (bus->devices[devfn]) {
-            dev = aml_scope("S%.02X", devfn);
-        } else {
-            dev = aml_device("S%.02X", devfn);
-            aml_append(dev, aml_name_decl("_ADR", aml_int(adr)));
-        }
-
-        /*
-         * Can't declare _SUN here for every device as it changes 'slot'
-         * enumeration order in linux kernel, so use another variable for it
-         */
-        aml_append(dev, aml_name_decl("ASUN", aml_int(slot)));
-        aml_append(dev, aml_pci_device_dsm());
-
-        aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
-        /* add _EJ0 to make slot hotpluggable  */
-        method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
-        aml_append(method,
-            aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
-        );
-        aml_append(dev, method);
-
-        build_append_pcihp_notify_entry(notify_method, slot);
-
-        /* device descriptor has been composed, add it into parent context */
-        aml_append(parent_scope, dev);
-    }
-    aml_append(parent_scope, notify_method);
-}
-
-void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
-{
-    int devfn;
-    Aml *dev;
-
-    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
-        /* ACPI spec: 1.0b: Table 6-2 _ADR Object Bus Types, PCI type */
-        int adr = PCI_SLOT(devfn) << 16 | PCI_FUNC(devfn);
-        PCIDevice *pdev = bus->devices[devfn];
-
-        if (!pdev || is_devfn_ignored_generic(devfn, bus)) {
-            continue;
-        }
-
-        /* start to compose PCI device descriptor */
-        dev = aml_device("S%.02X", devfn);
-        aml_append(dev, aml_name_decl("_ADR", aml_int(adr)));
-
-        call_dev_aml_func(DEVICE(bus->devices[devfn]), dev);
-        /* add _DSM if device has acpi-index set */
-        if (pdev->acpi_index &&
-            !object_property_get_bool(OBJECT(pdev), "hotpluggable",
-                                      &error_abort)) {
-            aml_append(dev, aml_pci_static_endpoint_dsm(pdev));
-        }
-
-        /* device descriptor has been composed, add it into parent context */
-        aml_append(parent_scope, dev);
-    }
-}
-
 /*
  * build_prt - Define interrupt routing rules
  *
-- 
2.49.0


