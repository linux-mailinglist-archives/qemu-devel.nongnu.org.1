Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D304A5CA9A
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 17:17:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts2BQ-00051u-9x; Tue, 11 Mar 2025 12:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts22p-0004X0-8r
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts22i-0005oS-80
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0ufkswK0lBCVux74WUpfHC7vHcbevViUd8jJN1L2R4=;
 b=cAY22unq9bdcObH6NTU9z0v0x3d1VsEdZRj73xKOb6O9w3NokoOF2zb4sRc33npdxiy6E+
 phP7zKq2AWxeMuOnls+PmG5lV1/6iFl6aSm/8KoLE3qJvgcsB/Dkli04mmpRPSdD72gcYW
 4/VYIv1l/dKYcEsB1Ud8RoFqkDOZ4vA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-lpAiglPuP9Gpjjlh2bOSsg-1; Tue,
 11 Mar 2025 12:01:07 -0400
X-MC-Unique: lpAiglPuP9Gpjjlh2bOSsg-1
X-Mimecast-MFC-AGG-ID: lpAiglPuP9Gpjjlh2bOSsg_1741708866
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F87D18001E0; Tue, 11 Mar 2025 16:01:06 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 388FC1800373; Tue, 11 Mar 2025 16:01:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 19/22] virtio: extract iothread-vq-mapping.h API
Date: Tue, 11 Mar 2025 17:00:18 +0100
Message-ID: <20250311160021.349761-20-kwolf@redhat.com>
In-Reply-To: <20250311160021.349761-1-kwolf@redhat.com>
References: <20250311160021.349761-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The code that builds an array of AioContext pointers indexed by the
virtqueue is not specific to virtio-blk. virtio-scsi will need to do the
same thing, so extract the functions.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250311132616.1049687-11-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/virtio/iothread-vq-mapping.h |  45 ++++++++
 hw/block/virtio-blk.c                   | 142 +-----------------------
 hw/virtio/iothread-vq-mapping.c         | 131 ++++++++++++++++++++++
 hw/virtio/meson.build                   |   1 +
 4 files changed, 178 insertions(+), 141 deletions(-)
 create mode 100644 include/hw/virtio/iothread-vq-mapping.h
 create mode 100644 hw/virtio/iothread-vq-mapping.c

diff --git a/include/hw/virtio/iothread-vq-mapping.h b/include/hw/virtio/iothread-vq-mapping.h
new file mode 100644
index 0000000000..57335c3703
--- /dev/null
+++ b/include/hw/virtio/iothread-vq-mapping.h
@@ -0,0 +1,45 @@
+/*
+ * IOThread Virtqueue Mapping
+ *
+ * Copyright Red Hat, Inc
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#ifndef HW_VIRTIO_IOTHREAD_VQ_MAPPING_H
+#define HW_VIRTIO_IOTHREAD_VQ_MAPPING_H
+
+#include "qapi/error.h"
+#include "qapi/qapi-types-virtio.h"
+
+/**
+ * iothread_vq_mapping_apply:
+ * @list: The mapping of virtqueues to IOThreads.
+ * @vq_aio_context: The array of AioContext pointers to fill in.
+ * @num_queues: The length of @vq_aio_context.
+ * @errp: If an error occurs, a pointer to the area to store the error.
+ *
+ * Fill in the AioContext for each virtqueue in the @vq_aio_context array given
+ * the iothread-vq-mapping parameter in @list.
+ *
+ * iothread_vq_mapping_cleanup() must be called to free IOThread object
+ * references after this function returns success.
+ *
+ * Returns: %true on success, %false on failure.
+ **/
+bool iothread_vq_mapping_apply(
+        IOThreadVirtQueueMappingList *list,
+        AioContext **vq_aio_context,
+        uint16_t num_queues,
+        Error **errp);
+
+/**
+ * iothread_vq_mapping_cleanup:
+ * @list: The mapping of virtqueues to IOThreads.
+ *
+ * Release IOThread object references that were acquired by
+ * iothread_vq_mapping_apply().
+ */
+void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list);
+
+#endif /* HW_VIRTIO_IOTHREAD_VQ_MAPPING_H */
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6bf7b50520..5077793e5e 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -33,6 +33,7 @@
 #endif
 #include "hw/virtio/virtio-bus.h"
 #include "migration/qemu-file-types.h"
+#include "hw/virtio/iothread-vq-mapping.h"
 #include "hw/virtio/virtio-access.h"
 #include "hw/virtio/virtio-blk-common.h"
 #include "qemu/coroutine.h"
@@ -1423,147 +1424,6 @@ static const BlockDevOps virtio_block_ops = {
     .drained_end   = virtio_blk_drained_end,
 };
 
