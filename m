Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DB981E65D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:26:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3gb-0003cO-1M; Tue, 26 Dec 2023 04:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gY-0003Qz-53
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gT-00004t-K2
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I6kn2SB5MVcdzC6da0OFpj8gZVEzPbbWYo5A8QNCIGo=;
 b=TRiqV8497ZcVoJtFJjFCFKIQrNBpvDGBqUGoUmS4OEnqLbBo5TF/fM2Sbm+bKZMJhET1kT
 uk6Xxj7UV0TLkzUFVU1X26rtxt/RhuJqtnBBgOAN52X98vTy3QDa+JC/18WreB8NhkBKsu
 uALHHgHvYBRFSnlhszVBeLtmozT2a4w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-biOnDW4eMZKv1RorCfnZ2w-1; Tue, 26 Dec 2023 04:25:06 -0500
X-MC-Unique: biOnDW4eMZKv1RorCfnZ2w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d4a423c84so33780355e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582702; x=1704187502;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I6kn2SB5MVcdzC6da0OFpj8gZVEzPbbWYo5A8QNCIGo=;
 b=BQUIE9GVXiDHx7RjznqVBXsLsMWC9+w4i3MzpAYuLWHJ1LQdz6++oHw3h2YOwSalrf
 yeD+fitS/BOc2a6WS9XKnwFew5beT2OGLzxzl8RZmdjYyE1mYiIaS25L6bo5trgM9rRG
 LwS6x/TaVVk1G2P80bmS4p0gxuuX/0YevHKi1AI7FuDo2g3dVDYBWQInxNCeZZ+RU/3Z
 butEsAJCxGy4vCY0MXbyjR7xbMfbxxr5f74AN3rhZvwXhmLFS0k9IZQN2W9VCSDxbgY2
 ka5IJVU1Auj/+Tbpbamrbi7Oef6sPGUIVjowzNYpXLEEZ/TX74mosfrJRyH9ClXzIABU
 C9gQ==
X-Gm-Message-State: AOJu0Yy1NQFq4OvlSeW3O/NXHNnIWQoQUzFkNegLeodhumJ+9pji0xhN
 wSTrDkdOrFTeNFaJ2shcTS54a0EGNc4LI3ABgGx4IucqE1A8msq+zIKHnPp3YRiZretU+a0GhEH
 ToT0ZcPsjB94z6HHIvPP/b5nov6rrAQbOAwoUAEFd0THFKQplYgunGXLgdV2IPpOhK2DzodZnaE
 TN
X-Received: by 2002:a05:600c:1554:b0:40c:2d88:1edd with SMTP id
 f20-20020a05600c155400b0040c2d881eddmr2430767wmg.130.1703582702387; 
 Tue, 26 Dec 2023 01:25:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/NuZ+Je4MAVZeGiG08xCZr6EqAbU/dHYAqkTMteh8IK70vPj3iXLk35j09Hox+rWJIbus5g==
X-Received: by 2002:a05:600c:1554:b0:40c:2d88:1edd with SMTP id
 f20-20020a05600c155400b0040c2d881eddmr2430760wmg.130.1703582702094; 
 Tue, 26 Dec 2023 01:25:02 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm12195144wmq.16.2023.12.26.01.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:24:59 -0800 (PST)
Date: Tue, 26 Dec 2023 04:24:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 14/21] vdpa: move file descriptor to vhost_vdpa_shared
Message-ID: <5c93bd6fabc2d21bead140e2dfbd5ccf45d58815.1703582625.git.mst@redhat.com>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

Next patches will register the vhost_vdpa memory listener while the VM
is migrating at the destination, so we can map the memory to the device
before stopping the VM at the source.  The main goal is to reduce the
downtime.

However, the destination QEMU is unaware of which vhost_vdpa device will
register its memory_listener.  If the source guest has CVQ enabled, it
will be the CVQ device.  Otherwise, it  will be the first one.

