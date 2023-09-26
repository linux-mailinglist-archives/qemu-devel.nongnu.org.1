Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AED2C7AEC4D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:18:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql709-0001BO-29; Tue, 26 Sep 2023 08:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1ql6z9-0000Yu-Jj; Tue, 26 Sep 2023 08:16:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1ql6z3-0001RS-H4; Tue, 26 Sep 2023 08:16:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QC6BE5005870; Tue, 26 Sep 2023 12:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d7y4aPhhI9vatxttR3dfEcTuidPlvX93JnxIKUK0cOg=;
 b=hbIqMTWhkJ0HaPZDmRhOb+EFpC84sMHDsrQHOAdslukrObb0Jo74Vk/m+sq1upPsPJ0p
 w4EqHAJtTnE5prTL9gJr/Eo0lgFdLsGVgkMjcbr/9w9PWhwV6pXJM7ePTOq4+BK3Q3gC
 wEn+e1NyLRXwnJAy3P90mICvprvfddU+w91Zhd8nbYFmMmYzA1jZrmoa4GjJ36jckGRO
 BeePge5rL5uoAypjwp58A8iCVJ6P1Brn2CiCJD8mqVk4aEvcIxYXkbGpXcjqzN2BPEw7
 84jTo8fWZk53//n6GsD5HF4BzgKsG1JwfjttFD90Jnj5oh9U7RFZeEKFHHjDvhDvvGJe qg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbxnggrbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:54 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QC6GKB006612;
 Tue, 26 Sep 2023 12:15:53 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbxnggrap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QAtViP008427; Tue, 26 Sep 2023 12:15:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabsknfm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38QCFnIL36635384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 12:15:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8283820043;
 Tue, 26 Sep 2023 12:15:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 119C82004E;
 Tue, 26 Sep 2023 12:15:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Sep 2023 12:15:49 +0000 (GMT)
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
Subject: [PATCH v24 03/21] s390x/cpu topology: add topology entries on CPU
 hotplug
Date: Tue, 26 Sep 2023 14:15:16 +0200
Message-Id: <20230926121534.406035-4-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926121534.406035-1-nsg@linux.ibm.com>
References: <20230926121534.406035-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 76B4KMuI-lW4DMw3gPKNpM4pFTUF8pBL
X-Proofpoint-ORIG-GUID: L9zFfN0WUwISrjo5QHZsGUCVWr--Tv1D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_08,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

The topology information are attributes of the CPU and are
specified during the CPU device creation.

On hot plug we:
- calculate the default values for the topology for drawers,
  books and sockets in the case they are not specified.
- verify the CPU attributes
- check that we have still room on the desired socket

The possibility to insert a CPU in a mask is dependent on the
number of cores allowed in a socket, a book or a drawer, the
checking is done during the hot plug of the CPU to have an
immediate answer.

If the complete topology is not specified, the core is added
in the physical topology based on its core ID and it gets
defaults values for the modifier attributes.

This way, starting QEMU without specifying the topology can
still get some advantage of the CPU topology.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 MAINTAINERS                     |   6 +
 include/hw/s390x/cpu-topology.h |  54 +++++++
 hw/s390x/cpu-topology.c         | 259 ++++++++++++++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c      |  22 ++-
 hw/s390x/meson.build            |   1 +
 5 files changed, 340 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/s390x/cpu-topology.h
 create mode 100644 hw/s390x/cpu-topology.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 355b1960ce..c5a5303f61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1691,6 +1691,12 @@ F: hw/s390x/event-facility.c
 F: hw/s390x/sclp*.c
 L: qemu-s390x@nongnu.org
 
+S390 CPU topology
+M: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
+S: Supported
+F: include/hw/s390x/cpu-topology.h
+F: hw/s390x/cpu-topology.c
+
 X86 Machines
 ------------
 PC
diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
new file mode 100644
index 0000000000..97b0af2795
--- /dev/null
+++ b/include/hw/s390x/cpu-topology.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * CPU Topology
+ *
+ * Copyright IBM Corp. 2022, 2023
+ * Author(s): Pierre Morel <pmorel@linux.ibm.com>
+ *
+ */
+#ifndef HW_S390X_CPU_TOPOLOGY_H
+#define HW_S390X_CPU_TOPOLOGY_H
+
+#ifndef CONFIG_USER_ONLY
+
+#include "qemu/queue.h"
+#include "hw/boards.h"
+#include "qapi/qapi-types-machine-target.h"
+
+typedef struct S390Topology {
+    uint8_t *cores_per_socket;
+} S390Topology;
+
+#ifdef CONFIG_KVM
+bool s390_has_topology(void);
+void s390_topology_setup_cpu(MachineState *ms, S390CPU *cpu, Error **errp);
+#else
+static inline bool s390_has_topology(void)
+{
+       return false;
+}
+static inline void s390_topology_setup_cpu(MachineState *ms,
+                                           S390CPU *cpu,
+                                           Error **errp) {}
+#endif
+
+extern S390Topology s390_topology;
+
+static inline int s390_std_socket(int n, CpuTopology *smp)
+{
+    return (n / smp->cores) % smp->sockets;
+}
+
+static inline int s390_std_book(int n, CpuTopology *smp)
+{
+    return (n / (smp->cores * smp->sockets)) % smp->books;
+}
+
+static inline int s390_std_drawer(int n, CpuTopology *smp)
+{
+    return (n / (smp->cores * smp->sockets * smp->books)) % smp->drawers;
+}
+
+#endif /* CONFIG_USER_ONLY */
+
+#endif
diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
new file mode 100644
index 0000000000..189fcc5334
--- /dev/null
+++ b/hw/s390x/cpu-topology.c
@@ -0,0 +1,259 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * CPU Topology
+ *
+ * Copyright IBM Corp. 2022, 2023
+ * Author(s): Pierre Morel <pmorel@linux.ibm.com>
+ *
+ * S390 topology handling can be divided in two parts:
+ *
+ * - The first part in this file is taking care of all common functions
+ *   used by KVM and TCG to create and modify the topology.
+ *
+ * - The second part, building the topology information data for the
+ *   guest with CPU and KVM specificity will be implemented inside
+ *   the target/s390/kvm sub tree.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/qdev-properties.h"
+#include "hw/boards.h"
+#include "target/s390x/cpu.h"
+#include "hw/s390x/s390-virtio-ccw.h"
+#include "hw/s390x/cpu-topology.h"
+
+/*
+ * s390_topology is used to keep the topology information.
+ * .cores_per_socket: tracks information on the count of cores
+ *                    per socket.
+ */
+S390Topology s390_topology = {
+    /* will be initialized after the CPU model is realized */
+    .cores_per_socket = NULL,
+};
+
+/**
+ * s390_socket_nb:
+ * @cpu: s390x CPU
+ *
+ * Returns the socket number used inside the cores_per_socket array
+ * for a topology tree entry
+ */
+static int s390_socket_nb_from_ids(int drawer_id, int book_id, int socket_id)
+{
+    return (drawer_id * current_machine->smp.books + book_id) *
+           current_machine->smp.sockets + socket_id;
+}
+
+/**
+ * s390_socket_nb:
+ * @cpu: s390x CPU
+ *
+ * Returns the socket number used inside the cores_per_socket array
+ * for a cpu.
+ */
+static int s390_socket_nb(S390CPU *cpu)
+{
+    return s390_socket_nb_from_ids(cpu->env.drawer_id, cpu->env.book_id,
+                                   cpu->env.socket_id);
+}
+
+/**
+ * s390_has_topology:
+ *
+ * Return: true if the topology is supported by the machine.
+ */
+bool s390_has_topology(void)
+{
+    return false;
+}
+
+/**
+ * s390_topology_init:
+ * @ms: the machine state where the machine topology is defined
+ *
+ * Keep track of the machine topology.
+ *
+ * Allocate an array to keep the count of cores per socket.
+ * The index of the array starts at socket 0 from book 0 and
+ * drawer 0 up to the maximum allowed by the machine topology.
+ */
+static void s390_topology_init(MachineState *ms)
+{
+    CpuTopology *smp = &ms->smp;
+
+    s390_topology.cores_per_socket = g_new0(uint8_t, smp->sockets *
+                                            smp->books * smp->drawers);
+}
+
+/**
+ * s390_topology_cpu_default:
+ * @cpu: pointer to a S390CPU
+ * @errp: Error pointer
+ *
+ * Setup the default topology if no attributes are already set.
+ * Passing a CPU with some, but not all, attributes set is considered
+ * an error.
+ *
+ * The function calculates the (drawer_id, book_id, socket_id)
+ * topology by filling the cores starting from the first socket
+ * (0, 0, 0) up to the last (smp->drawers, smp->books, smp->sockets).
+ *
+ * CPU type and dedication have defaults values set in the
+ * s390x_cpu_properties, entitlement must be adjust depending on the
+ * dedication.
+ *
+ * Returns false if it is impossible to setup a default topology
+ * true otherwise.
+ */
+static bool s390_topology_cpu_default(S390CPU *cpu, Error **errp)
+{
+    CpuTopology *smp = &current_machine->smp;
+    CPUS390XState *env = &cpu->env;
+
+    /* All geometry topology attributes must be set or all unset */
+    if ((env->socket_id < 0 || env->book_id < 0 || env->drawer_id < 0) &&
+        (env->socket_id >= 0 || env->book_id >= 0 || env->drawer_id >= 0)) {
+        error_setg(errp,
+                   "Please define all or none of the topology geometry attributes");
+        return false;
+    }
+
+    /* If one value is unset all are unset -> calculate defaults */
+    if (env->socket_id < 0) {
+        env->socket_id = s390_std_socket(env->core_id, smp);
+        env->book_id = s390_std_book(env->core_id, smp);
+        env->drawer_id = s390_std_drawer(env->core_id, smp);
+    }
+
+    /*
+     * When the user specifies the entitlement as 'auto' on the command line,
+     * QEMU will set the entitlement as:
+     * Medium when the CPU is not dedicated.
+     * High when dedicated is true.
+     */
+    if (env->entitlement == S390_CPU_ENTITLEMENT_AUTO) {
+        if (env->dedicated) {
+            env->entitlement = S390_CPU_ENTITLEMENT_HIGH;
+        } else {
+            env->entitlement = S390_CPU_ENTITLEMENT_MEDIUM;
+        }
+    }
+    return true;
+}
+
+/**
+ * s390_topology_check:
+ * @socket_id: socket to check
+ * @book_id: book to check
+ * @drawer_id: drawer to check
+ * @entitlement: entitlement to check
+ * @dedicated: dedication to check
+ * @errp: Error pointer
+ *
+ * The function checks if the topology
+ * attributes fits inside the system topology.
+ *
+ * Returns false if the specified topology does not match with
+ * the machine topology.
+ */
+static bool s390_topology_check(uint16_t socket_id, uint16_t book_id,
+                                uint16_t drawer_id, uint16_t entitlement,
+                                bool dedicated, Error **errp)
+{
+    CpuTopology *smp = &current_machine->smp;
+
+    if (socket_id >= smp->sockets) {
+        error_setg(errp, "Unavailable socket: %d", socket_id);
+        return false;
+    }
+    if (book_id >= smp->books) {
+        error_setg(errp, "Unavailable book: %d", book_id);
+        return false;
+    }
+    if (drawer_id >= smp->drawers) {
+        error_setg(errp, "Unavailable drawer: %d", drawer_id);
+        return false;
+    }
+    if (entitlement >= S390_CPU_ENTITLEMENT__MAX) {
+        error_setg(errp, "Unknown entitlement: %d", entitlement);
+        return false;
+    }
+    if (dedicated && (entitlement == S390_CPU_ENTITLEMENT_LOW ||
+                      entitlement == S390_CPU_ENTITLEMENT_MEDIUM)) {
+        error_setg(errp, "A dedicated CPU implies high entitlement");
+        return false;
+    }
+    return true;
+}
+
+/**
+ * s390_update_cpu_props:
+ * @ms: the machine state
+ * @cpu: the CPU for which to update the properties from the environment.
+ *
+ */
+static void s390_update_cpu_props(MachineState *ms, S390CPU *cpu)
+{
+    CpuInstanceProperties *props;
+
+    props = &ms->possible_cpus->cpus[cpu->env.core_id].props;
+
+    props->socket_id = cpu->env.socket_id;
+    props->book_id = cpu->env.book_id;
+    props->drawer_id = cpu->env.drawer_id;
+}
+
+/**
+ * s390_topology_setup_cpu:
+ * @ms: MachineState used to initialize the topology structure on
+ *      first call.
+ * @cpu: the new S390CPU to insert in the topology structure
+ * @errp: the error pointer
+ *
+ * Called from CPU hotplug to check and setup the CPU attributes
+ * before the CPU is inserted in the topology.
+ * There is no need to update the MTCR explicitly here because it
+ * will be updated by KVM on creation of the new CPU.
+ */
+void s390_topology_setup_cpu(MachineState *ms, S390CPU *cpu, Error **errp)
+{
+    int entry;
+
+    /*
+     * We do not want to initialize the topology if the CPU model
+     * does not support topology, consequently, we have to wait for
+     * the first CPU to be realized, which realizes the CPU model
+     * to initialize the topology structures.
+     *
+     * s390_topology_setup_cpu() is called from the CPU hotplug.
+     */
+    if (!s390_topology.cores_per_socket) {
+        s390_topology_init(ms);
+    }
+
+    if (!s390_topology_cpu_default(cpu, errp)) {
+        return;
+    }
+
+    if (!s390_topology_check(cpu->env.socket_id, cpu->env.book_id,
+                             cpu->env.drawer_id, cpu->env.entitlement,
+                             cpu->env.dedicated, errp)) {
+        return;
+    }
+
+    /* Do we still have space in the socket */
+    entry = s390_socket_nb(cpu);
+    if (s390_topology.cores_per_socket[entry] >= current_machine->smp.cores) {
+        error_setg(errp, "No more space on this socket");
+        return;
+    }
+
+    /* Update the count of cores in sockets */
+    s390_topology.cores_per_socket[entry] += 1;
+
+    /* topology tree is reflected in props */
+    s390_update_cpu_props(ms, cpu);
+}
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c1123a9b45..7fe2bce20c 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -45,6 +45,7 @@
 #include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
 #include "qapi/visitor.h"
