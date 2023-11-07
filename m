Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B71D27E38DD
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:20:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J2t-0002Oj-VF; Tue, 07 Nov 2023 05:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J27-0001O1-Am
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J25-0002Eh-BD
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q5BKMN8AiQu0HrMpDRk8cwqjohWpFp/kFamZr3z+5m8=;
 b=iGpkHSplzs9wPvhBqfmEScvqAm1y/9VKyiw3QGFLfsGibrDmDDBF036TuLA6RzPIQLqXfr
 cwH6HkZE+Yoe/VvoBKXkupoBQ4He36wI7Em3JcOZz9lz9HqN2SSJLQbW4NmqF5+YA76Txf
 W8K0EfQfjluh0EZSbhqDgC5rMhpwVpQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-zV_ipk4OMxedMdAfP7Kluw-1; Tue, 07 Nov 2023 05:09:59 -0500
X-MC-Unique: zV_ipk4OMxedMdAfP7Kluw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32f7384d5a2so2646977f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351797; x=1699956597;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5BKMN8AiQu0HrMpDRk8cwqjohWpFp/kFamZr3z+5m8=;
 b=li7J/DDH1xvjwlCH5Bmsgt1JdOA13+mt9ZGqkySuI/dJ9/VM6E9ovqapRuxIQHAk2v
 Kx1QnJAkqmiHVmCB0t8r9Jl0y+Zd4mMMJNUsRpdOcJmIdzwsvw4FTZR/hFnoNwNG74Dc
 +cHRnYqDZg5MlrKwVSv8/5BUxJK2Gp8SnUcVR7SKUbhT9AwojAQUYW66tRo1nGXKd+PZ
 lXPKLdhTKq2/WScgVjUg9gyp1/hbkVrx7K6fpQPL7aBYdo1gtituLAJPKypKFtT/20d1
 zQtjGxbv8WpbW4o39vOYwgiCghKapg/e8Jz1LECiT/9IDNF6XfzJd0/vcIgPnpFmPHsE
 UbbA==
X-Gm-Message-State: AOJu0YzKgFd2iR++DnHFPIM6MIKDU4i5d4BTSS7UKVC41yekNrCI5yhn
 2Aq+lMmzDjrKtgPoujxkvjs/Cs8eannvLc8RHmdn2LokMB/KEe3grlx9FUVv2vGwX8oOF96LIK2
 rqVk7iI0gHvhIW6b3cks+i/AzH8bxoiFJ0/CxxLatY1N/VVmPuSuIjRhW8QDR6/hSyf7v
X-Received: by 2002:a5d:6c68:0:b0:32f:79e5:8119 with SMTP id
 r8-20020a5d6c68000000b0032f79e58119mr30159910wrz.1.1699351797622; 
 Tue, 07 Nov 2023 02:09:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+9jMtjbPlAmKct8/dx2yTk6oUw7LioQWUVnbnKmmNeeWo4yjACG1POTYzw3CWLoa0kX0+sA==
X-Received: by 2002:a5d:6c68:0:b0:32f:79e5:8119 with SMTP id
 r8-20020a5d6c68000000b0032f79e58119mr30159892wrz.1.1699351797269; 
 Tue, 07 Nov 2023 02:09:57 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 i16-20020a5d55d0000000b0032d8354fb43sm1913865wrw.76.2023.11.07.02.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:09:56 -0800 (PST)
Date: Tue, 7 Nov 2023 05:09:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, virtio-fs@redhat.com
Subject: [PULL 07/63] vhost-user-fs: Implement internal migration
Message-ID: <bca3e2a13814253b4ed878a3313688554edd1b66.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Hanna Czenczek <hreitz@redhat.com>

A virtio-fs device's VM state consists of:
- the virtio device (vring) state (VMSTATE_VIRTIO_DEVICE)
- the back-end's (virtiofsd's) internal state

We get/set the latter via the new vhost operations to transfer migratory
state.  It is its own dedicated subsection, so that for external
migration, it can be disabled.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20231016134243.68248-8-hreitz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


