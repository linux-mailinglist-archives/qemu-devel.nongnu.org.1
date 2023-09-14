Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF3E7A036F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:11:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglC5-0007m3-0e; Thu, 14 Sep 2023 08:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qglBf-0007VC-C4; Thu, 14 Sep 2023 08:11:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qglBV-00025s-LF; Thu, 14 Sep 2023 08:11:11 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38EC6m4W004923; Thu, 14 Sep 2023 12:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XB068evvRakaTMeH4zf4SNkxbq7Fkqy0L2iaXz3IFjE=;
 b=eZXzLoSam1cMt8YZJlJKJ9/sjt8U7Gv+wAo3Mh56vWCsGdVGr/uVQnO7/7m+A9I/nPg5
 OEje3eapDjpSZzThDMoLseefv9ZfF1nP2sam1QjTz5UPUqvxew7+YKBAzhh6vJJipqay
 GtMfTYPrtxmx0xhBT/UG+HgbfUJQD0/Ne2qLPtlihKW3hnlW0GiNCWbYb9nurlB45AS9
 5g4dNW8XkQ4beBwdcWSQmB8CD65mIEYZfWKrCoZNvAWq6gf7IriMWDwMn+3HIjPZothg
 DJnhO6/WtomAyMNklAzoUxhnh125DdMJk+KShkRWy1CU29R8XYKMNZ8tYM19Y0XLMcJb GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t41h7gwe0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 12:10:44 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38EC6siL005445;
 Thu, 14 Sep 2023 12:08:34 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t41h7gj1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 12:08:34 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38E9beiB011971; Thu, 14 Sep 2023 12:06:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r2a6j0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 12:06:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38EC6uqn17760992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 12:06:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B1F92004E;
 Thu, 14 Sep 2023 12:06:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D47C920076;
 Thu, 14 Sep 2023 12:06:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 14 Sep 2023 12:06:55 +0000 (GMT)
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
Subject: [PATCH v23 03/20] target/s390x/cpu topology: handle STSI(15) and
 build the SYSIB
Date: Thu, 14 Sep 2023 14:06:33 +0200
Message-Id: <20230914120650.1318932-4-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914120650.1318932-1-nsg@linux.ibm.com>
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7cYz9FQcRuMIbzT_keAnlGnsPMeIVpB7
X-Proofpoint-ORIG-GUID: bUdAY7HL3TEScjezx7KIsGYLLDTdK8h4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140103
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

On interception of STSI(15.1.x) the System Information Block
(SYSIB) is built from the list of pre-ordered topology entries.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 MAINTAINERS                      |   1 +
 qapi/machine-target.json         |  14 ++
 include/hw/s390x/cpu-topology.h  |  23 +++
 include/hw/s390x/sclp.h          |   1 +
 target/s390x/cpu.h               |  75 +++++++
 hw/s390x/cpu-topology.c          |   2 +
 target/s390x/kvm/kvm.c           |   5 +-
 target/s390x/kvm/stsi-topology.c | 338 +++++++++++++++++++++++++++++++
 target/s390x/kvm/meson.build     |   3 +-
 9 files changed, 460 insertions(+), 2 deletions(-)
 create mode 100644 target/s390x/kvm/stsi-topology.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c6599a55b..17b92fe3ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1702,6 +1702,7 @@ M: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
 S: Supported
 F: include/hw/s390x/cpu-topology.h
 F: hw/s390x/cpu-topology.c
+F: target/s390x/kvm/stsi-topology.c
 
 X86 Machines
 ------------
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index f0a6b72414..0d45a590ce 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -361,3 +361,17 @@
                    'TARGET_MIPS',
                    'TARGET_LOONGARCH64',
                    'TARGET_RISCV' ] } }
