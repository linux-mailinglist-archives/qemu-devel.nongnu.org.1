Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF607B7AB9
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:52:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxV1-0006DF-3W; Wed, 04 Oct 2023 04:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUa-0004b2-So
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUY-0001VV-OD
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5XOx5uSgyVSXpoNfTcwoFWgq5vZoBZe4Va9ktCDvYA=;
 b=KwW8x3ofgz5o9h0KRBQY5xglO76dUfz53ltb/KrM5302TulAJiLC8BeFEn5o/Z9v0DvYBi
 6cNnsfPxsjoiGiOJMcdOB5FElb7nIc3nJPiEQrQ/NzhPiIseISB7Bff5XXmc4ChgaU6X5B
 /9bQQuAaG8d54KFNyzTLMdEaAYi7PxA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-irYN0lToN-WhgOUri4q5iA-1; Wed, 04 Oct 2023 04:44:09 -0400
X-MC-Unique: irYN0lToN-WhgOUri4q5iA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so13451125e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409048; x=1697013848;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t5XOx5uSgyVSXpoNfTcwoFWgq5vZoBZe4Va9ktCDvYA=;
 b=v+1ZuJufson3LL5xMrxhml2hnFQAOvyLKgG5qf4VBLZRuhfLU+TelnnXsMy/NnZK0F
 Us9kA7zfZHhSaH0qkAtpHpJJg+Vhi28WBgMjsmoesFQufeQ/EgQ1SkoJykuqx3cLOlfE
 0kHbkdYN8cd27Vn8C0I9KtySWPNoR6qZM6OJUOwaZ9TwLhxg7q29ffbcEOZu98jDdQGq
 NJOSNKTvsxBwt+iC5P6abOJtnDevUeu6aPLNE+hAe3nRPDlPnptBOOXi3IMg+JLdEYxA
 /V0lwNrvyztHvm4Sye+kLyKW40y5c/rcewpc6yMoo6FI8pmyUCmKtQaiGulIREpGLrUA
 32/g==
X-Gm-Message-State: AOJu0YwEU+qWXZdsW0BfFRX4R8o4ij9/1j7GKllpxde0Cv0rBukaZ3ES
 Hmc9xOvT5NKDxH3cLUvE2pCCiFoxv9HsMn7vdkwFlp8u/BQ1A91/u062tpPqHwLegPwlwrgYLbI
 Wa32i1DeglApTesI5R+kSwWOVTxzyJL7qjctHUMgqxlJ+tozcYODxFPQYzSzU0xKxRzAC
X-Received: by 2002:a7b:c456:0:b0:3fe:d71a:d84e with SMTP id
 l22-20020a7bc456000000b003fed71ad84emr1887485wmi.1.1696409047944; 
 Wed, 04 Oct 2023 01:44:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGicVmIdlMOjhQz3S25BXXVftn+5ztJMdYcmPndC0Jm9HNuAFMh9CvM0L3FiNQIspXjIW/RJg==
X-Received: by 2002:a7b:c456:0:b0:3fe:d71a:d84e with SMTP id
 l22-20020a7bc456000000b003fed71ad84emr1887473wmi.1.1696409047602; 
 Wed, 04 Oct 2023 01:44:07 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 n9-20020a7bcbc9000000b0040641a9d49bsm933754wmi.17.2023.10.04.01.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:06 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 18/63] vdpa: move vhost_vdpa_set_vring_ready to the caller
Message-ID: <b24272731cfab1e58d5c49c49419045d277f93e9.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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

From: Eugenio Pérez <eperezma@redhat.com>

Doing that way allows CVQ to be enabled before the dataplane vqs,
restoring the state as MQ or MAC addresses properly in the case of a
migration.

The patch does it by defining a ->load NetClientInfo callback also for
dataplane.  Ideally, this should be done by an independent patch, but
the function is already static so it would only add an empty
vhost_vdpa_net_data_load stub.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230822085330.3978829-5-eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vdpa-dev.c   |  3 ++
 hw/virtio/vhost-vdpa.c |  3 --
 net/vhost-vdpa.c       | 65 ++++++++++++++++++++++++++++--------------
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 363b625243..f22d5d5bc0 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -255,6 +255,9 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
         error_setg_errno(errp, -ret, "Error starting vhost");
         goto err_guest_notifiers;
     }
+    for (i = 0; i < s->dev.nvqs; ++i) {
+        vhost_vdpa_set_vring_ready(&s->vdpa, i);
+    }
     s->started = true;
 
     /*
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index e7de880d51..89ff02a999 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1303,9 +1303,6 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
         if (unlikely(!ok)) {
             return -1;
         }
-        for (int i = 0; i < dev->nvqs; ++i) {
-            vhost_vdpa_set_vring_ready(v, dev->vq_index + i);
-        }
     } else {
         vhost_vdpa_suspend(dev);
         vhost_vdpa_svqs_stop(dev);
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 008c0cf8b3..0715bed8e6 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -375,6 +375,22 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
     return 0;
 }
 
+static int vhost_vdpa_net_data_load(NetClientState *nc)
+{
+    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+    struct vhost_vdpa *v = &s->vhost_vdpa;
+    bool has_cvq = v->dev->vq_index_end % 2;
+
+    if (has_cvq) {
+        return 0;
+    }
+
+    for (int i = 0; i < v->dev->nvqs; ++i) {
+        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
+    }
+    return 0;
+}
+
 static void vhost_vdpa_net_client_stop(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
@@ -397,6 +413,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .size = sizeof(VhostVDPAState),
         .receive = vhost_vdpa_receive,
         .start = vhost_vdpa_net_data_start,
+        .load = vhost_vdpa_net_data_load,
         .stop = vhost_vdpa_net_client_stop,
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
@@ -1022,30 +1039,34 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
-    if (!v->shadow_vqs_enabled) {
-        return 0;
+    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
+
+    if (v->shadow_vqs_enabled) {
+        n = VIRTIO_NET(v->dev->vdev);
+        r = vhost_vdpa_net_load_mac(s, n);
+        if (unlikely(r < 0)) {
+            return r;
+        }
+        r = vhost_vdpa_net_load_mq(s, n);
+        if (unlikely(r)) {
+            return r;
+        }
+        r = vhost_vdpa_net_load_offloads(s, n);
+        if (unlikely(r)) {
+            return r;
+        }
+        r = vhost_vdpa_net_load_rx(s, n);
+        if (unlikely(r)) {
+            return r;
+        }
+        r = vhost_vdpa_net_load_vlan(s, n);
+        if (unlikely(r)) {
+            return r;
+        }
     }
 
-    n = VIRTIO_NET(v->dev->vdev);
-    r = vhost_vdpa_net_load_mac(s, n);
-    if (unlikely(r < 0)) {
-        return r;
-    }
-    r = vhost_vdpa_net_load_mq(s, n);
-    if (unlikely(r)) {
-        return r;
-    }
-    r = vhost_vdpa_net_load_offloads(s, n);
-    if (unlikely(r)) {
-        return r;
-    }
-    r = vhost_vdpa_net_load_rx(s, n);
-    if (unlikely(r)) {
-        return r;
-    }
-    r = vhost_vdpa_net_load_vlan(s, n);
-    if (unlikely(r)) {
-        return r;
+    for (int i = 0; i < v->dev->vq_index; ++i) {
+        vhost_vdpa_set_vring_ready(v, i);
     }
 
     return 0;
-- 
MST


