Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 521357A4E6A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGvU-0006Ed-5P; Mon, 18 Sep 2023 12:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qiGvF-0006DP-9n
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qiGuz-0006uY-RF
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695053772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVVZKYNygJbVbLc1nDEHJwLbgKIc2c2EZR0NZgWsvJg=;
 b=C/LEmslLB0CR7odmyINuS7liAMuCDhc3W5+hyWrYtgMWH0Z1qnXNbdc/3dxi7BvXHqstm+
 0LS/70nPLjWon/BtEDHy10PS+jePwYnNdlTQ2l/z9dkkv+/wxs3hD7JfMTV44MMx3Xnct8
 la9HitGz3lXqsPgvvXZUcVy+PuLKZVM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-PmafrPsANu2EbRFVkOQ6Qw-1; Mon, 18 Sep 2023 12:16:08 -0400
X-MC-Unique: PmafrPsANu2EbRFVkOQ6Qw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 760E81C03332;
 Mon, 18 Sep 2023 16:16:08 +0000 (UTC)
Received: from localhost (unknown [10.39.195.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00780140273C;
 Mon, 18 Sep 2023 16:16:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 <qemu-block@nongnu.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 1/2] qdev: add IOThreadVirtQueueMappingList property type
Date: Mon, 18 Sep 2023 12:16:03 -0400
Message-ID: <20230918161604.1400051-2-stefanha@redhat.com>
In-Reply-To: <20230918161604.1400051-1-stefanha@redhat.com>
References: <20230918161604.1400051-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qapi/virtio.json                    | 30 ++++++++++++++++++
 include/hw/qdev-properties-system.h |  4 +++
 hw/core/qdev-properties-system.c    | 47 +++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index e6dcee7b83..cb341ae596 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -928,3 +928,33 @@
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
+# @vqs: an optional array of virtqueue indices that will be handled by this
+#       IOThread. When absent, virtqueues are assigned round-robin across all
+#       IOThreadVirtQueueMappings provided. Either all
+#       IOThreadVirtQueueMappings must have @vqs or none of them must have it.
+#
+# Since: 8.2
+#
+##
+
+{ 'struct': 'IOThreadVirtQueueMapping',
+  'data': { 'iothread': 'str', '*vqs': ['uint16'] } }
+
+##
+# @IOThreadVirtQueueMappings:
+#
+# IOThreadVirtQueueMapping list. This struct is not actually used but the
+# IOThreadVirtQueueMappingList type it generates is!
+#
+# Since: 8.2
+##
+
+{ 'struct': 'IOThreadVirtQueueMappings',
+  'data': { 'mappings': ['IOThreadVirtQueueMapping'] } }
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 0ac327ae60..c526e502c8 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -22,6 +22,7 @@ extern const PropertyInfo qdev_prop_audiodev;
 extern const PropertyInfo qdev_prop_off_auto_pcibar;
 extern const PropertyInfo qdev_prop_pcie_link_speed;
 extern const PropertyInfo qdev_prop_pcie_link_width;
+extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
 
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
@@ -73,5 +74,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 #define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) \
     DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID)
 
+#define DEFINE_PROP_IOTHREAD_VQ_MAPPING_LIST(_name, _state, _field) \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_iothread_vq_mapping_list, \
+                IOThreadVirtQueueMappingList *)
 
 #endif
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 6d5d43eda2..831796e106 100644
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
@@ -1147,3 +1148,49 @@ const PropertyInfo qdev_prop_uuid = {
     .set   = set_uuid,
     .set_default_value = set_default_uuid_auto,
 };
+
+/* --- IOThreadVirtQueueMappingList --- */
+
+static void get_iothread_vq_mapping_list(Object *obj, Visitor *v,
+        const char *name, void *opaque, Error **errp)
+{
+    IOThreadVirtQueueMappingList **prop_ptr =
+        object_field_prop_ptr(obj, opaque);
+    IOThreadVirtQueueMappingList *list = *prop_ptr;
+
+    visit_type_IOThreadVirtQueueMappingList(v, name, &list, errp);
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
2.41.0