-static bool
-iothread_vq_mapping_validate(IOThreadVirtQueueMappingList *list, uint16_t
-        num_queues, Error **errp)
-{
-    g_autofree unsigned long *vqs = bitmap_new(num_queues);
-    g_autoptr(GHashTable) iothreads =
-        g_hash_table_new(g_str_hash, g_str_equal);
-
-    for (IOThreadVirtQueueMappingList *node = list; node; node = node->next) {
-        const char *name = node->value->iothread;
-        uint16List *vq;
-
-        if (!iothread_by_id(name)) {
-            error_setg(errp, "IOThread \"%s\" object does not exist", name);
-            return false;
-        }
-
-        if (!g_hash_table_add(iothreads, (gpointer)name)) {
-            error_setg(errp,
-                    "duplicate IOThread name \"%s\" in iothread-vq-mapping",
-                    name);
-            return false;
-        }
-
-        if (node != list) {
-            if (!!node->value->vqs != !!list->value->vqs) {
-                error_setg(errp, "either all items in iothread-vq-mapping "
-                                 "must have vqs or none of them must have it");
-                return false;
-            }
-        }
-
-        for (vq = node->value->vqs; vq; vq = vq->next) {
-            if (vq->value >= num_queues) {
-                error_setg(errp, "vq index %u for IOThread \"%s\" must be "
-                        "less than num_queues %u in iothread-vq-mapping",
-                        vq->value, name, num_queues);
-                return false;
-            }
-
-            if (test_and_set_bit(vq->value, vqs)) {
-                error_setg(errp, "cannot assign vq %u to IOThread \"%s\" "
-                        "because it is already assigned", vq->value, name);
-                return false;
-            }
-        }
-    }
-
-    if (list->value->vqs) {
-        for (uint16_t i = 0; i < num_queues; i++) {
-            if (!test_bit(i, vqs)) {
-                error_setg(errp,
-                        "missing vq %u IOThread assignment in iothread-vq-mapping",
-                        i);
-                return false;
-            }
-        }
-    }
-
-    return true;
-}
-
-/**
- * iothread_vq_mapping_apply:
- * @list: The mapping of virtqueues to IOThreads.
- * @vq_aio_context: The array of AioContext pointers to fill in.
- * @num_queues: The length of @vq_aio_context.
- * @errp: If an error occurs, a pointer to the area to store the error.
- *
- * Fill in the AioContext for each virtqueue in the @vq_aio_context array given
- * the iothread-vq-mapping parameter in @list.
- *
- * iothread_vq_mapping_cleanup() must be called to free IOThread object
- * references after this function returns success.
- *
- * Returns: %true on success, %false on failure.
- **/
-static bool iothread_vq_mapping_apply(
-        IOThreadVirtQueueMappingList *list,
-        AioContext **vq_aio_context,
-        uint16_t num_queues,
-        Error **errp)
-{
-    IOThreadVirtQueueMappingList *node;
-    size_t num_iothreads = 0;
-    size_t cur_iothread = 0;
-
-    if (!iothread_vq_mapping_validate(list, num_queues, errp)) {
-        return false;
-    }
-
-    for (node = list; node; node = node->next) {
-        num_iothreads++;
-    }
-
-    for (node = list; node; node = node->next) {
-        IOThread *iothread = iothread_by_id(node->value->iothread);
-        AioContext *ctx = iothread_get_aio_context(iothread);
-
-        /* Released in virtio_blk_vq_aio_context_cleanup() */
-        object_ref(OBJECT(iothread));
-
-        if (node->value->vqs) {
-            uint16List *vq;
-
-            /* Explicit vq:IOThread assignment */
-            for (vq = node->value->vqs; vq; vq = vq->next) {
-                assert(vq->value < num_queues);
-                vq_aio_context[vq->value] = ctx;
-            }
-        } else {
-            /* Round-robin vq:IOThread assignment */
-            for (unsigned i = cur_iothread; i < num_queues;
-                 i += num_iothreads) {
-                vq_aio_context[i] = ctx;
-            }
-        }
-
-        cur_iothread++;
-    }
-
-    return true;
-}
-
-/**
- * iothread_vq_mapping_cleanup:
- * @list: The mapping of virtqueues to IOThreads.
- *
- * Release IOThread object references that were acquired by
- * iothread_vq_mapping_apply().
- */
-static void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list)
-{
-    IOThreadVirtQueueMappingList *node;
-
-    for (node = list; node; node = node->next) {
-        IOThread *iothread = iothread_by_id(node->value->iothread);
-        object_unref(OBJECT(iothread));
-    }
-}
-
 /* Context: BQL held */
 static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
 {
diff --git a/hw/virtio/iothread-vq-mapping.c b/hw/virtio/iothread-vq-mapping.c
new file mode 100644
index 0000000000..15909eb933
--- /dev/null
+++ b/hw/virtio/iothread-vq-mapping.c
@@ -0,0 +1,131 @@
+/*
+ * IOThread Virtqueue Mapping
+ *
+ * Copyright Red Hat, Inc
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#include "qemu/osdep.h"
+#include "system/iothread.h"
+#include "hw/virtio/iothread-vq-mapping.h"
+
+static bool
+iothread_vq_mapping_validate(IOThreadVirtQueueMappingList *list, uint16_t
+        num_queues, Error **errp)
+{
+    g_autofree unsigned long *vqs = bitmap_new(num_queues);
+    g_autoptr(GHashTable) iothreads =
+        g_hash_table_new(g_str_hash, g_str_equal);
+
+    for (IOThreadVirtQueueMappingList *node = list; node; node = node->next) {
+        const char *name = node->value->iothread;
+        uint16List *vq;
+
+        if (!iothread_by_id(name)) {
+            error_setg(errp, "IOThread \"%s\" object does not exist", name);
+            return false;
+        }
+
+        if (!g_hash_table_add(iothreads, (gpointer)name)) {
+            error_setg(errp,
+                    "duplicate IOThread name \"%s\" in iothread-vq-mapping",
+                    name);
+            return false;
+        }
+
+        if (node != list) {
+            if (!!node->value->vqs != !!list->value->vqs) {
+                error_setg(errp, "either all items in iothread-vq-mapping "
+                                 "must have vqs or none of them must have it");
+                return false;
+            }
+        }
+
+        for (vq = node->value->vqs; vq; vq = vq->next) {
+            if (vq->value >= num_queues) {
+                error_setg(errp, "vq index %u for IOThread \"%s\" must be "
+                        "less than num_queues %u in iothread-vq-mapping",
+                        vq->value, name, num_queues);
+                return false;
+            }
+
+            if (test_and_set_bit(vq->value, vqs)) {
+                error_setg(errp, "cannot assign vq %u to IOThread \"%s\" "
+                        "because it is already assigned", vq->value, name);
+                return false;
+            }
+        }
+    }
+
+    if (list->value->vqs) {
+        for (uint16_t i = 0; i < num_queues; i++) {
+            if (!test_bit(i, vqs)) {
+                error_setg(errp,
+                        "missing vq %u IOThread assignment in iothread-vq-mapping",
+                        i);
+                return false;
+            }
+        }
+    }
+
+    return true;
+}
+
+bool iothread_vq_mapping_apply(
+        IOThreadVirtQueueMappingList *list,
+        AioContext **vq_aio_context,
+        uint16_t num_queues,
+        Error **errp)
+{
+    IOThreadVirtQueueMappingList *node;
+    size_t num_iothreads = 0;
+    size_t cur_iothread = 0;
+
+    if (!iothread_vq_mapping_validate(list, num_queues, errp)) {
+        return false;
+    }
+
+    for (node = list; node; node = node->next) {
+        num_iothreads++;
+    }
+
+    for (node = list; node; node = node->next) {
+        IOThread *iothread = iothread_by_id(node->value->iothread);
+        AioContext *ctx = iothread_get_aio_context(iothread);
+
+        /* Released in virtio_blk_vq_aio_context_cleanup() */
+        object_ref(OBJECT(iothread));
+
+        if (node->value->vqs) {
+            uint16List *vq;
+
+            /* Explicit vq:IOThread assignment */
+            for (vq = node->value->vqs; vq; vq = vq->next) {
+                assert(vq->value < num_queues);
+                vq_aio_context[vq->value] = ctx;
+            }
+        } else {
+            /* Round-robin vq:IOThread assignment */
+            for (unsigned i = cur_iothread; i < num_queues;
+                 i += num_iothreads) {
+                vq_aio_context[i] = ctx;
+            }
+        }
+
+        cur_iothread++;
+    }
+
+    return true;
+}
+
+void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list)
+{
+    IOThreadVirtQueueMappingList *node;
+
+    for (node = list; node; node = node->next) {
+        IOThread *iothread = iothread_by_id(node->value->iothread);
+        object_unref(OBJECT(iothread));
+    }
+}
+
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index a5f9f7999d..19b04c4d9c 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -1,5 +1,6 @@
 system_virtio_ss = ss.source_set()
 system_virtio_ss.add(files('virtio-bus.c'))
+system_virtio_ss.add(files('iothread-vq-mapping.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-pci.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_MMIO', if_true: files('virtio-mmio.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
-- 
2.48.1


