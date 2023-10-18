Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D94377CDCC6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6HY-0004Sw-FZ; Wed, 18 Oct 2023 09:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6H5-0004Lm-VX
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:07:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6H4-0007yt-2H
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TppKG0m+yq0DBZlEnNTstB5ilmksDEBfnyvEfeJZYWE=;
 b=SloOeSwJVxYIDc6Z73P9u6+6C77VdKgGmGYFBVv9hRWRRNUHEc+3MHYT/5NMn61Fn68R2N
 9j3sFEzH8C6LCkMJ17gFzC2h+77JbS8dFuLDFpDOQMIpJmHR50bKXYYdWiOteY4/tg8hjd
 KdQXUfYaPC/mWa0xtyjCjdhx4eEuoTU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-BrfbAu2qNoOCX6d3mYgEgw-1; Wed, 18 Oct 2023 09:07:34 -0400
X-MC-Unique: BrfbAu2qNoOCX6d3mYgEgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 249791DD35D5;
 Wed, 18 Oct 2023 13:07:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E921E20268C8;
 Wed, 18 Oct 2023 13:07:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 09/25] qapi/s390x/cpu topology: set-cpu-topology qmp command
Date: Wed, 18 Oct 2023 15:07:00 +0200
Message-ID: <20231018130716.286638-10-thuth@redhat.com>
In-Reply-To: <20231018130716.286638-1-thuth@redhat.com>
References: <20231018130716.286638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20231016183925.2384704-10-nsg@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qapi/machine-target.json |  42 +++++++++++++
 hw/s390x/cpu-topology.c  | 132 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 93cbf1c128..7688f32ffa 100644
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
+# Modify the topology by moving the CPU inside the topology tree,
+# or by changing a modifier attribute of a CPU.
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
+# @unstable: This command is experimental.
+#
+# Returns: Nothing on success.
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
2.41.0


