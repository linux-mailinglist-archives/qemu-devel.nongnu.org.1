Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2451F750682
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 13:45:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJXqP-0003I6-Sc; Wed, 12 Jul 2023 07:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJXqN-0003Hf-Rm
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJXqM-00030P-Ap
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689160633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k34kcLwTvPEkT+3XVYFdwFc+Apb+lpmPwdTMWwux4Wg=;
 b=f8FTJUds1u24wJBlo7flAXl4F1kv2IRjsVHjkcGrOFS/o9mYgY84ivdAvmfLJzjhRPKnju
 PEkELdu+C6KdUYb3MlbLUVJwzyCt6eNJJMOWXQ517fpjg2JIUICB1yN+z5lsJPitJnHdRK
 WkXsxNzmbwbqAeA02ISz03qSbdf2yjM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-IWj6wq6FOKO5UZVuFRRkLw-1; Wed, 12 Jul 2023 07:17:12 -0400
X-MC-Unique: IWj6wq6FOKO5UZVuFRRkLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25CF42815E28
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 11:17:12 +0000 (UTC)
Received: from localhost (unknown [10.39.193.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE3E6200A7CA;
 Wed, 12 Jul 2023 11:17:11 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v2 4/4] vhost-user-fs: Implement internal migration
Date: Wed, 12 Jul 2023 13:17:02 +0200
Message-ID: <20230712111703.28031-5-hreitz@redhat.com>
In-Reply-To: <20230712111703.28031-1-hreitz@redhat.com>
References: <20230712111703.28031-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

A virtio-fs device's VM state consists of:
- the virtio device (vring) state (VMSTATE_VIRTIO_DEVICE)
- the back-end's (virtiofsd's) internal state

We get/set the latter via the new vhost operations to transfer migratory
state.  It is its own dedicated subsection, so that for external
migration, it can be disabled.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/virtio/vhost-user-fs.c | 101 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 49d699ffc2..2b30f3d442 100644
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
+    if (!vhost_supports_migratory_state(&fs->vhost_dev)) {
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


