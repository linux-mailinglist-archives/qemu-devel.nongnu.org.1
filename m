Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E09CB81A03C
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:49:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwvn-0003X2-Ew; Wed, 20 Dec 2023 08:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFwvj-0003WF-Mb
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFwvh-000671-U4
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703080089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8WphHss/lK1vl0Sn+vcq2/xrKctuCv/0iQ7zUFek6Xs=;
 b=ApXdwmgdE9wcF+ltpqn0l368uG2EpRmSdLkS9Vjc5SCBOc0qOgqSqXq7pJOjYrVRisLWrS
 gXOemHONC8ZqakADX1zKNbpDJk7T8jbk8Wqadkxg7fbRneTa9ssqwsJfsnJRoLRJMPwr6k
 E9pVukjEEBcJnyRaiwseKD4YMm5eN1c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-Tfga9LQVNt-lTjuBeDKg-w-1; Wed, 20 Dec 2023 08:48:05 -0500
X-MC-Unique: Tfga9LQVNt-lTjuBeDKg-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84EAD101A52A;
 Wed, 20 Dec 2023 13:48:05 +0000 (UTC)
Received: from localhost (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01CBA2166B34;
 Wed, 20 Dec 2023 13:48:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 3/4] qdev: add IOThreadVirtQueueMappingList property type
Date: Wed, 20 Dec 2023 08:47:54 -0500
Message-ID: <20231220134755.814917-4-stefanha@redhat.com>
In-Reply-To: <20231220134755.814917-1-stefanha@redhat.com>
References: <20231220134755.814917-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

virtio-blk and virtio-scsi devices will need a way to specify the
mapping between IOThreads and virtqueues. At the moment all virtqueues
are assigned to a single IOThread or the main loop. This single thread
can be a CPU bottleneck, so it is necessary to allow finer-grained
assignment to spread the load.

Introduce DEFINE_PROP_IOTHREAD_VQ_MAPPING_LIST() so devices can take a
parameter that maps virtqueues to IOThreads. The command-line syntax for
this new property is as follows:

  --device '{"driver":"foo","iothread-vq-mapping":[{"iothread":"iothread0","vqs":[0,1,2]},...]}'

IOThreads are specified by name and virtqueues are specified by 0-based
index.

It will be common to simply assign virtqueues round-robin across a set
of IOThreads. A convenient syntax that does not require specifying
individual virtqueue indices is available:

  --device '{"driver":"foo","iothread-vq-mapping":[{"iothread":"iothread0"},{"iothread":"iothread1"},...]}'

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/virtio.json                    | 29 ++++++++++++++++++
 include/hw/qdev-properties-system.h |  5 ++++
 hw/core/qdev-properties-system.c    | 46 +++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index e6dcee7b83..19c7c36e36 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -928,3 +928,32 @@
   'data': { 'path': 'str', 'queue': 'uint16', '*index': 'uint16' },
   'returns': 'VirtioQueueElement',
   'features': [ 'unstable' ] }
+
+##
+# @IOThreadVirtQueueMapping:
+#
+# Describes the subset of virtqueues assigned to an IOThread.
+#
+# @iothread: the id of IOThread object
+#
+# @vqs: an optional array of virtqueue indices that will be handled by this
+#     IOThread.  When absent, virtqueues are assigned round-robin across all
+#     IOThreadVirtQueueMappings provided.  Either all IOThreadVirtQueueMappings
+#     must have @vqs or none of them must have it.
+#
+# Since: 9.0
+##
+
+{ 'struct': 'IOThreadVirtQueueMapping',
+  'data': { 'iothread': 'str', '*vqs': ['uint16'] } }
+
+##
+# @DummyVirtioForceArrays:
+#
+# Not used by QMP; hack to let us use IOThreadVirtQueueMappingList internally
+#
+# Since: 9.0
+##
+
+{ 'struct': 'DummyVirtioForceArrays',
+  'data': { 'unused-iothread-vq-mapping': ['IOThreadVirtQueueMapping'] } }
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 91f7a2452d..06c359c190 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -24,6 +24,7 @@ extern const PropertyInfo qdev_prop_off_auto_pcibar;
 extern const PropertyInfo qdev_prop_pcie_link_speed;
 extern const PropertyInfo qdev_prop_pcie_link_width;
 extern const PropertyInfo qdev_prop_cpus390entitlement;
+extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
 
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
@@ -82,4 +83,8 @@ extern const PropertyInfo qdev_prop_cpus390entitlement;
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_cpus390entitlement, \
                        CpuS390Entitlement)
 
+#define DEFINE_PROP_IOTHREAD_VQ_MAPPING_LIST(_name, _state, _field) \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_iothread_vq_mapping_list, \
+                IOThreadVirtQueueMappingList *)
+
 #endif
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 73cced4626..1a396521d5 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -18,6 +18,7 @@
 #include "qapi/qapi-types-block.h"
 #include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-migration.h"
+#include "qapi/qapi-visit-virtio.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
@@ -1160,3 +1161,48 @@ const PropertyInfo qdev_prop_cpus390entitlement = {
     .set   = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
+
+/* --- IOThreadVirtQueueMappingList --- */
+
+static void get_iothread_vq_mapping_list(Object *obj, Visitor *v,
+        const char *name, void *opaque, Error **errp)
+{
+    IOThreadVirtQueueMappingList **prop_ptr =
+        object_field_prop_ptr(obj, opaque);
+
+    visit_type_IOThreadVirtQueueMappingList(v, name, prop_ptr, errp);
+}
+
+static void set_iothread_vq_mapping_list(Object *obj, Visitor *v,
+        const char *name, void *opaque, Error **errp)
+{
+    IOThreadVirtQueueMappingList **prop_ptr =
+        object_field_prop_ptr(obj, opaque);
+    IOThreadVirtQueueMappingList *list;
+
+    if (!visit_type_IOThreadVirtQueueMappingList(v, name, &list, errp)) {
+        return;
+    }
+
+    qapi_free_IOThreadVirtQueueMappingList(*prop_ptr);
+    *prop_ptr = list;
+}
+
+static void release_iothread_vq_mapping_list(Object *obj,
+        const char *name, void *opaque)
+{
+    IOThreadVirtQueueMappingList **prop_ptr =
+        object_field_prop_ptr(obj, opaque);
+
+    qapi_free_IOThreadVirtQueueMappingList(*prop_ptr);
+    *prop_ptr = NULL;
+}
+
+const PropertyInfo qdev_prop_iothread_vq_mapping_list = {
+    .name = "IOThreadVirtQueueMappingList",
+    .description = "IOThread virtqueue mapping list [{\"iothread\":\"<id>\", "
+                   "\"vqs\":[1,2,3,...]},...]",
+    .get = get_iothread_vq_mapping_list,
+    .set = set_iothread_vq_mapping_list,
+    .release = release_iothread_vq_mapping_list,
+};
-- 
2.43.0