Move the file descriptor to VhostVDPAShared so all vhost_vdpa can use
it, rather than always in the first / last vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20231221174322.3130442-7-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  2 +-
 hw/virtio/vdpa-dev.c           |  2 +-
 hw/virtio/vhost-vdpa.c         | 14 +++++++-------
 net/vhost-vdpa.c               | 11 ++++-------
 4 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 01e0f25e27..796a180afa 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -32,6 +32,7 @@ typedef struct VhostVDPAHostNotifier {
 
 /* Info shared by all vhost_vdpa device models */
 typedef struct vhost_vdpa_shared {
+    int device_fd;
     struct vhost_vdpa_iova_range iova_range;
 
     /* IOVA mapping used by the Shadow Virtqueue */
@@ -42,7 +43,6 @@ typedef struct vhost_vdpa_shared {
 } VhostVDPAShared;
 
 typedef struct vhost_vdpa {
-    int device_fd;
     int index;
     uint32_t msg_type;
     bool iotlb_batch_begin_sent;
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 457960d28a..8774986571 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -66,7 +66,6 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
     if (*errp) {
         return;
     }
-    v->vdpa.device_fd = v->vhostfd;
 
     v->vdev_id = vhost_vdpa_device_get_u32(v->vhostfd,
                                            VHOST_VDPA_GET_DEVICE_ID, errp);
@@ -115,6 +114,7 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
         goto free_vqs;
     }
     v->vdpa.shared = g_new0(VhostVDPAShared, 1);
+    v->vdpa.shared->device_fd = v->vhostfd;
     v->vdpa.shared->iova_range = iova_range;
 
     ret = vhost_dev_init(&v->dev, &v->vdpa, VHOST_BACKEND_TYPE_VDPA, 0, NULL);
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 720cffbc08..09df150ef2 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -90,7 +90,7 @@ int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
                        hwaddr size, void *vaddr, bool readonly)
 {
     struct vhost_msg_v2 msg = {};
-    int fd = v->device_fd;
+    int fd = v->shared->device_fd;
     int ret = 0;
 
     msg.type = v->msg_type;
@@ -122,7 +122,7 @@ int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
                          hwaddr size)
 {
     struct vhost_msg_v2 msg = {};
-    int fd = v->device_fd;
+    int fd = v->shared->device_fd;
     int ret = 0;
 
     msg.type = v->msg_type;
@@ -145,7 +145,7 @@ int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
 
 static void vhost_vdpa_listener_begin_batch(struct vhost_vdpa *v)
 {
-    int fd = v->device_fd;
+    int fd = v->shared->device_fd;
     struct vhost_msg_v2 msg = {
         .type = v->msg_type,
         .iotlb.type = VHOST_IOTLB_BATCH_BEGIN,
@@ -174,7 +174,7 @@ static void vhost_vdpa_listener_commit(MemoryListener *listener)
     struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
     struct vhost_dev *dev = v->dev;
     struct vhost_msg_v2 msg = {};
-    int fd = v->device_fd;
+    int fd = v->shared->device_fd;
 
     if (!(dev->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
         return;
@@ -499,7 +499,7 @@ static int vhost_vdpa_call(struct vhost_dev *dev, unsigned long int request,
                              void *arg)
 {
     struct vhost_vdpa *v = dev->opaque;
-    int fd = v->device_fd;
+    int fd = v->shared->device_fd;
     int ret;
 
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
@@ -661,7 +661,7 @@ static int vhost_vdpa_host_notifier_init(struct vhost_dev *dev, int queue_index)
     struct vhost_vdpa *v = dev->opaque;
     VirtIODevice *vdev = dev->vdev;
     VhostVDPAHostNotifier *n;
-    int fd = v->device_fd;
+    int fd = v->shared->device_fd;
     void *addr;
     char *name;
 
@@ -1290,7 +1290,7 @@ static void vhost_vdpa_suspend(struct vhost_dev *dev)
 
     if (dev->backend_cap & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) {
         trace_vhost_vdpa_suspend(dev);
-        r = ioctl(v->device_fd, VHOST_VDPA_SUSPEND);
+        r = ioctl(v->shared->device_fd, VHOST_VDPA_SUSPEND);
         if (unlikely(r)) {
             error_report("Cannot suspend: %s(%d)", g_strerror(errno), errno);
         } else {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index bf8e8327da..10cf0027de 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -235,14 +235,11 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
         vhost_net_cleanup(s->vhost_net);
         g_free(s->vhost_net);
         s->vhost_net = NULL;
-    }
-     if (s->vhost_vdpa.device_fd >= 0) {
-        qemu_close(s->vhost_vdpa.device_fd);
-        s->vhost_vdpa.device_fd = -1;
     }
     if (s->vhost_vdpa.index != 0) {
         return;
     }
+    qemu_close(s->vhost_vdpa.shared->device_fd);
     g_free(s->vhost_vdpa.shared);
 }
 
@@ -448,7 +445,7 @@ static int vhost_vdpa_set_address_space_id(struct vhost_vdpa *v,
     };
     int r;
 
-    r = ioctl(v->device_fd, VHOST_VDPA_SET_GROUP_ASID, &asid);
+    r = ioctl(v->shared->device_fd, VHOST_VDPA_SET_GROUP_ASID, &asid);
     if (unlikely(r < 0)) {
         error_report("Can't set vq group %u asid %u, errno=%d (%s)",
                      asid.index, asid.num, errno, g_strerror(errno));
@@ -544,7 +541,7 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
         return 0;
     }
 
-    cvq_group = vhost_vdpa_get_vring_group(v->device_fd,
+    cvq_group = vhost_vdpa_get_vring_group(v->shared->device_fd,
                                            v->dev->vq_index_end - 1,
                                            &err);
     if (unlikely(cvq_group < 0)) {
@@ -1671,7 +1668,6 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
     qemu_set_info_str(nc, TYPE_VHOST_VDPA);
     s = DO_UPCAST(VhostVDPAState, nc, nc);
 
-    s->vhost_vdpa.device_fd = vdpa_device_fd;
     s->vhost_vdpa.index = queue_pair_index;
     s->always_svq = svq;
     s->migration_state.notify = NULL;
@@ -1680,6 +1676,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         vhost_vdpa_net_valid_svq_features(features,
                                           &s->vhost_vdpa.migration_blocker);
         s->vhost_vdpa.shared = g_new0(VhostVDPAShared, 1);
+        s->vhost_vdpa.shared->device_fd = vdpa_device_fd;
         s->vhost_vdpa.shared->iova_range = iova_range;
         s->vhost_vdpa.shared->shadow_data = svq;
     } else if (!is_datapath) {
-- 
MST


