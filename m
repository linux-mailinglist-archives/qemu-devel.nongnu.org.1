Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CB5AFD9AB
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Jul 2025 23:22:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFIh-0005m3-OR; Tue, 08 Jul 2025 16:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZEDD-0004hw-WB
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZEDB-0006B1-HU
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752003760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ztOHQuRdZU6Ia6/9fdzeOkwFogOl4LLzWMJKwr7hjGI=;
 b=dzyr6gGc8luENkJnhB7yARd7LvYWZxhzn0Ej0KXghtL7SdvSgzpHbyQIo7+i3tqgf+271a
 UhUzsV/jhRR2M9nsjc0uKBBbf4rcdwWJl4f7dU3DXZXnWwXoVJUfxbtFu6Yz6bjZC7r3nf
 R2D7KD++JLT4NV8neRWe/B4IOVzussY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-gcyLuUOpPh6obSAxS76PQg-1; Tue,
 08 Jul 2025 10:26:20 -0400
X-MC-Unique: gcyLuUOpPh6obSAxS76PQg-1
X-Mimecast-MFC-AGG-ID: gcyLuUOpPh6obSAxS76PQg_1751984775
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A7C41956048; Tue,  8 Jul 2025 14:26:15 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.187])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 03D1730001B1; Tue,  8 Jul 2025 14:26:08 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v6 13/36] hw/i386/acpi-build: Move
 build_append_notification_callback to pcihp
Date: Tue,  8 Jul 2025 16:22:55 +0200
Message-ID: <20250708142437.1344644-14-eric.auger@redhat.com>
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

We plan to reuse build_append_notification_callback() on ARM
so let's move it to pcihp.c.

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 include/hw/acpi/pcihp.h |  1 +
 hw/acpi/pcihp.c         | 58 +++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c    | 58 -----------------------------------------
 3 files changed, 59 insertions(+), 58 deletions(-)

diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 253ac6e483..f4fd44cb32 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -78,6 +78,7 @@ void build_acpi_pci_hotplug(Aml *table, AmlRegionSpace rs, uint64_t pcihp_addr);
 void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar);
 void build_append_pcihp_resources(Aml *table,
                                   uint64_t io_addr, uint64_t io_len);
+bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus);
 
 /* Called on reset */
 void acpi_pcihp_reset(AcpiPciHpState *s);
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index afa3ec5f4d..b64d06afc9 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -39,6 +39,7 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qom/qom-qobject.h"
+#include "qobject/qnum.h"
 #include "trace.h"
 
 #define ACPI_PCIHP_SIZE 0x0018
@@ -703,6 +704,63 @@ void build_append_pcihp_resources(Aml *scope /* \\_SB.PCI0 */,
     aml_append(scope, dev);
 }
 
+bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus)
+{
+    Aml *method;
+    PCIBus *sec;
+    QObject *bsel;
+    int nr_notifiers = 0;
+    GQueue *pcnt_bus_list = g_queue_new();
+
+    QLIST_FOREACH(sec, &bus->child, sibling) {
+        Aml *br_scope = aml_scope("S%.02X", sec->parent_dev->devfn);
+        if (pci_bus_is_root(sec)) {
+            continue;
+        }
+        nr_notifiers = nr_notifiers +
+                       build_append_notification_callback(br_scope, sec);
+        /*
+         * add new child scope to parent
+         * and keep track of bus that have PCNT,
+         * bus list is used later to call children PCNTs from this level PCNT
+         */
+        if (nr_notifiers) {
+            g_queue_push_tail(pcnt_bus_list, sec);
+            aml_append(parent_scope, br_scope);
+        }
+    }
+
+    /*
+     * Append PCNT method to notify about events on local and child buses.
+     * ps: hostbridge might not have hotplug (bsel) enabled but might have
+     * child bridges that do have bsel.
+     */
+    method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
+
+    /* If bus supports hotplug select it and notify about local events */
+    bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
+    if (bsel) {
+        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
+
+        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
+        aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
+                                     aml_int(1))); /* Device Check */
+        aml_append(method, aml_call2("DVNT", aml_name("PCID"),
+                                     aml_int(3))); /* Eject Request */
+        nr_notifiers++;
+    }
+
+    /* Notify about child bus events in any case */
+    while ((sec = g_queue_pop_head(pcnt_bus_list))) {
+        aml_append(method, aml_name("^S%.02X.PCNT", sec->parent_dev->devfn));
+    }
+
+    aml_append(parent_scope, method);
+    qobject_unref(bsel);
+    g_queue_free(pcnt_bus_list);
+    return !!nr_notifiers;
+}
+
 const VMStateDescription vmstate_acpi_pcihp_pci_status = {
     .name = "acpi_pcihp_pci_status",
     .version_id = 1,
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6ca2b34ef8..3275675e60 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -563,64 +563,6 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
     }
 }
 
-static bool build_append_notification_callback(Aml *parent_scope,
-                                               const PCIBus *bus)
-{
-    Aml *method;
-    PCIBus *sec;
-    QObject *bsel;
-    int nr_notifiers = 0;
-    GQueue *pcnt_bus_list = g_queue_new();
-
-    QLIST_FOREACH(sec, &bus->child, sibling) {
-        Aml *br_scope = aml_scope("S%.02X", sec->parent_dev->devfn);
-        if (pci_bus_is_root(sec)) {
-            continue;
-        }
-        nr_notifiers = nr_notifiers +
-                       build_append_notification_callback(br_scope, sec);
-        /*
-         * add new child scope to parent
-         * and keep track of bus that have PCNT,
-         * bus list is used later to call children PCNTs from this level PCNT
-         */
-        if (nr_notifiers) {
-            g_queue_push_tail(pcnt_bus_list, sec);
-            aml_append(parent_scope, br_scope);
-        }
-    }
-
-    /*
-     * Append PCNT method to notify about events on local and child buses.
-     * ps: hostbridge might not have hotplug (bsel) enabled but might have
-     * child bridges that do have bsel.
-     */
-    method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
-
-    /* If bus supports hotplug select it and notify about local events */
-    bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
-    if (bsel) {
-        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
-
-        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
-        aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
-                                     aml_int(1))); /* Device Check */
-        aml_append(method, aml_call2("DVNT", aml_name("PCID"),
-                                     aml_int(3))); /* Eject Request */
-        nr_notifiers++;
-    }
-
-    /* Notify about child bus events in any case */
-    while ((sec = g_queue_pop_head(pcnt_bus_list))) {
-        aml_append(method, aml_name("^S%.02X.PCNT", sec->parent_dev->devfn));
-    }
-
-    aml_append(parent_scope, method);
-    qobject_unref(bsel);
-    g_queue_free(pcnt_bus_list);
-    return !!nr_notifiers;
-}
-
 /*
  * build_prt - Define interrupt routing rules
  *
-- 
2.49.0


