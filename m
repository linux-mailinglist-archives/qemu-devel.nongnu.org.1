Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB027CDCBA
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:08:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6Gu-00041P-Pk; Wed, 18 Oct 2023 09:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6Gs-000404-7h
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6Gp-0007v2-MI
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2XU8wOQg1eEixqLXCHJHg1BgCc9TzFT0UjWkh0yEv8=;
 b=BspcnvGU0AGKaDpfaXIVdKdFV5WckvYxqZeg02VbDC+lQGuAkP/rFFgavBFV/HtS4TkAjW
 9tiNd0y7JZP37rDX6dIjZ7P6MWvcnHGZCpGiWznq0+VuNFl8qVPWFd+P+LK4+TvoGHwozF
 fUg0zcnJ7O0Mh/uWlqnWFgygpJn67EE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-a3HCq8SEMeyJ5duu7qhmOw-1; Wed, 18 Oct 2023 09:07:22 -0400
X-MC-Unique: a3HCq8SEMeyJ5duu7qhmOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF1AF3857B83;
 Wed, 18 Oct 2023 13:07:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A18E320268CB;
 Wed, 18 Oct 2023 13:07:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 02/25] CPU topology: extend with s390 specifics
Date: Wed, 18 Oct 2023 15:06:53 +0200
Message-ID: <20231018130716.286638-3-thuth@redhat.com>
In-Reply-To: <20231018130716.286638-1-thuth@redhat.com>
References: <20231018130716.286638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Pierre Morel <pmorel@linux.ibm.com>

S390 adds two new SMP levels, drawers and books to the CPU
topology.
S390 CPUs have specific topology features like dedication and
entitlement. These indicate to the guest information on host
vCPU scheduling and help the guest make better scheduling decisions.

Add the new levels to the relevant QAPI structs.
Add all the supported topology levels, dedication and entitlement
as properties to S390 CPUs.
Create machine-common.json so we can later include it in
machine-target.json also.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20231016183925.2384704-3-nsg@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                         |  1 +
 qapi/machine-common.json            | 21 +++++++++++++
 qapi/machine.json                   | 21 +++++++++++--
 qapi/qapi-schema.json               |  1 +
 include/hw/boards.h                 | 10 +++++-
 include/hw/qdev-properties-system.h |  4 +++
 target/s390x/cpu.h                  |  6 ++++
 hw/core/machine-smp.c               | 48 ++++++++++++++++++++++++-----
 hw/core/machine.c                   |  4 +++
 hw/core/qdev-properties-system.c    | 13 ++++++++
 hw/s390x/s390-virtio-ccw.c          |  4 +++
 system/vl.c                         |  6 ++++
 target/s390x/cpu.c                  |  7 +++++
 qapi/meson.build                    |  1 +
 qemu-options.hx                     |  7 +++--
 15 files changed, 141 insertions(+), 13 deletions(-)
 create mode 100644 qapi/machine-common.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 9bd4fe378d..2bf3399b3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1793,6 +1793,7 @@ F: hw/core/null-machine.c
 F: hw/core/numa.c
 F: hw/cpu/cluster.c
 F: qapi/machine.json
+F: qapi/machine-common.json
 F: qapi/machine-target.json
 F: include/hw/boards.h
 F: include/hw/core/cpu.h
diff --git a/qapi/machine-common.json b/qapi/machine-common.json
new file mode 100644
index 0000000000..fa6bd71d12
--- /dev/null
+++ b/qapi/machine-common.json
@@ -0,0 +1,21 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+##
+# = Machines S390 data types
+##
+
+##
+# @CpuS390Entitlement:
+#
+# An enumeration of CPU entitlements that can be assumed by a virtual
+# S390 CPU
+#
+# Since: 8.2
+##
+{ 'enum': 'CpuS390Entitlement',
+  'prefix': 'S390_CPU_ENTITLEMENT',
+  'data': [ 'auto', 'low', 'medium', 'high' ] }
diff --git a/qapi/machine.json b/qapi/machine.json
index f053245756..17b69a6aea 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -9,6 +9,7 @@
 ##
 
 { 'include': 'common.json' }
