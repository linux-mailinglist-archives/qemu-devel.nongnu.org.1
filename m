Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1947A041A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:41:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgle2-0002Bi-8U; Thu, 14 Sep 2023 08:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qgldy-0002BI-Pm; Thu, 14 Sep 2023 08:40:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qgldw-0001BA-4Q; Thu, 14 Sep 2023 08:40:26 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38ECQnRa027629; Thu, 14 Sep 2023 12:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IzSs1tXQMiUAuLaiMoqhU3MQp6ekAoHEnR6TN9j3HHQ=;
 b=bwP4wr2L5I1SRo82DtMo6AvE/adbJfhq+irApHJ+5sc6qXbO6p0KRdJr3NRSWe5Kv254
 FWLVUHMsmP+U01BJPNSW4z9qLXr4qLCtnsfdW5QwGJFyfjpWrc98TkvZ0qUAnEASoz0E
 gNwQU42WpzCyaGTbkJcyPpLnCI2xkIMuB6AOe4HGVC9l4bWsfDvoQxLyKn3znDZNMJXI
 +B/Vij4cPeWFhaujmR9q+VOtDz1I3qenadDdTlqw8ckVUU78/JUD+8ZD17ppmG1NWqBU
 oXeQBaUNmNWNlzNhECjuh/FREzYQZif6YBlqFR+6Ins0Qmrkhuw9kCb9r/kr+ObyC+Cn Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t426grjcp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 12:40:14 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38ECR3Jk028726;
 Thu, 14 Sep 2023 12:37:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t426grfhe-10
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 12:37:41 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38EAYa83022728; Thu, 14 Sep 2023 12:06:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t141p2pnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 12:06:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38EC6tQl28901690
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 12:06:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DB5C20071;
 Thu, 14 Sep 2023 12:06:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B41D2006E;
 Thu, 14 Sep 2023 12:06:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 14 Sep 2023 12:06:54 +0000 (GMT)
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v23 01/20] CPU topology: extend with s390 specifics
Date: Thu, 14 Sep 2023 14:06:31 +0200
Message-Id: <20230914120650.1318932-2-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914120650.1318932-1-nsg@linux.ibm.com>
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nl0JzG3cFQr48ObTDiPno9-dB5k-WjXc
X-Proofpoint-ORIG-GUID: QEXSG_vsO4VvNMe7EZnfKh_EB3RkBLG0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140108
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Pierre Morel <pmorel@linux.ibm.com>

S390 adds two new SMP levels, drawers and books to the CPU
topology.
S390 CPUs have specific topology features like dedication and
entitlement. These indicate to the guest information on host
vCPU scheduling and help the guest make better scheduling decisions.

Let us provide the SMP properties with books and drawers levels
and S390 CPU with dedication and entitlement,

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 qapi/machine-common.json            | 21 +++++++++++++
 qapi/machine.json                   | 19 ++++++++++--
 include/hw/boards.h                 | 10 +++++-
 include/hw/qdev-properties-system.h |  4 +++
 target/s390x/cpu.h                  |  6 ++++
 hw/core/machine-smp.c               | 48 ++++++++++++++++++++++++-----
 hw/core/machine.c                   |  4 +++
 hw/core/qdev-properties-system.c    | 13 ++++++++
 hw/s390x/s390-virtio-ccw.c          |  4 +++
 softmmu/vl.c                        |  6 ++++
 target/s390x/cpu.c                  |  7 +++++
 qapi/meson.build                    |  1 +
 qemu-options.hx                     |  7 +++--
 13 files changed, 137 insertions(+), 13 deletions(-)
 create mode 100644 qapi/machine-common.json

diff --git a/qapi/machine-common.json b/qapi/machine-common.json
new file mode 100644
index 0000000000..e40421bb37
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
+# An enumeration of cpu entitlements that can be assumed by a virtual
+# S390 CPU
+#
+# Since: 8.2
+##
+{ 'enum': 'CpuS390Entitlement',
+  'prefix': 'S390_CPU_ENTITLEMENT',
+  'data': [ 'auto', 'low', 'medium', 'high' ] }
diff --git a/qapi/machine.json b/qapi/machine.json
index a08b6576ca..a63cb951d2 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -9,6 +9,7 @@
 ##
 
 { 'include': 'common.json' }
+{ 'include': 'machine-common.json' }
 
 ##
 # @SysEmuTarget:
@@ -71,7 +72,7 @@
 #
 # @thread-id: ID of the underlying host thread
 #
-# @props: properties describing to which node/socket/core/thread
+# @props: properties describing to which node/drawer/book/socket/core/thread
 #     virtual CPU belongs to, provided if supported by board
 #
 # @target: the QEMU system emulation target, which determines which
