Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 004DB74DA0A
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:38:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsvd-0005u0-J5; Mon, 10 Jul 2023 11:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvW-0005of-4A
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:50 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvH-0004n6-Rf
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82dc7so48285895e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003334; x=1691595334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iuW0jAfNN8A5+sR2hBxbLj3ogPv3jO9gBXIeFboC3qM=;
 b=uyAiHWBKNrwXEov3SUlRfOs5mb5vduz8KJDIwGc22Efvyl+2qKo9Zs9VaFUSexdvqN
 7o/qHbdGLuwVwwmC12VVfHJYOiN3pK3bggm76Njrj68DbNckyQjiQ7TrINZUeNV4kaYW
 X/V1oNbZ5ksSD4VWDC63Cpa89U6JiHy/KqNr4NGx0cvXUBRR+tuwxkudV6IONi8OISNw
 kXHcahtWyWFtthYN8r62h2Y+sXERXJwT+AoqvVKAsTEB3p1WFHdKRf0Pg6Vzc7UvzXEG
 +HfS5dsd9B231biK+6+Me2kgX7JGxMHzvyWshCgNDK7ncdA/R+d5ZUEY7SS/3L8Pi4XB
 gEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003334; x=1691595334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iuW0jAfNN8A5+sR2hBxbLj3ogPv3jO9gBXIeFboC3qM=;
 b=Wuh37o52yhyg7fun8BIyxSv5by4rK/7nk2lPswCFjA+Nyq3RvxNRAoLB0Nn2wB+u/3
 tdOziHfS57cvzgc1C6X89ExcfnEdgYogmxicYWXAUZQ30sqy2CY+vcdy9DQF9Ztw8imD
 sQnLIl7mRlJGHpjR0/WJq548jCCiiMvxSabSjJYmCEM3ZLGLBvCU1b73b+igitrMMJ/r
 rbRgQNhalEQzLwYc1o4AxU8Ty4OcmrS4CJmIb/EyRqr9xJTDCCv+55qk914PV4/13ngP
 cLAjI3JJy3CEOXmuMH6h0RX+z12zlPjym9x6MLuoqwsISKYXZG1JrO7BSlimCrZyQ0oM
 kd4Q==
X-Gm-Message-State: ABy/qLbXSbBiuQm93uuCuOlFIse0Q3yyQQ25l483F8cZrMpfsy+I6xAO
 3Afhhb6HlEBPmMdiY4l5shXjcg==
X-Google-Smtp-Source: APBJJlHlZE2PoziFv03FDIVlpqPOlccXiAxxVZXmB17EnmIVp4QaNheo6ENZ5j7EsxzsdJA9fN+IWA==
X-Received: by 2002:a7b:c397:0:b0:3fc:6b:15d4 with SMTP id
 s23-20020a7bc397000000b003fc006b15d4mr9587411wmj.27.1689003334448; 
 Mon, 10 Jul 2023 08:35:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z13-20020a5d4d0d000000b002fb60c7995esm12056258wrt.8.2023.07.10.08.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:35:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7249E1FFCD;
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
Subject: [RFC PATCH v3 19/20] hw/virtio: probe backend for specs if it
 supports it