+
+##
+# @CpuS390Polarization:
+#
+# An enumeration of cpu polarization that can be assumed by a virtual
+# S390 CPU
+#
+# Since: 8.2
+##
+{ 'enum': 'CpuS390Polarization',
+  'prefix': 'S390_CPU_POLARIZATION',
+  'data': [ 'horizontal', 'vertical' ],
+    'if': 'TARGET_S390X'
+}
diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
index 97b0af2795..350c7ea8aa 100644
--- a/include/hw/s390x/cpu-topology.h
+++ b/include/hw/s390x/cpu-topology.h
@@ -15,10 +15,33 @@
 #include "hw/boards.h"
 #include "qapi/qapi-types-machine-target.h"
 
+#define S390_TOPOLOGY_CPU_IFL   0x03
+
+typedef struct s390_topology_id {
+    uint8_t sentinel;
+    uint8_t drawer;
+    uint8_t book;
+    uint8_t socket;
+    uint8_t type;
+    uint8_t vertical:1;
+    uint8_t entitlement:2;
+    uint8_t dedicated;
+    uint8_t origin;
+} s390_topology_id;
+
+typedef struct S390TopologyEntry {
+    QTAILQ_ENTRY(S390TopologyEntry) next;
+    s390_topology_id id;
+    uint64_t mask;
+} S390TopologyEntry;
+
 typedef struct S390Topology {
     uint8_t *cores_per_socket;
+    CpuS390Polarization polarization;
 } S390Topology;
 
+typedef QTAILQ_HEAD(, S390TopologyEntry) S390TopologyList;
+
 #ifdef CONFIG_KVM
 bool s390_has_topology(void);
 void s390_topology_setup_cpu(MachineState *ms, S390CPU *cpu, Error **errp);
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index cf1f2efae2..c49051e17e 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -112,6 +112,7 @@ typedef struct CPUEntry {
 } QEMU_PACKED CPUEntry;
 
 #define SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET     128