+#include "hw/s390x/cpu-topology.h"
 
 static Error *pv_mig_blocker;
 
@@ -309,10 +310,18 @@ static void s390_cpu_plug(HotplugHandler *hotplug_dev,
 {
     MachineState *ms = MACHINE(hotplug_dev);
     S390CPU *cpu = S390_CPU(dev);
+    ERRP_GUARD();
 
     g_assert(!ms->possible_cpus->cpus[cpu->env.core_id].cpu);
     ms->possible_cpus->cpus[cpu->env.core_id].cpu = OBJECT(dev);
 
+    if (s390_has_topology()) {
+        s390_topology_setup_cpu(ms, cpu, errp);
+        if (*errp) {
+            return;
+        }
+    }
+
     if (dev->hotplugged) {
         raise_irq_cpu_hotplug();
     }
@@ -562,11 +571,20 @@ static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
     for (i = 0; i < ms->possible_cpus->len; i++) {
+        CpuInstanceProperties *props = &ms->possible_cpus->cpus[i].props;
+
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id = i;
-        ms->possible_cpus->cpus[i].props.has_core_id = true;
-        ms->possible_cpus->cpus[i].props.core_id = i;
+
+        props->has_core_id = true;
+        props->core_id = i;
+        props->has_socket_id = true;
+        props->socket_id = s390_std_socket(i, &ms->smp);
+        props->has_book_id = true;
+        props->book_id = s390_std_book(i, &ms->smp);
+        props->has_drawer_id = true;
+        props->drawer_id = s390_std_drawer(i, &ms->smp);
     }
 
     return ms->possible_cpus;
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 6fd096813a..482fd13420 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -23,6 +23,7 @@ s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
   's390-skeys-kvm.c',
   's390-stattrib-kvm.c',
   's390-pci-kvm.c',
+  'cpu-topology.c',
 ))
 s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
   'tod-tcg.c',
-- 
2.39.2


