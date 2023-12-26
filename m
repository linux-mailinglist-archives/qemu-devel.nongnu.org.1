Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E45281E654
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:25:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3fz-0001IJ-V4; Tue, 26 Dec 2023 04:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fn-0001H1-7j
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fl-0008G8-Fp
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xP1V8T2FgKjwD1W++v0ktUcbqsF7NLMyhF1n3TtP/Y4=;
 b=CJ8sul1Qi8RscYNIlWAT5pGk4DQl5sb/R+fg3WKnpHf0lO7TC0QNg0iw5z7TiXbnTfCGO4
 pz8itqiyyPyN1ee7ZkZeoC1Pe8UQcUAWol1Mjjp7yJcUlf0uJXnIjWvdl0dXQfm3dGfLzC
 K/XVa5LQFraf3qUulOSA4ZZm1M+us7k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-9ZA3IyDWPZm4oGmStvEuVA-1; Tue, 26 Dec 2023 04:24:23 -0500
X-MC-Unique: 9ZA3IyDWPZm4oGmStvEuVA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d5b7be93aso1336085e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582660; x=1704187460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xP1V8T2FgKjwD1W++v0ktUcbqsF7NLMyhF1n3TtP/Y4=;
 b=Jd9Kbn+wkFfRcL0BYEskpQDkrttdplRSmKER3Qz6+YRH/fqhAnocTnZzBYMCe81dRJ
 fSnne4vzf49Uyx6MjuyDht/0c4vX/1d8tHnDsRLIFKCGTgX5kMCNWqx9OZmSvMvaYN5v
 ugo38xcb0cq6Mnk+F/d2tvZnuA1j2/MromKO9xIS9ZgaVZeH/E5q6XVYn7hTRRKnMlT4
 2HhbK5HW8sEqqj+NufSlyGQHfnZdSkWOhYk6T4XCEHX/soxjnZAnaoyQALeOtPaQg5wm
 UJVjAFSQEKUHa6azj44yc2l2PzbkNWYZ/X4JqMyYKOL9HvPOUiOF3UdbCrfmZ9GgLiZS
 s0ww==
X-Gm-Message-State: AOJu0YxwLM9IaQE9SJiPmiGOYE+LViLKm5uDR82avsAyKWq0lUnJMzqx
 31o5auHYsvcVPgzu1oDwI2TMnaJSYkTCS4vdNKQV0/2Ire1eGyOcrDKA4hm7mNNHXXFhq0NmV+1
 +ViPaB9AVXwaFLfFKc56z/2UpVpMe7esxYVbOd51js1Pd3Q/+bz9DLMSdZGKpGD2KCCuiEWfPt9
 SY
X-Received: by 2002:a05:600c:8505:b0:40c:367d:9022 with SMTP id
 gw5-20020a05600c850500b0040c367d9022mr1959769wmb.151.1703582660199; 
 Tue, 26 Dec 2023 01:24:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERzDqRCleI+5hWtr+zSB7/pMLYFzKJkhFF4eTCM0xz5W7GeBu+bj2onBeEBQyABc4eu5UU3A==
X-Received: by 2002:a05:600c:8505:b0:40c:367d:9022 with SMTP id
 gw5-20020a05600c850500b0040c367d9022mr1959759wmb.151.1703582659792; 
 Tue, 26 Dec 2023 01:24:19 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 f11-20020a05600c4e8b00b0040d5118e42esm10923472wmq.22.2023.12.26.01.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:24:17 -0800 (PST)
Date: Tue, 26 Dec 2023 04:24:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mike Christie <michael.christie@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 04/21] vhost-scsi: Add support for a worker thread per virtqueue
Message-ID: <51396556f0927c3d202f9903db5aa5aa8d4cbd2c.1703582625.git.mst@redhat.com>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
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

From: Mike Christie <michael.christie@oracle.com>

