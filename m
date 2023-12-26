Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0AA81E64E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:24:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3fk-0001EI-6s; Tue, 26 Dec 2023 04:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fi-0001DG-Qn
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fh-0008Fw-4y
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=afYN6k1oPeJkIFiSUzbyD9REIUlFHavOgE55XoawkLE=;
 b=CDXRmjt14gNi6KytgQ2wv6SNR4YUhFmdl19jsXS/5sSp+pXk/vjT4uM9/8KU3KpSacrArc
 f9uQczUXm0xmNvHT1QVBuCaJNkWOCx88n0akjQrOg4r1xTEe9SgpYYK1OjgdQTlpIpP1YX
 4n6wyxCTwAdYrJAQB9IGoymw+iQ8ReM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-QLKKt20ENCei-bdAwu6-4w-1; Tue, 26 Dec 2023 04:24:18 -0500
X-MC-Unique: QLKKt20ENCei-bdAwu6-4w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33691eecbebso2686541f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582655; x=1704187455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afYN6k1oPeJkIFiSUzbyD9REIUlFHavOgE55XoawkLE=;
 b=q6ch3q8r8HbWOxRUsRdlRT3zrGcXzXnOS7BCPyZb/sO00Oy1V/DLquJjUCmhVVgagZ
 CKRFJBYmGCWirSFIdZ2FhVtdqMJX/12XD3TdCRjWcYBSTpaAgjVO3KCKrWiM0/o9Wdod
 AKMPC0d1VKKS0azXXqzjwtQLDZN0ZekveoB/PDGm3qBE6lmD/AzA+70dUTjWkxAbNpAJ
 TKqBWZExc9kUg0cze5Tb1g1TOHwruAGnZ/ry44/TXNfKf6IqZdtJuisRHTxJ5Bh2n+xE
 i+8I5GsVc1btkNVSQQ/nBMzByD0A8D2iPNYWp9gdseVDWx8jr5KA9Vyzhg/cifTHNe1B
 sOew==
X-Gm-Message-State: AOJu0YxU3sz5NGHC1QSDX+MoHpyDcXejW12GG4f1VGaj026ftqHUv+no
 RM3SmNjQRv5d0Sutc/rcTuwf57598kcawczFt+LuIz5kCwH5/T8HKsIYRjBLAhNSnb46Ty08jpw
 tJ7I3Z1+v7Zu3zmXa5qdDuncni7I42oEaUg1QgemOEgI2rImf2Pfl6zyAaWw57Vgs+psQeZsQzk
 qs
X-Received: by 2002:a05:600c:2907:b0:40c:709:d924 with SMTP id
 i7-20020a05600c290700b0040c0709d924mr3624525wmd.147.1703582655451; 
 Tue, 26 Dec 2023 01:24:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMzlsOJA9HLAoAMDwrAJIV/8ar/+5ls1yNlmuz7d2zE+dD3CVcz/m9OOqhsXh5KOsryvkC2Q==
X-Received: by 2002:a05:600c:2907:b0:40c:709:d924 with SMTP id
 i7-20020a05600c290700b0040c0709d924mr3624517wmd.147.1703582655112; 
 Tue, 26 Dec 2023 01:24:15 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 bi6-20020a05600c3d8600b0040d5868cc15sm3793902wmb.23.2023.12.26.01.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:24:12 -0800 (PST)
Date: Tue, 26 Dec 2023 04:24:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mike Christie <michael.christie@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 03/21] vhost: Add worker backend callouts
Message-ID: <9aad781959d770eb2479596a23e471cd82bd4e5b.1703582625.git.mst@redhat.com>
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

This adds the vhost backend callouts for the worker ioctls added in the
6.4 linux kernel commit:

c1ecd8e95007 ("vhost: allow userspace to create workers")

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Message-Id: <20231204231618.21962-2-michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-backend.h | 14 ++++++++++++++
 hw/virtio/vhost-backend.c         | 28 ++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index a86d103f82..70c2e8ffee 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -45,6 +45,8 @@ struct vhost_memory;
 struct vhost_vring_file;
 struct vhost_vring_state;
 struct vhost_vring_addr;
+struct vhost_vring_worker;
+struct vhost_worker_state;
 struct vhost_scsi_target;
 struct vhost_iotlb_msg;
 struct vhost_virtqueue;
@@ -85,6 +87,14 @@ typedef int (*vhost_set_vring_err_op)(struct vhost_dev *dev,
                                       struct vhost_vring_file *file);
 typedef int (*vhost_set_vring_busyloop_timeout_op)(struct vhost_dev *dev,
                                                    struct vhost_vring_state *r);
+typedef int (*vhost_attach_vring_worker_op)(struct vhost_dev *dev,
+                                            struct vhost_vring_worker *worker);
+typedef int (*vhost_get_vring_worker_op)(struct vhost_dev *dev,
+                                         struct vhost_vring_worker *worker);
+typedef int (*vhost_new_worker_op)(struct vhost_dev *dev,
+                                   struct vhost_worker_state *worker);
+typedef int (*vhost_free_worker_op)(struct vhost_dev *dev,
+                                    struct vhost_worker_state *worker);
 typedef int (*vhost_set_features_op)(struct vhost_dev *dev,
                                      uint64_t features);
 typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
@@ -172,6 +182,10 @@ typedef struct VhostOps {
     vhost_set_vring_call_op vhost_set_vring_call;
     vhost_set_vring_err_op vhost_set_vring_err;
     vhost_set_vring_busyloop_timeout_op vhost_set_vring_busyloop_timeout;
+    vhost_new_worker_op vhost_new_worker;
+    vhost_free_worker_op vhost_free_worker;
+    vhost_get_vring_worker_op vhost_get_vring_worker;
+    vhost_attach_vring_worker_op vhost_attach_vring_worker;
     vhost_set_features_op vhost_set_features;
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 17f3fc6a08..833804dd40 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -158,6 +158,30 @@ static int vhost_kernel_set_vring_busyloop_timeout(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_SET_VRING_BUSYLOOP_TIMEOUT, s);
 }
 
+static int vhost_kernel_new_worker(struct vhost_dev *dev,
+                                   struct vhost_worker_state *worker)
+{
+    return vhost_kernel_call(dev, VHOST_NEW_WORKER, worker);
+}
+
+static int vhost_kernel_free_worker(struct vhost_dev *dev,
+                                    struct vhost_worker_state *worker)
+{
+    return vhost_kernel_call(dev, VHOST_FREE_WORKER, worker);
+}
+
+static int vhost_kernel_attach_vring_worker(struct vhost_dev *dev,
+                                            struct vhost_vring_worker *worker)
+{
+    return vhost_kernel_call(dev, VHOST_ATTACH_VRING_WORKER, worker);
+}
+
+static int vhost_kernel_get_vring_worker(struct vhost_dev *dev,
+                                         struct vhost_vring_worker *worker)
+{
+    return vhost_kernel_call(dev, VHOST_GET_VRING_WORKER, worker);
+}
+
 static int vhost_kernel_set_features(struct vhost_dev *dev,
                                      uint64_t features)
 {
@@ -313,6 +337,10 @@ const VhostOps kernel_ops = {
         .vhost_set_vring_err = vhost_kernel_set_vring_err,
         .vhost_set_vring_busyloop_timeout =
                                 vhost_kernel_set_vring_busyloop_timeout,
+        .vhost_get_vring_worker = vhost_kernel_get_vring_worker,
+        .vhost_attach_vring_worker = vhost_kernel_attach_vring_worker,
+        .vhost_new_worker = vhost_kernel_new_worker,
+        .vhost_free_worker = vhost_kernel_free_worker,
         .vhost_set_features = vhost_kernel_set_features,
         .vhost_get_features = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
-- 
MST


