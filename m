Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E74099248D9
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jul 2024 22:15:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjsz-0001GR-Cc; Tue, 02 Jul 2024 16:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjst-0001BT-W1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjsr-0007Ny-SB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uKK/AiLdjMfeKEPpHLdhaqq0Kf5J8WlC0WD4BsUonqY=;
 b=B4X4LbqVczTcOtHkSjr8iudPPUc23EBFiY7h6X/c+ZogiaBhBtqMKoEGPUHVuU/ToM0wOB
 6ndXbQYB1YdSJg87Ks2QAofFqe8VXjwGCxOWc2bfvEqc7PD20k4RHjNCl3SCGWs3ILBhFC
 btRF3iUjF+LIFM1uiZz0wSnUmYzmHCU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-n3fiUGhWP7StvdVXB-8pWQ-1; Tue, 02 Jul 2024 16:13:47 -0400
X-MC-Unique: n3fiUGhWP7StvdVXB-8pWQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4257dd7d462so19977335e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951225; x=1720556025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKK/AiLdjMfeKEPpHLdhaqq0Kf5J8WlC0WD4BsUonqY=;
 b=aXJ3Fn+YU1kWtGQuNwDeGwHOJZhH06Ut+vIKiQJuOfFTmNyJ7vcak5xJR6m8ux3FxD
 coxhSrtlJs77WXqTeH2bq5OO5x8L6b8g2RPqP6DmH38Iiaf0ufo+kifVm2aWJZc12nye
 kzR0hfjDlp7R8onng9WgTyb2h/YL/R02GQRwLBYuQSky58L0+Dge9fD92sHD0VK8FQ8U
 q1cEGvsyUU6EjRY4EwhrrZz9ztEvpoNjmBr/rLjCahRnYR3zN+WlhJHbTlaNAL1S01T3
 3KSeRKLgmpCqNlQ6VSbG9Q7W0I9wxj5YfIzpvTPj4sstxg1z+xd54rmkp6PTvgNCgJ6G
 XaWQ==
X-Gm-Message-State: AOJu0Yx5Bqo6U+ZLnOrhf2wl54/OUQH7eXcmuRFOII7yL3rQwY8TwM8y
 PwAqP34oHx6ofDkuQ8vRBXoE59Rm4Iil5S1Sg6hf2BvFqqTCbb6nwjEezi6YZ3F4DP0uEydsmTA
 rwRZcQx0gFWwThr992aywSbpny2WUQNVPpNezEhmUrnnKGRZFZQMDdg0foDjbIkJUWPty+2knSM
 IDApCBlliSoOC+t1HjpDK7dyM1VVs7Rw==
X-Received: by 2002:a05:600c:2d42:b0:424:a5b4:6dd3 with SMTP id
 5b1f17b1804b1-4257a0763fbmr71494085e9.36.1719951225664; 
 Tue, 02 Jul 2024 13:13:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2t9q1rqluDoZRLWPLfWpEITd7C0LSIRz+RPZvSqkqcCfWG97bumt7kdF+UqubgLwlEsyqRQ==
X-Received: by 2002:a05:600c:2d42:b0:424:a5b4:6dd3 with SMTP id
 5b1f17b1804b1-4257a0763fbmr71493835e9.36.1719951225037; 
 Tue, 02 Jul 2024 13:13:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af54ecasm207528015e9.12.2024.07.02.13.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:13:44 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:13:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Joao Martins <joao.m.martins@oracle.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL v2 02/91] vhost: Perform memory section dirty scans once per
 iteration
Message-ID: <c5cd7e5f230afb56891e3826fbb60f9e2b6c086a.1719951026.git.mst@redhat.com>
References: <cover.1719951026.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951026.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Si-Wei Liu <si-wei.liu@oracle.com>

On setups with one or more virtio-net devices with vhost on,
dirty tracking iteration increases cost the bigger the number
amount of queues are set up e.g. on idle guests migration the
following is observed with virtio-net with vhost=on:

48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14

With high memory rates the symptom is lack of convergence as soon
as it has a vhost device with a sufficiently high number of queues,
the sufficient number of vhost devices.

On every migration iteration (every 100msecs) it will redundantly
query the *shared log* the number of queues configured with vhost
that exist in the guest. For the virtqueue data, this is necessary,
but not for the memory sections which are the same. So essentially
we end up scanning the dirty log too often.

To fix that, select a vhost device responsible for scanning the
log with regards to memory sections dirty tracking. It is selected
when we enable the logger (during migration) and cleared when we
disable the logger. If the vhost logger device goes away for some
reason, the logger will be re-selected from the rest of vhost
devices.

After making mem-section logger a singleton instance, constant cost
of 7%-9% (like the 1 queue report) will be seen, no matter how many
queues or how many vhost devices are configured:

48 queues -> 8.71%    [.] vhost_dev_sync_region.isra.13
2 devices, 8 queues -> 7.97%   [.] vhost_dev_sync_region.isra.14

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Message-Id: <1710448055-11709-2-git-send-email-si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/virtio/vhost.h |  1 +
 hw/virtio/vhost.c         | 67 +++++++++++++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 02477788df..d75faf46e9 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -129,6 +129,7 @@ struct vhost_dev {
     void *opaque;
     struct vhost_log *log;
     QLIST_ENTRY(vhost_dev) entry;
+    QLIST_ENTRY(vhost_dev) logdev_entry;
     QLIST_HEAD(, vhost_iommu) iommu_list;
     IOMMUNotifier n;
     const VhostDevConfigOps *config_ops;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index a1e8b79e1a..06fc71746e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -45,6 +45,7 @@
 
 static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
 static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
+static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
 
 /* Memslots used by backends that support private memslots (without an fd). */
 static unsigned int used_memslots;
@@ -149,6 +150,47 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
     }
 }
 
+static inline bool vhost_dev_should_log(struct vhost_dev *dev)
+{
+    assert(dev->vhost_ops);
+    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
+    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
+
+    return dev == QLIST_FIRST(&vhost_log_devs[dev->vhost_ops->backend_type]);
+}
+
+static inline void vhost_dev_elect_mem_logger(struct vhost_dev *hdev, bool add)
+{
+    VhostBackendType backend_type;
+
+    assert(hdev->vhost_ops);
+
+    backend_type = hdev->vhost_ops->backend_type;
+    assert(backend_type > VHOST_BACKEND_TYPE_NONE);
+    assert(backend_type < VHOST_BACKEND_TYPE_MAX);
+
+    if (add && !QLIST_IS_INSERTED(hdev, logdev_entry)) {
+        if (QLIST_EMPTY(&vhost_log_devs[backend_type])) {
+            QLIST_INSERT_HEAD(&vhost_log_devs[backend_type],
+                              hdev, logdev_entry);
+        } else {
+            /*
+             * The first vhost_device in the list is selected as the shared
+             * logger to scan memory sections. Put new entry next to the head
+             * to avoid inadvertent change to the underlying logger device.
+             * This is done in order to get better cache locality and to avoid
+             * performance churn on the hot path for log scanning. Even when
+             * new devices come and go quickly, it wouldn't end up changing
+             * the active leading logger device at all.
+             */
+            QLIST_INSERT_AFTER(QLIST_FIRST(&vhost_log_devs[backend_type]),
+                               hdev, logdev_entry);
+        }
+    } else if (!add && QLIST_IS_INSERTED(hdev, logdev_entry)) {
+        QLIST_REMOVE(hdev, logdev_entry);
+    }
+}
+
 static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
                                    MemoryRegionSection *section,
                                    hwaddr first,
@@ -166,12 +208,14 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
     start_addr = MAX(first, start_addr);
     end_addr = MIN(last, end_addr);
 
-    for (i = 0; i < dev->mem->nregions; ++i) {
-        struct vhost_memory_region *reg = dev->mem->regions + i;
-        vhost_dev_sync_region(dev, section, start_addr, end_addr,
-                              reg->guest_phys_addr,
-                              range_get_last(reg->guest_phys_addr,
-                                             reg->memory_size));
+    if (vhost_dev_should_log(dev)) {
+        for (i = 0; i < dev->mem->nregions; ++i) {
+            struct vhost_memory_region *reg = dev->mem->regions + i;
+            vhost_dev_sync_region(dev, section, start_addr, end_addr,
+                                  reg->guest_phys_addr,
+                                  range_get_last(reg->guest_phys_addr,
+                                                 reg->memory_size));
+        }
     }
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
@@ -383,6 +427,7 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
         g_free(log);
     }
 
+    vhost_dev_elect_mem_logger(dev, false);
     dev->log = NULL;
     dev->log_size = 0;
 }
@@ -998,6 +1043,15 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
             goto err_vq;
         }
     }
+
+    /*
+     * At log start we select our vhost_device logger that will scan the
+     * memory sections and skip for the others. This is possible because
+     * the log is shared amongst all vhost devices for a given type of
+     * backend.
+     */
+    vhost_dev_elect_mem_logger(dev, enable_log);
+
     return 0;
 err_vq:
     for (; i >= 0; --i) {
@@ -2075,6 +2129,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
             VHOST_OPS_DEBUG(r, "vhost_set_log_base failed");
             goto fail_log;
         }
+        vhost_dev_elect_mem_logger(hdev, true);
     }
     if (vrings) {
         r = vhost_dev_set_vring_enable(hdev, true);
-- 
MST