Date: Mon, 10 Jul 2023 16:35:21 +0100
Message-Id: <20230710153522.3469097-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710153522.3469097-1-alex.bennee@linaro.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Now we have detected and validated the protocol support lets do the
probe. The empty state indicates no probe took place.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/virtio/vhost.h | 12 +++++++
 hw/virtio/vhost-user.c    | 73 +++++++++++++++++++++++++++++++++++----
 hw/virtio/vhost.c         |  2 +-
 3 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 912706668a..1d8de1c558 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -68,6 +68,13 @@ typedef struct VhostDevConfigOps {
 
 struct vhost_memory;
 
+typedef struct VhostUserBackendSpecs {
+    uint32_t device_id;
+    uint32_t config_size;
+    uint32_t min_vqs;
+    uint32_t max_vqs;
+} VhostUserBackendSpecs;
+
 /**
  * struct vhost_dev - common vhost_dev structure
  * @vhost_ops: backend specific ops
@@ -107,11 +114,15 @@ struct vhost_dev {
      * VHOST_USER_SET_FEATURES or VHOST_NET_F_VIRTIO_NET_HDR. Its
      * future use should be discouraged and the variable retired as
      * its easy to confuse with the VirtIO backend_features.
+     *
+     * @specs: the results of a GET_BACKEND_SPECS probe.
      */
     uint64_t features;
     uint64_t acked_features;
     uint64_t backend_features;
 
+    VhostUserBackendSpecs specs;
+
     /**
      * @protocol_features: is the vhost-user only feature set by
      * VHOST_USER_SET_PROTOCOL_FEATURES. Protocol features are only
@@ -134,6 +145,7 @@ struct vhost_dev {
     QLIST_HEAD(, vhost_iommu) iommu_list;
     IOMMUNotifier n;
     const VhostDevConfigOps *config_ops;
+
 };
 
 extern const VhostOps kernel_ops;
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 3116b3e46a..36aa4ec2d5 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -123,6 +123,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_REM_MEM_REG = 38,
     VHOST_USER_SET_STATUS = 39,
     VHOST_USER_GET_STATUS = 40,
+    VHOST_USER_GET_BACKEND_SPECS = 41,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -204,13 +205,6 @@ typedef struct VhostUserInflight {
     uint16_t queue_size;
 } VhostUserInflight;
 
-typedef struct VhostUserBackendSpecs {
-    uint32_t device_id;
-    uint32_t config_size;
-    uint32_t min_vqs;
-    uint32_t max_vqs;
-} VhostUserBackendSpecs;
-
 typedef struct {
     VhostUserRequest request;
 
@@ -1991,6 +1985,56 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
     return 0;
 }
 
+static bool vhost_user_get_backend_specs(struct vhost_dev *dev, Error **errp)
+{
+    int ret;
+    VhostUserMsg msg = {
+        .hdr.request = VHOST_USER_GET_BACKEND_SPECS,
+        .hdr.flags = VHOST_USER_VERSION,
+        .hdr.size = VHOST_USER_HDR_SIZE,
+    };
+
+    if (!virtio_has_feature(dev->protocol_features,
+                VHOST_USER_PROTOCOL_F_STANDALONE)) {
+        error_setg(errp, "VHOST_USER_PROTOCOL_F_STANDALONE not supported");
+        return -EINVAL;
+    }
+
+    ret = vhost_user_write(dev, &msg, NULL, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vhost_get_backend send failed");
+        return ret;
+    }
+
+    ret = vhost_user_read(dev, &msg);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vhost_get_backend recv failed");
+        return ret;
+    }
+
+    if (msg.hdr.request != VHOST_USER_GET_BACKEND_SPECS) {
+        error_setg(errp,
+                   "Received unexpected msg type. Expected %d received %d",
+                   VHOST_USER_GET_BACKEND_SPECS, msg.hdr.request);
+        return -EPROTO;
+    }
+
+    if (msg.hdr.size != sizeof(msg.payload.specs)) {
+        error_setg(errp, "Received bad msg size.");
+        return -EPROTO;
+    }
+
+    if (msg.payload.specs.config_size && !virtio_has_feature(dev->protocol_features,
+                                                             VHOST_USER_PROTOCOL_F_CONFIG)) {
+        error_setg(errp, "VHOST_USER_PROTOCOL_F_CONFIG not supported");
+        return -EPROTO;
+    }
+
+    dev->specs = msg.payload.specs;
+
+    return 0;
+}
+
 static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
                                    Error **errp)
 {
@@ -2073,6 +2117,21 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
             return -EPROTO;
         }
 
+        if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_STANDALONE)) {
+            err = vhost_user_get_backend_specs(dev, errp);
+            if (err < 0) {
+                error_setg_errno(errp, EPROTO, "vhost_get_backend_specs failed");
+                return -EPROTO;
+            }
+            /*
+             * If this was never set by the user we can now fill it in
+             * so we can continue the initialisation
+             */
+            if (!dev->nvqs) {
+                dev->nvqs = dev->specs.min_vqs;
+            }
+        }
+
         /* query the max queues we support if backend supports Multiple Queue */
         if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MQ)) {
             err = vhost_user_get_u64(dev, VHOST_USER_GET_QUEUE_NUM,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4c73ced3b7..d14467aa1c 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1450,7 +1450,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     }
 
     /* Skip if we don't yet have number of vqs */
-    if (hdev->vqs && hdev->nvqs) {
+    if (hdev->nvqs) {
         if (!vhost_init_virtqs(hdev, busyloop_timeout, errp)) {
             goto fail_busyloop;
         }
-- 
2.39.2


