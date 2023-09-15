Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A13787A1C37
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 12:27:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh61b-0006wF-RC; Fri, 15 Sep 2023 06:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qh61D-0006cb-NA
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 06:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qh61B-0002o6-Fz
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 06:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694773544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZBkpqxm+T7IKVbIYYr65BEU4VvEReH0vO+YG9VbRzk=;
 b=jMtBcDZ5clciQ95GwXIOr4S92E7HgZ68+SSLp52QTedCr5RuD+s8t5Gp6lpLOdo425VyvM
 cI8A32jDudjoPptpbnTDhppOMzaVBfh6dQeVzDabMkZjcoqi/XUkE+texjMYrrmhLs+cQa
 nByuhwZw9+9dho6kdzpvYdHJcOWWPx4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-fMAL9KAgMeGLHv5tfHqwHQ-1; Fri, 15 Sep 2023 06:25:43 -0400
X-MC-Unique: fMAL9KAgMeGLHv5tfHqwHQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA048101B043
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:25:42 +0000 (UTC)
Received: from localhost (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51CF310F1BEA;
 Fri, 15 Sep 2023 10:25:42 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Cc: Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: [PATCH v3 5/5] vhost-user-fs: Implement internal migration
Date: Fri, 15 Sep 2023 12:25:30 +0200
Message-ID: <20230915102531.55894-6-hreitz@redhat.com>
In-Reply-To: <20230915102531.55894-1-hreitz@redhat.com>
References: <20230915102531.55894-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

A virtio-fs device's VM state consists of:
- the virtio device (vring) state (VMSTATE_VIRTIO_DEVICE)
- the back-end's (virtiofsd's) internal state

We get/set the latter via the new vhost operations to transfer migratory
state.  It is its own dedicated subsection, so that for external
migration, it can be disabled.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/virtio/vhost-user-fs.c | 101 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 49d699ffc2..eb91723855 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -298,9 +298,108 @@ static struct vhost_dev *vuf_get_vhost(VirtIODevice *vdev)
     return &fs->vhost_dev;
 }
 
+/**
+ * Fetch the internal state from virtiofsd and save it to `f`.
+ */
+static int vuf_save_state(QEMUFile *f, void *pv, size_t size,
+                          const VMStateField *field, JSONWriter *vmdesc)
+{
+    VirtIODevice *vdev = pv;
+    VHostUserFS *fs = VHOST_USER_FS(vdev);
+    Error *local_error = NULL;
+    int ret;
+
+    ret = vhost_save_backend_state(&fs->vhost_dev, f, &local_error);
+    if (ret < 0) {
+        error_reportf_err(local_error,
+                          "Error saving back-end state of %s device %s "
+                          "(tag: \"%s\"): ",
+                          vdev->name, vdev->parent_obj.canonical_path,
+                          fs->conf.tag ?: "<none>");
+        return ret;
+    }
+
+    return 0;
+}
+
+/**
+ * Load virtiofsd's internal state from `f` and send it over to virtiofsd.
+ */
+static int vuf_load_state(QEMUFile *f, void *pv, size_t size,
+                          const VMStateField *field)
+{
+    VirtIODevice *vdev = pv;
+    VHostUserFS *fs = VHOST_USER_FS(vdev);
+    Error *local_error = NULL;
+    int ret;
+
+    ret = vhost_load_backend_state(&fs->vhost_dev, f, &local_error);
+    if (ret < 0) {
+        error_reportf_err(local_error,
+                          "Error loading back-end state of %s device %s "
+                          "(tag: \"%s\"): ",
+                          vdev->name, vdev->parent_obj.canonical_path,
+                          fs->conf.tag ?: "<none>");
+        return ret;
+    }
+
+    return 0;
+}
+
+static bool vuf_is_internal_migration(void *opaque)
+{
+    /* TODO: Return false when an external migration is requested */
+    return true;
+}
+
+static int vuf_check_migration_support(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+    VHostUserFS *fs = VHOST_USER_FS(vdev);
+
+    if (!vhost_supports_device_state(&fs->vhost_dev)) {
+        error_report("Back-end of %s device %s (tag: \"%s\") does not support "
+                     "migration through qemu",
+                     vdev->name, vdev->parent_obj.canonical_path,
+                     fs->conf.tag ?: "<none>");
+        return -ENOTSUP;
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vuf_backend_vmstate;
+
 static const VMStateDescription vuf_vmstate = {
     .name = "vhost-user-fs",
-    .unmigratable = 1,
+    .version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vuf_backend_vmstate,
+        NULL,
+    }
+};
+
+static const VMStateDescription vuf_backend_vmstate = {
+    .name = "vhost-user-fs-backend",
+    .version_id = 0,
+    .needed = vuf_is_internal_migration,
+    .pre_load = vuf_check_migration_support,
+    .pre_save = vuf_check_migration_support,
+    .fields = (VMStateField[]) {
+        {
+            .name = "back-end",
+            .info = &(const VMStateInfo) {
+                .name = "virtio-fs back-end state",
+                .get = vuf_load_state,
+                .put = vuf_save_state,
+            },
+        },
+        VMSTATE_END_OF_LIST()
+    },
 };
 
 static Property vuf_properties[] = {
-- 
2.41.0