@@ -901,7 +902,11 @@
 #
 # @node-id: NUMA node ID the CPU belongs to
 #
-# @socket-id: socket number within node/board the CPU belongs to
+# @drawer-id: drawer number within node/board the CPU belongs to (since 8.2)
+#
+# @book-id: book number within drawer/node/board the CPU belongs to (since 8.2)
+#
+# @socket-id: socket number within book/node/board the CPU belongs to
 #
 # @die-id: die number within socket the CPU belongs to (since 4.1)
 #
@@ -912,7 +917,7 @@
 #
 # @thread-id: thread number within core the CPU belongs to
 #
-# Note: currently there are 6 properties that could be present but
+# Note: currently there are 8 properties that could be present but
 #     management should be prepared to pass through other properties
 #     with device_add command to allow for future interface extension.
 #     This also requires the filed names to be kept in sync with the
@@ -922,6 +927,8 @@
 ##
 { 'struct': 'CpuInstanceProperties',
   'data': { '*node-id': 'int',
+            '*drawer-id': 'int',
+            '*book-id': 'int',
             '*socket-id': 'int',
             '*die-id': 'int',
             '*cluster-id': 'int',
@@ -1480,6 +1487,10 @@
 #
 # @cpus: number of virtual CPUs in the virtual machine
 #
+# @drawers: number of drawers in the CPU topology (since 8.2)
+#
+# @books: number of books in the CPU topology (since 8.2)
+#
 # @sockets: number of sockets in the CPU topology
 #
 # @dies: number of dies per socket in the CPU topology
@@ -1498,6 +1509,8 @@
 ##
 { 'struct': 'SMPConfiguration', 'data': {
      '*cpus': 'int',
+     '*drawers': 'int',
+     '*books': 'int',
      '*sockets': 'int',
      '*dies': 'int',
      '*clusters': 'int',
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 6c67af196a..6dcfc879eb 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -134,12 +134,16 @@ typedef struct {
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
@@ -310,7 +314,9 @@ typedef struct DeviceMemoryState {
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
@@ -319,6 +325,8 @@ typedef struct DeviceMemoryState {
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
index 304029e57c..dfcc1aa1fc 100644
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
index da699cf4e1..363ddafc89 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -843,6 +843,8 @@ static void machine_get_smp(Object *obj, Visitor *v, const char *name,
     MachineState *ms = MACHINE(obj);
     SMPConfiguration *config = &(SMPConfiguration){
         .has_cpus = true, .cpus = ms->smp.cpus,
+        .has_drawers = true, .drawers = ms->smp.drawers,
+        .has_books = true, .books = ms->smp.books,
         .has_sockets = true, .sockets = ms->smp.sockets,
         .has_dies = true, .dies = ms->smp.dies,
         .has_clusters = true, .clusters = ms->smp.clusters,
@@ -1108,6 +1110,8 @@ static void machine_initfn(Object *obj)
     /* default to mc->default_cpus */
     ms->smp.cpus = mc->default_cpus;
     ms->smp.max_cpus = mc->default_cpus;
+    ms->smp.drawers = 1;
+    ms->smp.books = 1;
     ms->smp.sockets = 1;
     ms->smp.dies = 1;
     ms->smp.clusters = 1;
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 6d5d43eda2..7f50ce9746 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -1147,3 +1147,16 @@ const PropertyInfo qdev_prop_uuid = {
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
index bfcf64d007..bbb001cb9e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -733,6 +733,8 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->no_sdcard = 1;
     mc->max_cpus = S390_MAX_CPUS;
     mc->has_hotpluggable_cpus = true;
+    mc->smp_props.books_supported = true;
+    mc->smp_props.drawers_supported = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = s390_get_hotplug_handler;
     mc->cpu_index_to_instance_props = s390_cpu_index_to_props;
@@ -842,6 +844,8 @@ static void ccw_machine_8_1_class_options(MachineClass *mc)
 {
     ccw_machine_8_2_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
+    mc->smp_props.drawers_supported = false;
+    mc->smp_props.books_supported = false;
 }
 DEFINE_CCW_MACHINE(8_1, "8.1", false);
 
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 3db4fd2680..eb2450ac24 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -724,6 +724,12 @@ static QemuOptsList qemu_smp_opts = {
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
index df167493c3..74405beb51 100644
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
@@ -292,6 +293,12 @@ static gchar *s390_gdb_arch_name(CPUState *cs)
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
index 6be621c232..09889913c3 100644
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
2.39.2


