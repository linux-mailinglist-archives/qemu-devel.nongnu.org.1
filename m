Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CA87BA724
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:55:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRcX-0008Gv-6x; Thu, 05 Oct 2023 12:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qoRcU-00089f-J4; Thu, 05 Oct 2023 12:54:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qoRcP-0007c0-7o; Thu, 05 Oct 2023 12:54:38 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 395GoQaS009656; Thu, 5 Oct 2023 16:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AWVfBGRZQsrVub6S7EWCtm+4ipjd0cMUwu6oFTuPywc=;
 b=kwvbpYCukjTOsKkZoCqT5TmDyhoNV/CYNjrh9kJCqMGMlmlwrsyJ6VCUQYKh9CwPPgWz
 k5xwLT+yCmezWasFn6k+1DZFKKUMlodq+g/42LcK0qX3zSKix3BbI7jlemttaGxCykbJ
 9hUS002cGnxx/rMHom6TZS50yY+yGSit0nMkk0iAupkLCM9MMtphUVq1Sp415pHmfGPT
 tfPXEKXWsVa4R43qj6oltG65koT3mepJVLGoTBcNeLhndfJxQpdxKBEQPjxS3V7wN25v
 JtQyoWwGyiyd01XyfoI9aMqz//QoB6w09DXvhaGkH/ngkumOeCeHOdVumBtBIpEDU6xd vA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj1108845-12
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:54:19 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395FwdaD031828;
 Thu, 5 Oct 2023 16:02:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj08t08p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:02:34 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 395FEwtV025087; Thu, 5 Oct 2023 16:02:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3texcywp7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 16:02:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 395G1xim17433274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Oct 2023 16:01:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B457A2004B;
 Thu,  5 Oct 2023 16:01:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67C612005A;
 Thu,  5 Oct 2023 16:01:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Oct 2023 16:01:59 +0000 (GMT)
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
Subject: [PATCH v25 09/21] qapi/s390x/cpu topology: set-cpu-topology qmp
 command
Date: Thu,  5 Oct 2023 18:01:43 +0200
Message-Id: <20231005160155.1945588-10-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231005160155.1945588-1-nsg@linux.ibm.com>
References: <20231005160155.1945588-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W80m1sUdSEmnEG5fIiZiwiUdYDUt2VZj
X-Proofpoint-ORIG-GUID: m_C2LUpkKFl-8eH2gjLhu3BAcX0c1DdR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_12,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050132
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The modification of the CPU attributes are done through a monitor
command.

It allows to move the core inside the topology tree to optimize
the cache usage in the case the host's hypervisor previously
moved the CPU.

The same command allows to modify the CPU attributes modifiers
like polarization entitlement and the dedicated attribute to notify
the guest if the host admin modified scheduling or dedication of a vCPU.

With this knowledge the guest has the possibility to optimize the
usage of the vCPUs.

The command has a feature unstable for the moment.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 qapi/machine-target.json |  42 +++++++++++++
 hw/s390x/cpu-topology.c  | 132 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 93cbf1c128..3fd8390922 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -4,6 +4,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
 
+{ 'include': 'machine-common.json' }
+
 ##
 # @CpuModelInfo:
 #
@@ -375,3 +377,43 @@
   'data': [ 'horizontal', 'vertical' ],
   'if': 'TARGET_S390X'
 }
+
+##
+# @set-cpu-topology:
+#
+# Modifies the topology by moving the CPU inside the topology
+# tree or by changing a modifier attribute of a CPU.
+# Absent values will not be modified.
+#
+# @core-id: the vCPU ID to be moved
+#
+# @socket-id: destination socket to move the vCPU to
+#
+# @book-id: destination book to move the vCPU to
+#
+# @drawer-id: destination drawer to move the vCPU to
+#
+# @entitlement: entitlement to set
+#
+# @dedicated: whether the provisioning of real to virtual CPU is dedicated
+#
+# Features:
+#
+# @unstable: This command may still be modified.
+#
+# Returns: Nothing on success, the reason on failure.
+#
+# Since: 8.2
+##
+{ 'command': 'set-cpu-topology',
+  'data': {
+      'core-id': 'uint16',
+      '*socket-id': 'uint16',
+      '*book-id': 'uint16',
+      '*drawer-id': 'uint16',
+      '*entitlement': 'CpuS390Entitlement',
+      '*dedicated': 'bool'
+  },
+  'features': [ 'unstable' ],
+  'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
+}
diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
index 4e4c35f6da..f3771f5045 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -23,6 +23,7 @@
 #include "target/s390x/cpu.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/cpu-topology.h"
