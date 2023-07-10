Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6353974DA0B
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:38:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsvm-0005yQ-Oc; Mon, 10 Jul 2023 11:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvb-0005sx-Cc
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvK-0004ni-4G
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso47473095e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003335; x=1691595335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xDZmGNDNyuhkll410B4VoGo9VxH/iR/CeowwBsfUY1w=;
 b=QkYx+xUlO1OnM+U7cOlueYmTRxa1bcRe22n9kzYln3nevXTCPjNWcEniLPfkYm79vZ
 KvtBm3Ga+uZMT4h04nx/RzrT14Fs73vn/z2T6iOpPIC+cReZXRCJtA2axuOWG7QJun7r
 LBoNiyVR+X1c6ekBtUwVKWRKzFSVuKBc//NR7hOgPP19FwNL13KdaCue90FQv1L4CAbn
 dp/kGb85v2XetvnDznRnrY0ZbeOTbtlpbVzZMzvDLm6u2dJU4DGQzmKAkhb/H05xi//i
 45XXZeFzfF3HxTykWRtgan9FWT8Gs+3FqtDujK4CE2Zsqo9v1mINrEnhHSPDzPDUf+yv
 13Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003335; x=1691595335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xDZmGNDNyuhkll410B4VoGo9VxH/iR/CeowwBsfUY1w=;
 b=Q2+RlGRjQhHepR0bwfk/MxQD+oVgiVyM+dzpgoFxHV0IUVa3D9udUIvJkPUXncEKTa
 ck3f//3YWKNLW9FHw//w/Ld2bMw8htf7Bp+26v5oLwY7rE8Hewpdsq+4zew6iozlNVyL
 ZcMNK3orAQtuTAxb5K0/p9CfUks2pzTGYaO+I5u/EUKh9wfFHDNAeWmh0tRj+Eo3+kWi
 ayRY7TN6aTbsjLEy3jH9PA+w+dvf4UBVoMJZcWANegNv/GXrrP/Mg/hWTUQ72PKMmtMF
 bemsbKu8Kqb1MbabUY4FlIKVteZ1extqYvkPDi5aj2A26Slyh3384AOhJW2NOhB7ThwL
 Hyjg==
X-Gm-Message-State: ABy/qLbnGPX5bMbxTGCc/PKpML72cwHUOACx9awU+DVSYCX83RSt8tMy
 PoU/E4ooKfgiSYewIzRq4u01aQ==
X-Google-Smtp-Source: APBJJlHLqJ4Mlkj9dFkkGl4/ONoA1dBrB26X9nPDrCwrX2VYRm23TJVV0hio78HKBH1qucN9kEImbw==
X-Received: by 2002:a1c:ed0d:0:b0:3fa:934c:8350 with SMTP id
 l13-20020a1ced0d000000b003fa934c8350mr11463432wmh.27.1689003335577; 
 Mon, 10 Jul 2023 08:35:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a7bc7d6000000b003fbcdba1a63sm189157wmk.12.2023.07.10.08.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:35:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3BCE21FFCB;
 Mon, 10 Jul 2023 16:35:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC PATCH v3 17/20] hw/virtio: push down allocation responsibility
 for vhost_dev->vqs
Date: Mon, 10 Jul 2023 16:35:19 +0100
Message-Id: <20230710153522.3469097-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710153522.3469097-1-alex.bennee@linaro.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