+{ 'include': 'machine-common.json' }
 
 ##
 # @SysEmuTarget:
@@ -907,7 +908,13 @@
 #
 # @node-id: NUMA node ID the CPU belongs to
 #
-# @socket-id: socket number within CPU topology the CPU belongs to
+# @drawer-id: drawer number within CPU topology the CPU belongs to
+#     (since 8.2)
+#
+# @book-id: book number within parent container the CPU belongs to
+#     (since 8.2)
+#
+# @socket-id: socket number within parent container the CPU belongs to
 #
 # @die-id: die number within the parent container the CPU belongs to
 #    (since 4.1)
@@ -928,6 +935,8 @@
 { 'struct': 'CpuInstanceProperties',
   # Keep these in sync with the properties device_add accepts
   'data': { '*node-id': 'int',
+            '*drawer-id': 'int',
+            '*book-id': 'int',
             '*socket-id': 'int',
             '*die-id': 'int',
             '*cluster-id': 'int',
@@ -1488,7 +1497,7 @@
 # containers.
 #
 # The ordering from highest/coarsest to lowest/finest is:
-# @sockets, @dies, @clusters, @cores, @threads.
+# @drawers, @books, @sockets, @dies, @clusters, @cores, @threads.
 #
 # Different architectures support different subsets of topology
 # containers.
@@ -1501,7 +1510,11 @@
 # @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
 #     machine
 #
-# @sockets: number of sockets in the CPU topology
+# @drawers: number of drawers in the CPU topology (since 8.2)
+#
+# @books: number of books in the CPU topology (since 8.2)
+#
+# @sockets: number of sockets per parent container
 #
 # @dies: number of dies per parent container
 #
@@ -1515,6 +1528,8 @@
 ##
 { 'struct': 'SMPConfiguration', 'data': {
      '*cpus': 'int',
+     '*drawers': 'int',
+     '*books': 'int',
      '*sockets': 'int',
      '*dies': 'int',
      '*clusters': 'int',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 6594afba31..c01ec335e6 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -66,6 +66,7 @@
 { 'include': 'introspect.json' }
 { 'include': 'qom.json' }
 { 'include': 'qdev.json' }
+{ 'include': 'machine-common.json' }
 { 'include': 'machine.json' }
 { 'include': 'machine-target.json' }
 { 'include': 'replay.json' }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 43a56dc51e..a735999298 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -135,12 +135,16 @@ typedef struct {
  * @clusters_supported - whether clusters are supported by the machine
  * @has_clusters - whether clusters are explicitly specified in the user
  *                 provided SMP configuration
+ * @books_supported - whether books are supported by the machine
+ * @drawers_supported - whether drawers are supported by the machine
  */
 typedef struct {
     bool prefer_sockets;
     bool dies_supported;
     bool clusters_supported;
     bool has_clusters;
+    bool books_supported;
+    bool drawers_supported;
 } SMPCompatProps;
 
 /**
@@ -323,7 +327,9 @@ typedef struct DeviceMemoryState {
 /**
  * CpuTopology:
  * @cpus: the number of present logical processors on the machine
- * @sockets: the number of sockets on the machine
+ * @drawers: the number of drawers on the machine
+ * @books: the number of books in one drawer
+ * @sockets: the number of sockets in one book
  * @dies: the number of dies in one socket
  * @clusters: the number of clusters in one die
  * @cores: the number of cores in one cluster
@@ -332,6 +338,8 @@ typedef struct DeviceMemoryState {
  */
 typedef struct CpuTopology {
     unsigned int cpus;
+    unsigned int drawers;
+    unsigned int books;
     unsigned int sockets;
     unsigned int dies;
     unsigned int clusters;
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 0ac327ae60..e4f8a13afc 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -22,6 +22,7 @@ extern const PropertyInfo qdev_prop_audiodev;
 extern const PropertyInfo qdev_prop_off_auto_pcibar;
 extern const PropertyInfo qdev_prop_pcie_link_speed;
 extern const PropertyInfo qdev_prop_pcie_link_width;
+extern const PropertyInfo qdev_prop_cpus390entitlement;
 
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
@@ -73,5 +74,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 #define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) \
     DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID)
 
+#define DEFINE_PROP_CPUS390ENTITLEMENT(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_cpus390entitlement, \
+                       CpuS390Entitlement)
 
 #endif
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7bea7075e1..56f9340914 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -30,6 +30,7 @@
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 #include "tcg/tcg_s390x.h"
+#include "qapi/qapi-types-machine-common.h"
 
 #define ELF_MACHINE_UNAME "S390X"
 
@@ -132,6 +133,11 @@ struct CPUArchState {
 
 #if !defined(CONFIG_USER_ONLY)
     uint32_t core_id; /* PoP "CPU address", same as cpu_index */
+    int32_t socket_id;
+    int32_t book_id;
+    int32_t drawer_id;
+    bool dedicated;
+    CpuS390Entitlement entitlement; /* Used only for vertical polarization */
     uint64_t cpuid;
 #endif
 
diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 0f4d9b6f7a..25019c91ee 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -33,6 +33,14 @@ static char *cpu_hierarchy_to_string(MachineState *ms)
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     GString *s = g_string_new(NULL);
 
+    if (mc->smp_props.drawers_supported) {
+        g_string_append_printf(s, "drawers (%u) * ", ms->smp.drawers);
+    }
+
+    if (mc->smp_props.books_supported) {
+        g_string_append_printf(s, "books (%u) * ", ms->smp.books);
+    }
+
     g_string_append_printf(s, "sockets (%u)", ms->smp.sockets);
 
     if (mc->smp_props.dies_supported) {
@@ -75,6 +83,8 @@ void machine_parse_smp_config(MachineState *ms,
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     unsigned cpus    = config->has_cpus ? config->cpus : 0;
+    unsigned drawers = config->has_drawers ? config->drawers : 0;
+    unsigned books   = config->has_books ? config->books : 0;
     unsigned sockets = config->has_sockets ? config->sockets : 0;
     unsigned dies    = config->has_dies ? config->dies : 0;
     unsigned clusters = config->has_clusters ? config->clusters : 0;
@@ -87,6 +97,8 @@ void machine_parse_smp_config(MachineState *ms,
      * explicit configuration like "cpus=0" is not allowed.
      */
     if ((config->has_cpus && config->cpus == 0) ||
+        (config->has_drawers && config->drawers == 0) ||
+        (config->has_books && config->books == 0) ||
         (config->has_sockets && config->sockets == 0) ||
         (config->has_dies && config->dies == 0) ||
         (config->has_clusters && config->clusters == 0) ||
@@ -113,6 +125,19 @@ void machine_parse_smp_config(MachineState *ms,
     dies = dies > 0 ? dies : 1;
     clusters = clusters > 0 ? clusters : 1;
 
+    if (!mc->smp_props.books_supported && books > 1) {
+        error_setg(errp, "books not supported by this machine's CPU topology");
+        return;
+    }
+    books = books > 0 ? books : 1;
+
+    if (!mc->smp_props.drawers_supported && drawers > 1) {
+        error_setg(errp,
+                   "drawers not supported by this machine's CPU topology");
+        return;
+    }
+    drawers = drawers > 0 ? drawers : 1;
+
     /* compute missing values based on the provided ones */
     if (cpus == 0 && maxcpus == 0) {
         sockets = sockets > 0 ? sockets : 1;
@@ -126,33 +151,41 @@ void machine_parse_smp_config(MachineState *ms,
             if (sockets == 0) {
                 cores = cores > 0 ? cores : 1;
                 threads = threads > 0 ? threads : 1;
-                sockets = maxcpus / (dies * clusters * cores * threads);
+                sockets = maxcpus /
+                          (drawers * books * dies * clusters * cores * threads);
             } else if (cores == 0) {
                 threads = threads > 0 ? threads : 1;
-                cores = maxcpus / (sockets * dies * clusters * threads);
+                cores = maxcpus /
+                        (drawers * books * sockets * dies * clusters * threads);
             }
         } else {
             /* prefer cores over sockets since 6.2 */
             if (cores == 0) {
                 sockets = sockets > 0 ? sockets : 1;
                 threads = threads > 0 ? threads : 1;
-                cores = maxcpus / (sockets * dies * clusters * threads);
+                cores = maxcpus /
+                        (drawers * books * sockets * dies * clusters * threads);
             } else if (sockets == 0) {
                 threads = threads > 0 ? threads : 1;
-                sockets = maxcpus / (dies * clusters * cores * threads);
+                sockets = maxcpus /
+                          (drawers * books * dies * clusters * cores * threads);
             }
         }
 
         /* try to calculate omitted threads at last */
         if (threads == 0) {
-            threads = maxcpus / (sockets * dies * clusters * cores);
+            threads = maxcpus /
+                      (drawers * books * sockets * dies * clusters * cores);
         }
     }
 
-    maxcpus = maxcpus > 0 ? maxcpus : sockets * dies * clusters * cores * threads;
+    maxcpus = maxcpus > 0 ? maxcpus : drawers * books * sockets * dies *
+                                      clusters * cores * threads;
     cpus = cpus > 0 ? cpus : maxcpus;
 
     ms->smp.cpus = cpus;
+    ms->smp.drawers = drawers;
+    ms->smp.books = books;
     ms->smp.sockets = sockets;
     ms->smp.dies = dies;
     ms->smp.clusters = clusters;
@@ -163,7 +196,8 @@ void machine_parse_smp_config(MachineState *ms,
     mc->smp_props.has_clusters = config->has_clusters;
 
     /* sanity-check of the computed topology */
-    if (sockets * dies * clusters * cores * threads != maxcpus) {
+    if (drawers * books * sockets * dies * clusters * cores * threads !=
+        maxcpus) {
         g_autofree char *topo_msg = cpu_hierarchy_to_string(ms);
         error_setg(errp, "Invalid CPU topology: "
                    "product of the hierarchy must match maxcpus: "
diff --git a/hw/core/machine.c b/hw/core/machine.c
index cfd1edfe20..0c45f64bae 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -861,6 +861,8 @@ static void machine_get_smp(Object *obj, Visitor *v, const char *name,
     MachineState *ms = MACHINE(obj);
     SMPConfiguration *config = &(SMPConfiguration){
         .has_cpus = true, .cpus = ms->smp.cpus,
+        .has_drawers = true, .drawers = ms->smp.drawers,
+        .has_books = true, .books = ms->smp.books,
         .has_sockets = true, .sockets = ms->smp.sockets,
         .has_dies = true, .dies = ms->smp.dies,
         .has_clusters = true, .clusters = ms->smp.clusters,
@@ -1135,6 +1137,8 @@ static void machine_initfn(Object *obj)
     /* default to mc->default_cpus */
     ms->smp.cpus = mc->default_cpus;
     ms->smp.max_cpus = mc->default_cpus;
+    ms->smp.drawers = 1;
+    ms->smp.books = 1;
     ms->smp.sockets = 1;
     ms->smp.dies = 1;
     ms->smp.clusters = 1;
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 688340610e..7c6dfab128 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -1139,3 +1139,16 @@ const PropertyInfo qdev_prop_uuid = {
     .set   = set_uuid,
     .set_default_value = set_default_uuid_auto,
 };
+
+/* --- s390 cpu entitlement policy --- */
+
+QEMU_BUILD_BUG_ON(sizeof(CpuS390Entitlement) != sizeof(int));
+
+const PropertyInfo qdev_prop_cpus390entitlement = {
+    .name  = "CpuS390Entitlement",
+    .description = "low/medium (default)/high",
+    .enum_table  = &CpuS390Entitlement_lookup,
+    .get   = qdev_propinfo_get_enum,
+    .set   = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 2d75f2131f..c1123a9b45 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -744,6 +744,8 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->no_sdcard = 1;
     mc->max_cpus = S390_MAX_CPUS;
     mc->has_hotpluggable_cpus = true;
+    mc->smp_props.books_supported = true;
+    mc->smp_props.drawers_supported = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = s390_get_hotplug_handler;
     mc->cpu_index_to_instance_props = s390_cpu_index_to_props;
@@ -853,6 +855,8 @@ static void ccw_machine_8_1_class_options(MachineClass *mc)
 {
     ccw_machine_8_2_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
+    mc->smp_props.drawers_supported = false;
+    mc->smp_props.books_supported = false;
 }
 DEFINE_CCW_MACHINE(8_1, "8.1", false);
 
diff --git a/system/vl.c b/system/vl.c
index 3100ac01ed..92d29bf521 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -726,6 +726,12 @@ static QemuOptsList qemu_smp_opts = {
         {
             .name = "cpus",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "drawers",
+            .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "books",
+            .type = QEMU_OPT_NUMBER,
         }, {
             .name = "sockets",
             .type = QEMU_OPT_NUMBER,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 6093ab0a12..ba646461a1 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -31,6 +31,7 @@
 #include "qapi/qapi-types-machine.h"
 #include "sysemu/hw_accel.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "fpu/softfloat-helpers.h"
 #include "disas/capstone.h"
 #include "sysemu/tcg.h"
@@ -290,6 +291,12 @@ static const gchar *s390_gdb_arch_name(CPUState *cs)
 static Property s390x_cpu_properties[] = {
 #if !defined(CONFIG_USER_ONLY)
     DEFINE_PROP_UINT32("core-id", S390CPU, env.core_id, 0),
+    DEFINE_PROP_INT32("socket-id", S390CPU, env.socket_id, -1),
+    DEFINE_PROP_INT32("book-id", S390CPU, env.book_id, -1),
+    DEFINE_PROP_INT32("drawer-id", S390CPU, env.drawer_id, -1),
+    DEFINE_PROP_BOOL("dedicated", S390CPU, env.dedicated, false),
+    DEFINE_PROP_CPUS390ENTITLEMENT("entitlement", S390CPU, env.entitlement,
+                                   S390_CPU_ENTITLEMENT_AUTO),
 #endif
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/qapi/meson.build b/qapi/meson.build
index 60a668b343..f81a37565c 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -36,6 +36,7 @@ qapi_all_modules = [
   'error',
   'introspect',
   'job',
+  'machine-common',
   'machine',
   'machine-target',
   'migration',
diff --git a/qemu-options.hx b/qemu-options.hx
index 54a7e94970..e26230bac5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -272,11 +272,14 @@ SRST
 ERST
 
 DEF("smp", HAS_ARG, QEMU_OPTION_smp,
-    "-smp [[cpus=]n][,maxcpus=maxcpus][,sockets=sockets][,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]\n"
+    "-smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets]\n"
+    "               [,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]\n"
     "                set the number of initial CPUs to 'n' [default=1]\n"
     "                maxcpus= maximum number of total CPUs, including\n"
     "                offline CPUs for hotplug, etc\n"
-    "                sockets= number of sockets on the machine board\n"
+    "                drawers= number of drawers on the machine board\n"
+    "                books= number of books in one drawer\n"
+    "                sockets= number of sockets in one book\n"
     "                dies= number of dies in one socket\n"
     "                clusters= number of clusters in one die\n"
     "                cores= number of cores in one cluster\n"
-- 
2.41.0