+#include "qapi/qapi-commands-machine-target.h"
 
 /*
  * s390_topology is used to keep the topology information.
@@ -257,6 +258,29 @@ static bool s390_topology_check(uint16_t socket_id, uint16_t book_id,
     return true;
 }
 
+/**
+ * s390_topology_need_report
+ * @cpu: Current cpu
+ * @drawer_id: future drawer ID
+ * @book_id: future book ID
+ * @socket_id: future socket ID
+ * @entitlement: future entitlement
+ * @dedicated: future dedicated
+ *
+ * A modified topology change report is needed if the topology
+ * tree or the topology attributes change.
+ */
+static bool s390_topology_need_report(S390CPU *cpu, int drawer_id,
+                                      int book_id, int socket_id,
+                                      uint16_t entitlement, bool dedicated)
+{
+    return cpu->env.drawer_id != drawer_id ||
+           cpu->env.book_id != book_id ||
+           cpu->env.socket_id != socket_id ||
+           cpu->env.entitlement != entitlement ||
+           cpu->env.dedicated != dedicated;
+}
+
 /**
  * s390_update_cpu_props:
  * @ms: the machine state
@@ -325,3 +349,111 @@ void s390_topology_setup_cpu(MachineState *ms, S390CPU *cpu, Error **errp)
     /* topology tree is reflected in props */
     s390_update_cpu_props(ms, cpu);
 }
+
+static void s390_change_topology(uint16_t core_id,
+                                 bool has_socket_id, uint16_t socket_id,
+                                 bool has_book_id, uint16_t book_id,
+                                 bool has_drawer_id, uint16_t drawer_id,
+                                 bool has_entitlement,
+                                 CpuS390Entitlement entitlement,
+                                 bool has_dedicated, bool dedicated,
+                                 Error **errp)
+{
+    MachineState *ms = current_machine;
+    int old_socket_entry;
+    int new_socket_entry;
+    bool report_needed;
+    S390CPU *cpu;
+
+    cpu = s390_cpu_addr2state(core_id);
+    if (!cpu) {
+        error_setg(errp, "Core-id %d does not exist!", core_id);
+        return;
+    }
+
+    /* Get attributes not provided from cpu and verify the new topology */
+    if (!has_socket_id) {
+        socket_id = cpu->env.socket_id;
+    }
+    if (!has_book_id) {
+        book_id = cpu->env.book_id;
+    }
+    if (!has_drawer_id) {
+        drawer_id = cpu->env.drawer_id;
+    }
+    if (!has_dedicated) {
+        dedicated = cpu->env.dedicated;
+    }
+
+    /*
+     * When the user specifies the entitlement as 'auto' on the command line,
+     * QEMU will set the entitlement as:
+     * Medium when the CPU is not dedicated.
+     * High when dedicated is true.
+     */
+    if (!has_entitlement || entitlement == S390_CPU_ENTITLEMENT_AUTO) {
+        if (dedicated) {
+            entitlement = S390_CPU_ENTITLEMENT_HIGH;
+        } else {
+            entitlement = S390_CPU_ENTITLEMENT_MEDIUM;
+        }
+    }
+
+    if (!s390_topology_check(socket_id, book_id, drawer_id,
+                             entitlement, dedicated, errp)) {
+        return;
+    }
+
+    /* Check for space on new socket */
+    old_socket_entry = s390_socket_nb(cpu);
+    new_socket_entry = s390_socket_nb_from_ids(drawer_id, book_id, socket_id);
+
+    if (new_socket_entry != old_socket_entry) {
+        if (s390_topology.cores_per_socket[new_socket_entry] >=
+            ms->smp.cores) {
+            error_setg(errp, "No more space on this socket");
+            return;
+        }
+        /* Update the count of cores in sockets */
+        s390_topology.cores_per_socket[new_socket_entry] += 1;
+        s390_topology.cores_per_socket[old_socket_entry] -= 1;
+    }
+
+    /* Check if we will need to report the modified topology */
+    report_needed = s390_topology_need_report(cpu, drawer_id, book_id,
+                                              socket_id, entitlement,
+                                              dedicated);
+
+    /* All checks done, report new topology into the vCPU */
+    cpu->env.drawer_id = drawer_id;
+    cpu->env.book_id = book_id;
+    cpu->env.socket_id = socket_id;
+    cpu->env.dedicated = dedicated;
+    cpu->env.entitlement = entitlement;
+
+    /* topology tree is reflected in props */
+    s390_update_cpu_props(ms, cpu);
+
+    /* Advertise the topology change */
+    if (report_needed) {
+        s390_cpu_topology_set_changed(true);
+    }
+}
+
+void qmp_set_cpu_topology(uint16_t core,
+                          bool has_socket, uint16_t socket,
+                          bool has_book, uint16_t book,
+                          bool has_drawer, uint16_t drawer,
+                          bool has_entitlement, CpuS390Entitlement entitlement,
+                          bool has_dedicated, bool dedicated,
+                          Error **errp)
+{
+    if (!s390_has_topology()) {
+        error_setg(errp, "This machine doesn't support topology");
+        return;
+    }
+
+    s390_change_topology(core, has_socket, socket, has_book, book,
+                         has_drawer, drawer, has_entitlement, entitlement,
+                         has_dedicated, dedicated, errp);
+}
-- 
2.39.2