All the allocations are a function the number of vqs we are allocating
so let the vhost code deal with it directly. This allows to eliminate
some complexity of the clean-up code (because vhost_dev_init cleanups
after itself if it fails). We can also places where we store copies of
@vqs in child objects.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/virtio/vhost-user-blk.h |  1 -
 include/hw/virtio/vhost.h          |  9 +++++++++
 backends/vhost-user.c              |  1 -
 hw/block/vhost-user-blk.c          |  7 +------
 hw/scsi/vhost-scsi.c               |  2 --
 hw/scsi/vhost-user-scsi.c          |  6 ------
 hw/virtio/vdpa-dev.c               |  9 ++-------
 hw/virtio/vhost-user-device.c      |  3 ---
 hw/virtio/vhost-user-fs.c          |  1 -
 hw/virtio/vhost.c                  | 10 ++++++++--
 10 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index ea085ee1ed..479fcc2a82 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -37,7 +37,6 @@ struct VHostUserBlk {
     struct vhost_dev dev;
     struct vhost_inflight *inflight;
     VhostUserState vhost_user;
-    struct vhost_virtqueue *vhost_vqs;
     VirtQueue **virtqs;
 
     /*
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index f7f10c8fb7..912706668a 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -82,6 +82,10 @@ struct vhost_dev {
     MemoryRegionSection *mem_sections;
     int n_tmp_sections;
     MemoryRegionSection *tmp_sections;
+    /**
+     * @vqs - internal to vhost_dev, allocated based on @nvqs
+     * @nvqs - number of @vqs to allocate.
+     */
     struct vhost_virtqueue *vqs;
     unsigned int nvqs;
     /* the first virtqueue which would be used by this vhost dev */
@@ -156,6 +160,9 @@ struct vhost_net {
  * negotiation of backend interface. Configuration of the VirtIO
  * itself won't happen until the interface is started.
  *
+ * If the initialisation fails it will call vhost_dev_cleanup() to
+ * tear down the interface and free memory.
+ *
  * Return: 0 on success, non-zero on error while setting errp.
  */
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
@@ -165,6 +172,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure
+ *
+ * This includes freeing internals such as @vqs
  */
 void vhost_dev_cleanup(struct vhost_dev *hdev);
 
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 94c6a82d52..05a3cf77d0 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -34,7 +34,6 @@ vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vdev,
 
     b->vdev = vdev;
     b->dev.nvqs = nvqs;
-    b->dev.vqs = g_new0(struct vhost_virtqueue, nvqs);
 
     ret = vhost_dev_init(&b->dev, &b->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
                          errp);
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index eecf3f7a81..9221f159ec 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -332,7 +332,6 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
 
     s->dev.num_queues = s->num_queues;
     s->dev.nvqs = s->num_queues;
-    s->dev.vqs = s->vhost_vqs;
     s->dev.vq_index = 0;
     s->dev.backend_features = 0;
 
@@ -480,7 +479,6 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     }
 
     s->inflight = g_new0(struct vhost_inflight, 1);
-    s->vhost_vqs = g_new0(struct vhost_virtqueue, s->num_queues);
 
     retries = REALIZE_CONNECTION_RETRIES;
     assert(!*errp);
@@ -504,8 +502,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     return;
 
 virtio_err:
-    g_free(s->vhost_vqs);
-    s->vhost_vqs = NULL;
+    vhost_dev_cleanup(&s->dev);
     g_free(s->inflight);
     s->inflight = NULL;
     for (i = 0; i < s->num_queues; i++) {
@@ -527,8 +524,6 @@ static void vhost_user_blk_device_unrealize(DeviceState *dev)
                              NULL, NULL, NULL, false);
     vhost_dev_cleanup(&s->dev);
     vhost_dev_free_inflight(s->inflight);
-    g_free(s->vhost_vqs);
-    s->vhost_vqs = NULL;
     g_free(s->inflight);
     s->inflight = NULL;
 
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 443f67daa4..aa25cdfcdc 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -214,8 +214,6 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
     }
 
     vsc->dev.nvqs = VHOST_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
-    vqs = g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
-    vsc->dev.vqs = vqs;
     vsc->dev.vq_index = 0;
     vsc->dev.backend_features = 0;
 
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index ee99b19e7a..7e4c20ba42 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -94,7 +94,6 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
     VHostUserSCSI *s = VHOST_USER_SCSI(dev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
-    struct vhost_virtqueue *vqs = NULL;
     Error *err = NULL;
     int ret;
 
@@ -116,10 +115,8 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     }
 
     vsc->dev.nvqs = VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
-    vsc->dev.vqs = g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
     vsc->dev.vq_index = 0;
     vsc->dev.backend_features = 0;
-    vqs = vsc->dev.vqs;
 
     ret = vhost_dev_init(&vsc->dev, &s->vhost_user,
                          VHOST_BACKEND_TYPE_USER, 0, errp);
@@ -136,7 +133,6 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
 
 free_vhost:
     vhost_user_cleanup(&s->vhost_user);
-    g_free(vqs);
 free_virtio:
     virtio_scsi_common_unrealize(dev);
 }
@@ -146,13 +142,11 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserSCSI *s = VHOST_USER_SCSI(dev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
-    struct vhost_virtqueue *vqs = vsc->dev.vqs;
 
     /* This will stop the vhost backend. */
     vhost_user_scsi_set_status(vdev, 0);
 
     vhost_dev_cleanup(&vsc->dev);
-    g_free(vqs);
 
     virtio_scsi_common_unrealize(dev);
     vhost_user_cleanup(&s->vhost_user);
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 363b625243..c537c0d5f5 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -54,7 +54,6 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
     VhostVdpaDevice *v = VHOST_VDPA_DEVICE(vdev);
     struct vhost_vdpa_iova_range iova_range;
     uint16_t max_queue_size;
-    struct vhost_virtqueue *vqs;
     int i, ret;
 
     if (!v->vhostdev) {
@@ -101,8 +100,6 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
     }
 
     v->dev.nvqs = v->num_queues;
-    vqs = g_new0(struct vhost_virtqueue, v->dev.nvqs);
-    v->dev.vqs = vqs;
     v->dev.vq_index = 0;
     v->dev.vq_index_end = v->dev.nvqs;
     v->dev.backend_features = 0;
@@ -112,7 +109,7 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
     if (ret < 0) {
         error_setg(errp, "vhost-vdpa-device: get iova range failed: %s",
                    strerror(-ret));
-        goto free_vqs;
+        goto out;
     }
     v->vdpa.iova_range = iova_range;
 
@@ -120,7 +117,7 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
     if (ret < 0) {
         error_setg(errp, "vhost-vdpa-device: vhost initialization failed: %s",
                    strerror(-ret));
-        goto free_vqs;
+        goto out;
     }
 
     v->config_size = vhost_vdpa_device_get_u32(v->vhostfd,
@@ -160,8 +157,6 @@ free_config:
     g_free(v->config);
 vhost_cleanup:
     vhost_dev_cleanup(&v->dev);
-free_vqs:
-    g_free(vqs);
 out:
     qemu_close(v->vhostfd);
     v->vhostfd = -1;
diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
index d787f52364..0109d4829d 100644
--- a/hw/virtio/vhost-user-device.c
+++ b/hw/virtio/vhost-user-device.c
@@ -288,7 +288,6 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
     }
 
     vub->vhost_dev.nvqs = vub->num_vqs;
-    vub->vhost_dev.vqs = g_new0(struct vhost_virtqueue, vub->vhost_dev.nvqs);
 
     /* connect to backend */
     ret = vhost_dev_init(&vub->vhost_dev, &vub->vhost_user,
@@ -306,12 +305,10 @@ static void vub_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(dev);
-    struct vhost_virtqueue *vhost_vqs = vub->vhost_dev.vqs;
 
     /* This will stop vhost backend if appropriate. */
     vub_set_status(vdev, 0);
     vhost_dev_cleanup(&vub->vhost_dev);
-    g_free(vhost_vqs);
     do_vhost_user_cleanup(vdev, vub);
 }
 
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 49d699ffc2..b6667f08b0 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -248,7 +248,6 @@ static void vuf_device_realize(DeviceState *dev, Error **errp)
 
     /* 1 high prio queue, plus the number configured */
     fs->vhost_dev.nvqs = 1 + fs->conf.num_request_queues;
-    fs->vhost_dev.vqs = g_new0(struct vhost_virtqueue, fs->vhost_dev.nvqs);
     ret = vhost_dev_init(&fs->vhost_dev, &fs->vhost_user,
                          VHOST_BACKEND_TYPE_USER, 0, errp);
     if (ret < 0) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 971df8ccc5..4c73ced3b7 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1392,6 +1392,8 @@ static bool vhost_init_virtqs(struct vhost_dev *hdev, uint32_t busyloop_timeout,
 {
     int i, r, n_initialized_vqs = 0;
 
+    hdev->vqs = g_new0(struct vhost_virtqueue, hdev->nvqs);
+
     for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
         r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i);
         if (r < 0) {
@@ -1530,9 +1532,13 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
 
     trace_vhost_dev_cleanup(hdev);
 
-    for (i = 0; i < hdev->nvqs; ++i) {
-        vhost_virtqueue_cleanup(hdev->vqs + i);
+    if (hdev->vqs) {
+        for (i = 0; i < hdev->nvqs; ++i) {
+            vhost_virtqueue_cleanup(hdev->vqs + i);
+        }
+        g_free(hdev->vqs);
     }
+
     if (hdev->mem) {
         /* those are only safe after successful init */
         memory_listener_unregister(&hdev->memory_listener);
-- 
2.39.2