+#define SCLP_READ_SCP_INFO_MNEST                2
 typedef struct ReadInfo {
     SCCBHeader h;
     uint16_t rnmax;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index dfcc1aa1fc..c1ba5c46d6 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -571,6 +571,29 @@ typedef struct SysIB_322 {
 } SysIB_322;
 QEMU_BUILD_BUG_ON(sizeof(SysIB_322) != 4096);
 
+/*
+ * Topology Magnitude fields (MAG) indicates the maximum number of
+ * topology list entries (TLE) at the corresponding nesting level.
+ */
+#define S390_TOPOLOGY_MAG  6
+#define S390_TOPOLOGY_MAG6 0
+#define S390_TOPOLOGY_MAG5 1
+#define S390_TOPOLOGY_MAG4 2
+#define S390_TOPOLOGY_MAG3 3
+#define S390_TOPOLOGY_MAG2 4
+#define S390_TOPOLOGY_MAG1 5
+/* Configuration topology */
+typedef struct SysIB_151x {
+    uint8_t  reserved0[2];
+    uint16_t length;
+    uint8_t  mag[S390_TOPOLOGY_MAG];
+    uint8_t  reserved1;
+    uint8_t  mnest;
+    uint32_t reserved2;
+    char tle[];
+} SysIB_151x;
+QEMU_BUILD_BUG_ON(sizeof(SysIB_151x) != 16);
+
 typedef union SysIB {
     SysIB_111 sysib_111;
     SysIB_121 sysib_121;
@@ -578,9 +601,61 @@ typedef union SysIB {
     SysIB_221 sysib_221;
     SysIB_222 sysib_222;
     SysIB_322 sysib_322;
+    SysIB_151x sysib_151x;
 } SysIB;
 QEMU_BUILD_BUG_ON(sizeof(SysIB) != 4096);
 
+/*
+ * CPU Topology List provided by STSI with fc=15 provides a list
+ * of two different Topology List Entries (TLE) types to specify
+ * the topology hierarchy.
+ *
+ * - Container Topology List Entry
+ *   Defines a container to contain other Topology List Entries
+ *   of any type, nested containers or CPU.
+ * - CPU Topology List Entry
+ *   Specifies the CPUs position, type, entitlement and polarization
+ *   of the CPUs contained in the last Container TLE.
+ *
+ * There can be theoretically up to five levels of containers, QEMU
+ * uses only three levels, the drawer's, book's and socket's level.
+ *
+ * A container with a nesting level (NL) greater than 1 can only
+ * contain another container of nesting level NL-1.
+ *
+ * A container of nesting level 1 (socket), contains as many CPU TLE
+ * as needed to describe the position and qualities of all CPUs inside
+ * the container.
+ * The qualities of a CPU are polarization, entitlement and type.
+ *
+ * The CPU TLE defines the position of the CPUs of identical qualities
+ * using a 64bits mask which first bit has its offset defined by
+ * the CPU address origin field of the CPU TLE like in:
+ * CPU address = origin * 64 + bit position within the mask
+ */
+/* Container type Topology List Entry */
+typedef struct SYSIBContainerListEntry {
+        uint8_t nl;
+        uint8_t reserved[6];
+        uint8_t id;
+} SYSIBContainerListEntry;
+QEMU_BUILD_BUG_ON(sizeof(SYSIBContainerListEntry) != 8);
+
+/* CPU type Topology List Entry */
+typedef struct SysIBCPUListEntry {
+        uint8_t nl;
+        uint8_t reserved0[3];
+#define SYSIB_TLE_POLARITY_MASK 0x03
+#define SYSIB_TLE_DEDICATED     0x04
+        uint8_t flags;
+        uint8_t type;
+        uint16_t origin;
+        uint64_t mask;
+} SysIBCPUListEntry;
+QEMU_BUILD_BUG_ON(sizeof(SysIBCPUListEntry) != 16);
+
+void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t ar, uintptr_t ra);
+
 /* MMU defines */
 #define ASCE_ORIGIN           (~0xfffULL) /* segment table origin             */
 #define ASCE_SUBSPACE         0x200       /* subspace group control           */
diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
index 189fcc5334..9bf13a6ebf 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -28,10 +28,12 @@
  * s390_topology is used to keep the topology information.
  * .cores_per_socket: tracks information on the count of cores
  *                    per socket.
+ * .polarization: tracks machine polarization.
  */
 S390Topology s390_topology = {
     /* will be initialized after the CPU model is realized */
     .cores_per_socket = NULL,
+    .polarization = S390_CPU_POLARIZATION_HORIZONTAL,
 };
 
 /**
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 852fbd0df7..56b31b8aae 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1911,9 +1911,12 @@ static int handle_stsi(S390CPU *cpu)
         if (run->s390_stsi.sel1 != 2 || run->s390_stsi.sel2 != 2) {
             return 0;
         }
-        /* Only sysib 3.2.2 needs post-handling for now. */
         insert_stsi_3_2_2(cpu, run->s390_stsi.addr, run->s390_stsi.ar);
         return 0;
+    case 15:
+        insert_stsi_15_1_x(cpu, run->s390_stsi.sel2, run->s390_stsi.addr,
+                           run->s390_stsi.ar, RA_IGNORED);
+        return 0;
     default:
         return 0;
     }
diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-topology.c
new file mode 100644
index 0000000000..22bac2b834
--- /dev/null
+++ b/target/s390x/kvm/stsi-topology.c
@@ -0,0 +1,338 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU S390x CPU Topology
+ *
+ * Copyright IBM Corp. 2022, 2023
+ * Author(s): Pierre Morel <pmorel@linux.ibm.com>
+ *
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/s390x/sclp.h"
+#include "hw/s390x/cpu-topology.h"
+
+QEMU_BUILD_BUG_ON(S390_CPU_ENTITLEMENT_LOW != 1);
+QEMU_BUILD_BUG_ON(S390_CPU_ENTITLEMENT_MEDIUM != 2);
+QEMU_BUILD_BUG_ON(S390_CPU_ENTITLEMENT_HIGH != 3);
+
+/**
+ * fill_container:
+ * @p: The address of the container TLE to fill
+ * @level: The level of nesting for this container
+ * @id: The container receives a unique ID inside its own container
+ *
+ * Returns the next free TLE entry.
+ */
+static char *fill_container(char *p, int level, int id)
+{
+    SYSIBContainerListEntry *tle = (SYSIBContainerListEntry *)p;
+
+    tle->nl = level;
+    tle->id = id;
+    return p + sizeof(*tle);
+}
+
+/**
+ * fill_tle_cpu:
+ * @p: The address of the CPU TLE to fill
+ * @entry: a pointer to the S390TopologyEntry defining this
+ *         CPU container.
+ *
+ * Returns the next free TLE entry.
+ */
+static char *fill_tle_cpu(char *p, S390TopologyEntry *entry)
+{
+    SysIBCPUListEntry *tle = (SysIBCPUListEntry *)p;
+    s390_topology_id topology_id = entry->id;
+
+    tle->nl = 0;
+    tle->flags = 0;
+    if (topology_id.vertical) {
+        tle->flags |= topology_id.entitlement;
+    }
+    if (topology_id.dedicated) {
+        tle->flags |= SYSIB_TLE_DEDICATED;
+    }
+    tle->type = topology_id.type;
+    tle->origin = cpu_to_be16(topology_id.origin * 64);
+    tle->mask = cpu_to_be64(entry->mask);
+    return p + sizeof(*tle);
+}
+
+/*
+ * Macro to check that the size of data after increment
+ * will not get bigger than the size of the SysIB.
+ */
+#define SYSIB_GUARD(data, x) do {       \
+        data += x;                      \
+        if (data > sizeof(SysIB)) {     \
+            return 0;                   \
+        }                               \
+    } while (0)
+
+/**
+ * stsi_topology_fill_sysib:
+ * @p: A pointer to the position of the first TLE
+ * @level: The nested level wanted by the guest
+ *
+ * Fill the SYSIB with the topology information as described in
+ * the PoP, nesting containers as appropriate, with the maximum
+ * nesting limited by @level.
+ *
+ * Return value:
+ * On success: the size of the SysIB_15x after being filled with TLE.
+ * On error: 0 in the case we would overrun the end of the SysIB.
+ */
+static int stsi_topology_fill_sysib(S390TopologyList *topology_list,
+                                    char *p, int level)
+{
+    S390TopologyEntry *entry;
+    int last_drawer = -1;
+    int last_book = -1;
+    int last_socket = -1;
+    int drawer_id = 0;
+    int book_id = 0;
+    int socket_id = 0;
+    int n = sizeof(SysIB_151x);
+
+    QTAILQ_FOREACH(entry, topology_list, next) {
+        bool drawer_change = last_drawer != entry->id.drawer;
+        bool book_change = drawer_change || last_book != entry->id.book;
+        bool socket_change = book_change || last_socket != entry->id.socket;
+
+        if (level > 3 && drawer_change) {
+            SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
+            p = fill_container(p, 3, drawer_id++);
+            book_id = 0;
+        }
+        if (level > 2 && book_change) {
+            SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
+            p = fill_container(p, 2, book_id++);
+            socket_id = 0;
+        }
+        if (socket_change) {
+            SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
+            p = fill_container(p, 1, socket_id++);
+        }
+
+        SYSIB_GUARD(n, sizeof(SysIBCPUListEntry));
+        p = fill_tle_cpu(p, entry);
+        last_drawer = entry->id.drawer;
+        last_book = entry->id.book;
+        last_socket = entry->id.socket;
+    }
+
+    return n;
+}
+
+/**
+ * setup_stsi:
+ * @topology_list: ordered list of groups of CPUs with same properties
+ * @sysib: pointer to a SysIB to be filled with SysIB_151x data
+ * @level: Nested level specified by the guest
+ *
+ * Setup the SYSIB for STSI 15.1, the header as well as the description
+ * of the topology.
+ */
+static int setup_stsi(S390TopologyList *topology_list, SysIB_151x *sysib,
+                      int level)
+{
+    sysib->mnest = level;
+    switch (level) {
+    case 4:
+        sysib->mag[S390_TOPOLOGY_MAG4] = current_machine->smp.drawers;
+        sysib->mag[S390_TOPOLOGY_MAG3] = current_machine->smp.books;
+        sysib->mag[S390_TOPOLOGY_MAG2] = current_machine->smp.sockets;
+        sysib->mag[S390_TOPOLOGY_MAG1] = current_machine->smp.cores;
+        break;
+    case 3:
+        sysib->mag[S390_TOPOLOGY_MAG3] = current_machine->smp.drawers *
+                                         current_machine->smp.books;
+        sysib->mag[S390_TOPOLOGY_MAG2] = current_machine->smp.sockets;
+        sysib->mag[S390_TOPOLOGY_MAG1] = current_machine->smp.cores;
+        break;
+    case 2:
+        sysib->mag[S390_TOPOLOGY_MAG2] = current_machine->smp.drawers *
+                                         current_machine->smp.books *
+                                         current_machine->smp.sockets;
+        sysib->mag[S390_TOPOLOGY_MAG1] = current_machine->smp.cores;
+        break;
+    }
+
+    return stsi_topology_fill_sysib(topology_list, sysib->tle, level);
+}
+
+/**
+ * s390_topology_add_cpu_to_entry:
+ * @entry: Topology entry to setup
+ * @cpu: the S390CPU to add
+ *
+ * Set the core bit inside the topology mask.
+ */
+static void s390_topology_add_cpu_to_entry(S390TopologyEntry *entry,
+                                           S390CPU *cpu)
+{
+    set_bit(63 - (cpu->env.core_id % 64), &entry->mask);
+}
+
+/**
+ * s390_topology_from_cpu:
+ * @cpu: S390CPU to calculate the topology id
+ *
+ * Initialize the topology id from the CPU environment.
+ */
+static s390_topology_id s390_topology_from_cpu(S390CPU *cpu)
+{
+    s390_topology_id topology_id = {
+        .drawer = cpu->env.drawer_id,
+        .book = cpu->env.book_id,
+        .socket = cpu->env.socket_id,
+        .type = S390_TOPOLOGY_CPU_IFL,
+        .vertical = s390_topology.polarization == S390_CPU_POLARIZATION_VERTICAL,
+        .entitlement = cpu->env.entitlement,
+        .dedicated = cpu->env.dedicated,
+        .origin = cpu->env.core_id / 64,
+    };
+
+    return topology_id;
+}
+
+/**
+ * s390_topology_id_cmp:
+ * @l: first s390_topology_id
+ * @r: second s390_topology_id
+ *
+ * Compare two topology ids according to the sorting order specified by the PoP.
+ *
+ * Returns a negative number if the first id is less than, 0 if it is equal to
+ *     and positive if it is larger than the second id.
+ */
+static int s390_topology_id_cmp(const s390_topology_id *l,
+                                const s390_topology_id *r)
+{
+    /*
+     * lexical order, compare less significant values only if more significant
+     * ones are equal
+     */
+    return l->sentinel - r->sentinel ?:
+           l->drawer - r->drawer ?:
+           l->book - r->book ?:
+           l->socket - r->socket ?:
+           l->type - r->type ?:
+           -1 * (l->vertical - r->vertical) ?:
+           -1 * (l->entitlement - r->entitlement) ?:
+           -1 * (l->dedicated - r->dedicated) ?:
+           l->origin - r->origin;
+}
+
+static bool s390_topology_id_eq(const s390_topology_id *l,
+                               const s390_topology_id *r)
+{
+    return !s390_topology_id_cmp(l, r);
+}
+
+static bool s390_topology_id_lt(const s390_topology_id *l,
+                                const s390_topology_id *r)
+{
+    return s390_topology_id_cmp(l, r) < 0;
+}
+
+/**
+ * s390_topology_fill_list_sorted:
+ * @topology_list: list to fill
+ *
+ * Loop over all CPU and insert it at the right place
+ * inside the TLE entry list.
+ * Fill the S390Topology list with entries according to the order
+ * specified by the PoP.
+ */
+static void s390_topology_fill_list_sorted(S390TopologyList *topology_list)
+{
+    CPUState *cs;
+    S390TopologyEntry sentinel = { .id.sentinel = 1 };
+
+    QTAILQ_INIT(topology_list);
+
+    QTAILQ_INSERT_HEAD(topology_list, &sentinel, next);
+
+    CPU_FOREACH(cs) {
+        s390_topology_id id = s390_topology_from_cpu(S390_CPU(cs));
+        S390TopologyEntry *entry = NULL, *tmp;
+
+        QTAILQ_FOREACH(tmp, topology_list, next) {
+            if (s390_topology_id_eq(&id, &tmp->id)) {
+                entry = tmp;
+                break;
+            } else if (s390_topology_id_lt(&id, &tmp->id)) {
+                entry = g_malloc0(sizeof(*entry));
+                entry->id = id;
+                QTAILQ_INSERT_BEFORE(tmp, entry, next);
+                break;
+            }
+        }
+        assert(entry);
+        s390_topology_add_cpu_to_entry(entry, S390_CPU(cs));
+    }
+
+    QTAILQ_REMOVE(topology_list, &sentinel, next);
+}
+
+/**
+ * s390_topology_empty_list:
+ *
+ * Clear all entries in the S390Topology list.
+ */
+static void s390_topology_empty_list(S390TopologyList *topology_list)
+{
+    S390TopologyEntry *entry = NULL;
+    S390TopologyEntry *tmp = NULL;
+
+    QTAILQ_FOREACH_SAFE(entry, topology_list, next, tmp) {
+        QTAILQ_REMOVE(topology_list, entry, next);
+        g_free(entry);
+    }
+}
+
+/**
+ * insert_stsi_15_1_x:
+ * @cpu: the CPU doing the call for which we set CC
+ * @sel2: the selector 2, containing the nested level
+ * @addr: Guest logical address of the guest SysIB
+ * @ar: the access register number
+ * @ra: the return address
+ *
+ * Emulate STSI 15.1.x, that is, perform all necessary checks and
+ * fill the SYSIB.
+ * In case the topology description is too long to fit into the SYSIB,
+ * set CC=3 and abort without writing the SYSIB.
+ */
+void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t ar, uintptr_t ra)
+{
+    S390TopologyList topology_list;
+    SysIB sysib = {0};
+    int length;
+
+    if (!s390_has_topology() || sel2 < 2 || sel2 > SCLP_READ_SCP_INFO_MNEST) {
+        setcc(cpu, 3);
+        return;
+    }
+
+    s390_topology_fill_list_sorted(&topology_list);
+
+    length = setup_stsi(&topology_list, &sysib.sysib_151x, sel2);
+
+    if (!length) {
+        s390_topology_empty_list(&topology_list);
+        setcc(cpu, 3);
+        return;
+    }
+
+    sysib.sysib_151x.length = cpu_to_be16(length);
+    if (!s390_cpu_virt_mem_write(cpu, addr, ar, &sysib, length)) {
+        setcc(cpu, 0);
+    } else {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
+    }
+
+    s390_topology_empty_list(&topology_list);
+}
diff --git a/target/s390x/kvm/meson.build b/target/s390x/kvm/meson.build
index d6aca590ae..588a9aa737 100644
--- a/target/s390x/kvm/meson.build
+++ b/target/s390x/kvm/meson.build
@@ -1,7 +1,8 @@
 
 s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
   'pv.c',
-  'kvm.c'
+  'kvm.c',
+  'stsi-topology.c'
 ), if_false: files(
   'stubs.c'
 ))
-- 
2.39.2


