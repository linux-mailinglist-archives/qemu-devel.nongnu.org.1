Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E749B7CDCF5
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:15:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6IH-0006kY-1z; Wed, 18 Oct 2023 09:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6Ha-0004pX-IA
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HW-00084a-BF
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4taefV76TunAA0qwymOAdI8JoajvVPkEpE8hFW9JmM=;
 b=gQTbAs4xRaIcTlie6/r5mwB45j0r/CdoxOho+FZhG6N9RVOUaxVvd0fkR73jorJTuW8qHm
 hGcwQG7eCweBO0ryFKo3LIvANcYv3BeU3pnCueL6RG280GFTqA0s20h4gV2CGDfbNVXtvv
 d1T385rKE3EZl+w5vXi0UzbkHh0CM8s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-DAR-SPHWO6WT5C5KZyXXBw-1; Wed, 18 Oct 2023 09:07:56 -0400
X-MC-Unique: DAR-SPHWO6WT5C5KZyXXBw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB18685A58C;
 Wed, 18 Oct 2023 13:07:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1ED520268C8;
 Wed, 18 Oct 2023 13:07:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 14/25] docs/s390x/cpu topology: document s390x cpu topology
Date: Wed, 18 Oct 2023 15:07:05 +0200
Message-ID: <20231018130716.286638-15-thuth@redhat.com>
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

Add some basic examples for the definition of cpu topology
in s390x.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20231016183925.2384704-15-nsg@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                        |   2 +
 docs/devel/index-internals.rst     |   1 +
 docs/devel/s390-cpu-topology.rst   | 170 ++++++++++++++++++++
 docs/system/s390x/cpu-topology.rst | 244 +++++++++++++++++++++++++++++
 docs/system/target-s390x.rst       |   1 +
 qapi/machine.json                  |   2 +
 6 files changed, 420 insertions(+)
 create mode 100644 docs/devel/s390-cpu-topology.rst
 create mode 100644 docs/system/s390x/cpu-topology.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index cfc37e9af7..de8d9f5104 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1716,6 +1716,8 @@ S: Supported
 F: include/hw/s390x/cpu-topology.h
 F: hw/s390x/cpu-topology.c
 F: target/s390x/kvm/stsi-topology.c
+F: docs/devel/s390-cpu-topology.rst
+F: docs/system/s390x/cpu-topology.rst
 
 X86 Machines
 ------------
diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index e1a93df263..6f81df92bc 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -14,6 +14,7 @@ Details about QEMU's various subsystems including how to add features to them.
    migration
    multi-process
    reset
+   s390-cpu-topology
    s390-dasd-ipl
    tracing
    vfio-migration