This adds support for vhost-scsi to be able to create a worker thread
per virtqueue. Right now for vhost-net we get a worker thread per
tx/rx virtqueue pair which scales nicely as we add more virtqueues and
CPUs, but for scsi we get the single worker thread that's shared by all
virtqueues. When trying to send IO to more than 2 virtqueues the single
thread becomes a bottlneck.

This patch adds a new setting, worker_per_virtqueue, which can be set
to:

false: Existing behavior where we get the single worker thread.
true: Create a worker per IO virtqueue.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Message-Id: <20231204231618.21962-3-michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/hw/virtio/virtio-scsi.h |  1 +
 hw/scsi/vhost-scsi.c            | 62 +++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 7f0573b1bf..7be0105918 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -51,6 +51,7 @@ typedef struct virtio_scsi_config VirtIOSCSIConfig;
 struct VirtIOSCSIConf {
     uint32_t num_queues;
     uint32_t virtqueue_size;
+    bool worker_per_virtqueue;
     bool seg_max_adjust;
     uint32_t max_sectors;
     uint32_t cmd_per_lun;
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 3126df9e1d..08aa7534df 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -165,6 +165,59 @@ static const VMStateDescription vmstate_virtio_vhost_scsi = {
     .pre_save = vhost_scsi_pre_save,
 };
 
+static int vhost_scsi_set_workers(VHostSCSICommon *vsc, bool per_virtqueue)
+{
+    struct vhost_dev *dev = &vsc->dev;
+    struct vhost_vring_worker vq_worker;
+    struct vhost_worker_state worker;
+    int i, ret;
+
+    /* Use default worker */
+    if (!per_virtqueue || dev->nvqs == VHOST_SCSI_VQ_NUM_FIXED + 1) {
+        return 0;
+    }
+
+    /*
+     * ctl/evt share the first worker since it will be rare for them
+     * to send cmds while IO is running.
+     */
+    for (i = VHOST_SCSI_VQ_NUM_FIXED + 1; i < dev->nvqs; i++) {
+        memset(&worker, 0, sizeof(worker));
+
+        ret = dev->vhost_ops->vhost_new_worker(dev, &worker);
+        if (ret == -ENOTTY) {
+            /*
+             * worker ioctls are not implemented so just ignore and
+             * and continue device setup.
+             */
+            warn_report("vhost-scsi: Backend supports a single worker. "
+                        "Ignoring worker_per_virtqueue=true setting.");
+            ret = 0;
+            break;
+        } else if (ret) {
+            break;
+        }
+
+        memset(&vq_worker, 0, sizeof(vq_worker));
+        vq_worker.worker_id = worker.worker_id;
+        vq_worker.index = i;
+
+        ret = dev->vhost_ops->vhost_attach_vring_worker(dev, &vq_worker);
+        if (ret == -ENOTTY) {
+            /*
+             * It's a bug for the kernel to have supported the worker creation
+             * ioctl but not attach.
+             */
+            dev->vhost_ops->vhost_free_worker(dev, &worker);
+            break;
+        } else if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
 static void vhost_scsi_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
@@ -232,6 +285,13 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         goto free_vqs;
     }
 
+    ret = vhost_scsi_set_workers(vsc, vs->conf.worker_per_virtqueue);
+    if (ret < 0) {
+        error_setg(errp, "vhost-scsi: vhost worker setup failed: %s",
+                   strerror(-ret));
+        goto free_vqs;
+    }
+
     /* At present, channel and lun both are 0 for bootable vhost-scsi disk */
     vsc->channel = 0;
     vsc->lun = 0;
@@ -297,6 +357,8 @@ static Property vhost_scsi_properties[] = {
                                                  VIRTIO_SCSI_F_T10_PI,
                                                  false),
     DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
+    DEFINE_PROP_BOOL("worker_per_virtqueue", VirtIOSCSICommon,
+                     conf.worker_per_virtqueue, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST


