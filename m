Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C4924028
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jul 2024 16:14:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeA4-0001w7-Fs; Tue, 02 Jul 2024 10:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeA1-0001vq-Mg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOe9z-0007p8-NP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gfd+vfybB3O3+4pkXHRWr1BbxFsd2M2r8td4r0aSbjQ=;
 b=E5cSr6HfaQqRFbvyfJdD+o/Gqq7UtGP6gt0U+L3lkGz+PiV3FGHWj85ySPuK8lRPmS7BEp
 U5eX4IQk++Ftu6g6F7xCnrDAquYuStg//fk0+S1hizl+frfa7TcztXrvJyCmD99XojLgyO
 VvwES7M97gQ4lZKzHISS6P0fmPMI8HE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-QE5KVxKkOc6TPgaHRynCDQ-1; Tue, 02 Jul 2024 10:07:04 -0400
X-MC-Unique: QE5KVxKkOc6TPgaHRynCDQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4257a75193aso19211005e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929223; x=1720534023;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfd+vfybB3O3+4pkXHRWr1BbxFsd2M2r8td4r0aSbjQ=;
 b=SHXCW1wUfYpQalzikBhMjcTil/9SjEvXZPPkHgzBJB9DqLM8haNtc2LW9RY5PHEyw6
 TgceJr6npCDTSbN4OrhZ918V9AAAcpnXj/M9iAsX0ZuLV8crzxbycH04Xlg8dy8TbbDb
 0efBG4uwPT5oeCguJTwZb38RURaTQuiHaTFkUHlcPGDVU6nfaXp95dBiQeMKzHe+6q+z
 +ntPVtrD+JzzGfxmYhDPp+LGs7pPWEWEt+AqUf+Xbo4MoGD9zMrvJ+fGsmS5W25+8mtu
 Frtxyo1PX/y2SEUJak5pJqcbTrYdzbVLN8rQMlxMu2c6TuJcAA77Vunx8fRucUkmrvbG
 65sA==
X-Gm-Message-State: AOJu0YxsYxIEiQmIiUuUMvDa0+maNKCJhCugJaH25Vvzh6GL/kjC6iD1
 unaL1J0iILZ6JqQjFrvjeskU8necPF1b5TM3BAzKR9jZTwwffbTy2OK3iQcOsHomAc4YID+KHMe
 Jze1Jq7rH6BZC34x9smdBwpJ8L3mFxUAg5c5j+uEwI8w//8w1U1dBoqRCM+vw5wtZa7zz+jSa2F
 WS0c9C4LtPbnG/ccwDfZf7zljN/Wultw==
X-Received: by 2002:a05:600c:314b:b0:424:a5df:b998 with SMTP id
 5b1f17b1804b1-4257a00cfd8mr57298355e9.9.1719929223024; 
 Tue, 02 Jul 2024 07:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ5w1IuuEk6M/eeTfqXJQoWF9ZwfO12xl8UVvoA4QCHwidLbfqczToXLdMetbxNTO+9r9J9A==
X-Received: by 2002:a05:600c:314b:b0:424:a5df:b998 with SMTP id
 5b1f17b1804b1-4257a00cfd8mr57298085e9.9.1719929222459; 
 Tue, 02 Jul 2024 07:07:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257cdf4982sm120540635e9.47.2024.07.02.07.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:07:02 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:06:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>
Subject: [PULL 01/91] vhost: dirty log should be per backend type
Message-ID: <51d59a64eed6c2cd2d2f991f44ffbe21eb33c733.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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

There could be a mix of both vhost-user and vhost-kernel clients
in the same QEMU process, where separate vhost loggers for the
specific vhost type have to be used. Make the vhost logger per
backend type, and have them properly reference counted.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Message-Id: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4acd77e890..a1e8b79e1a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -43,8 +43,8 @@
     do { } while (0)
 #endif
 
-static struct vhost_log *vhost_log;
-static struct vhost_log *vhost_log_shm;
+static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
+static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
 
 /* Memslots used by backends that support private memslots (without an fd). */
 static unsigned int used_memslots;
@@ -287,6 +287,10 @@ static int vhost_set_backend_type(struct vhost_dev *dev,
         r = -1;
     }
 
+    if (r == 0) {
+        assert(dev->vhost_ops->backend_type == backend_type);
+    }
+
     return r;
 }
 
@@ -319,16 +323,22 @@ static struct vhost_log *vhost_log_alloc(uint64_t size, bool share)
     return log;
 }
 
-static struct vhost_log *vhost_log_get(uint64_t size, bool share)
+static struct vhost_log *vhost_log_get(VhostBackendType backend_type,
+                                       uint64_t size, bool share)
 {
-    struct vhost_log *log = share ? vhost_log_shm : vhost_log;
+    struct vhost_log *log;
+
+    assert(backend_type > VHOST_BACKEND_TYPE_NONE);
+    assert(backend_type < VHOST_BACKEND_TYPE_MAX);
+
+    log = share ? vhost_log_shm[backend_type] : vhost_log[backend_type];
 
     if (!log || log->size != size) {
         log = vhost_log_alloc(size, share);
         if (share) {
-            vhost_log_shm = log;
+            vhost_log_shm[backend_type] = log;
         } else {
-            vhost_log = log;
+            vhost_log[backend_type] = log;
         }
     } else {
         ++log->refcnt;
@@ -340,11 +350,20 @@ static struct vhost_log *vhost_log_get(uint64_t size, bool share)
 static void vhost_log_put(struct vhost_dev *dev, bool sync)
 {
     struct vhost_log *log = dev->log;
+    VhostBackendType backend_type;
 
     if (!log) {
         return;
     }
 
+    assert(dev->vhost_ops);
+    backend_type = dev->vhost_ops->backend_type;
+
+    if (backend_type == VHOST_BACKEND_TYPE_NONE ||
+        backend_type >= VHOST_BACKEND_TYPE_MAX) {
+        return;
+    }
+
     --log->refcnt;
     if (log->refcnt == 0) {
         /* Sync only the range covered by the old log */
@@ -352,13 +371,13 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
             vhost_log_sync_range(dev, 0, dev->log_size * VHOST_LOG_CHUNK - 1);
         }
 
-        if (vhost_log == log) {
+        if (vhost_log[backend_type] == log) {
             g_free(log->log);
-            vhost_log = NULL;
-        } else if (vhost_log_shm == log) {
+            vhost_log[backend_type] = NULL;
+        } else if (vhost_log_shm[backend_type] == log) {
             qemu_memfd_free(log->log, log->size * sizeof(*(log->log)),
                             log->fd);
-            vhost_log_shm = NULL;
+            vhost_log_shm[backend_type] = NULL;
         }
 
         g_free(log);
@@ -376,7 +395,8 @@ static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
 
 static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
 {
-    struct vhost_log *log = vhost_log_get(size, vhost_dev_log_is_shared(dev));
+    struct vhost_log *log = vhost_log_get(dev->vhost_ops->backend_type,
+                                          size, vhost_dev_log_is_shared(dev));
     uint64_t log_base = (uintptr_t)log->log;
     int r;
 
@@ -2044,7 +2064,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
         uint64_t log_base;
 
         hdev->log_size = vhost_get_log_size(hdev);
-        hdev->log = vhost_log_get(hdev->log_size,
+        hdev->log = vhost_log_get(hdev->vhost_ops->backend_type,
+                                  hdev->log_size,
                                   vhost_dev_log_is_shared(hdev));
         log_base = (uintptr_t)hdev->log->log;
         r = hdev->vhost_ops->vhost_set_log_base(hdev,
-- 
MST