diff --git a/docs/devel/s390-cpu-topology.rst b/docs/devel/s390-cpu-topology.rst
new file mode 100644
index 0000000000..9eab28d5e5
--- /dev/null
+++ b/docs/devel/s390-cpu-topology.rst
@@ -0,0 +1,170 @@
+QAPI interface for S390 CPU topology
+====================================
+
+The following sections will explain the QAPI interface for S390 CPU topology
+with the help of exemplary output.
+For this, let's assume that QEMU has been started with the following
+command, defining 4 CPUs, where CPU[0] is defined by the -smp argument and will
+have default values:
+
+.. code-block:: bash
+
+ qemu-system-s390x \
+    -enable-kvm \
+    -cpu z14,ctop=on \
+    -smp 1,drawers=3,books=3,sockets=2,cores=2,maxcpus=36 \
+    -device z14-s390x-cpu,core-id=19,entitlement=high \
+    -device z14-s390x-cpu,core-id=11,entitlement=low \
+    -device z14-s390x-cpu,core-id=112,entitlement=high \
+   ...
+
+Additions to query-cpus-fast
+----------------------------
+
+The command query-cpus-fast allows querying the topology tree and
+modifiers for all configured vCPUs.
+
+.. code-block:: QMP
+
+ { "execute": "query-cpus-fast" }
+ {
+  "return": [
+    {
+      "dedicated": false,
+      "thread-id": 536993,
+      "props": {
+        "core-id": 0,
+        "socket-id": 0,
+        "drawer-id": 0,
+        "book-id": 0
+      },
+      "cpu-state": "operating",
+      "entitlement": "medium",
+      "qom-path": "/machine/unattached/device[0]",
+      "cpu-index": 0,
+      "target": "s390x"
+    },
+    {
+      "dedicated": false,
+      "thread-id": 537003,
+      "props": {
+        "core-id": 19,
+        "socket-id": 1,
+        "drawer-id": 0,
+        "book-id": 2
+      },
+      "cpu-state": "operating",
+      "entitlement": "high",
+      "qom-path": "/machine/peripheral-anon/device[0]",
+      "cpu-index": 19,
+      "target": "s390x"
+    },
+    {
+      "dedicated": false,
+      "thread-id": 537004,
+      "props": {
+        "core-id": 11,
+        "socket-id": 1,
+        "drawer-id": 0,
+        "book-id": 1
+      },
+      "cpu-state": "operating",
+      "entitlement": "low",
+      "qom-path": "/machine/peripheral-anon/device[1]",
+      "cpu-index": 11,
+      "target": "s390x"
+    },
+    {
+      "dedicated": true,
+      "thread-id": 537005,
+      "props": {
+        "core-id": 112,
+        "socket-id": 0,
+        "drawer-id": 3,
+        "book-id": 2
+      },
+      "cpu-state": "operating",
+      "entitlement": "high",
+      "qom-path": "/machine/peripheral-anon/device[2]",
+      "cpu-index": 112,
+      "target": "s390x"
+    }
+  ]
+ }
+
+
+QAPI command: set-cpu-topology
+------------------------------
+
+The command set-cpu-topology allows modifying the topology tree
+or the topology modifiers of a vCPU in the configuration.
+
+.. code-block:: QMP
+
+    { "execute": "set-cpu-topology",
+      "arguments": {
+         "core-id": 11,
+         "socket-id": 0,
+         "book-id": 0,
+         "drawer-id": 0,
+         "entitlement": "low",
+         "dedicated": false
+      }
+    }
+    {"return": {}}
+
+The core-id parameter is the only mandatory parameter and every
+unspecified parameter keeps its previous value.
+
+QAPI event CPU_POLARIZATION_CHANGE
+----------------------------------
+
+When a guest requests a modification of the polarization,
+QEMU sends a CPU_POLARIZATION_CHANGE event.
+
+When requesting the change, the guest only specifies horizontal or
+vertical polarization.
+It is the job of the entity administrating QEMU to set the dedication and fine
+grained vertical entitlement in response to this event.
+
+Note that a vertical polarized dedicated vCPU can only have a high
+entitlement, giving 6 possibilities for vCPU polarization:
+
+- Horizontal
+- Horizontal dedicated
+- Vertical low
+- Vertical medium
+- Vertical high
+- Vertical high dedicated
+
+Example of the event received when the guest issues the CPU instruction
+Perform Topology Function PTF(0) to request an horizontal polarization:
+
+.. code-block:: QMP
+
+  {
+    "timestamp": {
+      "seconds": 1687870305,
+      "microseconds": 566299
+    },
+    "event": "CPU_POLARIZATION_CHANGE",
+    "data": {
+      "polarization": "horizontal"
+    }
+  }
+
+QAPI query command: query-s390x-cpu-polarization
+------------------------------------------------
+
+The query command query-s390x-cpu-polarization returns the current
+CPU polarization of the machine.
+In this case the guest previously issued a PTF(1) to request vertical polarization:
+
+.. code-block:: QMP
+
+    { "execute": "query-s390x-cpu-polarization" }
+    {
+        "return": {
+          "polarization": "vertical"
+        }
+    }
diff --git a/docs/system/s390x/cpu-topology.rst b/docs/system/s390x/cpu-topology.rst
new file mode 100644
index 0000000000..5133fdc362
--- /dev/null
+++ b/docs/system/s390x/cpu-topology.rst
@@ -0,0 +1,244 @@
+.. _cpu-topology-s390x:
+
+CPU topology on s390x
+=====================
+
+Since QEMU 8.2, CPU topology on s390x provides up to 3 levels of
+topology containers: drawers, books and sockets. They define a
+tree-shaped hierarchy.
+
+The socket container has one or more CPU entries.
+Each of these CPU entries consists of a bitmap and three CPU attributes:
+
+- CPU type
+- entitlement
+- dedication
+
+Each bit set in the bitmap correspond to a core-id of a vCPU with matching
+attributes.
+
+This documentation provides general information on S390 CPU topology,
+how to enable it and explains the new CPU attributes.
+For information on how to modify the S390 CPU topology and how to
+monitor polarization changes, see ``docs/devel/s390-cpu-topology.rst``.
+
+Prerequisites
+-------------
+
+To use the CPU topology, you need to run with KVM on a s390x host that
+uses the Linux kernel v6.0 or newer (which provide the so-called
+``KVM_CAP_S390_CPU_TOPOLOGY`` capability that allows QEMU to signal the
+CPU topology facility via the so-called STFLE bit 11 to the VM).
+
+Enabling CPU topology
+---------------------
+
+Currently, CPU topology is only enabled in the host model by default.
+
+Enabling CPU topology in a CPU model is done by setting the CPU flag
+``ctop`` to ``on`` as in:
+
+.. code-block:: bash
+
+   -cpu gen16b,ctop=on
+
+Having the topology disabled by default allows migration between
+old and new QEMU without adding new flags.
+
+Default topology usage
+----------------------
+
+The CPU topology can be specified on the QEMU command line
+with the ``-smp`` or the ``-device`` QEMU command arguments.
+
+Note also that since 7.2 threads are no longer supported in the topology
+and the ``-smp`` command line argument accepts only ``threads=1``.
+
+If none of the containers attributes (drawers, books, sockets) are
+specified for the ``-smp`` flag, the number of these containers
+is 1.
+
+Thus the following two options will result in the same topology:
+
+.. code-block:: bash
+
+    -smp cpus=5,drawer=1,books=1,sockets=8,cores=4,maxcpus=32
+
+and
+
+.. code-block:: bash
+
+    -smp cpus=5,sockets=8,cores=4,maxcpus=32
+
+When a CPU is defined by the ``-smp`` command argument, its position
+inside the topology is calculated by adding the CPUs to the topology
+based on the core-id starting with core-0 at position 0 of socket-0,
+book-0, drawer-0 and filling all CPUs of socket-0 before filling socket-1
+of book-0 and so on up to the last socket of the last book of the last
+drawer.
+
+When a CPU is defined by the ``-device`` command argument, the
+tree topology attributes must all be defined or all not defined.
+
+.. code-block:: bash
+
+    -device gen16b-s390x-cpu,drawer-id=1,book-id=1,socket-id=2,core-id=1
+
+or
+
+.. code-block:: bash
+
+    -device gen16b-s390x-cpu,core-id=1,dedicated=true
+
+If none of the tree attributes (drawer, book, sockets), are specified
+for the ``-device`` argument, like for all CPUs defined with the ``-smp``
+command argument the topology tree attributes will be set by simply
+adding the CPUs to the topology based on the core-id.
+
+QEMU will not try to resolve collisions and will report an error if the
+CPU topology defined explicitly or implicitly on a ``-device``
+argument collides with the definition of a CPU implicitly defined
+on the ``-smp`` argument.
+
+When the topology modifier attributes are not defined for the
+``-device`` command argument they takes following default values:
+
+- dedicated: ``false``
+- entitlement: ``medium``
+
+
+Hot plug
+++++++++
+
+New CPUs can be plugged using the device_add hmp command as in:
+
+.. code-block:: bash
+
+  (qemu) device_add gen16b-s390x-cpu,core-id=9
+
+The placement of the CPU is derived from the core-id as described above.
+
+The topology can of course also be fully defined:
+
+.. code-block:: bash
+
+    (qemu) device_add gen16b-s390x-cpu,drawer-id=1,book-id=1,socket-id=2,core-id=1
+
+
+Examples
+++++++++
+
+In the following machine we define 8 sockets with 4 cores each.
+
+.. code-block:: bash
+
+  $ qemu-system-s390x -m 2G \
+    -cpu gen16b,ctop=on \
+    -smp cpus=5,sockets=8,cores=4,maxcpus=32 \
+    -device host-s390x-cpu,core-id=14 \
+
+A new CPUs can be plugged using the device_add hmp command as before:
+
+.. code-block:: bash
+
+  (qemu) device_add gen16b-s390x-cpu,core-id=9
+
+The core-id defines the placement of the core in the topology by
+starting with core 0 in socket 0 up to maxcpus.
+
+In the example above:
+
+* There are 5 CPUs provided to the guest with the ``-smp`` command line
+  They will take the core-ids 0,1,2,3,4
+  As we have 4 cores in a socket, we have 4 CPUs provided
+  to the guest in socket 0, with core-ids 0,1,2,3.
+  The last CPU, with core-id 4, will be on socket 1.
+
+* the core with ID 14 provided by the ``-device`` command line will
+  be placed in socket 3, with core-id 14
+
+* the core with ID 9 provided by the ``device_add`` qmp command will
+  be placed in socket 2, with core-id 9
+
+
+Polarization, entitlement and dedication
+----------------------------------------
+
+Polarization
+++++++++++++
+
+The polarization affects how the CPUs of a shared host are utilized/distributed
+among guests.
+The guest determines the polarization by using the PTF instruction.
+
+Polarization defines two models of CPU provisioning: horizontal
+and vertical.
+
+The horizontal polarization is the default model on boot and after
+subsystem reset. When horizontal polarization is in effect all vCPUs should
+have about equal resource provisioning.
+
+In the vertical polarization model vCPUs are unequal, but overall more resources
+might be available.
+The guest can make use of the vCPU entitlement information provided by the host
+to optimize kernel thread scheduling.
+
+A subsystem reset puts all vCPU of the configuration into the
+horizontal polarization.
+
+Entitlement
++++++++++++
+
+The vertical polarization specifies that the guest's vCPU can get
+different real CPU provisioning:
+
+- a vCPU with vertical high entitlement specifies that this
+  vCPU gets 100% of the real CPU provisioning.
+
+- a vCPU with vertical medium entitlement specifies that this
+  vCPU shares the real CPU with other vCPUs.
+
+- a vCPU with vertical low entitlement specifies that this
+  vCPU only gets real CPU provisioning when no other vCPUs needs it.
+
+In the case a vCPU with vertical high entitlement does not use
+the real CPU, the unused "slack" can be dispatched to other vCPU
+with medium or low entitlement.
+
+A vCPU can be "dedicated" in which case the vCPU is fully dedicated to a single
+real CPU.
+
+The dedicated bit is an indication of affinity of a vCPU for a real CPU
+while the entitlement indicates the sharing or exclusivity of use.
+
+Defining the topology on the command line
+-----------------------------------------
+
+The topology can entirely be defined using -device cpu statements,
+with the exception of CPU 0 which must be defined with the -smp
+argument.
+
+For example, here we set the position of the cores 1,2,3 to
+drawer 1, book 1, socket 2 and cores 0,9 and 14 to drawer 0,
+book 0, socket 0 without defining entitlement or dedication.
+Core 4 will be set on its default position on socket 1
+(since we have 4 core per socket) and we define it as dedicated and
+with vertical high entitlement.
+
+.. code-block:: bash
+
+  $ qemu-system-s390x -m 2G \
+    -cpu gen16b,ctop=on \
+    -smp cpus=1,sockets=8,cores=4,maxcpus=32 \
+    \
+    -device gen16b-s390x-cpu,drawer-id=1,book-id=1,socket-id=2,core-id=1 \
+    -device gen16b-s390x-cpu,drawer-id=1,book-id=1,socket-id=2,core-id=2 \
+    -device gen16b-s390x-cpu,drawer-id=1,book-id=1,socket-id=2,core-id=3 \
+    \
+    -device gen16b-s390x-cpu,drawer-id=0,book-id=0,socket-id=0,core-id=9 \
+    -device gen16b-s390x-cpu,drawer-id=0,book-id=0,socket-id=0,core-id=14 \
+    \
+    -device gen16b-s390x-cpu,core-id=4,dedicated=on,entitlement=high
+
+The entitlement defined for the CPU 4 will only be used after the guest
+successfully enables vertical polarization by using the PTF instruction.
diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.rst
index f6f11433c7..94c981e732 100644
--- a/docs/system/target-s390x.rst
+++ b/docs/system/target-s390x.rst
@@ -34,3 +34,4 @@ Architectural features
 .. toctree::
    s390x/bootdevices
    s390x/protvirt
+   s390x/cpu-topology
diff --git a/qapi/machine.json b/qapi/machine.json
index b4bd26f716..6c9d2f6dcf 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -909,6 +909,8 @@
 # Which members are optional and which mandatory depends on the
 # architecture and board.
 #
+# For s390x see :ref:`cpu-topology-s390x`.
+#
 # The ids other than the node-id specify the position of the CPU
 # within the CPU topology (as defined by the machine property "smp",
 # thus see also type @SMPConfiguration)
-- 
2.41.0


